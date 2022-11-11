CREATE DATABASE SampleData;

USE SampleData;

--- CREATING COUNTRY TABLE
CREATE TABLE Country (
id INT NOT NULL PRIMARY KEY,
name VARCHAR(20),
population INT,
area INT 
)

--INSERT VALUES INTO COUNTRY TABLE
INSERT INTO Country(id,name,population,area) VALUES(1,'France',66600000,640680),(2,'Germany',86700000,357000),(3,'USA',330000000,245000),(4,'Russia',8000000,124000),(5,'China',180000000,543000)

-- CREATING CITY TABLE
CREATE TABLE City (
id INT NOT NULL PRIMARY KEY,
name VARCHAR(20),
country_id INT,
population INT,
rating INT 
)

--INSERT VALUES INTO CITY TABLE
INSERT INTO City(id,name,country_id,population,rating) VALUES(1,'Paris',1,2243000,5),(2,'Berlin',2,3460000,3),(3,'New York',3,6500000,2),(4,'Moscow',4,4050000,4),(5,'Shanghai',5,25000000,1)

SELECT * FROM City

SELECT name AS [City Name]
FROM City

--UPDATE City
--SET [name] = name AS [City Name]


--NAMES OF CITIES WITH POPULATION BETWEEN 2000000 AND 5000000
SELECT name AS [City Name]
FROM City
WHERE population BETWEEN 3000000 AND 5000000

--CITIES IN COUNTRIES WITH IDs 1,3 AND 5
SELECT name AS [City Name]
FROM City
WHERE country_id IN (1,3,5)

--JOINING TABLES --
SELECT co.name AS country, ci.name AS city
FROM City AS ci
JOIN Country AS co
	ON ci.country_id = co.id

-- INNER JOIN --
-- Returns rows with matching values in both tables
SELECT city.name, country.name FROM City
INNER JOIN Country
ON city.country_id = Country.id

-- LEFT JOIN --
--Returns all rows from the left table with corresponding rows from the right. If there is no matching rows, Nulls
SELECT city.name, country.name FROM City
LEFT JOIN Country
ON city.country_id = Country.id

