# CovidAnalysisSQL

# Covid-19 Data Exploration

## About

This project aims to explore Covid-19 data to understand the impact of the pandemic across different regions, analyze trends in cases and deaths, and evaluate the effectiveness of containment measures. The dataset was obtained from the `CovidDataset` which includes comprehensive information on Covid-19 cases, deaths, and population data across various locations.

## Purposes Of The Project

The major aim of this project is to gain insights into the Covid-19 pandemic by analyzing the data to understand infection rates, mortality rates, and the overall impact on different regions.

## About Data

The dataset used for this project contains detailed information on Covid-19 cases and deaths, including:

| Column       | Description                              | Data Type      |
| :----------- | :--------------------------------------- | :------------- |
| location     | Location of the data point (e.g., country) | VARCHAR(50)    |
| date         | Date of the data point                   | DATE           |
| total_cases  | Total number of confirmed cases          | INT            |
| new_cases    | Number of new cases reported             | INT            |
| total_deaths | Total number of deaths                   | INT            |
| population   | Population of the location               | INT            |

### Analysis List

1. Infection Rate Analysis
   > Analyze the rate of Covid-19 infections across different countries and regions.

2. Mortality Rate Analysis
   > Evaluate the mortality rate of Covid-19 by comparing the number of deaths to the number of confirmed cases.

3. Population Impact Analysis
   > Determine the percentage of the population infected with Covid-19 in various locations.

4. Continent-wise Analysis
   > Compare the impact of Covid-19 across different continents.

## Approach Used

1. **Data Wrangling:** 
   - Inspect data for NULL values and handle missing data appropriately.
   - Convert data types where necessary for accurate analysis.

2. **Exploratory Data Analysis (EDA):**
   - Conduct a thorough analysis to answer key questions regarding infection rates, mortality rates, and population impact.
   - Use SQL queries to extract insights and generate summary statistics.

You can find the SQL code used for this project [HERE](https://github.com/Dilan-GitHub/CovidAnalysisSQL/blob/main/Covid.sql)
