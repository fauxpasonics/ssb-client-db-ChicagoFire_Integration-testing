CREATE TABLE [mergeprocess_new].[Queue]
(
[FK_MergeID] [int] NOT NULL,
[ObjectType] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Master_SFID] [varchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL,
[Slave_SFID] [nvarchar] (100) COLLATE SQL_Latin1_General_CP1_CI_AS NOT NULL
)
GO
ALTER TABLE [mergeprocess_new].[Queue] ADD CONSTRAINT [FK_MergeID] PRIMARY KEY CLUSTERED  ([FK_MergeID])
GO
