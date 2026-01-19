-- Static values for easy and fast processing display in Tableau 

-- property ratios 
CREATE VIEW rentalprices.clean_properties AS
SELECT 
    city,
    property_type,
    total_price,
    sqft_size,
    n_rooms,
    n_baths,
    year_built,
    ROUND(total_price / NULLIF(sqft_size, 0), 2) AS price_per_sqft,
    YEAR(CURRENT_DATE()) - year_built AS age,
    ROUND(n_rooms / NULLIF(n_baths, 0), 2) AS bed_bath_ratio
FROM rentalprices.cities_table
WHERE total_price > 0 AND sqft_size > 0;

-- z-scores of rental prices
CREATE VIEW rentalprices.properties_with_z_scores AS
WITH city_stats AS (
    SELECT 
        city,
        AVG(total_price) AS avg_price,
        STDDEV(total_price) AS stddev_price
    FROM rentalprices.clean_properties
    GROUP BY city
)
SELECT
    cp.*,
    ROUND((cp.total_price - cs.avg_price) / NULLIF(cs.stddev_price, 0), 2) AS price_z_score
FROM rentalprices.clean_properties cp
JOIN city_stats cs ON cp.city = cs.city;

-- city statistics 
CREATE VIEW rentalprices.city_stats AS
WITH ranked AS (
    SELECT 
        city,
        total_price,
        ROW_NUMBER() OVER (PARTITION BY city ORDER BY total_price) AS rn,
        COUNT(*) OVER (PARTITION BY city) AS cnt
    FROM rentalprices.clean_properties
)
SELECT
    cp.city,
    COUNT(*) AS property_count,
    ROUND(AVG(cp.total_price), 2) AS avg_price,
    ROUND(AVG(r.total_price), 2) AS median_price,
    ROUND(AVG(cp.price_per_sqft), 2) AS avg_price_per_sqft,
    ROUND(STDDEV(cp.total_price), 2) AS stddev_price
FROM rentalprices.clean_properties cp
LEFT JOIN ranked r ON cp.city = r.city 
    AND (r.rn = FLOOR((r.cnt + 1) / 2) OR r.rn = CEIL((r.cnt + 1) / 2))
GROUP BY cp.city;

-- data quality report 
CREATE VIEW rentalprices.data_quality AS
SELECT
    city,
    COUNT(*) AS total_records,
    SUM(CASE WHEN total_price IS NULL THEN 1 ELSE 0 END) AS missing_price,
    SUM(CASE WHEN sqft_size IS NULL OR sqft_size = 0 THEN 1 ELSE 0 END) AS invalid_sqft,
    ROUND(AVG(CASE WHEN total_price > 0 AND sqft_size > 0 THEN 1 ELSE 0 END) * 100, 2) AS pct_valid
FROM rentalprices.cities_table
GROUP BY city;
