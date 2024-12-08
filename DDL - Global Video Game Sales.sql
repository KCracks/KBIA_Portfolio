/********* GLOBAL VIDEO GAME SALES DDL CREATION **********/

/*********************************************************/
/******************  Create Database  ********************/
/*********************************************************/

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'GlobalVideoGameSales')
BEGIN
    CREATE DATABASE GlobalVideoGameSales;
END
GO

USE GlobalVideoGameSales;
GO

/*********************************************************/
/******************    Schema DDL       ******************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'stg' ) 
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA stg AUTHORIZATION dbo;'
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'dim' ) 
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA dim AUTHORIZATION dbo;'
END

IF NOT EXISTS (SELECT * FROM sys.schemas WHERE name = 'f' ) 
BEGIN
    EXEC sp_executesql N'CREATE SCHEMA f AUTHORIZATION dbo;'
END

/*********************************************************/
/************  Create stg.ALL_VG_Sales Table  ************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'stg' AND TABLE_NAME = 'ALL_VG_Sales')
BEGIN
    CREATE TABLE stg.ALL_VG_Sales (
        ID INT NOT NULL,
        Sales_Rank INT NOT NULL,
        [Video Game Title] NVARCHAR(200) NOT NULL,
        Release_Year INT NOT NULL,
        Genre NVARCHAR(15) NULL,
        [Publisher Company] NVARCHAR(100) NULL,
        [Gaming Platform] NVARCHAR(15) NULL,
        NorthAmerica_Sales INT NULL,
        Europe_Sales INT NULL,
        Japan_Sales INT NULL,
        OtherRegions_Sales INT NULL,
        GlobalSales INT NULL
    );
END

/*********************************************************/
/******************  Create Sequences   ******************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = 'PublisherID_Seq')
BEGIN
    CREATE SEQUENCE dbo.PublisherID_Seq
    AS INT
    START WITH 1
    INCREMENT BY 1;
END

IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = 'PlatformID_Seq')
BEGIN
    CREATE SEQUENCE dbo.PlatformID_Seq
    AS INT
    START WITH 1
    INCREMENT BY 1;
END

IF NOT EXISTS (SELECT * FROM sys.sequences WHERE name = 'GenreID_Seq')
BEGIN
    CREATE SEQUENCE dbo.GenreID_Seq
    AS INT
    START WITH 1
    INCREMENT BY 1;
END

/*********************************************************/
/******************  GlobalSales DIM DDL  ****************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'GlobalSales')
BEGIN
    CREATE TABLE dim.GlobalSales(
        RegionSalesID INT NOT NULL PRIMARY KEY,
        Release_Year INT NOT NULL,
        NorthAmerica_Sales INT NULL,
        Europe_Sales INT NULL,
        Japan_Sales INT NULL,
        OtherRegions_Sales INT NULL,
        GlobalSales INT NULL
    );
END

/*********************************************************/
/******************  VideoGameUnits DIM DDL  *************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'VideoGameUnits')
BEGIN
    CREATE TABLE dim.VideoGameUnits(
        GameID INT NOT NULL UNIQUE,
        Sales_Rank INT NOT NULL PRIMARY KEY,
        Video_Game_Title NVARCHAR(200) NOT NULL,
        Release_Year INT NOT NULL,
        Genre NVARCHAR(15) NULL,
        Publisher_Company NVARCHAR(100) NULL,
        Gaming_Platform NVARCHAR(15) NULL
    );
END

/*********************************************************/
/******************  PublisherCompanies DIM DDL  *********/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'PublisherCompanies')
BEGIN
    CREATE TABLE dim.PublisherCompanies(
        PublisherID INT NULL,
        Publisher_Company NVARCHAR(100) NOT NULL PRIMARY KEY
    );
END

/*********************************************************/
/******************  GamePlatform DIM DDL  ***************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'GamePlatform')
BEGIN
    CREATE TABLE dim.GamePlatform(
        PlatformID INT NULL,
        GamingPlatform NVARCHAR(15) NOT NULL PRIMARY KEY
    );
END

/*********************************************************/
/******************  GameGenre DIM DDL  ******************/
/*********************************************************/

IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'dim' AND TABLE_NAME = 'GameGenre')
BEGIN
    CREATE TABLE dim.GameGenre(
        GenreID INT NULL,
        VideoGameGenre NVARCHAR(15) NOT NULL PRIMARY KEY
    );
END

/*********************************************************/
/******************  Fact Table Creation  ****************/
/*********************************************************/

IF OBJECT_ID('f.IndustrySales', 'U') IS NOT NULL
BEGIN 
    DROP TABLE f.IndustrySales;
END

CREATE TABLE f.IndustrySales(
    IndustrySalesID INT NOT NULL,
    Sales_Rank INT NOT NULL,
    Video_Game_Title NVARCHAR(200) NOT NULL,
    Release_Year INT NOT NULL,
    Genre NVARCHAR(15) NULL,
    Publisher_Company NVARCHAR(100) NULL,
    Gaming_Platform NVARCHAR(15) NULL,
    NorthAmerica_Sales INT NULL,
    Europe_Sales INT NULL,
    Japan_Sales INT NULL,
    OtherRegions_Sales INT NULL,
    GlobalSales INT NULL
);