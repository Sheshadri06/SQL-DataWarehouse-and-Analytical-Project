IF OBJECT_ID('GOLD.fact_sales','V') IS NOT NULL
    DROP VIEW GOLD.fact_sales;
GO

CREATE VIEW GOLD.fact_sales AS

SELECT 
sd.sls_ord_num AS order_number,
p.product_key,
c.customer_key,
sd.sls_order_dt AS order_date,
sd.sls_ship_dt AS ship_date,
sd.sls_due_dt AS due_date,
sd.sls_sales AS sales,
sd.sls_quantity AS quntity,
sd.sls_price AS price
FROM SILVER.crm_sales_details sd
LEFT JOIN GOLD.dim_products p
ON  sd.sls_prd_key=p.product_number
LEFT JOIN GOLD.dim_customers c
ON   sd.sls_cust_id=c.customer_id

