-- Explore all tables
SELECT * FROM INFORMATION_SCHEMA.TABLES;

-- Explore all columns (example)
SELECT DISTINCT Country FROM Gold.DM_Customers;

-- Explore product structure
SELECT DISTINCT Category, Subcategory, Product_Name 
FROM Gold.DM_Products;
