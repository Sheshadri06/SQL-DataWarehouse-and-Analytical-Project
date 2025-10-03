 --EXEC SILVER.LOAD_SILVER ;


CREATE OR ALTER PROCEDURE SILVER.LOAD_SILVER AS
BEGIN
    DECLARE @start_time DATETIME ,@end_time DATETIME ,@batch_start_time DATETIME,@batch_end_time DATETIME;
        BEGIN TRY
            SET @batch_start_time=GETDATE();
		PRINT '===================================================='
		PRINT 'LOADING SILVER LAYER';
		PRINT '===================================================='

		PRINT '----------------------------------------------------'
		PRINT 'LOADING CRM TABLES FROM BRONZE TO SILVER';
		PRINT '----------------------------------------------------'
            
            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.crm_cust_info';
		    TRUNCATE TABLE SILVER.crm_cust_info;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.crm_cust_info';

                INSERT INTO SILVER.crm_cust_info(
                    cst_id,
                    cst_key,
                    cst_firstname,
                    cst_lastname,
                    cst_gndr,
                    cst_marital_status,
                    cst_create_date
                    )

                SELECT
                    cst_id,
                    cst_key,
                    TRIM(cst_firstname) AS cst_firstname,
                    TRIM(cst_lastname)  AS cst_lastname,
                    CASE 
                       WHEN UPPER(TRIM(cst_gndr))='M' THEN 'Male'
                       WHEN UPPER(TRIM(cst_gndr))='F' THEN 'Female'
                       ELSE 'n/a'
                    END AS  cst_gndr,
                    CASE 
                       WHEN UPPER(TRIM(cst_marital_status))='M' THEN 'Marreid'
                       WHEN UPPER(TRIM(cst_marital_status))='S' THEN 'Single'
                       ELSE 'n/a'
                    END AS  cst_marital_status,
                    cst_create_date

                FROM(
                    SELECT   
                    *,
                    row_number() OVER(PARTITION BY cst_id ORDER BY cst_create_date) AS flag
                    FROM bronze.crm_cust_info
                    WHERE cst_id is not null)t
                    WHERE flag=1;

            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';

            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.crm_prd_info';
		    TRUNCATE TABLE SILVER.crm_prd_info;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.crm_prd_info';

                INSERT INTO SILVER.crm_prd_info(
                    prd_id,
                    cat_id,
                    prd_key,
                    prd_nm,
                    prd_cost,
                    prd_line,
                    prd_start_dt,
                    prd_end_dt)

                SELECT
                prd_id,
                replace(SUBSTRING(prd_key,1,5),'-','_') AS cat_id,
                SUBSTRING(prd_key,7,LEN(prd_key)) AS prd_key,
                prd_nm,
                COALESCE (prd_cost,0) AS prd_cost,
                CASE (prd_line)
                     WHEN 'M' THEN 'Mountain'
                     WHEN 'T' THEN 'Touring'
                     WHEN 'R' THEN 'Road'
                     WHEN 'S' THEN 'Othersales'
                     ELSE 'n\a'
                END AS prd_line,
                CAST(prd_start_dt AS DATE) AS prd_start_dt,
                CAST(LEAD(prd_start_dt) OVER(PARTITION BY prd_key ORDER BY prd_start_dt )-1 AS DATE) AS prd_end_dt
                FROM BRONZE.crm_prd_info;

            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';

            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.crm_sales_details';
		    TRUNCATE TABLE SILVER.crm_sales_details;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.crm_sales_details';

                INSERT INTO SILVER.crm_sales_details (
                sls_ord_num,
                sls_prd_key,
                sls_cust_id,
                sls_order_dt,
                sls_ship_dt,
                sls_due_dt,
                sls_sales,
                sls_quantity,
                sls_price
                )

                SELECT 
                sls_ord_num,
                sls_prd_key,
                sls_cust_id,
                CASE 
                    WHEN sls_order_dt<=0 OR LEN(sls_order_dt)!=8 THEN NULL
                    ELSE CAST(CAST(sls_order_dt AS VARCHAR) AS DATE)
                END AS sls_order_dt,

                CASE 
                    WHEN sls_ship_dt<=0 OR LEN(sls_ship_dt)!=8 THEN NULL
                    ELSE CAST(CAST(sls_ship_dt AS VARCHAR) AS DATE)
                END AS sls_ship_dt,

                CASE 
                    WHEN sls_due_dt<=0 OR LEN(sls_due_dt)!=8 THEN NULL
                    ELSE CAST(CAST(sls_due_dt AS VARCHAR) AS DATE)
                END AS sls_due_dt,

                CASE 
                    WHEN sls_sales<=0 OR sls_sales IS NULL OR sls_sales!=sls_quantity * ABS(sls_price)
                    THEN  sls_quantity * ABS(sls_price)
                    ELSE sls_sales 
                END AS sls_sales,
                --Recalculate sales if original vales is missing or incorrect

                sls_quantity,

                CASE 
                    WHEN sls_price<=0 OR sls_price IS NULL  
                    THEN sls_sales/NULLIF(sls_quantity,0)
                    ELSE sls_price
                END AS sls_price 
                -- Derive price if original value s invalid
                FROM bronze.crm_sales_details;

            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';

        PRINT '----------------------------------------------------'
		PRINT 'LOADING ERP TABLES FROM BRONZE TO SILVER';
		PRINT '----------------------------------------------------'
            
            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.erp_CUST_AZ12';
		    TRUNCATE TABLE SILVER.erp_CUST_AZ12;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.erp_CUST_AZ12';

                INSERT INTO SILVER.erp_CUST_AZ12(
                cid,bdate,gend)
                SELECT  
                CASE 
	                WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID,4,LEN(CID))
	                ELSE CID
                END AS cid,
                CASE 
                    WHEN BDATE > GETDATE() THEN NULL
	                ELSE BDATE
                END AS bdate,
                CASE 
                    WHEN UPPER(TRIM(GEN)) IN ('M','MALE') THEN 'Male'
	                WHEN UPPER(TRIM(GEN)) IN ('F','FEMALE') THEN 'Female'
	                --WHEN  GEN IN (' ',NULL) THEN 'n/a'
	                ELSE 'n/a'
                END AS gend
                FROM bronze.erp_CUST_AZ12;

            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';


            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.erp_LOC_A101';
		    TRUNCATE TABLE SILVER.erp_LOC_A101;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.erp_LOC_A101';

                INSERT INTO SILVER.erp_LOC_A101 (cid, cntry)
                SELECT
                    REPLACE(CID, '-', '') AS cid,
                    --Normalize and Handling Missing or Blank country codes
                    CASE 
                        WHEN CNTRY IS NULL THEN 'n/a'                     
                        WHEN TRIM(CNTRY) = '' THEN 'n/a'           
                        WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'     
                        WHEN TRIM(CNTRY) IN ('US','USA') THEN 'United States' 
                        ELSE TRIM(CNTRY)                           
                    END AS cntry
                FROM bronze.erp_loc_A101;


            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';


            SET @start_time=GETDATE();

            PRINT'>>TRUNCATING TABLE:SILVER.erp_PX_CAT_G1V2';
		    TRUNCATE TABLE SILVER.erp_PX_CAT_G1V2;
            PRINT'>>LOADING DATA FROM BRONZE INTO:SILVER.erp_PX_CAT_G1V2';

                INSERT INTO SILVER.erp_PX_CAT_G1V2(
                ID,
                CAT,
                SUBCAT,
                MAINTENANCE
                )

                SELECT 
                ID,
                CAT,
                SUBCAT,
                MAINTENANCE
                FROM BRONZE.erp_PX_CAT_G1V2

            SET @end_time=GETDATE();

		    PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		    PRINT '>>--------------------------------------------------';


        SET @batch_end_time=GETDATE();

	    PRINT '===================================================='
		PRINT 'LOADING SIVERLAYER FROM BRONZE LAYER IS COMPLETED';
		PRINT 'Total Duration Time :'+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +'SECONDS';
		PRINT '===================================================='


        END TRY

        BEGIN CATCH

            PRINT '===================================================='
		    PRINT 'ERROR OCCUR DURIND THE SILVER  LAYER'
		    PRINT 'Error message'+ERROR_MESSAGE();
		    PRINT 'Error message'+CAST(ERROR_NUMBER() AS NVARCHAR);
		    PRINT 'Error message'+CAST(ERROR_STATE() AS NVARCHAR);
		    PRINT '===================================================='

        END CATCH

END
