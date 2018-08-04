SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




create VIEW [mergeprocess_new].[vwMergeContactRanks]

AS

SELECT a.name_email_hash
	, c.contactid ID
	--Add in custom ranking here
	,ROW_NUMBER() OVER(PARTITION BY a.name_email_hash ORDER BY CASE WHEN ISNULL(str_number,'') != '' THEN 1 ELSE 0 END DESC
	, c.str_lastactivitydate DESC
	, c.Modifiedon DESC
	, c.createdon DESC
	, c.contactid) xRank
FROM MERGEPROCESS_New.DetectedMerges a
JOIN dbo.hash_contactid b 
	ON a.name_email_hash = b.name_email_hash
	AND a.MergeType = 'Contact'
JOIN chicagofire_reporting.Prodcopy.contact c
	ON b.contactid = c.contactid
	--AND c.statuscodename = 'Active'
WHERE MergeComplete = 0;




GO
