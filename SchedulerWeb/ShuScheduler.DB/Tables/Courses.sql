CREATE TABLE [dbo].[Courses](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[MCode] [nvarchar](3) NOT NULL,
	[CCode] [nvarchar](3) NOT NULL,
	[SCode] [nvarchar](2) NULL,
	[Title] [nvarchar](100) NOT NULL,
	[Prerequisites] [nvarchar](max) NULL,
	[Semester_ID] [int] NOT NULL,
	[Year_ID] [int] NOT NULL,
	[TimePeriodStart] [datetime] NULL,
	[TimePeriodEnd] [datetime] NULL,
	[Credits] [int] NOT NULL,
	[LibArt_ID] [int] NOT NULL,
	[School_ID] [int] NOT NULL,
 CONSTRAINT [PK_Courses] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO

ALTER TABLE [dbo].[Courses] ADD  CONSTRAINT [DF_Courses_LACur]  DEFAULT ((1)) FOR [LibArt_ID]
GO

ALTER TABLE [dbo].[Courses] ADD  CONSTRAINT [DF_Courses_School_ID]  DEFAULT ((1)) FOR [School_ID]
GO

ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_LibArts] FOREIGN KEY([LibArt_ID])
REFERENCES [dbo].[LibArts] ([ID])
GO

ALTER TABLE [dbo].[Courses] CHECK CONSTRAINT [FK_Courses_LibArts]
GO

ALTER TABLE [dbo].[Courses]  WITH CHECK ADD  CONSTRAINT [FK_Courses_Schools] FOREIGN KEY([School_ID])
REFERENCES [dbo].[Schools] ([ID])
GO