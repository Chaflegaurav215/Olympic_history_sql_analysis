USE [master]
GO

/****** Object:  Table [dbo].[athlete_events]    Script Date: 12/10/2025 4:07:11 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[athlete_events](
	[athlete_id] [float] NULL,
	[games] [nvarchar](255) NULL,
	[year] [float] NULL,
	[season] [nvarchar](255) NULL,
	[city] [nvarchar](255) NULL,
	[sport] [nvarchar](255) NULL,
	[event] [nvarchar](255) NULL,
	[medal] [nvarchar](255) NULL
) ON [PRIMARY]
GO


