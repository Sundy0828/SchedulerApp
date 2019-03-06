CREATE TABLE [dbo].[Majors](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Courses] [nvarchar](max) NULL,
	[IsMajor] [bit] NOT NULL,
	[School_ID] [int] NOT NULL,
 CONSTRAINT [PK_Majors] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Majors] ADD  CONSTRAINT [DF_Majors_School_ID]  DEFAULT ((1)) FOR [School_ID]
GO

ALTER TABLE [dbo].[Majors]  WITH CHECK ADD  CONSTRAINT [FK_Majors_Schools] FOREIGN KEY([School_ID])
REFERENCES [dbo].[Schools] ([ID])
GO

ALTER TABLE [dbo].[Majors] CHECK CONSTRAINT [FK_Majors_Schools]
GO