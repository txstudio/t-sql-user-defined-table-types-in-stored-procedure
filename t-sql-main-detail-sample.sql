USE [master]
GO

ALTER DATABASE [MainDetailTableSample]
	SET SINGLE_USER WITH ROLLBACK IMMEDIATE
GO

DROP DATABASE [MainDetailTableSample]
GO

CREATE DATABASE [MainDetailTableSample]
GO

USE [MainDetailTableSample]
GO

--建立資料庫 SCHEMA 內容
CREATE SCHEMA [Product]
GO

CREATE SCHEMA [Order]
GO

--建立資料表與輸入預設資料
CREATE TABLE [Product].[Products]
(
	[No]			SMALLINT,

	[Schema]		VARCHAR(10),
	[Name]			NVARCHAR(25),

	[UnitPrice]		SMALLMONEY,
	[IsMarket]		BIT,

	CONSTRAINT [pk_Products] PRIMARY KEY ([No])
)
GO

INSERT INTO [Product].[Products] ([No],[Schema],[Name],[UnitPrice],[IsMarket]) 
	VALUES (1,'A9008J0EI',N'NOKIA 8 (4G/64G)',15900,1)
INSERT INTO [Product].[Products] ([No],[Schema],[Name],[UnitPrice],[IsMarket]) 
	VALUES (2,'A9008JSTY',N'NOKIA 3310 (3G)',1990,1)
INSERT INTO [Product].[Products] ([No],[Schema],[Name],[UnitPrice],[IsMarket]) 
	VALUES (3,'A90080392',N'HP Elite X3 Windows Phone',24900,1)
INSERT INTO [Product].[Products] ([No],[Schema],[Name],[UnitPrice],[IsMarket]) 
	VALUES (4,'A90062T7P',N'MAXELL CR2032 3V 鋰電池(5入)',100,1)
INSERT INTO [Product].[Products] ([No],[Schema],[Name],[UnitPrice],[IsMarket]) 
	VALUES (5,'A9006AZKX',N'勁量鹼性電池 6號 2入',40,1)
GO

--建立訂單序號的序列物件
CREATE SEQUENCE [Order].[OrderNo]
	START WITH 2
	INCREMENT BY 1
GO

CREATE TABLE [Order].[OrderHeaders]
(
	[No]			INT,

	[OrderDate]		SMALLDATETIME,

	[Payment]		NVARCHAR(50),
	[Shippment]		NVARCHAR(50),

	[IsValid]		BIT DEFAULT(1),

	CONSTRAINT [pk_OrderHeaders] PRIMARY KEY ([No])
)
GO

INSERT INTO [Order].[OrderHeaders]([No],[OrderDate],[Payment],[Shippment],[IsValid])
	VALUES (1,'2017-11-11',N'線上刷卡',N'宅配',1)
GO

CREATE TABLE [Order].[OrderDetails]
(
	[OrderHeaderNo]	INT,
	[ProductNo]		SMALLINT,
	[Index]			TINYINT,

	[Quantity]		SMALLINT,
	[UnitPrice]		SMALLMONEY,
)
GO

INSERT INTO [Order].[OrderDetails]([OrderHeaderNo],[ProductNo],[Index],[Quantity],[UnitPrice])
	VALUES (1,1,1,1,15900)
INSERT INTO [Order].[OrderDetails]([OrderHeaderNo],[ProductNo],[Index],[Quantity],[UnitPrice])
	VALUES (1,4,2,4,100)
GO
