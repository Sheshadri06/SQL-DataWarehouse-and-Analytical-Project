--EXEC BRONZE.LOAD_BRONZE;


CREATE OR ALTER PROCEDURE BRONZE.LOAD_BRONZE AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME,@batch_start_time DATETIME,@batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time=GETDATE();
		PRINT '===================================================='
		PRINT 'LOADING BRONZE LAYER';
		PRINT '===================================================='

		PRINT '----------------------------------------------------'
		PRINT 'LOADING CRM TABLES';
		PRINT '----------------------------------------------------'


	SET @start_time=GETDATE();
		PRINT'>>TRUNCATING TABLE:BRONZE.crm_cust_info';
		TRUNCATE TABLE BRONZE.crm_cust_info;
		PRINT'>>LOADING DATA INTO:BRONZE.crm_cust_info';
		BULK INSERT BRONZE.crm_cust_info
		FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------';


	SET @start_time=GETDATE();
		PRINT'>>TRUNCATING TABLE:BRONZE.crm_prd_info';
		TRUNCATE TABLE BRONZE.crm_prd_info;
		PRINT'>>LOADING DATA INTO:BRONZE.crm_prd_info';
		BULK INSERT BRONZE.crm_prd_info
		FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------';

	SET @start_time=GETDATE();
		PRINT'>>TRUNCATING TABLE:BRONZE.crm_sales_details';
		TRUNCATE TABLE BRONZE.crm_sales_details;
		PRINT'>>LOADING DATA INTO:BRONZE.crm_sales_details';
		BULK INSERT BRONZE.crm_sales_details
		FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
		
			TABLOCK
		);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------';


	PRINT '----------------------------------------------------'
	PRINT 'LOADING ERP TABLES';
	PRINT '----------------------------------------------------'

	SET @start_time=GETDATE();
	PRINT'>>TRUNCATING TABLE:BRONZE.erp_CUST_AZ12';
	TRUNCATE TABLE BRONZE.erp_CUST_AZ12;
	PRINT'>>LOADING DATA INTO:BRONZE.erp_CUST_AZ12';
	BULK INSERT BRONZE.erp_CUST_AZ12
	FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
	);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------';


	SET @start_time=GETDATE();
	PRINT'>>TRUNCATING TABLE:BRONZE.erp_LOC_A101';
	TRUNCATE TABLE BRONZE.erp_LOC_A101;
	PRINT'>>LOADING DATA INTO:BRONZE.erp_LOC_A101';
	BULK INSERT BRONZE.erp_LOC_A101
	FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
	WITH(
		FIRSTROW=2,
		FIELDTERMINATOR=',',
		TABLOCK
	);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------'


	SET @start_time=GETDATE();
		PRINT'>>TRUNCATING TABLE:BRONZE.erp_PX_CAT_G1V2';
		TRUNCATE TABLE BRONZE.erp_PX_CAT_G1V2;
		PRINT'>>LOADING DATA INTO:BRONZE.erp_PX_CAT_G1V2';
		BULK INSERT BRONZE.erp_PX_CAT_G1V2
		FROM 'C:\Users\Lakka Sheshadri\Desktop\data warehose project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW=2,
			FIELDTERMINATOR=',',
			TABLOCK
		);
	SET @end_time=GETDATE();
		PRINT 'LOAD DURATION: '+CAST(DATEDIFF(SECOND,@start_time,@end_time) AS NVARCHAR) +'SECONDS';
		PRINT '>>--------------------------------------------------';

    SET @batch_end_time=GETDATE();
	    PRINT '===================================================='
		PRINT 'LOADING BRONZELAYER IS COMPLETED';
		PRINT 'Total Duration Time :'+ CAST(DATEDIFF(SECOND,@batch_start_time,@batch_end_time) AS NVARCHAR) +'SECONDS';
		PRINT '===================================================='

	END TRY
	BEGIN CATCH
		PRINT '===================================================='
		PRINT 'ERROR OCCUR DURIND THE BRONZE LAYER'
		PRINT 'Error message'+ERROR_MESSAGE();
		PRINT 'Error message'+CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error message'+CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '===================================================='

	END CATCH
	END


	
