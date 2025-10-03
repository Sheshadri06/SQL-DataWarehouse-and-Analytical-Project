/*
===============================================================================
Dimension Exploration 
===============================================================================
*/
-- Retrieve a list of unique countries from which customers originate
SELECT DISTINCT 
country
FROM GOLD.dim_customers
ORDER BY country;

-- Retrieve a list of unique categories, subcategories, and products
SELECT DISTINCT 
    
    CASE 
        WHEN category IS NULL THEN 'n/a'
        ELSE category
    END AS category,
   
    CASE 
        WHEN subcategory IS NULL THEN 'n/a'
        ELSE subcategory
    END AS subcategory,
    product_name 
FROM gold.dim_products
ORDER BY category, subcategory, product_name;
