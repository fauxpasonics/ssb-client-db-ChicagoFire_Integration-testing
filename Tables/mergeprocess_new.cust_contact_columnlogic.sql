CREATE TABLE [mergeprocess_new].[cust_contact_columnlogic]
(
[targetid] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[subordinateid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[name_email_hash] [binary] (32) NULL,
[CoalesceNonEmptyValues] [int] NOT NULL,
[donotbulkemail] [bit] NULL,
[donotemail] [bit] NULL,
[donotbulkpostalmail] [bit] NULL,
[donotfax] [bit] NULL,
[donotphone] [bit] NULL,
[donotpostalmail] [bit] NULL,
[donotsendmm] [bit] NULL,
[ownerid] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridname] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[owneridtype] [varchar] (10) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[str_number] [nvarchar] (max) COLLATE SQL_Latin1_General_CP1_CI_AS NULL
)
GO
