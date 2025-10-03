/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
*/

-- Find the Total Sales
SELECT SUM(sales_amount) FROM GOLD.fact_sales;

-- Find how many items are sold
SELECT SUM(quantity) FROM GOLD.fact_sales;

-- Find the average selling price
SELECT AVG(price) FROM GOLD.fact_sales;

-- Find the Total number of Orders
SELECT  COUNT(DISTINCT order_number) FROM GOLD.fact_sales;

-- Find the total number of products
SELECT  COUNT(DISTINCT product_name) FROM GOLD.dim_products;

-- Find the total number of customers
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.dim_customers;

-- Find the total number of customers that has placed an order
SELECT COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;


-- Generate a Report that shows all key metrics
SELECT 'Total_sales' AS measure_name , SUM(sales_amount) AS measure_value FROM GOLD.fact_sales
UNION ALL
SELECT 'Total Quantity', SUM(quantity) FROM gold.fact_sales
UNION ALL
SELECT 'Average Price', AVG(price) FROM gold.fact_sales
UNION ALL
SELECT 'Total Orders', COUNT(DISTINCT order_number) FROM gold.fact_sales
UNION ALL
SELECT 'Total Products', COUNT(DISTINCT product_name) FROM gold.dim_products
UNION ALL
SELECT 'Total Customers', COUNT(DISTINCT customer_key) FROM gold.dim_customers
UNION ALL
SELECT 'Placed Orders', COUNT(DISTINCT customer_key) AS total_customers FROM gold.fact_sales;
