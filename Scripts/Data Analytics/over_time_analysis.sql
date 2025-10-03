/*
===============================================================================
Change Over Time Analysis
===============================================================================
Purpose:
    - Analyze how a measure evolves over time
    - Help track trends and identify seasonality of data
===============================================================================
*/

-- Analyse sales performance over the year
--by using Quick Data Functions

SELECT 
YEAR(order_date) AS order_year,
MONTH(order_date) AS order_month,
SUM(sales_amount) AS total_sales,
COUNT(DISTINCT customer_key) AS total_customers,
COUNT(DISTINCT product_key) AS total_products,
SUM(quantity) AS total_quantity
FROM GOLD.fact_sales
WHERE YEAR(order_date) is not null
GROUP BY YEAR(order_date),MONTH(order_date) 
ORDER BY YEAR(order_date),MONTH(order_date) ;

--NOTE: we also use DATETRUNC and FORMAT Functions

