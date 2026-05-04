SELECT
    Order_Date,
    Total_Sales,
    SUM(Total_Sales) OVER (ORDER BY Order_Date) AS Running_Total
FROM (
    SELECT 
        DATETRUNC(MONTH, sls_Order_DT) AS Order_Date,
        SUM(Sales_Amount) AS Total_Sales
    FROM Gold.Fact_Sales
    GROUP BY DATETRUNC(MONTH, sls_Order_DT)
) t;
