Select *
From PortfolioProject..Covid_Deaths
order by 3,4

Select location, date, total_cases, new_cases, total_deaths, population
From PortfolioProject..Covid_Deaths
order by 1,5

-- Total Cases Vs Total Deaths

Select location, date, total_cases, convert(float,total_deaths) as total_deaths , CONVERT(float, total_deaths)/Nullif(Convert(float,total_cases),0)*100 as DeathPercentage
From PortfolioProject..Covid_Deaths
where location like	'%Thai%'
order by 1,4

-- The percentage of people got Covid

Select location, date, convert(float,total_cases) as total_cases, population , CONVERT(float, total_cases)/population*100 as GotCovid
From PortfolioProject..Covid_Deaths
where location like	'%Cyprus%'
order by 1,3

-- Looking at Countries with Highest Infection Rate compared with population

Select location, max(convert(float,total_cases)) as total_cases, population , Max(CONVERT(float, total_cases)/population)*100 as MaxPercentageInfectionRate
From PortfolioProject..Covid_Deaths
--where location like	'%Thai%'
group by Location, population
order by 4 desc

-- Showing Countries with Highest Death count
Select location, max(cast(total_deaths as int)) as total_death_count
From PortfolioProject..Covid_Deaths
--where location like	'%World%'
where nullif(continent,'') is not null
group by Location
order by total_death_count desc

-- Showing Continent with Highest Death percentage
Select continent, max(cast(total_deaths as int)) as total_death_count
From PortfolioProject..Covid_Deaths
--where location like	'%World%'
where nullif(continent,'') is not null
group by continent
order by total_death_count desc

-- Global Number

Select sum(cast(new_cases as int)) as total_cases,sum(cast(new_deaths as int))as total_death, (sum(cast(new_deaths as float))/Nullif(sum(cast(new_cases as int)),0))*100 as Death_Percentage
From PortfolioProject..Covid_Deaths
where nullif(continent,'') is not null
order by total_cases

-- Total Population Vs Vaccinations

select dea.continent, dea.location, cast(dea.date as date), dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, cast(dea.date as date)) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/dea.population
From PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where nullif(dea.continent,'') is not null
order by 2,3

-- Use CTE
With PopVsVac (Continent, Location, Date, Population ,new_vaccinations, RollingPeopleVaccinated)
as
(
select dea.continent, dea.location, cast(dea.date as date), dea.population, vac.new_vaccinations, 
sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, cast(dea.date as date)) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/dea.population
From PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where nullif(dea.continent,'') is not null
--order by 2,3
)
Select *, (RollingPeopleVaccinated/Population)*100
From PopVsVac

-- Temp Table

DROP Table if exists #PercentPopulationVaccinate
Create table #PercentPopulationVaccinate
(
Continent nvarchar(255),
Location nvarchar (255),
Date datetime,
Population numeric,
New_Vaccinations numeric,
RollingPeopleVaccinated numeric
)
Insert into #PercentPopulationVaccinate
select dea.continent, dea.location, cast(dea.date as date), cast(dea.population as float), cast(vac.new_vaccinations as float), 
sum(cast(vac.new_vaccinations as float)) Over (Partition by dea.location order by dea.location, cast(dea.date as date)) as RollingPeopleVaccinated
-- RollingPeopleVaccinated/dea.population
From PortfolioProject..Covid_Deaths dea
join PortfolioProject..Covid_Vaccinations vac
	on dea.location = vac.location
	and dea.date = vac.date
where nullif(dea.continent,'') is not null
--order by 2,3
Select *, (RollingPeopleVaccinated/Population)*100
From #PercentPopulationVaccinate


----------------------------------------------------------------------------
-- For Visualization
--1
Select Sum(cast(new_cases as float)) as total_cases, sum(cast(new_deaths as float)) as total_deaths, 
sum(cast(new_deaths as float))/sum(cast(new_cases as float))*100 as DeathPercentage
From PortfolioProject..Covid_Deaths
where nullif(continent,'') is not null
--Order by 1,2

--2
Select location, sum(cast(new_deaths as float)) as total_death_count
From PortfolioProject..Covid_Deaths
where nullif(continent,'') is null
and location not in ('World', 'European Union', 'International','High income','Upper middle income','Lower middle income','Low income')
Group by location
Order by total_death_count desc

--3
Select location, cast(Population as float) as Population, max(cast(total_cases as float)) as HighestInfectionCount, 
max((cast(total_cases as float)/cast(population as float)))*100 as PercentPopulationInfected
From PortfolioProject..Covid_Deaths
Group by location ,Population
Order by PercentPopulationInfected desc

--4
Select location, cast(population as float) as Population, cast(date as date) as date, max(cast(total_cases as float)) as HighestInfectionCount, 
max((cast(total_cases as float)/cast(population as float)))*100 as PercentPopulationInfected
From PortfolioProject..Covid_Deaths
Group by location, Population, date
Order by PercentPopulationInfected desc
