CREATE TABLE [mergeprocess_new].[DetectedMerges]
(
[MergeType] [varchar] (7) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[name_email_hash] [binary] (32) NOT NULL,
[AutoMerge] [int] NOT NULL,
[NumRecords] [int] NULL,
[DetectedDate] [date] NOT NULL,
[MergeComplete] [bit] NOT NULL CONSTRAINT [DF_DetectedMerges_MergeComplete] DEFAULT ((0)),
[MergeComment] [varchar] (1000) COLLATE SQL_Latin1_General_CP1_CI_AS NULL,
[Approved] [bit] NULL,
[ApprovedDate] [datetime] NULL,
[PK_MergeID] [int] NOT NULL IDENTITY(1, 1)
)
GO
ALTER TABLE [mergeprocess_new].[DetectedMerges] ADD CONSTRAINT [PK_DetectedMerges] PRIMARY KEY CLUSTERED  ([MergeType], [name_email_hash])
GO
