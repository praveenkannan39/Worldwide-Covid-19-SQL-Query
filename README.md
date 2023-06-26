# Worldwide-Covid-19-SQL-Query

The Worldwide-Covid-19-SQL-Query analyzes worldwide COVID-19 deaths from January 2020 to April 2023. It utilizes three datasets: covid_deaths, covid_stats, and covid_vaccinations. The query includes WHERE clauses and aggregates the data to provide comprehensive information.

In the initial section, three queries retrieve data from the tables covid_deaths, covid_vaccinations, and covid_stats, respectively. These queries ensure that the dataset used for analysis is comprehensive, covering information related to deaths, vaccinations, and general statistics.

To examine the daily count of new cases and deaths by country, two queries are used. The first query selects the location, date, and new cases from the covid_deaths table, while the second query selects the location, date, and new deaths. These queries allow for tracking the daily progression of cases and deaths for each country.

To provide an overview of new cases and deaths by continent and country, the query groups the data by continent and location. It selects the continent, location, and sums up the new cases and deaths from the covid_deaths table. The results are then ordered based on the total death count.

For India specifically, a similar query is used, but with an additional WHERE clause filtering for the location 'India'. This query calculates the total death counts and new cases, focusing specifically on India.

These queries provide a comprehensive analysis of worldwide COVID-19 deaths and related statistics from the specified datasets. They allow for tracking daily cases and deaths, analyzing the data by country and continent, and providing specific insights for India.
