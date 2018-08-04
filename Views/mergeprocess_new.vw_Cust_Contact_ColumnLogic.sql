SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO












CREATE VIEW [mergeprocess_new].[vw_Cust_Contact_ColumnLogic]
AS
SELECT  ID AS targetid ,
		Slave_ID AS subordinateid ,					--	DCH 2016-10-04
		aa.name_email_hash,
		1 AS CoalesceNonEmptyValues,
        CAST(SUBSTRING(donotbulkemail, 2, 1) AS BIT) donotbulkemail ,
        CAST(SUBSTRING(donotemail, 2, 1) AS BIT) donotemail ,
        CAST(SUBSTRING(aa.donotbulkpostalmail, 2, 1) AS BIT) donotbulkpostalmail,
		CAST(SUBSTRING(aa.donotfax, 2, 1) AS BIT) donotfax,
		CAST(SUBSTRING(donotphone, 2, 1) AS BIT) donotphone ,
		CAST(SUBSTRING(donotpostalmail, 2, 1) AS BIT) donotpostalmail ,
		CAST(SUBSTRING(donotsendmm, 2, 1) AS BIT) donotsendmm
		,CAST(SUBSTRING(ownerid, 2, 50) AS NVARCHAR(100)) ownerid
		,CAST(SUBSTRING(owneridname, 2, 50) AS NVARCHAR(100)) owneridname
		, 'systemuser' AS owneridtype
		, NULLIF(c.str_number,'') str_number
	
FROM    ( SELECT    Master_SFID AS ID ,
					Slave_SFID AS Slave_ID ,					--	DCH 2016-10-04
					name_email_hash,
                    MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotbulkemail,0) <> 0
                             THEN '2' + CAST(donotbulkemail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotbulkemail,0) <> 0
                             THEN '1' + CAST(donotbulkemail AS VARCHAR(10))
							 ELSE '00'
                        END) donotbulkemail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotemail,0) <> 0
                             THEN '2' + CAST(donotemail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotemail,0) <> 0
                             THEN '1' + CAST(donotemail AS VARCHAR(10))
							 ELSE '00'
                        END) donotemail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotbulkpostalmail,0) <> 0
                             THEN '2' + CAST(donotbulkpostalmail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotbulkpostalmail,0) <> 0
                             THEN '1' + CAST(donotbulkpostalmail AS VARCHAR(10))
							 ELSE '00'
                        END) donotbulkpostalmail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotfax,0)  <> 0
                             THEN '2' + CAST(donotfax AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotfax,0) <> 0
                             THEN '1' + CAST(donotfax AS VARCHAR(10))
							 ELSE '00'
                        END) donotfax ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotphone,0) <> 0
                             THEN '2' + CAST(donotphone AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(donotphone,0) <> 0
                             THEN '1' + CAST(donotphone AS VARCHAR(10))
							 ELSE '00'
                        END) donotphone ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(donotpostalmail,0)  <> 0
                             THEN '2' + CAST(dta.donotpostalmail AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(dta.donotpostalmail,0) <> 0
                             THEN '1' + CAST(dta.donotpostalmail AS VARCHAR(10))
							 ELSE '00'
                        END) donotpostalmail ,
					MAX(CASE WHEN dta.xtype = 'Master'
                                  AND ISNULL(dta.donotsendmm,0) <> 0
                             THEN '2' + CAST(dta.donotsendmm AS VARCHAR(10))
                             WHEN dta.xtype = 'Slave'
                                  AND ISNULL(dta.donotsendmm,0) <> 0
                             THEN '1' + CAST(dta.donotsendmm AS VARCHAR(10))
							 ELSE '00'
                        END) donotsendmm
					,MAX(CASE WHEN dta.xtype = 'Master'
                                  AND dta.ownerid NOT IN ('B1B93224-CFE5-E711-A95A-000D3A180B20', 'A7B93224-CFE5-E711-A95A-000D3A180B20')
                             THEN '2' + CAST(dta.ownerid AS NVARCHAR(50))
                             WHEN dta.xtype = 'Slave'
                                  AND ownerid IS NOT NULL 
                             THEN '1' + CAST(dta.ownerid AS VARCHAR(50))
                        END) ownerid
					,MAX(CASE WHEN dta.xtype = 'Master'
                                  AND dta.ownerid NOT IN ('B1B93224-CFE5-E711-A95A-000D3A180B20', 'A7B93224-CFE5-E711-A95A-000D3A180B20')
                             THEN '2' + CAST(dta.owneridname AS NVARCHAR(50))
                             WHEN dta.xtype = 'Slave'
                                  AND owneridname IS NOT NULL 
                             THEN '1' + CAST(dta.owneridname AS VARCHAR(50))
                        END) owneridname
						--,  STUFF(b.str_number,1,0,b.str_number
						
	

          FROM      ( SELECT    *
                      FROM      ( SELECT    'Master' xtype ,
                                            a.Master_SFID ,
											a.Slave_SFID ,					--	DCH 2016-10-04
						
                                            b.*
                                  FROM      [MERGEPROCESS_New].[Queue] a
                                            JOIN ChicagoFire_Reporting.prodcopy.contact b ON a.Master_SFID = b.contactid
											--where fk_mergeid < 1000
                                  UNION ALL
                                  SELECT    'Slave' xtype ,
                                            a.Master_SFID ,
											a.Slave_SFID ,					--	DCH 2016-10-04
									
                                            b.*
                                  FROM      [MERGEPROCESS_New].[Queue] a
                                            JOIN  ChicagoFire_Reporting.prodcopy.contact b ON a.Slave_SFID = b.contactid
											--where fk_mergeid < 1000
                                ) x
                    ) dta
          GROUP BY  Master_SFID ,
					Slave_SFID					--	DCH 2016-10-04			
					,name_email_hash	
        ) aa
	LEFT JOIN dbo.concatids c
	ON aa.name_email_hash = c.name_email_hash
	--WHERE 1= 2
/*
where ID IN ('E4E2D6F3-C470-DC11-8633-001143E50512','54E777B7-1D1D-E211-BF41-001D0967E0FC','8A445D0C-10FF-E011-A528-001D0967E0FC')

*/

;







GO
