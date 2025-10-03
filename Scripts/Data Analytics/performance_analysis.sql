/*
===============================================================================
Performance Analysis (Year-over-Year, Month-over-Month)
===============================================================================
Purpose:
    - To measure the performance of products, customers, or regions over time.
    - For benchmarking and identifying high-performing entities.
    - To track yearly trends and growth.
===============================================================================
*/

/* Analyze the yearly performance of products by comparing their sales 
to both the average sales performance of the product and the previous year's sales */
WITH yearly_product_sales AS (
SELECT 
YEAR(f.order_date) AS order_year,
p.product_name,
SUM(f.sales_amount) AS current_sales
FROM GOLD.fact_sales f
LEFT JOIN  GOLD.dim_products p
ON f.product_key=p.product_key
where order_date is not null
GROUP BY YEAR(f.order_date),p.product_name
)

SELECT 
order_year,
product_name,
current_sales,
AVG(current_sales) OVER ( PARTITION BY product_name) AS avg_sales,
current_sales-AVG(current_sales) OVER ( PARTITION BY product_name) AS diff_avg,
CASE 
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) > 0 THEN 'Above Avg'
    WHEN current_sales - AVG(current_sales) OVER (PARTITION BY product_name) < 0 THEN 'Below Avg'
    ELSE 'Avg'
END AS avg_change,
 LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS pre_year_sales,
    current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) AS diff_pre_year,
    CASE 
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) > 0 THEN 'Increase'
        WHEN current_sales - LAG(current_sales) OVER (PARTITION BY product_name ORDER BY order_year) < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS pre_year_change
FROM yearly_product_sales
ORDER BY product_name,order_year

/* Analyze the yearly performance of customers by comparing their quantity 
to both the average quantity performance of the customer and the previous year's quantity */
WITH yearly_customer_quantity AS (
    SELECT 
        YEAR(f.order_date) AS order_year,
        c.customer_key,
        SUM(f.quantity) AS current_quantity
    FROM GOLD.fact_sales f
    LEFT JOIN GOLD.dim_customers c
        ON f.customer_key = c.customer_key
    WHERE f.order_date IS NOT NULL
    GROUP BY YEAR(f.order_date), c.customer_key
),
calc AS (
    SELECT *,
        AVG(current_quantity) OVER (PARTITION BY customer_key ORDER BY order_year) AS avg_quantity,
        LAG(current_quantity) OVER (PARTITION BY customer_key ORDER BY order_year) AS pre_year_quantity
    FROM yearly_customer_quantity
)
SELECT 
    order_year,
    customer_key,
    current_quantity,
    avg_quantity,
    current_quantity - avg_quantity AS diff_avg,
    CASE 
        WHEN current_quantity - avg_quantity > 0 THEN 'Above Avg'
        WHEN current_quantity - avg_quantity < 0 THEN 'Below Avg'
        ELSE 'Avg'
    END AS avg_change,
    pre_year_quantity,
    current_quantity - pre_year_quantity AS diff_pre_year,
    CASE 
        WHEN current_quantity - pre_year_quantity > 0 THEN 'Increase'
        WHEN current_quantity - pre_year_quantity < 0 THEN 'Decrease'
        ELSE 'No Change'
    END AS pre_year_change
FROM calc
ORDER BY customer_key, order_year;
