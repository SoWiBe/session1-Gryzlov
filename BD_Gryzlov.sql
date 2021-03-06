USE [user6]
GO
/****** Object:  Table [dbo].[type_agents]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[type_agents](
	[ID] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
 CONSTRAINT [PK_type_agents] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[products]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[products](
	[Id] [int] NOT NULL,
	[NameProduct] [nvarchar](255) NULL,
	[TypeProduct] [nvarchar](255) NULL,
	[Articul] [float] NULL,
	[CountPeople] [float] NULL,
	[NumberAngar] [float] NULL,
	[MinPriceForAgent] [float] NULL,
 CONSTRAINT [PK_products] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[agents]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[agents](
	[IdType] [int] NOT NULL,
	[Type] [nvarchar](255) NULL,
	[IDAgent] [int] NOT NULL,
	[Name] [nvarchar](255) NULL,
	[Email] [nvarchar](255) NULL,
	[Phone] [nvarchar](255) NULL,
	[Logo] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Priority] [nvarchar](255) NULL,
	[Director] [nvarchar](255) NULL,
	[INN] [float] NULL,
	[KPP] [float] NULL,
 CONSTRAINT [PK_agents] PRIMARY KEY CLUSTERED 
(
	[IDAgent] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productSale]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productSale](
	[IdSale] [int] IDENTITY(1,1) NOT NULL,
	[ID] [int] NULL,
	[Продукция] [nvarchar](255) NULL,
	[InAgent] [int] NULL,
	[Наименование агента] [nvarchar](255) NULL,
	[Дата реализации] [datetime] NULL,
	[Количество продукции] [int] NULL,
 CONSTRAINT [PK_productSale] PRIMARY KEY CLUSTERED 
(
	[IdSale] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[VW_AgentDetails]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[VW_AgentDetails]
AS
SELECT        dbo.agents.IDAgent, dbo.agents.Name, dbo.agents.Phone, dbo.agents.Priority, dbo.type_agents.Name AS Expr1, CASE WHEN A.Сумма_Продаж < 10000 THEN 5 WHEN A.Сумма_Продаж >= 10000 THEN 25 END AS Скидка
FROM            (SELECT        s.InAgent, SUM(s.[Количество продукции] * p.MinPriceForAgent) AS Сумма_Продаж
                          FROM            dbo.products AS p INNER JOIN
                                                    dbo.productSale AS s ON p.Id = s.ID
                          GROUP BY s.InAgent) AS A LEFT OUTER JOIN
                             (SELECT        s.InAgent, SUM(s.[Количество продукции] * p.MinPriceForAgent) AS Сумма_Продаж_ЗаГод
                               FROM            dbo.products AS p INNER JOIN
                                                         dbo.productSale AS s ON p.Id = s.ID
                               WHERE        (YEAR(s.[Дата реализации]) = YEAR(GETDATE()))
                               GROUP BY s.InAgent) AS b ON A.InAgent = b.InAgent INNER JOIN
                         dbo.agents ON A.InAgent = dbo.agents.IDAgent INNER JOIN
                         dbo.type_agents ON dbo.type_agents.ID = dbo.agents.IdType
GO
/****** Object:  Table [dbo].[HistoryPriority]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[HistoryPriority](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[oldPriority] [nvarchar](50) NULL,
	[newPriority] [nvarchar](50) NULL,
 CONSTRAINT [PK_HistoryPriority] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id_product] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id_product] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[productSale$ExternalData_2]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[productSale$ExternalData_2](
	[Продукция] [nvarchar](255) NULL,
	[InAgent] [float] NULL,
	[Наименование агента] [nvarchar](255) NULL,
	[Дата реализации] [datetime] NULL,
	[Количество продукции] [float] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[ID_user] [int] IDENTITY(1,1) NOT NULL,
	[Name] [nvarchar](50) NULL,
	[Password] [nvarchar](50) NULL,
	[Id_Product] [int] NULL,
 CONSTRAINT [PK_User] PRIMARY KEY CLUSTERED 
(
	[ID_user] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 1, N'CибБашкирТекстиль', N'vzimina@zdanova.com', N'(495) 285-78-38', N'\agents\agent_69.png', N'429540, Мурманская область, город Воскресенск, пл. Славы, 36', N'Приоритет = 218', N'Григорий Владимирович Елисеева', 7392007090, 576103661)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 2, N'CибГаз', N'inna.sarova@panfilov.ru', N'(495) 945-37-25', N'\agents\agent_103.png', N'365674, Архангельская область, город Серебряные Пруды, пр. Ленина, 29', N'488', N'Вячеслав Романович Третьякова', 6483417250, 455013058)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 3, N'CибПивОмскСнаб', N'evorontova@potapova.ru', N'+7 (922) 153-95-22', N'\agents\agent_46.png', N'816260, Ивановская область, город Москва, ул. Гагарина, 31', N'477 в приоритете на поставку', N'Людмила Александровна Сафонова', 5676173945, 256512286)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 4, N'ITСтройАлмаз', N'fokin.eduard@samoilov.com', N'8-800-185-78-91', N'\agents\agent_83.png', N'361730, Костромская область, город Волоколамск, шоссе Славы, 36', N'Приоритет = 159', N'Алексеева Валериан Андреевич', 7689065648, 456612755)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 5, N'Асбоцемент', N'antonin19@panfilov.ru', N' 8-800-211-16-23', N'\agents\agent_34.png', N'030119, Курганская область, город Дмитров, пер. Славы, 47', N'Приоритет = 273', N'Никитинаа Антонина Андреевна', 1261407459, 745921890)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 6, N'АсбоцементЛифтРеч-H', N'vladlena58@seliverstova.ru', N'(495) 245-57-16', N'\agents\agent_105.png', N'599158, Ростовская область, город Озёры, ул. Космонавтов, 05', N'407', N'Кондратьева Таисия Андреевна', 6567878928, 560960507)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 7, N'АсбоцементТехАвто', N'matveev.yliy@kiseleva.ru', N'+7 (922) 977-68-84', N'\agents\agent_110.png', N'304975, Пензенская область, город Солнечногорск, шоссе Балканская, 76', N'247 в приоритете на поставку', N'Сидорова Любовь Ивановна', 7626076463, 579234124)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 8, N'БашкирРечТомск', N' aleksandra77@karpov.com', N'8-800-254-71-85', N'\agents\agent_100.png', N'136886, Амурская область, город Видное, въезд Космонавтов, 39', N'84', N'Назарова Вера Андреевна', 7027724917, 823811460)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 9, N'БашкирФлотМотор-H', N' morozova.nika@kazakova.ru', N' (495) 793-84-82', N'\agents\agent_36.png', N'008081, Тюменская область, город Ногинск, въезд Гагарина, 94', N'416', N'Марат Алексеевич Фролов', 1657476072, 934931159)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 10, N'БашкирЮпитерТомск', N'dyckov.veniamin@kotova.ru', N'(812) 189-59-57', N'\agents\agent_59.png', N'035268, Сахалинская область, город Волоколамск, проезд Ладыгина, 51', N'139 в приоритете на поставку', N'Фадеева Раиса Александровна', 1606315697, 217799345)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 11, N'Бух', N'belova.vikentii@konstantinova.net', N' +7 (922) 375-49-21', N'\agents\agent_78.png', N'409600, Новгородская область, город Ногинск, пл. Гагарина, 68', N'82', N'Татьяна Сергеевна Королёваа', 1953785418, 122905583)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 12, N'БухВжух', N'valentina.bolsakova@aksenova.ru', N'(495) 367-21-41', N'отсутствует', N'481744, Амурская область, город Щёлково, пл. Сталина, 48', N'Приоритет = 327', N'Тарасов Болеслав Александрович', 2320989197, 359282667)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 13, N'БухМясМоторПром', N'varvara49@savin.ru', N'(35222) 83-23-59', N'\agents\agent_95.png', N'677498, Костромская область, город Зарайск, спуск Славы, 59', N'Приоритет = 158', N'Нина Дмитриевна Черноваа', 7377410338, 592041317)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 14, N'Вод', N' savva86@zaiteva.ru', N'(495) 142-19-84', N'\agents\agent_129.png', N'964386, Оренбургская область, город Чехов, пл. Косиора, 80', N'359', N'Зоя Романовна Селезнёва', 1296063939, 447430051)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 15, N'ВодГараж', N' pmaslov@fomiceva.com', N'+7 (922) 363-86-67', N'\agents\agent_67.png', N'988899, Саратовская область, город Раменское, пр. Славы, 40', N'250 в приоритете на поставку', N'Лаврентий Фёдорович Логинова', 5575072431, 684290320)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 16, N'ВодГор', N'tvetkova.robert@sorokin.com', N' (35222) 73-72-16', N'\agents\agent_125.png', N'265653, Калужская область, город Ступино, шоссе Гоголя, 89', N'Приоритет = 72', N'Фаина Фёдоровна Филиппова', 4463113470, 899603778)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 17, N'ВодТверьХозМашина', N'tkrylov@baranova.net', N' +7 (922) 849-91-96', N'\agents\agent_56.png', N'145030, Сахалинская область, город Шатура, въезд Гоголя, 79', N'Приоритет = 8', N'Александра Дмитриевна Ждановаа', 4174253174, 522227145)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 18, N'ВостокГлав', N'gordei95@kirillov.ru', N'(812) 949-29-26', N'\agents\agent_63.png', N'217022, Ростовская область, город Озёры, ул. Домодедовская, 19', N'Приоритет = 107', N'Инга Фёдоровна Дмитриева', 3580946305, 405017349)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 19, N'ВостокКазРыб', N'flukin@misin.org', N' (495) 987-31-63', N'\agents\agent_112.png', N'059565, Оренбургская область, город Истра, шоссе Домодедовская, 27', N'Приоритет = 361', N'Самсонов Родион Романович', 7411284960, 176779733)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 20, N'Газ', N'ulyna.antonov@noskov.ru', N'(35222) 22-45-58', N'\agents\agent_76.png', N'252821, Тамбовская область, город Пушкино, ул. Чехова, 40', N'170', N'Терентьев Илларион Максимович', 8876413796, 955381891)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 21, N'ГазДизайнЖелДор', N'elizaveta.komarov@rybakov.net', N'(495) 797-97-33', N'\agents\agent_49.png', N'695230, Курская область, город Красногорск, пр. Гоголя, 64', N'Приоритет = 236', N'Лев Иванович Третьяков', 2396029740, 458924890)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 22, N'Гараж', N'antonin51@korolev.com', N'(35222) 54-72-59', N'\agents\agent_90.png', N'585758, Самарская область, город Красногорск, бульвар Балканская, 13', N'Приоритет = 107', N'Панфилов Константин Максимович', 2638464552, 746822723)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 23, N'ГаражЛофт', N'lydmila.belyeva@karpov.ru', N'(495) 427-55-66', N'\agents\agent_108.png', N'294596, Мурманская область, город Шаховская, пр. Домодедовская, 88', N'Приоритет = 335', N'Клавдия Фёдоровна Кудряшова', 2816939574, 754741128)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 24, N'ГлавITФлотПроф', N'savva.rybov@kolobov.ru', N' (812) 146-66-46', N'\agents\agent_64.png', N'447811, Мурманская область, город Егорьевск, ул. Ленина, 24', N'62', N'Зыкова Стефан Максимович', 2561361494, 525678825)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 25, N'Гор', N'maiy12@koklov.net', N'(495) 973-48-55', N'\agents\agent_52.png', N'376483, Калужская область, город Сергиев Посад, ул. Славы, 09', N'175', N'Нонна Львовна Одинцоваа', 7088187045, 440309946)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 26, N'ЖелДорДизайнМетизТраст', N'lnikitina@kulikova.com', N'(812) 123-63-47', N'не указано', N'170549, Сахалинская область, город Видное, проезд Космонавтов, 89', N'290', N'Игорь Львович Агафонова', 7669116841, 906390137)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 27, N'Инфо', N'arsenii.mikailova@prokorov.com', N'8-800-793-59-97', N'\agents\agent_89.png', N'100469, Рязанская область, город Ногинск, шоссе Гагарина, 57', N'Приоритет = 304', N'Баранова Виктор Романович', 6549468639, 718386757)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 28, N'КазаньТекстиль', N'osimonova@andreeva.com', N'(35222) 86-74-21', N'\agents\agent_47.png', N'231891, Челябинская область, город Шатура, бульвар Ладыгина, 40', N'156 в приоритете на поставку', N'Александров Бронислав Максимович', 4584384019, 149680499)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 29, N'КазХоз', N'istrelkova@fomin.ru', N'+7 (922) 728-85-62', N'нет', N'384162, Астраханская область, город Одинцово, бульвар Гагарина, 57', N'Приоритет = 213', N'Степанова Роман Иванович', 6503377671, 232279972)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 30, N'КазЮпитерТомск', N'tgavrilov@frolov.ru', N'+7 (922) 772-33-58', N'\agents\agent_60.png', N'393450, Тульская область, город Кашира, пр. 1905 года, 47', N'244 в приоритете на поставку', N'Рафаил Андреевич Копылов', 9201745524, 510248846)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 31, N'Компания Алмаз', N'akalinina@zaitev.ru', N'+7 (922) 688-74-22', N'\agents\agent_121.png', N'016215, Воронежская область, город Зарайск, ул. Косиора, 48', N'Приоритет = 259', N'Фоминаа Лариса Романовна', 6698862694, 662876919)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 32, N'Компания ВодАлмазIT', N'zakar37@nikolaeva.ru', N'(35222) 52-76-16', N'\agents\agent_111.png', N'302100, Нижегородская область, город Мытищи, пер. 1905 года, 63', N'31', N'Гуляев Егор Евгеньевич', 2345297765, 908449277)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 33, N'Компания Газ', N'alina56@zdanov.com', N' (35222) 75-96-85', N'\agents\agent_120.png', N'310403, Кировская область, город Солнечногорск, пл. Балканская, 76', N'Приоритет = 445', N'Давид Андреевич Фадеев', 2262431140, 247369527)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 34, N'Компания Гараж', N' asiryeva@andreeva.com', N'+7 (922) 848-38-54', N'\agents\agent_66.png', N'395101, Белгородская область, город Балашиха, бульвар 1905 года, 00', N'413', N'Владлена Фёдоровна Ларионоваа', 6190244524, 399106161)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 35, N'Компания ЖелДорТверьМонтаж', N' burova.zlata@zueva.ru', N'(495) 521-61-75', N'\agents\agent_85.png', N'152424, Рязанская область, город Сергиев Посад, ул. 1905 года, 27', N'2', N'Нестор Максимович Гуляев', 3325722996, 665766347)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 36, N'Компания КазАлмаз', N'irina.gusina@vlasova.ru', N'8-800-533-24-75', N'\agents\agent_80.png', N'848810, Кемеровская область, город Лотошино, пер. Ломоносова, 90', N'396 в приоритете на поставку', N'Марк Фёдорович Муравьёва', 3084797352, 123190924)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 37, N'Компания КазМеталКазань', N' mmoiseev@teterin.ru', N'(495) 685-34-29', N'\agents\agent_130.png', N'532703, Пензенская область, город Чехов, наб. Чехова, 81', N'Приоритет = 252', N'Валерий Владимирович Хохлова', 4598939812, 303467543)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 38, N'Компания КрепЦемент', N'rusakov.efim@nikiforov.ru', N' (812) 963-77-87', N'\agents\agent_50.png', N'423477, Мурманская область, город Кашира, бульвар Домодедовская, 61', N'426', N'Екатерина Львовна Суворова', 3025099903, 606083992)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 39, N'Компания Монтаж', N'afanasev.anastasiy@muravev.ru', N' (35222) 92-45-98', N'\agents\agent_75.png', N'036381, Брянская область, город Кашира, бульвар Гагарина, 76', N'124', N'Силин Даниил Иванович', 6206428565, 118570048)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 40, N'Компания МоторТелекомЦемент-М', N'larisa44@silin.org', N'(812) 857-95-57', N'\agents\agent_118.png', N'021293, Амурская область, город Наро-Фоминск, шоссе Славы, 40', N'237', N'Иван Евгеньевич Белоусова', 7326832482, 440199498)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 41, N'Компания МясДизайнДизайн', N' gleb.gulyev@belyeva.com', N' (812) 535-17-25', N'\agents\agent_53.png', N'557264, Брянская область, город Серпухов, въезд Гоголя, 34', N'491', N'Клементина Сергеевна Стрелкова', 8004989990, 908629456)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 42, N'Компания СервисРадиоГор', N'nika.nekrasova@kovalev.ru', N' 8-800-676-32-86', N'\agents\agent_40.png', N'547196, Ульяновская область, город Серебряные Пруды, въезд Балканская, 81', N'169', N'Попов Вадим Александрович', 8880473721, 729975116)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 43, N'Компания СервисТелеМотор', N' veronika.egorov@bespalova.com', N' +7 (922) 461-25-29', N'\agents\agent_102.png', N'625988, Вологодская область, город Озёры, пр. Гоголя, 18', N'81 в приоритете на поставку', N'Фролова Эдуард Борисович', 3248454160, 138472695)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 44, N'Компания ТелекомХмельГаражПром', N' qkolesnikova@kalinina.ru', N'(812) 983-91-73', N'\agents\agent_71.png', N'126668, Ростовская область, город Зарайск, наб. Гагарина, 69', N'Приоритет = 457', N'Костина Татьяна Борисовна', 1614623826, 824882264)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 45, N'Компания ТомскХоз', N' nelli11@gureva.ru', N' +7 (922) 849-13-37', N'\agents\agent_115.png', N'861543, Томская область, город Истра, бульвар Славы, 42', N'464', N'Лазарева Аркадий Сергеевич', 8430391035, 961540858)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 46, N'Компания ФинансСервис', N' robert.serbakov@safonova.ru', N'(812) 878-42-71', N'\agents\agent_38.png', N'841700, Брянская область, город Серпухов, спуск Домодедовская, 35', N'395 в приоритете на поставку', N'Клавдия Сергеевна Виноградова', 7491491391, 673621812)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 47, N'Компания Хмель', N'ermakov.mark@isakova.ru', N' (812) 421-77-82', N'отсутствует', N'889757, Новосибирская область, город Раменское, бульвар 1905 года, 93', N'2', N'Владимир Борисович Суворова', 9004087602, 297273898)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 48, N'Креп', N'savina.dominika@belousova.com', N' (495) 217-46-29', N'\agents\agent_39.png', N'336489, Калининградская область, город Можайск, наб. Славы, 35', N'371', N'Назар Алексеевич Григорьева', 4880732317, 258673591)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 49, N'Лифт', N' zinaida01@bespalova.ru', N' (812) 484-92-38', N'\agents\agent_101.png', N'479565, Курганская область, город Клин, пл. Ленина, 54', N'92', N'Вера Евгеньевна Денисоваа', 6169713039, 848972934)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 50, N'МеталСервисМор', N'xdanilov@titov.ru', N'(35222) 91-28-62', N'нет', N'293265, Иркутская область, город Клин, пр. Славы, 12', N'475', N'Коновалова Кирилл Львович', 6922817841, 580142825)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 51, N'МеталТекстильЛифтТрест', N' muravev.trofim@sazonov.net', N'(812) 753-96-76', N'\agents\agent_86.png', N'786287, Свердловская область, город Волоколамск, пер. Будапештсткая, 72', N'425', N'Одинцов Назар Борисович', 2971553297, 821859486)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 52, N'МетизСтрой', N'kristina.pakomov@burova.ru', N' 8-800-172-62-56', N'\agents\agent_94.png', N'254238, Нижегородская область, город Павловский Посад, проезд Балканская, 23', N'Приоритет = 374', N'Ева Борисовна Беспалова', 4024742936, 295608432)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 53, N'МетизТехАвтоПроф', N'anastasiy.gromov@samsonova.com', N' (495) 581-42-46', N'\agents\agent_33.png', N'713016, Брянская область, город Подольск, пл. Домодедовская, 93', N'Приоритет = 321', N'Егор Фёдорович Третьякова', 2988890076, 215491048)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 54, N'Мобайл', N' dsiryev@dementeva.com', N'8-800-618-73-37', N'\agents\agent_107.png', N'606703, Амурская область, город Чехов, пл. Будапештсткая, 91', N'464', N'Екатерина Сергеевна Бобылёва', 7803888520, 885703265)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 55, N'Монтаж', N' zakar.sazonova@gavrilov.ru', N'(495) 867-76-15', N'не указано', N'066594, Магаданская область, город Шаховская, спуск Сталина, 59', N'Приоритет = 300', N'Блохина Сергей Максимович', 6142194281, 154457435)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 56, N'МонтажОрионУрал', N' pzaitev@blokin.org', N'(35222) 67-39-26', N'\agents\agent_96.png', N'027573, Тамбовская область, город Коломна, ул. Ленина, 20', N'50', N'Давыдоваа Нина Евгеньевна', 1692286718, 181380912)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 57, N'МясРеч', N'bkozlov@volkov.ru', N'8-800-453-63-45', N'\agents\agent_58.png', N'903648, Калужская область, город Воскресенск, пр. Будапештсткая, 91', N'355', N'Белоусоваа Ирина Максимовна', 9254261217, 656363498)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 58, N'МясТрансМоторЛизинг', N' vlad.sokolov@andreev.org', N' +7 (922) 676-34-94', N'\agents\agent_62.png', N'765320, Ивановская область, город Шатура, спуск Гоголя, 88', N'268', N'Тамара Дмитриевна Семёноваа', 6148685143, 196332656)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 59, N'Орион', N' aleksei63@kiselev.ru', N'8-800-621-61-93', N'\agents\agent_77.png', N'951035, Ивановская область, город Ступино, шоссе Космонавтов, 73', N'166', N'Мартынов Михаил Борисович', 2670166502, 716874456)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 60, N'ОрионГлав', N'sermakova@sarova.net', N' +7 (922) 684-13-74', N'\agents\agent_106.png', N'729639, Магаданская область, город Талдом, въезд Будапештсткая, 98', N'Приоритет = 482', N'Тимофеева Григорий Андреевич', 9032455179, 763045792)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 61, N'ОрионСофтВодСнос', N'isukanov@sobolev.com', N'(35222) 59-75-11', N'\agents\agent_97.png', N'577227, Калужская область, город Павловский Посад, наб. Чехова, 35', N'361 в приоритете на поставку', N'Мухина Ян Фёдорович', 1522348613, 977738715)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 62, N'ОрионТомскТех', N'faina.tikonova@veselov.com', N'+7 (922) 542-89-15', N'\agents\agent_119.png', N'738763, Курская область, город Егорьевск, спуск Чехова, 66', N'Приоритет = 73', N'Георгий Александрович Лукин', 9351493429, 583041591)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 63, N'Радио', N'rtretykova@kozlov.ru', N'8-800-897-32-78', N'\agents\agent_43.png', N'798718, Ленинградская область, город Пушкино, бульвар Балканская, 37', N'221', N'Эмма Андреевна Колесникова', 9077613654, 657690787)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 64, N'РадиоСевер', N'maiy.belov@rogov.ru', N'(495) 368-86-51', N'\agents\agent_123.png', N'491360, Московская область, город Одинцово, въезд Ленина, 19', N'431', N'Карпов Иосиф Максимович', 5889206249, 372789083)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 65, N'Рем', N'zanna25@nikiforova.com', N' (495) 987-88-53', N'\agents\agent_79.png', N'707812, Иркутская область, город Шаховская, ул. Гагарина, 17', N'Приоритет = 329', N'Шароваа Елизавета Львовна', 3203830728, 456254820)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 66, N'РемВод', N'komarov.elizaveta@agafonova.ru', N'+7 (922) 353-31-72', N'\agents\agent_126.png', N'449723, Смоленская область, город Наро-Фоминск, пер. Ломоносова, 94', N'1 в приоритете на поставку', N'Медведеваа Ярослава Фёдоровна', 3986603105, 811373078)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 67, N'РемГаражЛифт', N'novikova.gleb@sestakov.ru', N' 8-800-772-27-53', N'\agents\agent_65.png', N'048715, Ивановская область, город Люберцы, проезд Космонавтов, 89', N'Приоритет = 374', N'Филатов Владимир Максимович', 1656477206, 988968838)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 68, N'РемСантехОмскБанк', N'anisimov.mark@vorobev.ru', N' (812) 182-44-77', N'\agents\agent_57.png', N'289468, Омская область, город Видное, пер. Балканская, 33', N'Приоритет = 442', N'Фокина Искра Максимовна', 6823050572, 176488617)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 69, N'РемСтрем', N'rafail96@sukin.ru', N' (35222) 55-28-24', N'\agents\agent_116.png', N'373761, Псковская область, город Наро-Фоминск, наб. Гагарина, 03', N'88', N'Альбина Александровна Романова', 9006569852, 152177100)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 70, N'РосАвтоМонтаж', N'lapin.inessa@isaeva.com', N'(495) 445-97-76', N'\agents\agent_55.png', N'331914, Курская область, город Ногинск, спуск Ладыгина, 66', N'10 в приоритете на поставку', N'Диана Алексеевна Исаковаа', 4735043946, 263682488)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 71, N'СантехБашкир', N' nikodim81@kiseleva.com', N' +7 (922) 155-87-39', N'\agents\agent_99.png', N'180288, Тверская область, город Одинцово, ул. Бухарестская, 37', N'369 в приоритете на поставку', N'Виктор Иванович Молчанов', 4159215346, 639267493)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 72, N'СантехСеверЛенМашина', N' pgorbacev@vasilev.net', N'(812) 918-88-43', N'\agents\agent_74.png', N'606990, Новосибирская область, город Павловский Посад, въезд Домодедовская, 38', N'201', N'Павел Максимович Рожков', 3506691089, 830713603)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 73, N'СервисХмельМонтаж', N'galina31@melnikov.ru', N'+7 (922) 344-73-38', N'\agents\agent_92.png', N'928260, Нижегородская область, город Балашиха, пл. Косиора, 44', N'124 в приоритете на поставку', N'Анжелика Дмитриевна Горбунова', 3459886235, 356196105)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 74, N'Софт', N'jterentev@ersov.com', N'(35222) 12-82-65', N'\agents\agent_122.png', N'453714, Смоленская область, город Одинцово, спуск Косиора, 84', N'292', N'Петухова Прохор Фёдорович', 3889910123, 952047511)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 75, N'СофтРосБух', N'ivanova.antonin@rodionov.ru', N'+7 (922) 445-69-17', N'\agents\agent_124.png', N'747695, Амурская область, город Сергиев Посад, въезд Бухарестская, 46', N'69', N'Белова Полина Владимировна', 8321561226, 807803984)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 76, N'Строй', N'soloveva.adam@andreev.ru', N'(812) 447-45-59', N'отсутствует', N'763019, Омская область, город Шатура, пл. Сталина, 56', N'12', N'Кудрявцев Адриан Андреевич', 6678884759, 279288618)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 77, N'СтройГорНефть', N' lysy.kolesnikova@molcanova.com', N' (812) 385-21-37', N'\agents\agent_37.png', N'444539, Ульяновская область, город Лотошино, спуск Будапештсткая, 95', N'161 в приоритете на поставку', N'Тарасова Макар Максимович', 5916775587, 398299418)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 78, N'ТверьМетизУралСнос', N' rlazareva@novikov.ru', N'(35222) 57-92-75', N'\agents\agent_109.png', N'880551, Ленинградская область, город Красногорск, ул. Гоголя, 61', N'165', N'Зоя Андреевна Соболева', 1076095397, 947828491)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 79, N'ТверьМонтажОмск', N'dteterina@selezneva.ru', N'8-800-363-43-86', N'\agents\agent_128.png', N'761751, Амурская область, город Балашиха, шоссе Гоголя, 02', N'Приоритет = 272', N'Матвей Романович Большакова', 2421347164, 157370604)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 80, N'ТверьХозМорСбыт', N' marina58@koroleva.com', N'(495) 416-75-67', N'\agents\agent_117.png', N'252101, Ростовская область, город Дорохово, пер. Ленина, 85', N'207', N'Аким Львович Субботина', 6681338084, 460530907)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 81, N'ТекстильУралАвтоОпт', N'hkononova@pavlova.ru', N' (35222) 98-76-54', N'не указано', N'028936, Магаданская область, город Видное, ул. Гагарина, 54', N'176', N'Алина Сергеевна Дьячковаа', 3930950057, 678529397)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 82, N'ТелеГлавВекторСбыт', N'nsitnikov@kovaleva.ru', N'(35222) 56-15-37', N'\agents\agent_31.png', N'062489, Челябинская область, город Пушкино, въезд Бухарестская, 07', N'185', N'Екатерина Фёдоровна Ковалёва', 9504787157, 419758597)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 83, N'ТелекомГор', N'gorskov.larisa@kalinin.com', N'(35222) 78-93-21', N'\agents\agent_98.png', N'210024, Белгородская область, город Сергиев Посад, наб. Ломоносова, 43', N'Приоритет = 255', N'Ксения Андреевна Михайлова', 3748947224, 766431901)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 84, N'ТелекомЮпитер', N'kulikov.adrian@zuravlev.org', N'(812) 895-67-23', N'\agents\agent_81.png', N'959793, Курская область, город Егорьевск, бульвар Ленина, 72', N'302', N'Калинина Татьяна Ивановна', 9383182378, 944520594)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 85, N'Тех', N'vasilisa99@belyev.ru', N'+7 (922) 427-13-31', N'\agents\agent_61.png', N'731935, Калининградская область, город Павловский Посад, наб. Гагарина, 59', N'278', N'Аким Романович Логинова', 9282924869, 587356429)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (3, N'МФО', 86, N'Транс', N'artem.fadeev@polykov.com', N'8-800-954-23-89', N'\agents\agent_127.png', N'508299, Кемеровская область, город Кашира, пер. Гагарина, 42', N'38', N'Евсеева Болеслав Сергеевич', 9604275878, 951258069)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 87, N'ТяжРадиоУралПроф', N'liliy62@grisina.ru', N'+7 (922) 885-66-15', N'\agents\agent_88.png', N'521087, Орловская область, город Егорьевск, шоссе Ладыгина, 14', N'278', N'София Алексеевна Мухина', 5688533246, 401535045)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 88, N'УралСтройХмель', N' aleksandr95@kolobova.ru', N'(35222) 39-23-65', N'\agents\agent_113.png', N'462632, Костромская область, город Шаховская, шоссе Сталина, 92', N'Приоритет = 372', N'Август Борисович Красильникова', 8773558039, 402502867)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (6, N'ПАО', 89, N'ФинансТелеТверь', N' medvedev.klim@afanasev.com', N'(812) 115-56-93', N'\agents\agent_45.png', N'687171, Томская область, город Лотошино, пл. Славы, 59', N'100', N'Зайцеваа Дарья Сергеевна', 2646091050, 971874277)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 90, N'Флот', N'gerasim.makarov@kornilov.ru', N'8-800-144-25-38', N'\agents\agent_87.png', N'505562, Тюменская область, город Наро-Фоминск, пр. Косиора, 11', N'Приоритет = 473', N'Василий Андреевич Ковалёв', 1112170258, 382584255)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 91, N'ХозЮпитер', N'jisakova@nazarova.com', N'+7 (922) 332-48-96', N'\agents\agent_114.png', N'038182, Курганская область, город Москва, спуск Космонавтов, 16', N'375', N'Максимоваа Вера Фёдоровна', 6667635058, 380592865)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (5, N'ООО', 92, N'Цемент', N'panova.klementina@bobrov.ru', N'8-800-517-78-47', N'\agents\agent_54.png', N'084315, Амурская область, город Шаховская, наб. Чехова, 62', N'340', N'Анфиса Фёдоровна Буроваа', 9662118663, 650216214)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 93, N'ЦементАсбоцемент', N' polykov.veronika@artemeva.ru', N' (495) 184-87-92', N'отсутствует', N'619540, Курская область, город Раменское, пл. Балканская, 12', N'426', N'Воронова Мария Александровна', 4345774724, 352469905)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 94, N'ЦементКрепТех-М', N' yna.evdokimov@gordeeva.ru', N' (812) 838-79-58', N'\agents\agent_82.png', N'263764, Свердловская область, город Раменское, пер. Косиора, 28', N'189 в приоритете на поставку', N'Сергеев Владлен Александрович', 5359981084, 680416300)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 95, N'Электро', N'likacev.makar@antonov.ru', N' 8-800-714-36-41', N'\agents\agent_93.png', N'966815, Новгородская область, город Одинцово, пр. Космонавтов, 19', N'Приоритет = 366', N'Шарапова Елена Дмитриевна', 7896029866, 786038848)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 96, N'ЭлектроМоторТрансСнос', N'inessa.voronov@sidorova.ru', N' (35222) 43-62-19', N'отсутствует', N'913777, Самарская область, город Красногорск, ул. Бухарестская, 49', N'Приоритет = 151', N'Людмила Евгеньевна Новиковаа', 6608362851, 799760512)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (1, N'ЗАО', 97, N'ЭлектроРемОрионЛизинг', N'anfisa.fedotova@tvetkov.ru', N'(495) 519-97-41', N'\agents\agent_68.png', N'594365, Ярославская область, город Павловский Посад, бульвар Космонавтов, 64', N'198', N'Тарасова Дан Львович', 1340072597, 500478249)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 98, N'ЭлектроТранс', N'boleslav.zukova@nikiforova.com', N' (812) 342-24-31', N'\agents\agent_91.png', N'434616, Калининградская область, город Павловский Посад, пл. Ладыгина, 83', N'Приоритет = 129', N'Сава Александрович Титова', 6019144874, 450629885)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (2, N'МКК', 99, N'ЮпитерЛенГараж-М', N'larkipova@gorbunov.ru', N'(495) 327-58-25', N'\agents\agent_48.png', N'339507, Московская область, город Видное, ул. Космонавтов, 11', N'470', N'Васильева Валерия Борисовна', 2038393690, 259672761)
INSERT [dbo].[agents] ([IdType], [Type], [IDAgent], [Name], [Email], [Phone], [Logo], [Address], [Priority], [Director], [INN], [KPP]) VALUES (4, N'ОАО', 100, N'ЮпитерТяжОрионЭкспедиция', N' gblokin@orlov.net', N' (35222) 95-63-65', N'\agents\agent_44.png', N'960726, Томская область, город Орехово-Зуево, въезд 1905 года, 51', N'446', N'Валерий Евгеньевич Виноградов', 6843174002, 935556458)
GO
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (1, N'Попрыгун 2299', N' Взрослый', 34750945, 2, 2, 1688)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (2, N'Попрыгун 3016', N' Цифровой', 74919447, 1, 12, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (3, N'Попрыгун 6412', N' Для больших деток', 28152672, 2, 9, 523)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (4, N'Попрыгун 6882', N' Упругий', 12732041, 1, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (5, N'Попрыгунчик детский 1916', N' Взрослый', 73345857, 5, 8, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (6, N'Попрыгунчик детский 2071', N' Для маленьких деток', 3157982, 3, 6, 275)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (7, N'Попрыгунчик детский 5117', N' Для больших деток', 80875656, 3, 12, 338)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (8, N'Попрыгунчик детский 6029', N' Для больших деток', 69184347, 3, 7, 419)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (9, N'Попрыгунчик детский 6888', N' Для маленьких деток', 13875235, 4, 12, 1972)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (10, N'Попрыгунчик детский желтый 1371', N' Цифровой', 85514178, 3, 7, 252)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (11, N'Попрыгунчик детский желтый 2582', N' Взрослый', 32125209, 3, 11, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (12, N'Попрыгунчик детский желтый 6051', N' Цифровой', 88211092, 4, 12, 727)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (13, N'Попрыгунчик детский желтый 6678', N' Для больших деток', 80007300, 2, 1, 1768)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (14, N'Попрыгунчик детский красный 1289', N' Для маленьких деток', 82925345, 4, 10, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (15, N'Попрыгунчик детский красный 1740', N' Взрослый', 43330133, 5, 3, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (16, N'Попрыгунчик детский красный 1972', N' Для больших деток', 59509797, 1, 7, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (17, N'Попрыгунчик детский красный 3240', N' Для больших деток', 88098604, 3, 8, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (18, N'Попрыгунчик детский красный 3839', N' Для больших деток', 26655484, 5, 2, 1921)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (19, N'Попрыгунчик детский красный 4969', N' Для маленьких деток', 10614909, 5, 12, 913)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (20, N'Попрыгунчик детский красный 5400', N' Взрослый', 68237918, 4, 5, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (21, N'Попрыгунчик детский красный 6591', N' Взрослый', 79704172, 5, 7, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (22, N'Попрыгунчик детский розовый 1657', N' Для маленьких деток', 86558177, 4, 3, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (23, N'Попрыгунчик детский розовый 2694', N' Для больших деток', 13340356, 4, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (24, N'Попрыгунчик детский розовый 5197', N' Цифровой', 89612317, 1, 3, 1948)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (25, N'Попрыгунчик детский розовый 5376', N' Для маленьких деток', 74291677, 4, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (26, N'Попрыгунчик детский розовый 5501', N' Взрослый', 25409940, 2, 7, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (27, N'Попрыгунчик детский розовый 6346', N' Цифровой', 30282346, 1, 10, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (28, N'Попрыгунчик для девочек 1560', N' Для маленьких деток', 47378395, 5, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (29, N'Попрыгунчик для девочек 1656', N' Цифровой', 22217580, 5, 6, 1494)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (30, N'Попрыгунчик для девочек 1895', N' Цифровой', 54983244, 4, 4, 1586)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (31, N'Попрыгунчик для девочек 2311', N' Взрослый', 25262035, 4, 1, 1308)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (32, N'Попрыгунчик для девочек 3389', N' Взрослый', 26434211, 3, 10, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (33, N'Попрыгунчик для девочек 6849', N' Взрослый', 10084400, 1, 11, 933)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (34, N'Попрыгунчик для кошечек 2604', N' Для маленьких деток', 11890154, 2, 7, 842)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (35, N'Попрыгунчик для кошечек 3741', N' Взрослый', 43987093, 5, 4, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (36, N'Попрыгунчик для кошечек 4740', N' Упругий', 80698285, 1, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (37, N'Попрыгунчик для мальчиков 3307', N' Цифровой', 30269726, 4, 10, 1533)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (38, N'Попрыгунчик для мальчиков 3929', N' Для маленьких деток', 2158097, 1, 9, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (39, N'Попрыгунчик для мальчиков 4791', N' Для больших деток', 45540528, 3, 11, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (40, N'Попрыгунчик для мальчиков 5389', N' Взрослый', 70873532, 3, 2, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (41, N'Попрыгунчик для собачек 3500', N' Для больших деток', 79994924, 2, 9, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (42, N'Попрыгунчик для собачек 4381', N' Цифровой', 27301447, 2, 5, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (43, N'Попрыгунчик для собачек 4387', N' Упругий', 89607276, 3, 8, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (44, N'Попрыгунчик для собачек 4485', N' Взрослый', 33440129, 2, 12, 1995)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (45, N'Попрыгунчик для собачек 4529', N' Для больших деток', 81713527, 3, 6, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (46, N'Попрыгунчик для собачек 5096', N' Взрослый', 67975083, 4, 9, 1465)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (47, N'Попрыгунчик для собачек 5754', N' Цифровой', 79018408, 2, 8, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (48, N'Шар 2243', N' Взрослый', 42536654, 3, 12, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (49, N'Шар 4124', N' Цифровой', 39025230, 5, 8, NULL)
INSERT [dbo].[products] ([Id], [NameProduct], [TypeProduct], [Articul], [CountPeople], [NumberAngar], [MinPriceForAgent]) VALUES (50, N'Шар 6366', N' Взрослый', 25514523, 4, 4, NULL)
GO
SET IDENTITY_INSERT [dbo].[productSale] ON 

INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (1, 1, N'Попрыгун 2299', 47, N'Компания Хмель', CAST(N'2015-12-25T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (2, 1, N'Попрыгун 2299', 82, N'ТелеГлавВекторСбыт', CAST(N'2017-11-24T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (3, 2, N'Попрыгун 3016', 89, N'ФинансТелеТверь', CAST(N'2018-04-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (4, 2, N'Попрыгун 3016', 46, N'Компания ФинансСервис', CAST(N'2011-06-11T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (5, 3, N'Попрыгун 6412', 63, N'Радио', CAST(N'2019-06-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (6, 3, N'Попрыгун 6412', 3, N'CибПивОмскСнаб', CAST(N'2019-06-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (7, 3, N'Попрыгун 6412', 76, N'Строй', CAST(N'2017-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (8, 3, N'Попрыгун 6412', 70, N'РосАвтоМонтаж', CAST(N'2011-12-26T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (9, 4, N'Попрыгун 6882', 72, N'СантехСеверЛенМашина', CAST(N'2015-08-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (10, 5, N'Попрыгунчик детский 1916', 99, N'ЮпитерЛенГараж-М', CAST(N'2013-12-23T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (11, 5, N'Попрыгунчик детский 1916', 20, N'Газ', CAST(N'2014-07-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (12, 5, N'Попрыгунчик детский 1916', 92, N'Цемент', CAST(N'2012-01-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (13, 6, N'Попрыгунчик детский 2071', 76, N'Строй', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (14, 7, N'Попрыгунчик детский 5117', 65, N'Рем', CAST(N'2019-03-18T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (15, 7, N'Попрыгунчик детский 5117', 10, N'БашкирЮпитерТомск', CAST(N'2019-10-08T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (16, 8, N'Попрыгунчик детский 6029', 15, N'ВодГараж', CAST(N'2019-03-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (17, 8, N'Попрыгунчик детский 6029', 11, N'Бух', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (18, 8, N'Попрыгунчик детский 6029', 57, N'МясРеч', CAST(N'2015-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (19, 8, N'Попрыгунчик детский 6029', 21, N'ГазДизайнЖелДор', CAST(N'2016-11-17T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (20, 9, N'Попрыгунчик детский 6888', 68, N'РемСантехОмскБанк', CAST(N'2013-04-08T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (21, 10, N'Попрыгунчик детский желтый 1371', 85, N'Тех', CAST(N'2015-06-23T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (22, 10, N'Попрыгунчик детский желтый 1371', 77, N'СтройГорНефть', CAST(N'2012-04-23T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (23, 11, N'Попрыгунчик детский желтый 2582', 65, N'Рем', CAST(N'2013-07-11T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (24, 11, N'Попрыгунчик детский желтый 2582', 41, N'Компания МясДизайнДизайн', CAST(N'2017-11-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (25, 11, N'Попрыгунчик детский желтый 2582', 96, N'ЭлектроМоторТрансСнос', CAST(N'2015-12-02T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (26, 12, N'Попрыгунчик детский желтый 6051', 41, N'Компания МясДизайнДизайн', CAST(N'2011-08-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (27, 12, N'Попрыгунчик детский желтый 6051', 97, N'ЭлектроРемОрионЛизинг', CAST(N'2019-03-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (28, 13, N'Попрыгунчик детский желтый 6678', 1, N'CибБашкирТекстиль', CAST(N'2018-09-15T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (29, 13, N'Попрыгунчик детский желтый 6678', 76, N'Строй', CAST(N'2013-11-09T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (30, 13, N'Попрыгунчик детский желтый 6678', 34, N'Компания Гараж', CAST(N'2019-05-24T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (31, 14, N'Попрыгунчик детский красный 1289', 68, N'РемСантехОмскБанк', CAST(N'2012-08-12T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (32, 14, N'Попрыгунчик детский красный 1289', 58, N'МясТрансМоторЛизинг', CAST(N'2016-02-25T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (33, 14, N'Попрыгунчик детский красный 1289', 15, N'ВодГараж', CAST(N'2010-04-13T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (34, 14, N'Попрыгунчик детский красный 1289', 93, N'ЦементАсбоцемент', CAST(N'2019-10-15T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (35, 14, N'Попрыгунчик детский красный 1289', 47, N'Компания Хмель', CAST(N'2014-08-14T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (36, 15, N'Попрыгунчик детский красный 1740', 20, N'Газ', CAST(N'2012-09-26T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (37, 16, N'Попрыгунчик детский красный 1972', 34, N'Компания Гараж', CAST(N'2011-08-19T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (38, 16, N'Попрыгунчик детский красный 1972', 58, N'МясТрансМоторЛизинг', CAST(N'2019-07-05T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (39, 16, N'Попрыгунчик детский красный 1972', 82, N'ТелеГлавВекторСбыт', CAST(N'2015-09-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (40, 17, N'Попрыгунчик детский красный 3240', 68, N'РемСантехОмскБанк', CAST(N'2016-05-18T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (41, 17, N'Попрыгунчик детский красный 3240', 93, N'ЦементАсбоцемент', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (42, 18, N'Попрыгунчик детский красный 3839', 59, N'Орион', CAST(N'2014-06-11T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (43, 18, N'Попрыгунчик детский красный 3839', 34, N'Компания Гараж', CAST(N'2016-07-19T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (44, 18, N'Попрыгунчик детский красный 3839', 41, N'Компания МясДизайнДизайн', CAST(N'2018-04-08T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (45, 20, N'Попрыгунчик детский красный 5400', 96, N'ЭлектроМоторТрансСнос', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (46, 21, N'Попрыгунчик детский красный 6591', 85, N'Тех', CAST(N'2012-03-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (47, 21, N'Попрыгунчик детский красный 6591', 48, N'Креп', CAST(N'2014-12-12T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (48, 22, N'Попрыгунчик детский розовый 1657', 67, N'РемГаражЛифт', CAST(N'2018-02-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (49, 22, N'Попрыгунчик детский розовый 1657', 58, N'МясТрансМоторЛизинг', CAST(N'2016-08-13T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (50, 22, N'Попрыгунчик детский розовый 1657', 30, N'КазЮпитерТомск', CAST(N'2015-08-08T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (51, 22, N'Попрыгунчик детский розовый 1657', 99, N'ЮпитерЛенГараж-М', CAST(N'2015-03-28T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (52, 23, N'Попрыгунчик детский розовый 2694', 38, N'Компания КрепЦемент', CAST(N'2014-07-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (53, 23, N'Попрыгунчик детский розовый 2694', 39, N'Компания Монтаж', CAST(N'2019-08-16T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (54, 23, N'Попрыгунчик детский розовый 2694', 70, N'РосАвтоМонтаж', CAST(N'2017-02-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (55, 25, N'Попрыгунчик детский розовый 5376', 3, N'CибПивОмскСнаб', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (56, 25, N'Попрыгунчик детский розовый 5376', 89, N'ФинансТелеТверь', CAST(N'2017-03-09T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (57, 26, N'Попрыгунчик детский розовый 5501', 55, N'Монтаж', CAST(N'2014-03-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (58, 26, N'Попрыгунчик детский розовый 5501', 25, N'Гор', CAST(N'2010-05-03T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (59, 27, N'Попрыгунчик детский розовый 6346', 67, N'РемГаражЛифт', CAST(N'2015-02-02T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (60, 27, N'Попрыгунчик детский розовый 6346', 47, N'Компания Хмель', CAST(N'2016-08-18T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (61, 30, N'Попрыгунчик для девочек 1895', 59, N'Орион', CAST(N'2013-05-10T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (62, 31, N'Попрыгунчик для девочек 2311', 57, N'МясРеч', CAST(N'2015-02-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (63, 31, N'Попрыгунчик для девочек 2311', 34, N'Компания Гараж', CAST(N'2017-08-02T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (64, 32, N'Попрыгунчик для девочек 3389', 28, N'КазаньТекстиль', CAST(N'2010-06-20T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (65, 32, N'Попрыгунчик для девочек 3389', 5, N'Асбоцемент', CAST(N'2014-06-04T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (66, 32, N'Попрыгунчик для девочек 3389', 100, N'ЮпитерТяжОрионЭкспедиция', CAST(N'2017-05-20T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (67, 32, N'Попрыгунчик для девочек 3389', 39, N'Компания Монтаж', CAST(N'2016-09-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (68, 33, N'Попрыгунчик для девочек 6849', 42, N'Компания СервисРадиоГор', CAST(N'2011-09-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (69, 33, N'Попрыгунчик для девочек 6849', 59, N'Орион', CAST(N'2015-08-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (70, 34, N'Попрыгунчик для кошечек 2604', 28, N'КазаньТекстиль', CAST(N'2010-06-21T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (71, 34, N'Попрыгунчик для кошечек 2604', 85, N'Тех', CAST(N'2017-11-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (72, 35, N'Попрыгунчик для кошечек 3741', 76, N'Строй', CAST(N'2014-08-06T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (73, 36, N'Попрыгунчик для кошечек 4740', 25, N'Гор', CAST(N'2016-10-07T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (74, 37, N'Попрыгунчик для мальчиков 3307', 24, N'ГлавITФлотПроф', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (75, 38, N'Попрыгунчик для мальчиков 3929', 42, N'Компания СервисРадиоГор', CAST(N'2019-07-25T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (76, 38, N'Попрыгунчик для мальчиков 3929', 30, N'КазЮпитерТомск', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (77, 38, N'Попрыгунчик для мальчиков 3929', 17, N'ВодТверьХозМашина', CAST(N'2012-03-23T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (78, 39, N'Попрыгунчик для мальчиков 4791', 39, N'Компания Монтаж', CAST(N'2015-01-17T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (79, 40, N'Попрыгунчик для мальчиков 5389', 92, N'Цемент', CAST(N'2018-06-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (80, 41, N'Попрыгунчик для собачек 3500', 96, N'ЭлектроМоторТрансСнос', CAST(N'2017-11-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (81, 41, N'Попрыгунчик для собачек 3500', 48, N'Креп', CAST(N'2017-05-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (82, 42, N'Попрыгунчик для собачек 4381', 42, N'Компания СервисРадиоГор', CAST(N'2012-05-25T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (83, 43, N'Попрыгунчик для собачек 4387', 77, N'СтройГорНефть', CAST(N'2010-04-15T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (84, 43, N'Попрыгунчик для собачек 4387', 29, N'КазХоз', CAST(N'2017-10-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (85, 43, N'Попрыгунчик для собачек 4387', 55, N'Монтаж', CAST(N'2011-08-28T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (86, 43, N'Попрыгунчик для собачек 4387', 41, N'Компания МясДизайнДизайн', CAST(N'2013-01-24T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (87, 44, N'Попрыгунчик для собачек 4485', 67, N'РемГаражЛифт', CAST(N'2012-11-07T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (88, 44, N'Попрыгунчик для собачек 4485', 53, N'МетизТехАвтоПроф', CAST(N'2014-04-15T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (89, 44, N'Попрыгунчик для собачек 4485', 21, N'ГазДизайнЖелДор', CAST(N'2018-06-22T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (90, 44, N'Попрыгунчик для собачек 4485', 57, N'МясРеч', CAST(N'2011-02-01T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (91, 44, N'Попрыгунчик для собачек 4485', 15, N'ВодГараж', CAST(N'2013-12-01T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (92, 44, N'Попрыгунчик для собачек 4485', 44, N'Компания ТелекомХмельГаражПром', CAST(N'2017-10-14T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (93, 45, N'Попрыгунчик для собачек 4529', 48, N'Креп', CAST(N'2011-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (94, 47, N'Попрыгунчик для собачек 5754', 46, N'Компания ФинансСервис', CAST(N'2016-02-17T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (95, 47, N'Попрыгунчик для собачек 5754', 92, N'Цемент', CAST(N'2013-08-27T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (96, 48, N'Шар 2243', 96, N'ЭлектроМоторТрансСнос', CAST(N'2012-06-14T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (97, 49, N'Шар 4124', 81, N'ТекстильУралАвтоОпт', CAST(N'2012-09-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (98, 49, N'Шар 4124', 1, N'CибБашкирТекстиль', CAST(N'2016-11-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (99, 49, N'Шар 4124', 44, N'Компания ТелекомХмельГаражПром', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 1)
GO
INSERT [dbo].[productSale] ([IdSale], [ID], [Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (100, 49, N'Шар 4124', 9, N'БашкирФлотМотор-H', CAST(N'2010-11-17T00:00:00.000' AS DateTime), 5)
SET IDENTITY_INSERT [dbo].[productSale] OFF
GO
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 2299', 47, N'Компания Хмель', CAST(N'2015-12-25T00:00:00.000' AS DateTime), 4)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 2299', 82, N'ТелеГлавВекторСбыт', CAST(N'2017-11-24T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 3016', 89, N'ФинансТелеТверь', CAST(N'2018-04-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 3016', 46, N'Компания ФинансСервис', CAST(N'2011-06-11T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 6412', 63, N'Радио', CAST(N'2019-06-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 6412', 3, N'CибПивОмскСнаб', CAST(N'2019-06-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 6412', 76, N'Строй', CAST(N'2017-04-02T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 6412', 70, N'РосАвтоМонтаж', CAST(N'2011-12-26T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгун 6882', 72, N'СантехСеверЛенМашина', CAST(N'2015-08-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 1916', 99, N'ЮпитерЛенГараж-М', CAST(N'2013-12-23T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 1916', 20, N'Газ', CAST(N'2014-07-28T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 1916', 92, N'Цемент', CAST(N'2012-01-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 2071', 76, N'Строй', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 5117', 65, N'Рем', CAST(N'2019-03-18T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 5117', 10, N'БашкирЮпитерТомск', CAST(N'2019-10-08T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 6029', 15, N'ВодГараж', CAST(N'2019-03-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 6029', 11, N'Бух', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 6029', 57, N'МясРеч', CAST(N'2015-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 6029', 21, N'ГазДизайнЖелДор', CAST(N'2016-11-17T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский 6888', 68, N'РемСантехОмскБанк', CAST(N'2013-04-08T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 1371', 85, N'Тех', CAST(N'2015-06-23T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 1371', 77, N'СтройГорНефть', CAST(N'2012-04-23T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 2582', 65, N'Рем', CAST(N'2013-07-11T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 2582', 41, N'Компания МясДизайнДизайн', CAST(N'2017-11-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 2582', 96, N'ЭлектроМоторТрансСнос', CAST(N'2015-12-02T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 6051', 41, N'Компания МясДизайнДизайн', CAST(N'2011-08-27T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 6051', 97, N'ЭлектроРемОрионЛизинг', CAST(N'2019-03-06T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 6678', 1, N'CибБашкирТекстиль', CAST(N'2018-09-15T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 6678', 76, N'Строй', CAST(N'2013-11-09T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский желтый 6678', 34, N'Компания Гараж', CAST(N'2019-05-24T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1289', 68, N'РемСантехОмскБанк', CAST(N'2012-08-12T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1289', 58, N'МясТрансМоторЛизинг', CAST(N'2016-02-25T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1289', 15, N'ВодГараж', CAST(N'2010-04-13T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1289', 93, N'ЦементАсбоцемент', CAST(N'2019-10-15T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1289', 47, N'Компания Хмель', CAST(N'2014-08-14T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1740', 20, N'Газ', CAST(N'2012-09-26T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1972', 34, N'Компания Гараж', CAST(N'2011-08-19T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1972', 58, N'МясТрансМоторЛизинг', CAST(N'2019-07-05T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 1972', 82, N'ТелеГлавВекторСбыт', CAST(N'2015-09-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 3240', 68, N'РемСантехОмскБанк', CAST(N'2016-05-18T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 3240', 93, N'ЦементАсбоцемент', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 3839', 59, N'Орион', CAST(N'2014-06-11T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 3839', 34, N'Компания Гараж', CAST(N'2016-07-19T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 3839', 41, N'Компания МясДизайнДизайн', CAST(N'2018-04-08T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 5400', 96, N'ЭлектроМоторТрансСнос', CAST(N'2014-03-06T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 6591', 85, N'Тех', CAST(N'2012-03-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский красный 6591', 48, N'Креп', CAST(N'2014-12-12T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 1657', 67, N'РемГаражЛифт', CAST(N'2018-02-28T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 1657', 58, N'МясТрансМоторЛизинг', CAST(N'2016-08-13T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 1657', 30, N'КазЮпитерТомск', CAST(N'2015-08-08T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 1657', 99, N'ЮпитерЛенГараж-М', CAST(N'2015-03-28T00:00:00.000' AS DateTime), 16)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 2694', 38, N'Компания КрепЦемент', CAST(N'2014-07-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 2694', 39, N'Компания Монтаж', CAST(N'2019-08-16T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 2694', 70, N'РосАвтоМонтаж', CAST(N'2017-02-08T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 5376', 3, N'CибПивОмскСнаб', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 5376', 89, N'ФинансТелеТверь', CAST(N'2017-03-09T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 5501', 55, N'Монтаж', CAST(N'2014-03-17T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 5501', 25, N'Гор', CAST(N'2010-05-03T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 6346', 67, N'РемГаражЛифт', CAST(N'2015-02-02T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик детский розовый 6346', 47, N'Компания Хмель', CAST(N'2016-08-18T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 1895', 59, N'Орион', CAST(N'2013-05-10T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 2311', 57, N'МясРеч', CAST(N'2015-02-28T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 2311', 34, N'Компания Гараж', CAST(N'2017-08-02T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 3389', 28, N'КазаньТекстиль', CAST(N'2010-06-20T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 3389', 5, N'Асбоцемент', CAST(N'2014-06-04T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 3389', 100, N'ЮпитерТяжОрионЭкспедиция', CAST(N'2017-05-20T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 3389', 39, N'Компания Монтаж', CAST(N'2016-09-14T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 6849', 42, N'Компания СервисРадиоГор', CAST(N'2011-09-12T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для девочек 6849', 59, N'Орион', CAST(N'2015-08-17T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для кошечек 2604', 28, N'КазаньТекстиль', CAST(N'2010-06-21T00:00:00.000' AS DateTime), 7)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для кошечек 2604', 85, N'Тех', CAST(N'2017-11-11T00:00:00.000' AS DateTime), 10)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для кошечек 3741', 76, N'Строй', CAST(N'2014-08-06T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для кошечек 4740', 25, N'Гор', CAST(N'2016-10-07T00:00:00.000' AS DateTime), 17)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 3307', 24, N'ГлавITФлотПроф', CAST(N'2011-06-14T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 3929', 42, N'Компания СервисРадиоГор', CAST(N'2019-07-25T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 3929', 30, N'КазЮпитерТомск', CAST(N'2017-06-07T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 3929', 17, N'ВодТверьХозМашина', CAST(N'2012-03-23T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 4791', 39, N'Компания Монтаж', CAST(N'2015-01-17T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для мальчиков 5389', 92, N'Цемент', CAST(N'2018-06-13T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 3500', 96, N'ЭлектроМоторТрансСнос', CAST(N'2017-11-05T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 3500', 48, N'Креп', CAST(N'2017-05-01T00:00:00.000' AS DateTime), 5)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4381', 42, N'Компания СервисРадиоГор', CAST(N'2012-05-25T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4387', 77, N'СтройГорНефть', CAST(N'2010-04-15T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4387', 29, N'КазХоз', CAST(N'2017-10-12T00:00:00.000' AS DateTime), 8)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4387', 55, N'Монтаж', CAST(N'2011-08-28T00:00:00.000' AS DateTime), 11)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4387', 41, N'Компания МясДизайнДизайн', CAST(N'2013-01-24T00:00:00.000' AS DateTime), 3)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 67, N'РемГаражЛифт', CAST(N'2012-11-07T00:00:00.000' AS DateTime), 9)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 53, N'МетизТехАвтоПроф', CAST(N'2014-04-15T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 21, N'ГазДизайнЖелДор', CAST(N'2018-06-22T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 57, N'МясРеч', CAST(N'2011-02-01T00:00:00.000' AS DateTime), 12)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 15, N'ВодГараж', CAST(N'2013-12-01T00:00:00.000' AS DateTime), 19)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4485', 44, N'Компания ТелекомХмельГаражПром', CAST(N'2017-10-14T00:00:00.000' AS DateTime), 20)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 4529', 48, N'Креп', CAST(N'2011-07-01T00:00:00.000' AS DateTime), 14)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 5754', 46, N'Компания ФинансСервис', CAST(N'2016-02-17T00:00:00.000' AS DateTime), 18)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Попрыгунчик для собачек 5754', 92, N'Цемент', CAST(N'2013-08-27T00:00:00.000' AS DateTime), 15)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Шар 2243', 96, N'ЭлектроМоторТрансСнос', CAST(N'2012-06-14T00:00:00.000' AS DateTime), 2)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Шар 4124', 81, N'ТекстильУралАвтоОпт', CAST(N'2012-09-02T00:00:00.000' AS DateTime), 13)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Шар 4124', 1, N'CибБашкирТекстиль', CAST(N'2016-11-27T00:00:00.000' AS DateTime), 6)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Шар 4124', 44, N'Компания ТелекомХмельГаражПром', CAST(N'2016-02-26T00:00:00.000' AS DateTime), 1)
INSERT [dbo].[productSale$ExternalData_2] ([Продукция], [InAgent], [Наименование агента], [Дата реализации], [Количество продукции]) VALUES (N'Шар 4124', 9, N'БашкирФлотМотор-H', CAST(N'2010-11-17T00:00:00.000' AS DateTime), 5)
GO
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (1, N'ЗАО')
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (2, N'МКК')
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (3, N'МФО')
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (4, N'ОАО')
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (5, N'ООО')
INSERT [dbo].[type_agents] ([ID], [Name]) VALUES (6, N'ПАО')
GO
ALTER TABLE [dbo].[agents]  WITH CHECK ADD  CONSTRAINT [FK_agents_type_agents] FOREIGN KEY([IdType])
REFERENCES [dbo].[type_agents] ([ID])
GO
ALTER TABLE [dbo].[agents] CHECK CONSTRAINT [FK_agents_type_agents]
GO
ALTER TABLE [dbo].[productSale]  WITH CHECK ADD  CONSTRAINT [FK_productSale_agents] FOREIGN KEY([InAgent])
REFERENCES [dbo].[agents] ([IDAgent])
GO
ALTER TABLE [dbo].[productSale] CHECK CONSTRAINT [FK_productSale_agents]
GO
ALTER TABLE [dbo].[productSale]  WITH CHECK ADD  CONSTRAINT [FK_productSale_products] FOREIGN KEY([ID])
REFERENCES [dbo].[products] ([Id])
GO
ALTER TABLE [dbo].[productSale] CHECK CONSTRAINT [FK_productSale_products]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Product] FOREIGN KEY([Id_Product])
REFERENCES [dbo].[Product] ([Id_product])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Product]
GO
/****** Object:  Trigger [dbo].[TR_Agents_InsertAndUpdate]    Script Date: 14.12.2021 11:16:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
Create Trigger [dbo].[TR_Agents_InsertAndUpdate] On [dbo].[agents]
After Update, Insert
As
IF EXISTS(Select * From inserted) and Exists (Select * from deleted) And UPDATE([Priority])
BEGIN
	Insert Into [dbo].[HistoryPriority] ([oldPriority], [newPriority])
	Select d.Priority, i.Priority
	From inserted i inner join deleted d on i.IDAgent = d.IDAgent
END;
IF EXISTS(Select * From inserted) and not exists (Select * from deleted)
BEGIN
Insert Into [dbo].[HistoryPriority] ([oldPriority], [newPriority])
	Select null, i.Priority
	From inserted i inner join deleted d on i.IDAgent = d.IDAgent
END;
GO
ALTER TABLE [dbo].[agents] ENABLE TRIGGER [TR_Agents_InsertAndUpdate]
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "A"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 102
               Right = 214
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "b"
            Begin Extent = 
               Top = 6
               Left = 252
               Bottom = 102
               Right = 465
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "agents"
            Begin Extent = 
               Top = 6
               Left = 503
               Bottom = 136
               Right = 673
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "type_agents"
            Begin Extent = 
               Top = 6
               Left = 711
               Bottom = 102
               Right = 881
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 9
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'VW_AgentDetails'
GO
