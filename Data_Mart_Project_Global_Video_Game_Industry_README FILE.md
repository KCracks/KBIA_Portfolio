# 🎮🕹️🤖👽_**Video Game Industry Data Mart Analysis**_👽🤖🕹️🎮

This project focuses on the Video Game industry and the different components owing to it's growth and development between 1980 and 2008. It's purpose is to allow for predictive analysis to determine if the market is healthy and lucrative enough to facilitate investment for capital gains. It will also allow for determining the best Video Game Publisher Companies to invest in by analysing the following components:

- Video Game Titles
    
- Release Year
    
- Genre
    
- Gaming Platform
    
- Publisher Company
    
- North America Unit Sales
    
- Europe Unit Sales
    
- Japan Unit Sales
    
- Unit Sales from Other Regions Worldwide
    

🗒️ The dataset used for this project was received from [Kaggle](https://www.kaggle.com/datasets/ulrikthygepedersen/video-games-sales)


🗒️ This data mart was created based on the principles of Star Schema Design as outlined by [Ralph Kimball](https://www.kimballgroup.com/data-warehouse-business-intelligence-resources/kimball-techniques/dimensional-modeling-techniques/)


## 🤔<u>**Questions Addressed with this Data Mart**</u>🤔

The following questions represent the key points to be addressed with this Data Mart:

1\. Is the Global Video Game Market viable/profitable for capital gains investment?

2\. Which market (by Region) is the most lucrative for investment based on sales?

3\. Which companies are the highest performing and therefore best to invest into?

- By answering this question, the following key points will be addressed to curate a detailed response as to why the chosen companies are highly recommended for investing into:
    
    - Which are the Top Performing Publisher Companies?
        
    - What are the Top Performing Gaming Platforms?
        
    - Which is the Top Performing Game Franchise?

## 🕸️**GLOBAL VIDEO GAME INDUSTRY (1980-2008)** <u>**Entity-Relationship Diagram (ERD)**</u>🕸️

The following Entity-Relationship Diagram (ERD) shows a visual representation of the data and established relationships between relevant dimension and fact tables within the database of the Data Mart:

![Video Game Industry ERD](VideoGameIndustry_ERD_LightBackground_SVG.svg)


## **🎮**<u>**Data Definition Language (DDL) & Data Manipulation Language (DML) for Creating Database**</u>**🎮**

Below are links to download the two (2) executable DDL & DML SQL files required to create the database:

1. [DDL - Global Video Game Sales](https://github.com/KCracks/KBIA_Portfolio/blob/main/DDL%20-%20Global%20Video%20Game%20Sales.sql)

2. [DML - Global Video Game Sales](https://github.com/KCracks/KBIA_Portfolio/blob/main/DML%20-%20Global%20Video%20Game%20Sales.sql)


## 🕷️<u>**Structure and SQL Code Outline for Developing Data Definition Language (DDL) to Create Dimension & Fact Tables**</u>**🕷️**

The following SQL code outline represents <span style="color: var(--vscode-foreground);">Data Definition Language (DDL)&nbsp;</span> <span style="color: var(--vscode-foreground);">for generating necessary&nbsp;</span> <span style="color: var(--vscode-foreground);">dimension and fact tables</span> <span style="color: var(--vscode-foreground);">&nbsp;to give form and structure to the database for aforementioned Data Mart. These are inherently a series of SQL statements and instructions utilized to generate dimension and fact tables for the database; the application utilized was Microsoft SQL Server Management Studio (SSMS):</span>

```
**📓 GLOBAL VIDEO GAME SALES DDL CREATION 📓**

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  Create Database  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the database for which all subsequent dimension and fact tables will form a part of going forward:

IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'GlobalVideoGameSales')

BEGIN

    CREATE DATABASE GlobalVideoGameSales;

END

GO

USE GlobalVideoGameSales;

GO

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*    Schema DDL       \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the various schema "groups or containers" for which all subsequent dimension and fact tables will form a part of going forward. These are used to define and give structure to the database going forward:

IF NOT EXISTS (SELECT \* FROM sys.schemas WHERE name = 'stg' ) 

BEGIN

    EXEC sp\_executesql N'CREATE SCHEMA stg AUTHORIZATION dbo;'

END

IF NOT EXISTS (SELECT \* FROM sys.schemas WHERE name = 'dim' ) 

BEGIN

    EXEC sp\_executesql N'CREATE SCHEMA dim AUTHORIZATION dbo;'

END

IF NOT EXISTS (SELECT \* FROM sys.schemas WHERE name = 'f' ) 

BEGIN

    EXEC sp\_executesql N'CREATE SCHEMA f AUTHORIZATION dbo;'

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*  Create stg.ALL\_VG\_Sales Table  \*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the staging table utlizing the 'stg' schema. This table contains the raw data to be later logically inserted into dimension and fact tables going forward (please note, however, that this was not particularly necessary as the staging table for this particular database was generated and imported from Microsoft Power BI through utilizing specialized features from the "Dax Studio" application; this made the process a lot faster and more seemless).

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'stg' AND TABLE\_NAME = 'ALL\_VG\_Sales')

BEGIN

    CREATE TABLE stg.ALL\_VG\_Sales (

        ID INT NOT NULL,

        Sales\_Rank INT NOT NULL,

        \[Video Game Title\] NVARCHAR(200) NOT NULL,

        Release\_Year INT NOT NULL,

        Genre NVARCHAR(15) NULL,

        \[Publisher Company\] NVARCHAR(100) NULL,

        \[Gaming Platform\] NVARCHAR(15) NULL,

        NorthAmerica\_Sales INT NULL,

        Europe\_Sales INT NULL,

        Japan\_Sales INT NULL,

        OtherRegions\_Sales INT NULL,

        GlobalSales INT NULL

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  Create Sequences   \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL sequence statements are used to generate unique identifiers necessary for distinct/pridictable primary keys and other unique ID fields needed to adequately create connections/joins between the dimension and fact tables:

IF NOT EXISTS (SELECT \* FROM sys.sequences WHERE name = 'PublisherID\_Seq')

BEGIN

    CREATE SEQUENCE dbo.PublisherID\_Seq

    AS INT

    START WITH 1

    INCREMENT BY 1;

END

IF NOT EXISTS (SELECT \* FROM sys.sequences WHERE name = 'PlatformID\_Seq')

BEGIN

    CREATE SEQUENCE dbo.PlatformID\_Seq

    AS INT

    START WITH 1

    INCREMENT BY 1;

END

IF NOT EXISTS (SELECT \* FROM sys.sequences WHERE name = 'GenreID\_Seq')

BEGIN

    CREATE SEQUENCE dbo.GenreID\_Seq

    AS INT

    START WITH 1

    INCREMENT BY 1;

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  GlobalSales DIM DDL  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the 1st dimension table called "GlobalSales" utlizing the 'dim' schema. This dimension table was designed specifically to contain all relevant sale data for the database:  

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'dim' AND TABLE\_NAME = 'GlobalSales')

BEGIN

    CREATE TABLE dim.GlobalSales(

        RegionSalesID INT NOT NULL PRIMARY KEY,

        Release\_Year INT NOT NULL,

        NorthAmerica\_Sales INT NULL,

        Europe\_Sales INT NULL,

        Japan\_Sales INT NULL,

        OtherRegions\_Sales INT NULL,

        GlobalSales INT NULL

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  VideoGameUnits DIM DDL  \*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the 2nd dimension table called "VideoGameUnits" utlizing the 'dim' schema. This dimension table was designed specifically to contain all relevant data related to spcific video games for the database. All data to be contained within are interconnected and related to each other in some way:

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'dim' AND TABLE\_NAME = 'VideoGameUnits')

BEGIN

    CREATE TABLE dim.VideoGameUnits(

        GameID INT NOT NULL UNIQUE,

        Sales\_Rank INT NOT NULL PRIMARY KEY,

        Video\_Game\_Title NVARCHAR(200) NOT NULL,

        Release\_Year INT NOT NULL,

        Genre NVARCHAR(15) NULL,

        Publisher\_Company NVARCHAR(100) NULL,

        Gaming\_Platform NVARCHAR(15) NULL

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  PublisherCompanies DIM DDL  \*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the 3rd dimension table called "PublisherCompanies" utlizing the 'dim' schema. This is a simple dimension table which was designed specifically to contain all unique names and identifiers allotted to Video Game Publisher Companies for the database: 

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'dim' AND TABLE\_NAME = 'PublisherCompanies')

BEGIN

    CREATE TABLE dim.PublisherCompanies(

        PublisherID INT NULL,

        Publisher\_Company NVARCHAR(100) NOT NULL PRIMARY KEY

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  GamePlatform DIM DDL  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the 4th dimension table called "GamePlatform" utlizing the 'dim' schema. This is a simple dimension table which was designed specifically to contain all unique names and identifiers allotted to Gaming Platforms for the database: 

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'dim' AND TABLE\_NAME = 'GamePlatform')

BEGIN

    CREATE TABLE dim.GamePlatform(

        PlatformID INT NULL,

        GamingPlatform NVARCHAR(15) NOT NULL PRIMARY KEY

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  GameGenre DIM DDL  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the 5th dimension table called "GameGenre" utlizing the 'dim' schema. This is a simple dimension table which was designed specifically to contain all unique names and identifiers allotted to Gaming Genres for the database:  

IF NOT EXISTS (SELECT \* FROM INFORMATION\_SCHEMA.TABLES WHERE TABLE\_SCHEMA = 'dim' AND TABLE\_NAME = 'GameGenre')

BEGIN

    CREATE TABLE dim.GameGenre(

        GenreID INT NULL,

        VideoGameGenre NVARCHAR(15) NOT NULL PRIMARY KEY

    );

END

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*  Fact Table Creation  \*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

📒 The following SQL statement is used to generate the only Fact table for this database called "IndustrySales" utlizing the 'f' schema. This fact table was designed specifically to contain all metrics/measures needed by all abovementioned dimension tables and therefore establishes relationships between them throught on-to-many connections: 

IF OBJECT\_ID('f.IndustrySales', 'U') IS NOT NULL

BEGIN 

    DROP TABLE f.IndustrySales;

END

CREATE TABLE f.IndustrySales(

    IndustrySalesID INT NOT NULL,

    Sales\_Rank INT NOT NULL,

    Video\_Game\_Title NVARCHAR(200) NOT NULL,

    Release\_Year INT NOT NULL,

    Genre NVARCHAR(15) NULL,

    Publisher\_Company NVARCHAR(100) NULL,

    Gaming\_Platform NVARCHAR(15) NULL,

    NorthAmerica\_Sales INT NULL,

    Europe\_Sales INT NULL,

    Japan\_Sales INT NULL,

    OtherRegions\_Sales INT NULL,

    GlobalSales INT NULL

);

```

## 🧙‍♂️ **<u>Structure and SQL Code Outline for Data Manipulation Language (DML) utilized to Insert relevant Data into Dimension & Fact Tables</u>** **🧙‍♂️**

As the previously created DDL fact and dimension tables remain empty at this stage, the following SQL code outline represents <span style="color: var(--vscode-foreground);">Data Manipulation Language (DML)</span> <span style="color: var(--vscode-foreground);">for inserting specific data from the staging 'stg' table to requisite&nbsp;</span>  <span style="color: var(--vscode-foreground);">dimension and fact tables</span> <span style="color: var(--vscode-foreground);">for aforementioned Data Mart. The application utilized was Microsoft SQL Server Management Studio (SSMS):</span>

```

```
```
 
📓 GLOBAL VIDEO GAME SALES DML CREATION  📓

 📔The following SQL statement is used to simply select the newly created "GlobalVideoGameSales" database for which all subsequent dimension and fact tables form a part of:

USE GlobalVideoGameSales;

GO

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\* Insert Data into Dimension Tables \*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

**\-- Insert  data into dim.GlobalSales**

 📔The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to dimension 'dim' table (dim.GlobalSales):

INSERT INTO dim.GlobalSales (

    RegionSalesID, Release\_Year, NorthAmerica\_Sales, Europe\_Sales, Japan\_Sales, OtherRegions\_Sales, GlobalSales

)

SELECT ID, 

       Release\_Year, 

       NorthAmerica\_Sales, 

       Europe\_Sales, 

       Japan\_Sales, 

       OtherRegions\_Sales, 

       GlobalSales

FROM stg.ALL\_VG\_Sales;

**\-- Insert data into dim.VideoGameUnits**

📔The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to dimension 'dim' table (dim.VideoGameUnits):

INSERT INTO dim.VideoGameUnits (

    GameID, Sales\_Rank, Video\_Game\_Title, Release\_Year, Genre, Publisher\_Company, Gaming\_Platform

)

SELECT ID,

       Sales\_Rank,

       \[Video Game Title\],

       Release\_Year,

       Genre,

       \[Publisher Company\],

       \[Gaming Platform\]

FROM stg.ALL\_VG\_Sales;

**\-- Insert data into dim.PublisherCompanies**

📔The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to dimension 'dim' table (dim.PublisherCompanies); note the use of previously generated sequence (at DDL stage) to insert unique ID values. This cannot be done with data that is "NULL" in type and as such it had to be done while it was still NULL and then converted to "NOT NULL" to facilitate the constraint clause added at the end that establishes the rule that there must never be any duplicates in this field:

INSERT INTO dim.PublisherCompanies (Publisher\_Company)

SELECT DISTINCT \[Publisher Company\]

FROM stg.ALL\_VG\_Sales

WHERE \[Publisher Company\] IS NOT NULL;

UPDATE dim.PublisherCompanies

SET PublisherID = NEXT VALUE FOR dbo.PublisherID\_Seq

WHERE PublisherID IS NULL;

ALTER TABLE dim.PublisherCompanies

ALTER COLUMN PublisherID INT NOT NULL;

ALTER TABLE dim.PublisherCompanies

ADD CONSTRAINT UC\_PublisherCompanies\_ID UNIQUE (PublisherID);

  

**\-- Insert data into dim.GamePlatform** 

📔The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to dimension 'dim' table (dim.GamePlatform); note the use of previously generated sequence (at DDL stage) to insert unique ID values. This cannot be done with data that is "NULL" in type and as such it had to be done while it was still NULL and then converted to "NOT NULL" to facilitate the constraint clause added at the end that establishes the rule that there must never be any duplicates in this field :

INSERT INTO dim.GamePlatform (GamingPlatform)

SELECT DISTINCT \[Gaming Platform\]

FROM stg.ALL\_VG\_Sales

WHERE \[Gaming Platform\] IS NOT NULL;

UPDATE dim.GamePlatform

SET PlatformID = NEXT VALUE FOR dbo.PlatformID\_Seq

WHERE PlatformID IS NULL;

ALTER TABLE dim.GamePlatform

ALTER COLUMN PlatformID INT NOT NULL;

ALTER TABLE dim.GamePlatform

ADD CONSTRAINT UC\_GamePlatform\_ID UNIQUE (PlatformID);

  

**\-- Insert data into dim.GameGenre** 
📔 The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to dimension 'dim' table (dim.GameGenre); note the use of previously generated sequence (at DDL stage) to insert unique ID values. This cannot be done with data that is "NULL" in type and as such it had to be done while it was still NULL and then converted to "NOT NULL" to facilitate the constraint clause added at the end that establishes the rule that there must never be any duplicates in this field :

INSERT INTO dim.GameGenre (VideoGameGenre)

SELECT DISTINCT Genre

FROM stg.ALL\_VG\_Sales

WHERE Genre IS NOT NULL;

UPDATE dim.GameGenre

SET GenreID = NEXT VALUE FOR dbo.GenreID\_Seq

WHERE GenreID IS NULL;

ALTER TABLE dim.GameGenre

ALTER COLUMN GenreID INT NOT NULL;

ALTER TABLE dim.GameGenre

ADD CONSTRAINT UC\_GameGenre\_ID UNIQUE (GenreID);

  

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\* Insert Data into FACT Table \*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

**\-- Insert data into f.IndustrySales**

 📔 The following SQL statement inserts relevant data from the staging 'stg' table (stg.ALL_VG_Sales) to fact 'f' table (f.IndustrySales); this table contains all relevant data, metrics and measures that relate to all dimension tables. All data contained in this fact table are directly related, interconnected, and hence dependent on each other:

INSERT INTO f.IndustrySales (

    IndustrySalesID, Sales\_Rank, Video\_Game\_Title, Release\_Year, Genre, Publisher\_Company, Gaming\_Platform, 

    NorthAmerica\_Sales, Europe\_Sales, Japan\_Sales, OtherRegions\_Sales, GlobalSales

)

SELECT ID,

       Sales\_Rank,

       \[Video Game Title\],

       Release\_Year,

       Genre,

       \[Publisher Company\],

       \[Gaming Platform\],

       NorthAmerica\_Sales,

       Europe\_Sales,

       Japan\_Sales,

       OtherRegions\_Sales,

       GlobalSales

FROM stg.ALL\_VG\_Sales;

  

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*  Add Constraints for FACT Table    \*\*\*\*\*\*\*\*\*\*\*\*/

/\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*\*/

 📔 The following SQL statements establish all relevant constraints for the fact table. These constrainsts serve as the "threads" that sew the dimension tables to the fact table and vice versa as "one-to-many". They also serve to create "pseudo" connections between dimensions as well and hence allow data manipulation between them without them being directly connected. This is done through connecting all established "Primary Keys" contained in dimension tables  to foreign keys in the fact table. With that said, it is important to note that primary keys that are connected to related foreign keys must share the same data type and length to successfully connect. These constrainst also establish specific rules that must be abide by for further data manipulation throughout the Data Mart:  

ALTER TABLE f.IndustrySales

ADD CONSTRAINT PK\_IND PRIMARY KEY(Sales\_Rank);

ALTER TABLE f.IndustrySales

ADD CONSTRAINT FK\_INDtoGLO

    FOREIGN KEY (IndustrySalesID)

    REFERENCES dim.GlobalSales(RegionSalesID);

ALTER TABLE f.IndustrySales

ADD CONSTRAINT FK\_INDtoVGU

    FOREIGN KEY (Sales\_Rank)

    REFERENCES dim.VideoGameUnits(Sales\_Rank);

ALTER TABLE f.IndustrySales

ADD CONSTRAINT FK\_INDtoVGPub

    FOREIGN KEY (Publisher\_Company)

    REFERENCES dim.PublisherCompanies(Publisher\_Company);

ALTER TABLE f.IndustrySales

ADD CONSTRAINT FK\_INDtoVGP

    FOREIGN KEY (Gaming\_Platform)

    REFERENCES dim.GamePlatform(GamingPlatform);

ALTER TABLE f.IndustrySales

ADD CONSTRAINT FK\_INDtoVGG

    FOREIGN KEY (Genre)

    REFERENCES dim.GameGenre(VideoGameGenre);

```

