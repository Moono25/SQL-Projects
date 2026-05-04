-- Customers by country
SELECT Country, COUNT(Customer_Key) AS Total_Customers
FROM Gold.DM_Customers
GROUP BY Country;

-- Products by category
SELECT Category, COUNT(Product_ID) AS Total_Products
FROM Gold.DM_Products
GROUP BY Category;

-- Revenue by category
SELECT P.Category, SUM(S.Sales_Amount) AS Total_Revenue
FROM Gold.DM_Products P
LEFT JOIN Gold.Fact_Sales S 
    ON P.Product_Key = S.Product_Key
GROUP BY P.Category;
