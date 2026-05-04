-- First and last order
SELECT 
    MIN(sls_Order_DT) AS First_Order,
    MAX(sls_Order_DT) AS Last_Order
FROM Gold.Fact_Sales;

-- Years of data
SELECT 
    MIN(sls_Order_DT) AS First_Order,
    MAX(sls_Order_DT) AS Last_Order,
    DATEDIFF(YEAR, MIN(sls_Order_DT), MAX(sls_Order_DT)) AS Order_Range_Years
FROM Gold.Fact_Sales;
