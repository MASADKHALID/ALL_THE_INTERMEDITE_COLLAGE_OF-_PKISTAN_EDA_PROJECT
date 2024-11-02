create database intermidiade_collages_data;
use intermidiade_collages_data;
create table clean_table(     
	ID INT PRIMARY KEY,
	Name varchar(255),
	Location varchar(255),
	Study_Program varchar(400),
	Sector varchar(7),
	Affiliation varchar(400),
	Rating float
);
--BULK INSERT DATA
SELECT
	*
FROM clean_table;
BULK INSERT clean_table
FROM 'E:\anaconda_data_engineering\envs\cloud_data_engineeringenv\eda\clean_table.csv'
WITH
(
	FORMAT='CSV',
	FIRSTROW=2
)
GO
--CHECK DATA
SELECT *
FROM clean_table;
--TOP_10_COLLAGE
SELECT 
	TOP 10
       Name,
	   MAX(Rating) AS Maximum_Rating
INTO TOP_10_COLLGE
FROM clean_table
GROUP BY 
	   Name
ORDER BY 
	   Maximum_Rating DESC;
--CHECK DATA
SELECT *
FROM TOP_10_COLLGE;

--LEAST 10 COLAGE
SELECT 
	TOP 10
       Name,
	   MAX(Rating) AS Maximum_Rating
INTO LEAST_10_COLLGE
FROM clean_table
GROUP BY 
	   Name
ORDER BY 
	   Maximum_Rating ASC;
--CHECK DATA
SELECT *
FROM LEAST_10_COLLGE;
--PROGRAMS RATING
SELECT Study_Program,
	   MAX(Rating) AS Maximum_Rating,
	   MIN(Rating) AS Minimun_Rating
INTO PROGRMS_RATING
FROM clean_table
GROUP BY Study_Program;
--CHECK DATA
SELECT *
FROM PROGRMS_RATING;
 --SECTOR WISE MAXIMUM RATING 
SELECT 
    t1.Sector,
    t1.Name AS College_Name,
    t1.Rating AS MAXIMUM_RATING
INTO SECTOR_WISE_MAX_RATING
FROM 
    clean_table t1
JOIN 
    (SELECT 
        Sector, 
        MAX(Rating) AS MAXIMUM_RATING
     FROM 
        clean_table
     GROUP BY 
        Sector) t2
ON 
    t1.Sector = t2.Sector 
    AND t1.Rating = t2.MAXIMUM_RATING;
--CHECK DATA
SELECT *
FROM SECTOR_WISE_MAX_RATING;

 --SECTOR WISE MAXIMUM RATING 
SELECT 
    t1.Sector,
    t1.Name AS College_Name,
    t1.Rating AS MINIMUM_RATING
INTO SECTOR_WISE_MIN_RATING
FROM 
    clean_table t1
JOIN 
    (SELECT 
        Sector, 
        MIN(Rating) AS MINIMUM_RATING
     FROM 
        clean_table
     GROUP BY 
        Sector) t2
ON 
    t1.Sector = t2.Sector 
    AND t1.Rating = t2.MINIMUM_RATING;
--CHECK DATA
SELECT *
FROM SECTOR_WISE_MIN_RATING;
--AFFILIATE COLLAGE COUNT
SELECT 
	Affiliation,
	COUNT(Affiliation) AS no_of_collage_affiliate 
INTO AFFILIATION_COUNT
FROM clean_table 
GROUP BY 
	Affiliation;
--CHECK DATA
SELECT *
FROM AFFILIATION_COUNT;

