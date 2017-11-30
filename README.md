# 在「預存程序」使用「資料表值參數」

此範例模擬訂單建立功能，在一次的預存程序呼叫中建立訂單主資料與訂購商品詳細資料。

## 檔案與資料夾說明

本次範例中包含下列資訊

- t-sql-main-detail-sample.sql
- t-sql-main-detail-type-and-procedure.sql
- app/ExecuteApp/*

### t-sql-main-detail-sample.sql

此指令碼會建立下列物件與預設資料

|物件名稱|備註|
|--|--|
|Product.Products|商品資料表|
|Order.OrderHeaders|訂單主資料表|
|Order.OrderDetails|訂單詳細資料表|

資料庫物件如圖

![database-objects](https://raw.githubusercontent.com/txstudio/t-sql-user-defined-table-types-in-stored-procedure/master/img/sample-database-objects.gif)

訂單資料表關係如圖

![order-relationship](https://raw.githubusercontent.com/txstudio/t-sql-user-defined-table-types-in-stored-procedure/master/img/order-table-relationships.gif)

預設商品資料

![default-product-table-data](https://raw.githubusercontent.com/txstudio/t-sql-user-defined-table-types-in-stored-procedure/master/img/product-table-data.gif)

### t-sql-main-detail-type-and-procedure.sql

此指令碼會建立產生訂單預存程序與預存程序使用的「自訂資料表類型」，並在下方提供呼叫範例指令碼。

### app/ExecuteApp/*

使用 .NET Core 2.0 建立之主控台應用程式，呼叫範例指令碼建立的預存程序並取得呼叫結果。

> 請記得調整範例程式碼的資料庫連線字串

## 使用方式

執行 t-sql-main-detail-sample.sql 建立測試環境使用的資料表物件，再執行 t-sql-main-detail-type-and-procedure.sql 建立自訂型態與預存程序。

ExecuteApp 為 .NET Core 應用程式，開啟時請確認是否符合 .NET Core 開發環境。

## 參考資料
[Table-Valued Parameters | Microsoft Docs](https://docs.microsoft.com/en-us/dotnet/framework/data/adonet/sql/table-valued-parameters)
