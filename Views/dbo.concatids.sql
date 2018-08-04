SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO

CREATE VIEW [dbo].[concatids]
AS
 SELECT DISTINCT x1.name_email_hash, ISNULL(LEFT(STUFF((SELECT ' ' + x2.str_number   AS [text()]
 FROM chicagofire_reporting.prodcopy.Contact x2
 WHERE x1.name_email_hash=x2.name_email_hash
 ORDER BY x2.name_email_hash

 FOR XML PATH ('')),1,1,''),8000),'') AS str_number
 --INTO #STMFields
 FROM ChicagoFire_Reporting.prodcopy.contact x1

GO
