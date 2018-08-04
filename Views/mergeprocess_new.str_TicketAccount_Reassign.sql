SET QUOTED_IDENTIFIER ON
GO
SET ANSI_NULLS ON
GO
CREATE VIEW [mergeprocess_new].[str_TicketAccount_Reassign]
AS 
SELECT q.Master_SFID AS str_contactid, q.Slave_SFID subordinateid, ta.str_ticketaccountid, ta.str_contactid str_contactid_old 
FROM mergeprocess_new.Queue q
INNER JOIN ChicagoFire_Reporting.prodcopy.str_TicketAccount ta
ON ta.str_contactid = q.Slave_SFID
GO
