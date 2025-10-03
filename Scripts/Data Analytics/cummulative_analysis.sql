/*
===============================================================================
Cumulative Analysis
===============================================================================
Purpose:
    - To calculate running totals or moving averages for key metrics.
    - To track performance over time cumulatively.
    - Useful for growth analysis or identifying long-term trends.
===============================================================================
*/
-- Calculate the total sales per month 
-- and the running total of sales over time
-- calculate the moving average of price over time
-- 

SELECT 
order_date,
total_sales,
SUM(total_sales) OVER(ORDER BY order_date) AS running_total,
avg_price,
AVG(avg_price) OVER(ORDER BY order_date) AS moving_average
FROM
(
SELECT 
DATETRUNC(year,order_date) AS order_date,
SUM(sales_amount) AS total_sales,
AVG(price) AS avg_price,
COUNT(DISTINCT customer_key) AS total_customers
FROM GOLD.fact_sales
WHERE order_date is not null
GROUP BY DATETRUNC(year,order_date)
)T


