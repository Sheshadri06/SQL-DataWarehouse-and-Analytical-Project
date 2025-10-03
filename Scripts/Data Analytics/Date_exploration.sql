/*
===============================================================================
Date_range_eploration
===============================================================================
*/
-- Determine the first and last order date and the total duration in months
SELECT 
	MIN(order_date) AS first_date,
	MAX(order_date) AS last_date,
	DATEDIFF(MONTH,MIN(order_date),MAX(order_date)) AS total_month_range
FROM GOLD.fact_sales;

-- Determine the first and last order date and the total duration in year
SELECT 
	MIN(order_date) AS first_date,
	MAX(order_date) AS last_date,
	DATEDIFF(YEAR,MIN(order_date),MAX(order_date)) AS total_year_range
FROM GOLD.fact_sales;

-- Find the youngest and oldest customer based on birthdate
SELECT 
MIN(birthdate) AS older_birthdate,
DATEDIFF(YEAR,MIN(birthdate) ,GETDATE()) AS oldest_age,
MAX(birthdate) AS younger_birthdate,
DATEDIFF(YEAR,MAX(birthdate) ,GETDATE()) AS youngest_age
FROM GOLD.dim_customers;
