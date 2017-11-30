USE [MainDetailTableSample]
GO

--建立自訂資料表類型
CREATE TYPE [Order].[OrderDetails] AS TABLE
(
	[ProductNo]		SMALLINT,
	[Index]			TINYINT,
	[Quantity]		SMALLINT,
	[UnitPrice]		SMALLMONEY
)
GO

--建立訂單的預存程序
CREATE PROCEDURE [Order].[AddOrder]
	@OrderDate		SMALLDATETIME,
	@Payment		NVARCHAR(50),
	@Shippment		NVARCHAR(50),
	@OrderDetails	[Order].[OrderDetails] READONLY,
	@OrderNo		INT OUT
AS

	SET @OrderNo = (NEXT VALUE FOR [Order].[OrderNo])

	BEGIN TRANSACTION

	BEGIN TRY

		INSERT INTO [Order].[OrderHeaders] (
			[No]
			,[OrderDate]
			,[Payment]
			,[Shippment]
		) VALUES (
			@OrderNo
			,@OrderDate
			,@Payment
			,@Shippment
		)

		INSERT INTO [Order].[OrderDetails] (
			[OrderHeaderNo]
			,[ProductNo]
			,[Index]
			,[Quantity]
			,[UnitPrice]
		) SELECT @OrderNo
			,[ProductNo]
			,[Index]
			,[Quantity]
			,[UnitPrice]
		FROM @OrderDetails

		COMMIT TRANSACTION
	END TRY

	BEGIN CATCH
		SET @OrderNo = (-1)
		
		ROLLBACK TRANSACTION
	END CATCH

GO

--
--測試新增一筆資料
--
DECLARE	@OrderDate		SMALLDATETIME
DECLARE	@Payment		NVARCHAR(50)
DECLARE	@Shippment		NVARCHAR(50)
DECLARE @OrderDetails	[Order].[OrderDetails]
DECLARE @OrderNo		INT

SET @OrderDate = '2017-11-28'
SET @Payment = N'線上刷卡'
SET @Shippment = N'7-11 超商取貨'

INSERT INTO @OrderDetails ([ProductNo],[Index],[Quantity],[UnitPrice]) VALUES (4,0,5,100)
INSERT INTO @OrderDetails ([ProductNo],[Index],[Quantity],[UnitPrice]) VALUES (5,1,2,40)

EXECUTE [Order].[AddOrder] @OrderDate
	,@Payment
	,@Shippment
	,@OrderDetails
	,@OrderNo OUT
	
SELECT @OrderNo
SELECT * FROM [Order].[OrderHeaders]
SELECT * FROM [Order].[OrderDetails]