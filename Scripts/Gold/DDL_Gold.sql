/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
    This script creates views for the Gold layer in the data warehouse. 
    The Gold layer represents the final dimension and fact tables (Star Schema)

    Each view performs transformations and combines data from the Silver layer 
    to produce a clean, enriched, and business-ready dataset.

Usage:
    - These views can be queried directly for analytics and reporting.
===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================


CREATE VIEW Gold.DM_Customers AS
SELECT 
       ROW_NUMBER() OVER (ORDER BY CI.cst_id) AS Customer_Key,
       CI.[cst_id] AS Customer_ID
      ,CI.[cst_key] AS Customer_Number
      ,CI.[cst_firstname] AS First_Name
      ,CI.[cst_lastname] AS Last_Name
      ,LA.cntry AS Country
      ,CI.[cst_marital_status] AS Marital_Status
      ,CASE WHEN CI.[cst_gndr] != 'Unknown' THEN CI.[cst_gndr] --CRM is the Master for gender info
           ELSE COALESCE(CA.gen,  'Unknown')
      END AS Gender
      ,CA.bdate AS Birth_Date
      ,CI.[cst_create_date] AS Create_Date
  FROM [DataWarehouse].[Silver].[crm_cust_info] CI
  LEFT JOIN Silver.erp_cust_az12 CA
  ON CI.cst_key = CA.cid
  LEFT JOIN Silver.erp_loc_a101 LA
  ON CI.cst_key = LA.cid

  -- =============================================================================
-- Create Dimension: gold.dim_products
-- ===============================================================================

CREATE VIEW Gold.DM_Products AS
SELECT
ROW_NUMBER() OVER (ORDER BY  PN.prd_Start_DT, PN.prd_Key) AS Product_Key,
Pn.prd_ID AS Product_ID,
PN.prd_Key AS Product_Number,
PN.prd_Nm AS Product_Name,
PN.prd_Cat_ID AS Category_ID,
PC.cat AS Category,
PC.subcat AS Subcategory,
PC.maintenance AS Maintenance,
PN.prd_Cost AS Cost,
PN.prd_Line AS Product_Line,
PN.prd_Start_DT AS Start_date
FROM Silver.crm_prd_info PN
LEFT JOIN Silver.erp_px_cat_g1v2 PC
ON PN.prd_Cat_ID = PC.id
WHERE prd_End_DT IS NULL --FILTER OUT HISTORICAL DATA


-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================

CREATE VIEW Gold.Fact_Sales AS
SELECT [sls_Ord_Num] AS Order_Number
      , PR.[Product_Key]
      , CU.[Customer_Key]
      ,[sls_Order_DT]
      ,[sls_Ship_DT] AS Shipping_Date
      ,[sls_Due_DT] AS Due_Date
      ,[sls_Sales] AS Sales_Amount
      ,[sls_Quantity] AS Quantity
      ,[sls_Price]
  FROM [DataWarehouse].Silver.[crm_Sales_Details] SD
  LEFT JOIN [Gold].[DM_Products] PR 
  ON SD.sls_Prd_Key = PR.[Product_Number]
  LEFT JOIN Gold.DM_Customers CU
  ON SD.sls_Cust_ID = CU.[Customer_ID]
