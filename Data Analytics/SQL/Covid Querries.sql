SELECT * FROM [Covid data]..CovidDeatths
WHERE continent is NOT NULL
ORDER BY 3,4

SELECT * FROM [Covid data]..CovidVaccinations
ORDER BY 3,4



-- SELECTING DATA TO USE:
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM [Covid data]..CovidDeatths
ORDER BY 1,2


-- Total Cases Vs Total Deaths
-- The likelihood of dying in Uganda when you get infected by Covid
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [Covid data]..CovidDeatths
WHERE location = 'Uganda'
ORDER BY 1,2



-- TOTAL CASES VS POPULATION
 --Percentage of population with Covid in the USA
SELECT location, date, total_cases,total_deaths, population, (total_cases/population)*100 AS Total_Cases_Percentage
FROM [Covid data]..CovidDeatths
WHERE location = 'United States'
ORDER BY 1,2



-- Countries with highest cases as compared to population

SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Max_percentage
FROM [Covid data]..CovidDeatths
GROUP BY location, population
ORDER BY Max_percentage desc



-- Countries with highest death rates

SELECT location, MAX(CAST (total_deaths as int)) AS Death_Count
FROM [Covid data]..CovidDeatths
WHERE continent is NOT NULL
GROUP BY location 
ORDER BY Death_count desc


-- BREAKING DOWN BY CONTINENT

--  Continents with highest death count

SELECT location, MAX(CAST (total_deaths as int)) AS Death_Count
FROM [Covid data]..CovidDeatths
WHERE continent is NULL
GROUP BY location
ORDER BY Death_count desc

-- GLOBAL NUMBERS

SELECT date, SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(total_deaths/total_cases)*100 AS Death_Percentage
FROM [Covid data]..CovidDeatths
WHERE continent is NOT NULL
GROUP BY date
ORDER BY 1,2

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS int)) AS total_deaths, SUM(total_deaths/total_cases)*100 AS Death_Percentage
FROM [Covid data]..CovidDeatths
WHERE continent is NOT NULL
--GROUP BY date
ORDER BY 1,2



-- COVID VACCINATIONS TABLE

SELECT * FROM [Covid data]..CovidVaccinations
WHERE continent is NOT NULL
ORDER BY 3,4

-- SELECT DATA TO USE 

SELECT continent, location, date, new_tests, total_tests, people_vaccinated, people_fully_vaccinated FROM [Covid data]..CovidVaccinations
WHERE continent is NOT NULL
ORDER BY 1,2


-- JOINING THE TWO TABLES
SELECT *
FROM [Covid data]..CovidDeatths dea
join [Covid data]..CovidVaccinations vac
ON dea.location = vac.location 
AND dea.date = vac.date


-- TOTAL POPULATION VS VACCINATIONS

