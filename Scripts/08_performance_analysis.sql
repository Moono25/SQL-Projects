-- Yearly product performance
WITH Yearly_Product_Sales AS (
    SELECT
        YEAR(S.sls_Order_DT) AS Order_year,
        P.Product_Name,
        SUM(S.Sales_Amount) AS Current_Sales
    FROM Gold.Fact_Sales S
    LEFT JOIN Gold.DM_Products P 
        ON S.Product_Key = P.Product_Key
    GROUP BY P.Product_Name, YEAR(S.sls_Order_DT)
)
SELECT ...
