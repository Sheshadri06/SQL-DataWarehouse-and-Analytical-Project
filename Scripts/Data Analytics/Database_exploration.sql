/*
===============================================================================
Database Exploration
===============================================================================

*/
-- To Retrieve the list of tables in the Database
SELECT
	TABLE_CATALOG,
	TABLE_SCHEMA,
	TABLE_NAME,
	TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

--Retrieve the columns for a table(dim_products)
SELECT 
	COLUMN_NAME,
	ORDINAL_POSITION,
	IS_NULLABLE,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_products';

--Retrieve the columns for a table(dim_customers)
SELECT 
	COLUMN_NAME,
	ORDINAL_POSITION,
	IS_NULLABLE,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='dim_customers';

--Retrieve the columns for a table(fact_sales)
SELECT 
	COLUMN_NAME,
	ORDINAL_POSITION,
	IS_NULLABLE,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME='fact_sales';

--Checking how many rows in all tables 
SELECT
    'dim_customers' AS Table_Name,
    Count(*) AS Rows_Count
FROM GOLD.dim_customers




