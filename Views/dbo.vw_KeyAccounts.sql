SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO




CREATE VIEW [dbo].[vw_KeyAccounts]
AS

WITH TA AS (
SELECT pcc.name_email_hash, COUNT(*) count
FROM ChicagoFire_Reporting.prodcopy.contact pcc
--INNER JOIN ChicagoFire_Reporting.prodcopy.str_ticketaccount ta
--ON pcc.contactid = ta.str_contactid
WHERE pcc.statecode = 0
--AND ta.statecode = 0
AND pcc.str_category IS NOT NULL
AND pcc.name_email_hash IS NOT NULL
GROUP BY pcc.name_email_hash
HAVING COUNT(*) > 1
)


SELECT contactid, firstname, lastname, emailaddress1, pc.name_email_hash, str_category
FROM chicagofire_reporting.prodcopy.contact pc
LEFT JOIN TA t
ON pc.name_email_hash = t.name_email_hash
WHERE (pc.name_email_hash IS NOT null
-- AND (str_category IS NOT NULL
and t.name_email_hash IS NOT NULL)
--ORDER BY 5
 OR pc.contactid IN ('837736D8-11C3-E211-8425-005056B1000B','FE5CC935-EEAF-E711-80E6-000C29E71BA1')


GO
