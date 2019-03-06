CREATE TABLE [dbo].[Schools](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[SchoolName] [nvarchar](250) NOT NULL,
	[PrimaryColor] [nvarchar](50) NULL,
	[SecondayColor] [nvarchar](50) NULL,
 CONSTRAINT [PK_Schools] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO