-- This is the code Sample that I used to verify Data and assort values inside houses_Madrid database

SELECT house_type_id , '€'|| ROUND(AVG(buy_price), 2) AS HousePrice
FROM houses_Madrid
WHERE 1=1
	AND n_bathrooms > 3
GROUP BY house_type_id;

SELECT title,  ROUND(AVG(buy_price), 2) AS Average_p
FROM houses_Madrid
WHERE 1=1
	AND has_parking = 'True'
GROUP BY title;
 
SELECT COUNT(title)
From houses_Madrid
WHERE built_year <> ""
ORDER BY id ASC; 


