--*Portfolio Project*
--SQL queries used to create tableau dashboard.

-- Query totals on deaths, cases, and mortality rate.
SELECT SUM(new_cases) as 'Total Cases', SUM(cast(new_deaths as int)) as 'Total Deaths', SUM(cast(new_deaths as int))/SUM(new_cases)*100 as 'Mortality Rate'
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is not null
order by 1,2

-- Looking at total deaths by location, query factors out location data that would cause recounting i.e. 'World', 'European Union', etc...

SELECT location, SUM(cast(new_deaths as int)) as 'Total Deaths'
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is not null
and location not in ('World', 'European Union', 'International')
GROUP BY location
ORDER BY [Total Deaths] desc

-- Looking at total deaths by continent, query factors out location data that would cause recounting i.e. 'World', 'European Union', etc...
-- Effectively the same as the above query, but note that continent IS null. As locations with a null continent used the continent as as
-- location instead.

SELECT location, SUM(cast(new_deaths as int)) as 'Total Deaths'
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is null
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income')
GROUP BY location
ORDER BY [Total Deaths] desc

-- Looking for Australia specifically.

SELECT location, continent, sum(new_cases)
from PortfolioProject.dbo.CovidDeaths$
where location = 'Australia'
Group by location, continent

-- Looking at covid vacination data.

SELECT *
from PortfolioProject.dbo.CovidVacinations$

-- Vacination data by country.

SELECT location, MAX(cast(people_vaccinated as bigint)) as 'Total Vaccinations'
FROM PortfolioProject.dbo.CovidVacinations$
WHERE continent is not null
and location not in ('World', 'European Union', 'International', 'Upper middle income', 'High income', 'Lower middle income', 'Low income')
group by location
Order by [Total Vaccinations] desc

-- Query to create data on percentage of population infected per country.

SELECT location, date, total_cases/population*100 as 'Percent Infected'
FROM PortfolioProject.dbo.CovidDeaths$
WHERE continent is not null
and location not in ('World', 'European Union', 'International')
ORDER BY [Percent Infected] desc

