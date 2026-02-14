# Houses_Analysis_2024
SQLite and MySQL code use to create a unify table with valuable insight to analyze international properties in Tableau. Properties in Chicago, London, and Paris 

### Complete analysis accesible via Tableau. Found in my Tableau Public Profile: 
https://public.tableau.com/app/profile/humberto.bohorquez/viz/2024_price_city_analysis/Story1

### Tools Used: 
* **Database:** SQLite, MySQL
* **Data Engineering:** SQL (DDL & DML) for data cleaning and unification
* **Visualization:** Tableau

## Project Overview
Designed and implemented an end-to-end data analysis pipeline to evaluate international real estate markets, specifically focusing on residential properties in Chicago, London, and Paris. The project aimed to unify disparate datasets to identify arbitrage opportunities, price distribution variances, and location-based value drivers across three major financial hubs.

### Visual Analytics (Tableau Dashboard)
Developed an interactive dashboard to translate raw data into actionable financial insights:
* Price Distribution Analysis: Utilized Histograms to visualize the frequency distribution of property prices in each city, identifying the "fat tails" in luxury markets versus median-range housing.
* Volatility & Outlier Detection: Constructed Box Plots to compare price variability and isolate statistical outliers, helping to benchmark "fair value" ranges for investment properties in each metropolitan area.
* Correlation Studies: Deployed Scatter Plots to analyze the relationship between property size (sq footage) and listing price, calculating the price-per-square-foot efficiency for each region.
* Geospatial Intelligence: Implemented Heatmaps to pinpoint high-density clusters and "hot zones" for high-value listings within the urban cores of Chicago, London, and Paris.

## Key Insights & Impact
*Provided a consolidated view of international property markets, reducing data retrieval time for cross-market comparison.
* Identified distinct pricing tiers and market behaviors, offering a data-driven basis for potential real estate portfolio allocation in the US, UK, and France.

## Data Source 
The data for this project was sourced from:
* real_estate_barcelona.csv
* real_estate_paris.csv
* real_estate_chicago.csv

*Note: Raw data files are available in the `data/` directory of this repository.*
