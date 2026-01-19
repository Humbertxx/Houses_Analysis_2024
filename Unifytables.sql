REATE view rentalprices.cities_table AS
-- Chicago rental estate table (8 columns)
SELECT
  'Chicago' AS city,
  CASE
    WHEN `type` IN ('apartment', 'condos') THEN 'apartment'
    WHEN `type` IN ('multi_family') THEN 'duplex'
    when `type` in ('townhomes') then 'single_family'
    ELSE `type`
  END AS property_type,
  beds AS n_rooms,
  baths AS n_baths,
  sqft AS sqft_size,
  year_built,
  listPrice AS total_price
FROM rentalprices.real_estate_chicago
WHERE listPrice IS NOT NULL
  AND status = 'for_sale'
  AND sqft IS NOT null
UNION
SELECT
    'Izmir' AS city,
   CASE
		WHEN LOWER(`left`) LIKE '%k%' OR LOWER(`left`) LIKE '%da%' OR LOWER(`left`) LIKE '%villa%' THEN 'single_family'
		WHEN LOWER(`left`) LIKE ('ya%') THEN 'single_family'
		WHEN LOWER(`left`) IN ('loft','daire','residence','bina') THEN 'apartment'
		ELSE `left`
	END AS property_type,
    room AS n_rooms,
    salon AS n_baths,
    (area * 10.7639) AS sqft_size,
    (YEAR(CURRENT_DATE()) - age) AS year_built,
    (NULLIF(price, 0) * 0.03047)AS total_price -- price is in turkish lira
FROM rentalprices.real_estate_izmir
WHERE price IS NOT NULL
  AND area IS NOT null

UNION
-- Paris real estate (8 columns)
SELECT
	'Paris' AS city,
	CASE
		WHEN LOWER(`Type`) = 'house' THEN 'single_family'
		WHEN LOWER(`Type`) LIKE '%condo%' THEN 'apartment'
		else `Type`
	END AS property_type,
	Rooms AS n_rooms,
	Bathrooms AS n_baths,
	(CAST(NULLIF(REPLACE(REPLACE(Living, 'm^2', ''), ',', ''), '') AS DECIMAL(18,2)) * 10.7639) AS sqft_size,
    ConstructionYear AS year_built,
	-- (`ParkingLots(inside)` + `Garages(Outside)`) AS parking,
	CAST(NULLIF(REPLACE(REPLACE(price, '$', ''), ',', ''), '') AS DECIMAL(18,2)) AS total_price -- prices already in usd
FROM rentalprices.real_estate_paris
WHERE Price IS NOT NULL
	AND Living IS NOT null

UNION
-- Barcelona real estate table (8 columns)
SELECT
	'Barcelona' as city,
	CASE
		WHEN LOWER(property_type) LIKE '%flat%' OR LOWER(property_type) LIKE '%penthouse%'  OR LOWER(property_type) LIKE '%condo%' THEN 'apartment' 
		WHEN LOWER(property_type) in ('tower') THEN 'apartment' 
		WHEN LOWER(property_type) LIKE '%house%' or LOWER(property_type) LIKE '%villa%' or LOWER(property_type) LIKE '%estate%' then 'single_family'
		WHEN LOWER(property_type) in ('Duplex') then 'duplex'
		ELSE property_type
	END AS property_type,
	n_bedrooms as n_rooms,
	bathrooms as n_baths,
	(sq_m_built * 10.7639) AS sqft_size,
	year_built,
	-- parking,
	(CAST(NULLIF(REPLACE(REPLACE(price, '£', ''), ',', ''), '') AS DECIMAL(18,2)) * 1.17) AS total_price
FROM rentalprices.real_estate_barcelona
WHERE price IS NOT null
	and sq_m_built is not null;

