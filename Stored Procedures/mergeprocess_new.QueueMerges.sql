SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO






create PROC [mergeprocess_new].[QueueMerges] --Predators
--Exec  [MERGEPROCESS_New].[QueueMerges] 'Predators'
	--@Client VARCHAR(100) 
AS
--Declare @Client VARCHAR(100) ='Raiders'
--DECLARE @Account VARCHAR(100) = (SELECT CASE WHEN @client = 'Predators' THEN 'CRM_Account' ELSE CONCAT(@client,' CRM Account' ) END);
--DECLARE @Contact VARCHAR(100) = (SELECT CASE WHEN @client = 'Trailblazers' THEN 'CRM_Contact' 
--											 WHEN @client = 'Predators' THEN 'CRM_Contacts'
--											 ELSE CONCAT(@client,' CRM Contact' ) END );
--WITH only2Acct as
TRUNCATE TABLE MERGEPROCESS_New.Queue 
INSERT INTO MERGEPROCESS_New.Queue
/*
SELECT PK_MergeID, b.MergeType,  MAX(CASE WHEN xRank =1 THEN CAST(c.ID AS VARCHAR(100)) END) AS Winner, MAX(CASE WHEN xRank =2 THEN CAST(c.ID AS VARCHAR(100)) END) AS Loser 
FROM dbo.vwDimCustomer_ModAcctID a 
JOIN MERGEPROCESS_New.DetectedMerges b ON a.SSB_CRMSYSTEM_ACCT_ID = b.SSBID AND SourceSystem = @Account
JOIN MERGEPROCESS_New.vwMergeAccountRanks c ON a.SSID = CAST(c.ID AS VARCHAR(100))
WHERE (AutoMerge = 1 OR (AutoMerge = 0 AND Approved = 1))
	AND NumRecords = 2	
AND b.MergeType = 'Account'
AND MergeComplete = 0 
GROUP BY PK_MergeID,b.MergeType
HAVING MAX(CASE WHEN xRank =1 THEN CAST(c.ID AS VARCHAR(100)) END) IS NOT NULL AND  MAX(CASE WHEN xRank =2 THEN CAST(c.ID AS VARCHAR(100)) END) IS NOT NULL

UNION ALL
*/
SELECT PK_MergeID, b.MergeType,  MAX(CASE WHEN xRank =1 THEN CAST(c.ID AS VARCHAR(100)) END) AS Winner, MAX(CASE WHEN xRank =2 THEN CAST(c.ID AS VARCHAR(100)) END) AS Loser  
FROM dbo.Hash_ContactID a 
JOIN MERGEPROCESS_New.DetectedMerges b ON a.name_email_hash = b.name_email_hash
JOIN MERGEPROCESS_New.vwMergeContactRanks c ON a.contactid = CAST(c.ID AS VARCHAR(100))
WHERE (AutoMerge = 1 OR (AutoMerge = 0 AND Approved = 1))
	--AND NumRecords = 2	
	AND b.MergeType = 'Contact'
	AND MergeComplete = 0 
GROUP BY PK_MergeID,b.MergeType
HAVING MAX(CASE WHEN xRank =1 THEN CAST(c.ID AS VARCHAR(100)) END) IS NOT NULL AND  MAX(CASE WHEN xRank =2 THEN CAST(c.ID AS VARCHAR(100)) END) IS NOT NULL



GO
