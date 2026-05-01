/*===============================================================
DDL Scipt: That creates Silver Tables
=================================================================
Script Purpose: Creates tables in the 'Sliver' Schema, Dropping existing tables
if they are any.
Run the script to redefine the DDL structure of 'Bronze' Tables
=================================================================
*/
IF OBJECT_ID ('silver.crm_cust_info', 'U') IS NOT NULL 
DROP TABLE silver.crm_cust_info;
CREATE TABLE silver.crm_cust_info(
	cst_ID INT,
	cst_Key NVARCHAR(50),
	Cst_Firstname NVARCHAR(50),
	cst_Lastname NVARCHAR(50),
	cst_Marital_Status NVARCHAR(50),
	cst_Gndr NVARCHAR(50),
	cst_Create_Date DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID ('silver.crm_Sales_Details', 'U') IS NOT NULL
DROP TABLE silver.crm_Sales_Details;
CREATE TABLE silver.crm_Sales_Details( 
	sls_Ord_Num NVARCHAR(50),
	sls_Prd_Key NVARCHAR(50),
	sls_Cust_ID INT,
	sls_Order_DT DATE,
	sls_Ship_DT DATE,
	sls_Due_DT DATE,
	sls_Sales INT,
	sls_Quantity INT,
	sls_Price INT,
	dwh_create_date DATETIME2 DEFAULT GETDATE()

);

IF OBJECT_ID ('silver.crm_prd_info', 'U') IS NOT NULL
DROP TABLE silver.crm_prd_info;
CREATE TABLE silver.crm_prd_info(
	prd_ID INT,
	prd_Cat_ID NVARCHAR(50),
	prd_Key NVARCHAR(50),
	prd_Nm NVARCHAR(50),
	prd_Cost INT,
	prd_Line NVARCHAR(50),
	prd_Start_DT DATE,
	prd_End_DT DATE,
	dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID ('silver.erp_CUST_AZ12', 'U') IS NOT NULL
DROP TABLE silver.erp_CUST_AZ12;

CREATE TABLE silver.erp_CUST_AZ12 (
CID NVARCHAR(50),
  
BDATE DATE,
GEN NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);


IF OBJECT_ID ('silver.erp_LOC_A101', 'U') IS NOT NULL
DROP TABLE silver.erp_LOC_A101;
CREATE TABLE silver.erp_LOC_A101(
CID NVARCHAR(50),
CNTRY NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
		
IF OBJECT_ID ('silver.erp_PX_CAT_G1V2', 'U') IS NOT NULL
DROP TABLE silver.erp_PX_CAT_G1V2;
CREATE TABLE silver.erp_PX_CAT_G1V2 (
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
Maintenance NVARCHAR(50),
dwh_create_date DATETIME2 DEFAULT GETDATE()
);
