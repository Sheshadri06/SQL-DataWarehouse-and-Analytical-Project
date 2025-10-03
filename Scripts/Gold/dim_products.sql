IF OBJECT_ID('GOLD.dim_products','V') IS NOT NULL
    DROP VIEW GOLD.dim_products;
GO

CREATE VIEW GOLD.dim_products AS

SELECT
ROW_NUMBER() OVER(ORDER BY prf.prd_start_dt,prf.prd_key) AS product_key,
prf.prd_id AS product_id,
prf.prd_key AS product_number,
prf.prd_nm AS product_name,
prf.cat_id AS category_id,
CASE 
    WHEN px.cat is NULL THEN 'n/a'
    ELSE px.cat
END AS category,
CASE 
    WHEN px.subcat is NULL THEN 'n/a'
    ELSE px.subcat
END AS subcategory,
prf.prd_cost AS cost,

CASE 
    WHEN px.maintenance is NULL THEN 'n/a'
    ELSE px.maintenance
END AS maintenance,
prf.prd_start_dt AS startdate

FROM SILVER.crm_prd_info   prf
LEFT JOIN SILVER.erp_PX_CAT_G1V2  px 
ON   prf.cat_id=px.id
WHERE prd_end_dt IS NULL

