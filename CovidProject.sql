/*
Covid 19 Data Exploration

Skills used: Joins, CTE's, Temp Tables, Windows Functions, Aggregate Functions, Creating Views, Converting Data Types

*/

SELECT *
 FROM `covidproject-421018.CovidDataset.CovidDeaths` 
 WHERE continent is not null
 ORDER BY 3,4


 -- Select Data that we are goign to be starting with

 SELECT location, date, total_cases, new_cases, total_deaths, population
 FROM `covidproject-421018.CovidDataset.CovidDeaths` 
 WHERE continent is not null
 ORDER BY 1,2


-- Total cases vs Total Deaths
-- Shows Likelihood of dying if you contract covid in your country

SELECT location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 AS DeathPercentage
 FROM `covidproject-421018.CovidDataset.CovidDeaths` 
 WHERE location = 'United States'
 AND continent IS NOT NULL
 ORDER BY 1,2


-- Total Cases vs Population
-- Shows what percentage of population infected with Covid

 SELECT location, date, population, total_cases, (total_cases/population)*100 AS PercentPopulationInfected
 FROM `covidproject-421018.CovidDataset.CovidDeaths` 
 WHERE location = 'United States'
 ORDER BY 1,2

-- Countries with Highest Infection Rate compared to Population

SELECT location, population, Max(total_cases) AS HighestInfectionCount, MAX(total_cases/population)*100 AS PercentPopulationInfected
FROM `covidproject-421018.CovidDataset.CovidDeaths` 
GROUP BY location, population
ORDER BY PercentPopulationInfected DESC

-- Countries with Highest Death Count per Population

SELECT location, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM `covidproject-421018.CovidDataset.CovidDeaths` 
WHERE continent IS NOT NULL
GROUP BY location
ORDER BY TotalDeathCount DESC

-- Breaking Things Down By Continent

-- Showing Continents with Highest Death Count per Population

SELECT continent, MAX(CAST(total_deaths AS INT)) AS TotalDeathCount
FROM `covidproject-421018.CovidDataset.CovidDeaths` 
WHERE continent IS NOT NULL
GROUP BY continent
ORDER BY TotalDeathCount DESC


-- Globel Numbers

SELECT SUM(new_cases) AS total_cases, SUM(CAST(new_deaths AS INT)) AS total_deaths, SUM(CAST(new_deaths AS INT))/SUM(new_cases)*100 AS DeathPercentage
FROM `covidproject-421018.CovidDataset.CovidDeaths` 
WHERE continent IS NOT NULL
ORDER BY 1,2

-- Total Population vs. Vaccinations
-- Shows Percentage of Population that has recieved at least one Covid Vaccine

SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM 
`covidproject-421018.CovidDataset.CovidDeaths` AS dea
JOIN 
`covidproject-421018.CovidDataset.CovidVaccinations` AS vac
ON 
dea.location = vac.location
AND 
dea.date = vac.date
WHERE 
dea.continent IS NOT NULL
ORDER BY 2,3

-- Using  CTE to perform Calculation on Partition By in previous query

WITH PopvsVac AS (
SELECT dea.continent, dea.location, dea.date, dea.population, vac.new_vaccinations,
SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
FROM 
`covidproject-421018.CovidDataset.CovidDeaths` AS dea
JOIN 
`covidproject-421018.CovidDataset.CovidVaccinations` AS vac
ON 
dea.location = vac.location
AND 
dea.date = vac.date
WHERE 
dea.continent IS NOT NULL
)
SELECT *, (RollingPeopleVaccinated/Population)*100
 FROM PopvsVac;

-- Using Temp Table using Scripting Syntax to perform Calcuation on Partition By in previous query

WITH PercentPopulationVaccinated AS (
  SELECT 
    dea.continent, 
    dea.location, 
    dea.date, 
    dea.population, 
    vac.new_vaccinations,
    SUM(CAST(vac.new_vaccinations AS INT64)) OVER (PARTITION BY dea.location ORDER BY dea.location, dea.date) AS RollingPeopleVaccinated
  FROM 
    `covidproject-421018.CovidDataset.CovidDeaths` AS dea
  JOIN 
    `covidproject-421018.CovidDataset.CovidVaccinations` AS vac
  ON 
    dea.location = vac.location
    AND dea.date = vac.date
)

SELECT 
  *, 
  (RollingPeopleVaccinated / population) * 100 AS PercentPopulationVaccinated
FROM 
  PercentPopulationVaccinated;
