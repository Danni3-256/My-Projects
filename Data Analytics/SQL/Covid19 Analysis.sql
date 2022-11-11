/****** Script for SelectTopNRows command from SSMS  ******/
-- This is EDA AND ADHOC ANALYSIS ON THE GLOBAL IMPACT OF COVID-19 AS OF 17TH JUNE 2022

SELECT *
FROM [Covid data].[dbo].[Covid$]

-- SELECTING DATA TO USE:
SELECT continent,location, date,total_cases,total_tests,icu_patients,reproduction_rate,total_vaccinations,male_smokers,female_smokers,new_deaths,total_deaths, population
FROM [Covid data].[dbo].[Covid$]
ORDER BY 2

-- EDA ON UGANDA
-- Total Cases Vs Total Deaths
-- The likelihood of dying in Uganda when you get infected by Covid
SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
FROM [Covid data].[dbo].[Covid$]
WHERE location = 'Uganda'
ORDER BY 1,2

-- Total Deaths and Cases in Uganda
SELECT MAX(CAST(total_deaths AS INT)) As [Total Deaths], MAX(CAST(total_cases AS INT)) As [Total Cases],MAX(CAST(total_vaccinations AS INT)) As [Total Vaccinations],MAX(population) AS [Total Population]
FROM [Covid data].[dbo].[Covid$]
WHERE location = 'Uganda'


-- TOTAL CASES VS POPULATION
 --Percentage of population with Covid in Uganda
SELECT location, date, total_cases,total_deaths, population, (total_cases/population)*100 AS Total_Cases_Percentage
FROM [Covid data].[dbo].[Covid$]
WHERE location = 'Uganda'
ORDER BY 1,2

-- TABLE FOR UGANDA
--SELECT location, date, total_cases,total_deaths,(total_cases/population)*100 AS Total_Cases_Percentage,(total_deaths/total_cases)*100 AS [Death Percentage]
--INTO Uganda
--FROM [Covid data].[dbo].[Sheet1$]
--WHERE location = 'Uganda'
--ORDER BY 1,2

-- GLOBAL ANALYSIS
-- Countries with highest cases as compared to population

SELECT location, population, MAX(total_cases) AS Highest_Infection_Count, MAX((total_cases/population))*100 AS Max_percentage
FROM [Covid data].[dbo].[Covid$]
GROUP BY location, population
ORDER BY Max_percentage desc

-- Countries with highest death rates

SELECT location, MAX(CAST (total_deaths as int)) AS Death_Count
FROM [Covid data].[dbo].[Covid$]
WHERE continent is NOT NULL
GROUP BY location 
ORDER BY Death_count desc


-- CONTINENTAL ANALYSIS

SELECT * FROM [Covid data].[dbo].[Covid$]
WHERE continent is NOT NULL
ORDER BY 3,4

SELECT * FROM [Covid data].[dbo].[Covid$]
WHERE continent is NULL
ORDER BY 3,4

--  Continents with highest death count

SELECT location, MAX(CAST (total_deaths as int)) AS Death_Count
FROM [Covid data].[dbo].[Covid$]
WHERE continent is NULL
GROUP BY location
ORDER BY Death_count desc

-- GLOBAL NUMBERS

SELECT location, MAX(total_cases) AS [Total Cases], MAX(total_deaths) AS [Total Deaths], MAX(population) AS [Total Population]
FROM [Covid data].[dbo].[Covid$]
WHERE location = 'Uganda'
GROUP BY location
ORDER BY 3 DESC

SELECT DISTINCT location, MAX(reproduction_rate) AS [Reproduction Rate], SUM(People_vaccinated) AS [People Vaccinated], MAX(male_smokers) as [Male Smokers], MAX(female_smokers) AS [Female Smokers]
FROM [Covid data].[dbo].[Covid$]
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY 2 DESC








