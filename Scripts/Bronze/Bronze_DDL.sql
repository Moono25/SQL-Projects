/*
===============================================================
The following SQL code creates a table named `crm_cust_info` in 
the `Bronze` schema of the `DataWarehouse` database. 
This table is designed to store customer information, including their 
ID, key, first name, last name, marital status
===============================================================
*/

IF OBJECT_ID ('Bronze.crm_cust_info', 'U') IS NOT NULL
DROP TABLE Bronze.crm_cust_info;
CREATE TABLE Bronze.crm_cust_info(
	cst_ID INT,
	cst_Key NVARCHAR(50),
	Cst_Firstname NVARCHAR(50),
	cst_Lastname NVARCHAR(50),
	cst_Marital_Status NVARCHAR(50),
	cst_Gndr NVARCHAR(50),
	cst_Create_Date DATE
);

/*Theollowing SQL code creates a table named `crm_sls_info` in the `Bronze` schema of the `DataWarehouse` database.
This table is designed to store sales information, 
including order number, product key, customer ID, order date, ship date, due date, sales amount, quantity, and price.*/
IF OBJECT_ID ('Bronze.crm_Sales_Details', 'U') IS NOT NULL
DROP TABLE Bronze.crm_Sales_Details;
CREATE TABLE Bronze.crm_Sales_Details( 
	sls_Ord_Num NVARCHAR(50),
	sls_Prd_Key NVARCHAR(50),
	sls_Cust_ID INT,
	sls_Order_DT INT,
	sls_Ship_DT INT,
	sls_Due_DT INT,
	sls_Sales INT,
	sls_Quantity INT,
	sls_Price INT
);

-- The following SQL code creates a table named `crm_prd_info` in the `Bronze` schema of the `DataWarehouse` database.
IF OBJECT_ID ('Bronze.crm_prd_info', 'U') IS NOT NULL
DROP TABLE Bronze.crm_prd_info;
CREATE TABLE Bronze.crm_prd_info(
	prd_ID INT,
	prd_Key NVARCHAR(50),
	prd_Nm NVARCHAR(50),
	prd_Cost INT,
	prd_Line NVARCHAR(50),
	prd_Start_DT DATE,
	prd_End_DT DATE
);


IF OBJECT_ID ('Bronze.erp_CUST_AZ12', 'U') IS NOT NULL
DROP TABLE Bronze.erp_CUST_AZ12;

CREATE TABLE Bronze.erp_CUST_AZ12 (
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50),
);


IF OBJECT_ID ('Bronze.erp_LOC_A101', 'U') IS NOT NULL
DROP TABLE Bronze.erp_LOC_A101;
CREATE TABLE Bronze.erp_LOC_A101(
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);
		
IF OBJECT_ID ('Bronze.erp_PX_CAT_G1V2', 'U') IS NOT NULL
DROP TABLE Bronze.erp_PX_CAT_G1V2;
CREATE TABLE Bronze.erp_PX_CAT_G1V2 (
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
Maintenance NVARCHAR(50)
);
