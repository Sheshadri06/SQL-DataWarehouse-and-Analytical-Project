IF OBJECT_ID('SILVER.crm_cust_info', 'U') IS NOT NULL
     DROP TABLE SILVER.crm_cust_info;

CREATE TABLE SILVER.crm_cust_info(
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

IF OBJECT_ID('SILVER.crm_prd_info', 'U') IS NOT NULL
     DROP TABLE SILVER.crm_prd_info;

CREATE TABLE SILVER.crm_prd_info(
    prd_id INT,
    cat_id VARCHAR(50),
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost VARCHAR(50),
    prd_line VARCHAR(50),
    prd_start_dt DATE,
    prd_end_dt DATE,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
    );  

IF OBJECT_ID('SILVER.crm_sales_details', 'U') IS NOT NULL
     DROP TABLE SILVER.crm_sales_details;

CREATE TABLE SILVER.crm_sales_details(
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt DATE,
    sls_ship_dt DATE,
    sls_due_dt DATE,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT,
    dwh_create_date DATETIME2 DEFAULT GETDATE()
    );

IF OBJECT_ID('SILVER.erp_CUST_AZ12', 'U')IS NOT NULL
    DROP TABLE SILVER.erp_CUST_AZ12;

CREATE TABLE SILVER.erp_CUST_AZ12(
    cid VARCHAR(50),
    bdate DATE,
    gend VARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE()
    );  

IF OBJECT_ID('SILVER.erp_LOC_A101', 'U')IS NOT NULL
    DROP TABLE SILVER.erp_LOC_A101;

CREATE TABLE SILVER.erp_LOC_A101(
    cid VARCHAR(50),
    cntry VARCHAR(50),
     dwh_create_date DATETIME2 DEFAULT GETDATE()
    );


IF OBJECT_ID('SILVER.erp_PX_CAT_G1V2', 'U')IS NOT NULL
    DROP TABLE SILVER.erp_PX_CAT_G1V2;

CREATE TABLE SILVER.erp_PX_CAT_G1V2(
    id VARCHAR(50),
    cat VARCHAR(50),
    subcat VARCHAR(50),
    maintenance VARCHAR(50),
    dwh_create_date DATETIME2 DEFAULT GETDATE()
    );
