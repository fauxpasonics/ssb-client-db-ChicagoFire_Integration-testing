CREATE TABLE [mergeprocess_new].[receiveresults]
(
[contactid] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[donotbulkemail] [bit] NULL,
[donotemail] [bit] NULL,
[donotbulkpostalmail] [bit] NULL,
[donotfax] [bit] NULL,
[donotphone] [bit] NULL,
[donotpostalmail] [bit] NULL,
[donotsendmm] [bit] NULL,
[CrmRecordId] [uniqueidentifier] NULL,
[IsNew] [bit] NULL,
[CrmErrorMessage] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorColumn] [int] NULL,
[losing_contactid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ObjectType] [nvarchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ProcessDate] [datetime] NULL CONSTRAINT [DF__receivere__Proce__4CA06362] DEFAULT (getdate())
)
GO
