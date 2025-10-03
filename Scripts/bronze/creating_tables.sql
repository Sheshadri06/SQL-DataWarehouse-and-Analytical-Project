
IF OBJECT_ID('BRONZE.crm_cust_info', 'U') IS NOT NULL
     DROP TABLE BRONZE.crm_cust_info;

CREATE TABLE BRONZE.crm_cust_info(
    cst_id INT,
    cst_key VARCHAR(50),
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gndr VARCHAR(50),
    cst_create_date VARCHAR(50),
    );

IF OBJECT_ID('BRONZE.crm_prd_info', 'U') IS NOT NULL
     DROP TABLE BRONZE.crm_prd_info;

CREATE TABLE BRONZE.crm_prd_info(
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost VARCHAR(50),
    prd_line VARCHAR(50),
    prd_start_dt DATETIME,
    prd_end_dt DATETIME,
    );  

IF OBJECT_ID('BRONZE.crm_sales_details', 'U') IS NOT NULL
     DROP TABLE BRONZE.crm_sales_details;

CREATE TABLE BRONZE.crm_sales_details(
    sls_ord_num VARCHAR(50),
    sls_prd_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
    );

IF OBJECT_ID('BRONZE.erp_CUST_AZ12', 'U')IS NOT NULL
    DROP TABLE BRONZE.erp_CUST_AZ12;

CREATE TABLE BRONZE.erp_CUST_AZ12(
    CID VARCHAR(50),
    BDATE DATE,
    GEN VARCHAR(50),
    );  

IF OBJECT_ID('BRONZE.erp_LOC_A101', 'U')IS NOT NULL
    DROP TABLE BRONZE.erp_LOC_A101;

CREATE TABLE BRONZE.erp_LOC_A101(
    CID VARCHAR(50),
    CNTRY VARCHAR(50),
    );


IF OBJECT_ID('BRONZE.erp_PX_CAT_G1V2', 'U')IS NOT NULL
    DROP TABLE BRONZE.erp_PX_CAT_G1V2;

CREATE TABLE BRONZE.erp_PX_CAT_G1V2(
    ID VARCHAR(50),
    CAT VARCHAR(50),
    SUBCAT VARCHAR(50),
    MAINTENANCE VARCHAR(50)
    );



