CREATE TABLE [mergeprocess_new].[contactmerge_processlog]
(
[donotbulkemail] [bit] NULL,
[donotemail] [bit] NULL,
[donotbulkpostalmail] [bit] NULL,
[donotfax] [bit] NULL,
[donotphone] [bit] NULL,
[donotpostalmail] [bit] NULL,
[donotsendmm] [bit] NULL,
[targetid] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[subordinateid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[CoalesceNonEmptyValues] [int] NULL,
[owneridtype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[name_email_hash] [binary] (32) NULL,
[ownerid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[str_number] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ErrorCode] [int] NULL,
[ErrorColumn] [int] NULL,
[CrmErrorMessage] [nvarchar] (2048) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[ObjectType] [nvarchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
