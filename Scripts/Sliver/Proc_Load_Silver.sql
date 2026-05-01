/*
===============================================================================
Stored Procedure: Load Silver Layer (Bronze -> Silver)
===============================================================================
Script Purpose:
    This stored procedure performs the ETL (Extract, Transform, Load) process to 
    populate the 'silver' schema tables from the 'bronze' schema.
	Actions Performed:
		- Truncates Silver tables.
		- Inserts transformed and cleansed data from Bronze into Silver tables.
		
Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC Silver.load_silver;
===============================================================================
*/

GO
CREATE OR ALTER PROCEDURE silver.load_sliver AS
BEGIN
	DECLARE @Start_Time DATETIME, @End_Time DATETIME,@Batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
    	SET @Batch_Start_time = GETDATE();
		PRINT'===============================================';
		PRINT 'Loading data into Silver layer...';
		PRINT'===============================================';

		PRINT'-------------------------------';
		PRINT 'Loading CRM Tables...';
		PRINT'-------------------------------';

    SET @Start_Time = GETDATE();
    PRINT '>>Truncating Table Silver.crm_cust_info';
    TRUNCATE TABLE Silver.crm_cust_info;
    PRINT '>>Inserting Data Into:Silver.crm_cust_info';
    INSERT INTO Silver.crm_cust_info ( 
    cst_id,
    cst_key,
    cst_firstname,
    cst_lastname,
    cst_marital_status,
    cst_gndr,
    cst_create_date
    )
    SELECT
    cst_ID,
    cst_Key,
    TRIM(cst_firstname) AS cst_firstname,
    TRIM(cst_lastname) AS cst_lastname,
    CASE WHEN 
    UPPER(TRIM(cst_Marital_Status)) = 'M' THEN 'Married'
    WHEN UPPER(TRIM(cst_Marital_Status)) = 'S' THEN 'Single'
    ELSE 'Unknown'
    END AS cst_Marital_Status,--Making Marital status values readable
    CASE WHEN 
    UPPER(TRIM(cst_Gndr)) = 'F' THEN 'Female'
    WHEN UPPER(TRIM(cst_Gndr)) = 'M' THEN 'Male'
    ELSE 'Unknown'
    END AS cst_Gndr,--Making gender values readable
    cst_Create_Date
    FROM
    (
    SELECT *,
    ROW_NUMBER() OVER (PARTITION BY CST_ID ORDER BY cst_create_date) AS flag_last
    FROM [Bronze].[crm_cust_info])t WHERE FLAG_LAST = 1 --Select the most recent record per customer
    SET @End_Time = GETDATE();
    PRINT'>> Time taken: ' + CAST(DATEDIFF(SECOND, @Start_Time,@End_Time) AS NVARCHAR) + ' seconds';
	PRINT'>> ---------------';

    --prd_info

    SET @Start_Time = GETDATE();
    PRINT '>>Truncating Table Silver.crm_prd_info';
    TRUNCATE TABLE Silver.crm_prd_info;
     PRINT '>>Inserting Data Into:Silver.crm_prd_info'
     INSERT INTO Silver.crm_prd_info(
     prd_ID,
     prd_Cat_ID,
     prd_Key,
     prd_Nm,
     prd_Cost,
      prd_Line,
      prd_Start_DT,
      prd_End_DT
     )
     SELECT 
    [prd_ID],
    REPLACE(SUBSTRING(prd_key,1, 5), '-','_') AS prd_Cat_ID, -- Extracted category ID 
    SUBSTRING(prd_key, 7, LEN(prd_key)) AS Prd_Key -- Extracted product key without category prefix
    ,[prd_Nm]
    ,ISNULL([prd_Cost], 0) AS prd_Cost,
    CASE WHEN UPPER(TRIM(prd_Line)) = 'M' THEN 'Mountain' 
	    WHEN UPPER(TRIM(prd_Line)) = 'R' THEN 'Road'
	    WHEN UPPER(TRIM(prd_Line)) = 'S' THEN 'Other Sales'
	    WHEN UPPER(TRIM(prd_Line)) = 'T' THEN 'Touring'
	    ELSE 'Unknown' 
	    END AS Prd_Line --Decode product line codes to full names
    ,[prd_Start_DT]
    ,DATEADD(DAY, -1, 
        LEAD(prd_start_dt) OVER (
            PARTITION BY prd_key 
            ORDER BY prd_start_dt
        )
    ) AS Prd_end_DT -- Calculated end date as one day before the next start date
     FROM [DataWarehouse].[Bronze].[crm_prd_info]
    SET @End_Time = GETDATE();
    PRINT'>> Time taken: ' + CAST(DATEDIFF(SECOND, @Start_Time,@End_Time) AS NVARCHAR) + ' seconds';
	PRINT'>> ---------------';

    --sales_details

    SET @Start_Time = GETDATE();
    PRINT '>>Truncating Table Silver.crm_sales_details';
    TRUNCATE TABLE Silver.crm_sales_details;
    PRINT '>>Inserting Data Into:Silver.crm_sales_details'
    INSERT INTO [DataWarehouse].[Silver].[crm_sales_details]
           ([sls_ord_num]
          ,[sls_prd_key]
          ,[sls_cust_id]
          ,[sls_order_dt]
          ,[sls_ship_dt]
          ,[sls_due_dt]
          ,[sls_sales]
          ,[sls_quantity]
          ,[sls_price]
          )
    SELECT
          [sls_Ord_Num]
          ,[sls_Prd_Key]
          ,[sls_Cust_ID],
          CASE WHEN sls_Order_DT = 0 OR LEN(sls_Order_DT) != 8 THEN NULL
            ELSE CAST( CAST(sls_Order_DT AS VARCHAR) AS DATE)
          END AS [sls_Order_DT],
           CASE WHEN sls_Ship_DT = 0 OR LEN(sls_Ship_DT) != 8 THEN NULL
            ELSE CAST( CAST(sls_Ship_DT AS VARCHAR) AS DATE)
          END AS[sls_Ship_DT],
          CASE WHEN sls_Due_DT = 0 OR LEN(sls_Due_DT) != 8 THEN NULL
            ELSE CAST( CAST(sls_Due_DT AS VARCHAR) AS DATE)
          END AS [sls_Due_DT]
          ,CASE 
          WHEN sls_Sales IS NULL OR sls_Sales <=0 OR  sls_Sales != sls_Quantity * ABS(sls_Price)
	    THEN sls_Quantity * ABS(sls_Price)
    ELSE sls_Sales
    END AS [sls_Sales]-- Recalculating sales if orginal value is missing
           ,[sls_Quantity],
          CASE 
          WHEN sls_Price IS NULL OR sls_Price <= 0
	    THEN sls_Sales / NULLIF(sls_Quantity,0)
	    ELSE ABS(sls_Price)
	    END AS [sls_Price] -- Derive price even if The original value is invalid. 
      FROM [DataWarehouse].[Bronze].[crm_Sales_Details]
    SET @End_Time = GETDATE();
    PRINT'>> Time taken: ' + CAST(DATEDIFF(SECOND, @Start_Time,@End_Time) AS NVARCHAR) + ' seconds';
	PRINT'>> ---------------';
      --cust_az12


     SET @Start_Time = GETDATE();
     PRINT '>>Truncating Table Silver.erp_cust_az12';
     TRUNCATE TABLE Silver.erp_cust_az12;
     PRINT '>>Inserting Data Into:Silver.erp_cust_az12'
     INSERT INTO Silver.erp_cust_az12(
     CID,
     BDATE,
     GEN
     )
    SELECT 
    CASE WHEN CID LIKE 'NAS%' THEN SUBSTRING(CID, 4, LEN(CID))
	    ELSE CID
    END AS CID,
    CASE WHEN BDATE > GETDATE() THEN NULL
    ELSE BDATE
    END AS BDATE, -- Handle future birthdates by setting them to NULL
    CASE WHEN 
    UPPER(TRIM(GEN))  IN ('F', 'FEMALE')  THEN 'Female'
    WHEN UPPER(TRIM(GEN))  IN ('M', 'MALE')   THEN 'Male'
    ELSE 'Unknown'
    END AS GEN --Normalize gender values and handle unknowns
    FROM [Bronze].[erp_CUST_AZ12]
    SET @End_Time = GETDATE();
    PRINT'>> Time taken: ' + CAST(DATEDIFF(SECOND, @Start_Time,@End_Time) AS NVARCHAR) + ' seconds';
	PRINT'>> ---------------';

    PRINT'----------------------------------------------------'
    PRINT 'Loading ERP Tables';
    PRINT'----------------------------------------------------'


    --loc_a101

    SET @Start_Time = GETDATE();
    PRINT '>>Truncating Table Silver.erp_loc_a101';
    TRUNCATE TABLE Silver.erp_loc_a101;
    PRINT '>>Inserting Data Into:Silver.erp_loc_a101'
    INSERT INTO [Silver].[erp_loc_a101] (
    CID,cntry)
    SELECT REPLACE(CID,'-','')CID, -- Romved the - that would have made joining difficult
    CASE WHEN TRIM(CNTRY) = 'DE' THEN 'Germany'
	    WHEN TRIM(CNTRY) IN ('US', 'USA') THEN 'United States'
	    WHEN TRIM(CNTRY) = '' OR CNTRY IS NULL THEN 'Unkown'
	    ELSE TRIM(CNTRY)
    END CNTRY -- Normalize and Handle missing or Blank country codes
    FROM Bronze.erp_LOC_A101
    SET @End_Time = GETDATE();
    PRINT'>> Time taken: ' + CAST(DATEDIFF(SECOND, @Start_Time,@End_Time) AS NVARCHAR) + ' seconds';
	PRINT'>> ---------------';

    --px_cat_g1v2
    SET @Start_Time = GETDATE();
    PRINT '>>Truncating Table Silver.erp_px_cat_g1v2';
    TRUNCATE TABLE Silver.erp_px_cat_g1v2;
    PRINT '>>Inserting Data Into:Silver.erp_px_cat_g1v2'
    INSERT INTO Silver.erp_px_cat_g1v2 (
            [ID]
          ,[CAT]
          ,[SUBCAT]
          ,[Maintenance])
    SELECT [ID]
          ,[CAT]
          ,[SUBCAT]
          ,[Maintenance]
      FROM [DataWarehouse].[Bronze].[erp_PX_CAT_G1V2];
      SET @End_Time = GETDATE();
      PRINT'>> Time Taken: ' + CAST(DATEDIFF(SECOND, @Start_Time, @End_Time) AS VARCHAR) + 'Seconds';
      PRINT'>>----------------------------';

      SET @Batch_End_Time = GETDATE();
      PRINT '==============================================='
		PRINT 'Loading data into Silver layer is Completed';
		PRINT ' - Total load Duration' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + 'Seconds';
		PRINT '==============================================='
	END TRY
      BEGIN CATCH
			PRINT'===============================================';
			PRINT 'ERROR LOADING DATA INTO SILVER LAYER';
			PRINT'===============================================';
			PRINT 'Error Number: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
			PRINT 'Error Message: ' + ERROR_MESSAGE();
			PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR)
			PRINT'===============================================';
	END CATCH
      END
