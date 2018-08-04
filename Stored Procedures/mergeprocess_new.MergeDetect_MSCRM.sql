SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO


--exec [mergeprocess_new].[MergeDetect_MSCRM]


CREATE PROC [mergeprocess_new].[MergeDetect_MSCRM] --'Predators'
	--@Client VARCHAR(100) 
AS
Declare @Date Date = (select cast(getdate() as date));
----DECLARE @Account VARCHAR(100) = (SELECT CASE WHEN @client = 'Predators' THEN 'CRM_Account' ELSE CONCAT(@client,' PC_SFDC Account' ) END);
--DECLARE @Contact VARCHAR(100) = (SELECT CASE WHEN @client = 'Predators' THEN 'CRM_Contacts'
--											 ELSE CONCAT(@client,' CRM Contact' ) END );
DECLARE @timestemp NVARCHAR(100) = (SELECT REPLACE(REPLACE(CAST(CURRENT_TIMESTAMP AS NVARCHAR(100)),' ',''),':',''))



DECLARE @SQL VARCHAR(MAX) = 'select * into chicagofire_reporting.prodcopy.contact_' + @timestemp + ' from chicagofire_reporting.prodcopy.contact'


EXEC (@SQL)

UPDATE  CHICAGOFIRE_REPORTING.prodcopy.contact SET name_email_hash = NULL

UPDATE CHICAGOFIRE_REPORTING.prodcopy.contact SET name_email_hash = HASHBYTES('SHA2_256',ISNULL(LTRIM(RTRIM(firstname)),'')  + ISNULL(LTRIM(RTRIM(lastname)),'') + ISNULL(LTRIM(RTRIM(emailaddress1)),''))
FROM ChicagoFire_Reporting.prodcopy.contact WHERE ISNULL(emailaddress1,'') != ''


TRUNCATE TABLE dbo.Hash_ContactID

INSERT INTO dbo.Hash_ContactID
SELECT contactid, name_email_hash
FROM ChicagoFire_Reporting.prodcopy.contact
WHERE name_email_hash IS NOT NULL
AND statecode = 0;

 /*MergeAccount AS (
SELECT SSB_CRMSYSTEM_ACCT_ID, COUNT(1) CountAccounts, MAX(CASE WHEN b.SSID IS NOT NULL THEN 1 ELSE 0 END) Key_Related
FROM dbo.vwDimCustomer_ModAcctID a
LEFT JOIN dbo.vw_KeyAccounts b
	ON a.dimcustomerid = b.dimcustomerid
JOIN prodcopy.vw_account c							--	DCH 2016-10-05
	ON a.SSID = c.accountid							--	DCH 2016-10-05
	AND a.SourceSystem = @Account					--	CTW 2016-10-25
WHERE SourceSystem = @Account
AND c.merged = 0									--	DCH 2016-10-05
AND c.statuscode = 1								--	DCH 2016-10-05
GROUP BY SSB_CRMSYSTEM_ACCT_ID
HAVING COUNT(1) > 1), */

WITH MergeContact AS (
SELECT name_email_hash, COUNT(1) CountContacts, MAX(CASE WHEN b.ID IS NOT NULL THEN 1 ELSE 0 END) Key_Related
FROM dbo.Hash_ContactID a 
LEFT JOIN (
	SELECT CAST(cc.contactid AS VARCHAR(100)) ID
	FROM ChicagoFire_Reporting.prodcopy.Contact cc
	JOIN dbo.vw_KeyAccounts bb
		ON CAST(cc.contactid AS VARCHAR(100)) = CAST(bb.contactid AS VARCHAR(100))							--	DCH 2016-10-05
	AND cc.statecode = 0								--	DCH 2016-10-05
	AND ISNULL(cc.emailaddress1,'') != ''
	) b		
	ON a.contactid = b.ID
GROUP BY name_email_hash
HAVING COUNT(1) > 1
)



--select * from MergeContact where SSB_CRMSYSTEM_CONTACT_ID = 'A4D72EEC-3628-4637-A1B9-BF91BC158DC9'


MERGE  MERGEPROCESS_New.DetectedMerges  AS tar
USING ( --SELECT 'Account' MergeType, SSB_CRMSYSTEM_ACCT_ID SSBID, CASE WHEN CountAccounts = 2 AND Key_Related = 0 THEN 1 ELSE 0 END AutoMerge, @Date DetectedDate, CountAccounts NumRecords FROM MergeAccount
		--UNION ALL
		SELECT 'Contact' MergeType, name_email_hash, CASE WHEN  Key_Related = 0 THEN 1 ELSE 0 END AutoMerge, @Date DetectedDate, CountContacts NumRecords FROM MergeContact) AS sour
	ON tar.MergeType = sour.MergeType
	AND tar.name_email_hash = sour.name_email_hash
WHEN MATCHED  AND (tar.DetectedDate <> sour.DetectedDate 
				OR sour.NumRecords <> tar.NumRecords
				OR sour.AutoMerge <> tar.AutoMerge
				OR 0 <> tar.MergeComplete) THEN UPDATE 
	SET DetectedDate = @Date
	,NumRecords = sour.NumRecords
	,AutoMerge = sour.AutoMerge
	, tar.MergeComplete = 0
WHEN NOT MATCHED THEN INSERT
	(MergeType
	,name_email_hash
	,AutoMerge
	,DetectedDate
	,NumRecords)
VALUES(
	 sour.MergeType
	,sour.name_email_hash
	,sour.AutoMerge
	,sour.DetectedDate
	,sour.NumRecords)
WHEN NOT MATCHED BY SOURCE AND tar.MergeComment IS NULL AND tar.mergeComplete = 0 THEN UPDATE
	SET MergeComment = 'Merge Detection - Merge not completed, but not longer detected' 
	;





GO
