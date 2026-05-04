SELECT SUM(Sales_Amount) AS Total_Sales FROM Gold.Fact_Sales;

SELECT SUM(Quantity) AS Total_Quantity FROM Gold.Fact_Sales;

SELECT AVG(sls_Price) AS Average_Price FROM Gold.Fact_Sales;

SELECT COUNT(DISTINCT Order_Number) AS Total_Orders FROM Gold.Fact_Sales;

SELECT COUNT(Customer_ID) AS Total_Customers FROM Gold.DM_Customers;

SELECT COUNT(Product_ID) AS Total_Products FROM Gold.DM_Products;
