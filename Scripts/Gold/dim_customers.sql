
CREATE OR ALTER VIEW GOLD.dim_customers AS
WITH cust_data AS (
    SELECT 
        ci.cst_id AS customer_id,
        ci.cst_key AS customer_number,
        ci.cst_firstname AS first_name,
        ci.cst_lastname AS last_name,
        CASE 
           WHEN ci.cst_marital_status = 'marreid' THEN 'married'
           ELSE ci.cst_marital_status
        END AS marital_status,
        CASE 
            WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr
            ELSE COALESCE(cat.gend , 'n/a')
        END AS gender,
        cat.bdate AS birthdate,
        ci.cst_create_date AS createdate,
        loc.cntry AS country,
        ROW_NUMBER() OVER(PARTITION BY ci.cst_id ORDER BY ci.cst_id) AS rn
    FROM SILVER.crm_cust_info ci
    LEFT JOIN SILVER.erp_CUST_AZ12 cat
           ON ci.cst_key = cat.cid
    LEFT JOIN SILVER.erp_LOC_A101 loc
           ON ci.cst_key = loc.cid
)
SELECT 
    ROW_NUMBER() OVER(ORDER BY customer_id) AS customer_key,
    customer_id,
    customer_number,
    first_name,
    last_name,
    marital_status,
    gender,
    birthdate,
    createdate,
    country
FROM cust_data
WHERE rn = 1;

