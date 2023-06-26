--Looking into the data

select * from covid_deaths;
select * from covid_vaccinations;
select * from covid_stats;



--Total people infected and total death

select  
sum(new_deaths) as "Total Deaths",
sum(new_cases) as "Total Infected"
from covid_deaths
where continent is not null



--Daily count of new cases and death by country wise

select location, date, new_cases
from covid_deaths
where continent is not null;

select location, date, new_deaths
from covid_deaths
where continent is not null;



--Total deaths and new cases of each continent and country

select continent, location, sum(new_cases)as total_new_cases,sum(new_deaths) as total_death_count
from covid_deaths
where continent is not null
group by continent, location
order by total_death_count desc;



-- Looking at India's total death counts 

select location, 
sum(new_cases)as total_new_cases,
sum(new_deaths) as total_death_count
from covid_deaths
where continent is not null and location = 'India'
group by  location
order by total_death_count desc;



--Looking for percentage of total infected people on the total population of the countries.

select distinct(location), 
population, 
sum(new_cases) as total_new_cases, (sum(new_cases::numeric)/population)::numeric*100.0 AS percentage_population_infected
from covid_deaths
where continent is not null
group by location,population
order by percentage_population_infected desc ;



--Looking for percentage of total infected people in India.

select distinct(location), 
population, 
sum(new_cases) as total_cases, 
(sum(new_cases::numeric)/population::numeric)*100.0 AS percentage_population_infected
from covid_deaths
where location = 'India'
group by location, population
order by percentage_population_infected desc ;



--Looking for percentage of total death of people on the total population of the countries.

select distinct(location),
population, 
sum(new_deaths) as total_deaths, 
(sum(new_deaths::numeric)/population::numeric)*100.0 AS percentage_of_population_died
from covid_deaths
where continent is not null 
group by location, population
order by percentage_of_population_died desc ;



--Looking for percentage of total death of  people in India.

select location, population, sum(new_deaths) as total_death, (sum(new_deaths::numeric)/population::numeric)*100.0 AS percentage_population_died
from covid_deaths
where location = 'India'
group by  location, population
order by percentage_population_died desc ;



--Location-wise Statistics: Total Population, Cases, and Deaths

select  distinct(location) as continents ,
population as total_population, 
sum(new_cases) as total_new_cases, 
sum(new_deaths) as total_death,
(sum(new_cases)/population)*100 as percentage_of_total_cases,
(sum(new_deaths)/population)*100 as percentage_of_total_deaths
from covid_deaths
where continent is not null
group by location, population
order by total_new_cases desc;



--Continent-wise Statistics: Total Population, Cases, and Deaths

select  distinct(continent) as continents ,
sum(population) as total_population, 
sum(new_cases) as total_cases, 
sum(new_deaths) as total_death,
(sum(new_cases)/sum(population))*100 as percentage_of_total_cases,
(sum(new_deaths)/sum(population))*100 as percentage_of_total_deaths
from covid_deaths
where continent is not null
group by continent
order by total_cases desc;



--Looking into average hospitalized patients and icu patients in each year.

select extract (year from date) as year, 
round(avg(icu_patients)) as average_icu_patients,
round(avg(hosp_patients)) as average_hosp_patients
from covid_deaths
where date >= '2021-01-01' and date <= '2023-12-31'
group by year;



--Looking into total vaccination, total covid tests done, average of positivity rate of each countries
--Also calulating the percentage of vaccinated people in the country.

select
t.location,
t.total_tests,
t.average_positive_rate,
v.total_vaccinations,
v.population,
v.vaccination_rate
from
(
select covid_vaccinations.location,
sum(new_tests) as total_tests,
avg(positive_rate) as average_positive_rate
from covid_vaccinations
join covid_deaths on covid_vaccinations.location = covid_deaths.location
where covid_deaths.continent is not null and covid_vaccinations.continent is not null
group by covid_vaccinations.location
order by total_tests desc)

t join 

(select covid_vaccinations.location,
max(total_vaccinations) as total_vaccinations,
covid_deaths.population,
(max(total_vaccinations)/covid_deaths.population) * 100 as vaccination_rate
from covid_vaccinations
join covid_deaths on covid_vaccinations.location = covid_deaths.location
where covid_deaths.continent is not null and covid_vaccinations.continent is not null
group by
covid_vaccinations.location,
covid_deaths.population
order by vaccination_rate desc) 
v on t.location = v.location;



--Location wise total vaccinations

select location, max(total_vaccinations) as total_vaccinations
from covid_vaccinations
where continent is not null
group by location
order by total_vaccinations desc;



--India total vaccinations

select location, max(total_vaccinations) as total_vaccinations
from covid_vaccinations
where continent is not null and location = 'India'
group by location
order by total_vaccinations desc;



--Continent wise total vaccinations

select distinct(continent), max(total_vaccinations) as total_vaccinations
from covid_vaccinations
where continent is not null
group by continent
order by total_vaccinations desc;


--Covid statistics and demographics by Country 

select 
	covid_stats.location,
	covid_deaths.population,
 	avg(covid_stats.population_density) as average_populaion_density,
	avg(covid_stats.gdp_per_capita) as average_gdp_per_capita,
	avg(covid_stats.extreme_poverty) as average_extreme_poverty
from covid_stats
join covid_deaths on covid_deaths.location = covid_stats.location
group by covid_stats.location,covid_deaths.population
order by location;


--Statistics by Country and Age

select location,
avg(median_age) as average_median_age,
avg(aged_65_older) as average_age_above_65,
avg(aged_70_older) as average_age_above_70
from covid_stats
where continent is not null
group by location;


-- Health Demographics by Country

select location,
	avg(cardiovasc_death_rate) as cardiovasc_death_rate,
	avg(diabetes_prevalence) as diabetes_prevalence,
	avg(female_smokers) as female_smokers,
	avg(male_smokers) as male_smokers,
	avg(life_expectancy) as life_expectancy
from covid_stats
where continent is not null
group by location;


