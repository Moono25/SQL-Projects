-- Top 5 products
SELECT TOP 5 
    P.Product_Name,
    SUM(S.Sales_Amount) AS Total_Revenue
FROM Gold.DM_Products P
LEFT JOIN Gold.Fact_Sales S 
    ON P.Product_Key = S.Product_Key
GROUP BY P.Product_Name
ORDER BY Total_Revenue DESC;

-- Worst 5 products
SELECT TOP 5 
    P.Product_Name,
    SUM(S.Sales_Amount) AS Total_Revenue
FROM Gold.DM_Products P
LEFT JOIN Gold.Fact_Sales S 
    ON P.Product_Key = S.Product_Key
GROUP BY P.Product_Name
ORDER BY Total_Revenue ASC;
