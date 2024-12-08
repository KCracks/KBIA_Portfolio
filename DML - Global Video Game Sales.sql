/********* GLOBAL VIDEO GAME SALES DML CREATION **********/

USE GlobalVideoGameSales;
GO

/*********************************************************/
/*********** Insert Data into Dimension Tables ***********/
/*********************************************************/

-- Insert into dim.GlobalSales
INSERT INTO dim.GlobalSales (
    RegionSalesID, Release_Year, NorthAmerica_Sales, Europe_Sales, Japan_Sales, OtherRegions_Sales, GlobalSales
)
SELECT ID, 
       Release_Year, 
       NorthAmerica_Sales, 
       Europe_Sales, 
       Japan_Sales, 
       OtherRegions_Sales, 
       GlobalSales
FROM stg.ALL_VG_Sales;

-- Insert into dim.VideoGameUnits
INSERT INTO dim.VideoGameUnits (
    GameID, Sales_Rank, Video_Game_Title, Release_Year, Genre, Publisher_Company, Gaming_Platform
)
SELECT ID,
       Sales_Rank,
       [Video Game Title],
       Release_Year,
       Genre,
       [Publisher Company],
       [Gaming Platform]
FROM stg.ALL_VG_Sales;

-- Insert into dim.PublisherCompanies
INSERT INTO dim.PublisherCompanies (Publisher_Company)
SELECT DISTINCT [Publisher Company]
FROM stg.ALL_VG_Sales
WHERE [Publisher Company] IS NOT NULL;

UPDATE dim.PublisherCompanies
SET PublisherID = NEXT VALUE FOR dbo.PublisherID_Seq
WHERE PublisherID IS NULL;

ALTER TABLE dim.PublisherCompanies
ALTER COLUMN PublisherID INT NOT NULL;

ALTER TABLE dim.PublisherCompanies
ADD CONSTRAINT UC_PublisherCompanies_ID UNIQUE (PublisherID);

-- Insert into dim.GamePlatform 
INSERT INTO dim.GamePlatform (GamingPlatform)
SELECT DISTINCT [Gaming Platform]
FROM stg.ALL_VG_Sales
WHERE [Gaming Platform] IS NOT NULL;

UPDATE dim.GamePlatform
SET PlatformID = NEXT VALUE FOR dbo.PlatformID_Seq
WHERE PlatformID IS NULL;

ALTER TABLE dim.GamePlatform
ALTER COLUMN PlatformID INT NOT NULL;

ALTER TABLE dim.GamePlatform
ADD CONSTRAINT UC_GamePlatform_ID UNIQUE (PlatformID);

-- Insert into dim.GameGenre 
INSERT INTO dim.GameGenre (VideoGameGenre)
SELECT DISTINCT Genre
FROM stg.ALL_VG_Sales
WHERE Genre IS NOT NULL;

UPDATE dim.GameGenre
SET GenreID = NEXT VALUE FOR dbo.GenreID_Seq
WHERE GenreID IS NULL;

ALTER TABLE dim.GameGenre
ALTER COLUMN GenreID INT NOT NULL;

ALTER TABLE dim.GameGenre
ADD CONSTRAINT UC_GameGenre_ID UNIQUE (GenreID);

/*********************************************************/
/************** Insert Data into FACT Table **************/
/*********************************************************/

-- Insert data into f.IndustrySales
INSERT INTO f.IndustrySales (
    IndustrySalesID, Sales_Rank, Video_Game_Title, Release_Year, Genre, Publisher_Company, Gaming_Platform, 
    NorthAmerica_Sales, Europe_Sales, Japan_Sales, OtherRegions_Sales, GlobalSales
)
SELECT ID,
       Sales_Rank,
       [Video Game Title],
       Release_Year,
       Genre,
       [Publisher Company],
       [Gaming Platform],
       NorthAmerica_Sales,
       Europe_Sales,
       Japan_Sales,
       OtherRegions_Sales,
       GlobalSales
FROM stg.ALL_VG_Sales;

/*********************************************************/
/*********  Add Constraints for FACT Table    ************/
/*********************************************************/

ALTER TABLE f.IndustrySales
ADD CONSTRAINT PK_IND PRIMARY KEY(Sales_Rank);

ALTER TABLE f.IndustrySales
ADD CONSTRAINT FK_INDtoGLO
    FOREIGN KEY (IndustrySalesID)
    REFERENCES dim.GlobalSales(RegionSalesID);

ALTER TABLE f.IndustrySales
ADD CONSTRAINT FK_INDtoVGU
    FOREIGN KEY (Sales_Rank)
    REFERENCES dim.VideoGameUnits(Sales_Rank);

ALTER TABLE f.IndustrySales
ADD CONSTRAINT FK_INDtoVGPub
    FOREIGN KEY (Publisher_Company)
    REFERENCES dim.PublisherCompanies(Publisher_Company);

ALTER TABLE f.IndustrySales
ADD CONSTRAINT FK_INDtoVGP
    FOREIGN KEY (Gaming_Platform)
    REFERENCES dim.GamePlatform(GamingPlatform);

ALTER TABLE f.IndustrySales
ADD CONSTRAINT FK_INDtoVGG
    FOREIGN KEY (Genre)
    REFERENCES dim.GameGenre(VideoGameGenre);