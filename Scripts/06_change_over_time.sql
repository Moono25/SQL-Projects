SELECT 
    DATETRUNC(MONTH, sls_Order_DT) AS Order_Date,
    SUM(Sales_Amount) AS Total_Sales
FROM Gold.Fact_Sales
GROUP BY DATETRUNC(MONTH, sls_Order_DT)
ORDER BY Order_Date;
