USE [master]
GO

/****** Object:  Table [dbo].[athletes]    Script Date: 12/10/2025 4:13:12 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[athletes](
	[id] [float] NULL,
	[name] [nvarchar](255) NULL,
	[sex] [nvarchar](255) NULL,
	[height] [float] NULL,
	[weight] [float] NULL,
	[team] [nvarchar](255) NULL
) ON [PRIMARY]
GO


