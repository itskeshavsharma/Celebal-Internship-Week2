Use SuperstoreDB

--1. Exploring Table (Schema + Sample Data)

--Schema
EXEC sp_help superstore;

--Sample Data
select top 10 * from superstore

--Total records
select COUNT(*) as Total_Rows From superstore

--Distinct Customers
Select COUNT(distinct Customer_ID)AS Total_Customers FROM superstore;

--Distinct Products
SELECT COUNT(DISTINCT Product_ID) AS Total_Products FROM superstore;

--2. Applying WHERE Filters

--Region Analysis
SELECT * FROM superstore WHERE Region = 'West';

--Category Analysis
SELECT *
FROM superstore
WHERE Category = 'Technology';

--High Value Sales
SELECT *
FROM superstore
WHERE Sales > 1000;

--Recent Orders
select * 
from superstore
WHERE Order_Date >= '2017-01-01'

--High Profit Orders
select * from superstore
where profit > 500;

--Loss Making Orders
SELECT *
FROM superstore
WHERE Profit < 0;

--3. GROUP BY Aggregations

--Sales by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

--Profit By Category
SELECT
    Category,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Profit DESC;

--Quantity by Category
Select 
    Category,
    SUM(QUANTITY) AS TOTAL_QUANTITY
FROM Superstore
GROUP BY CATEGORY;

--TOTAL Sales + TOTAL Category by Category
SELECT
    Category,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Category
ORDER BY Total_Sales DESC;

--Sub Category Analysis
SELECT
    Sub_Category,
    SUM(Sales) AS Revenue,
    SUM(Profit) AS Profit
FROM superstore
GROUP BY Sub_Category
ORDER BY Revenue DESC;

--4. Sort & Limit Results

--Top 10 Products
SELECT TOP 10
    Product_Name,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Sales DESC;

--Top 10 Customers
SELECT TOP 10
    Customer_Name,
    SUM(Sales) AS Total_Sales
FROM superstore
GROUP BY Customer_Name
ORDER BY Total_Sales DESC;

--Top 5 States
Select Top 5 
    state,
    SUM(Sales) AS revenue
FROM superstore
GROUP BY State
ORDER BY Revenue DESC;

--Product Frequency Analysis
SELECT
    Product_id,
    COUNT(*) AS Duplicate
from Superstore
group by PRODUCT_ID
HAVING COUNT(*) > 1 
ORDER BY Duplicate DESC

--Most Profitable Products
SELECT TOP 10
    Product_Name,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit DESC;

--Least Profitable Products
SELECT TOP 10
    Product_Name,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY Product_Name
ORDER BY Total_Profit ASC;
    

--5. Business Use Cases

--Monthly Sales Trend
SELECT 
    YEAR(ORDER_DATE) AS YEAR,
    MONTH(ORDER_DATE) AS MONTH,
    SUM(SALES) AS REVENUE
FROM SUPERSTORE
GROUP BY 
    YEAR(ORDER_DATE),
    MONTH(ORDER_DATE)
ORDER BY 
    YEAR,
    MONTH

--Customer Segment Analysis
SELECT
    Segment,
    SUM(Sales) AS Revenue,
    SUM(Profit) AS Profit,
    SUM(Quantity) AS Quantity_Sold
FROM superstore
GROUP BY Segment
ORDER BY Revenue DESC;

SELECT * FROM SUPERSTORE

--Regional Performance
SELECT 
    REGION,
    SUM(SALES) AS REVENUE,
    SUM(PROFIT) AS PROFIT
FROM SUPERSTORE
GROUP BY REGION
ORDER BY REVENUE DESC

--Top States by Revenue
SELECT TOP 10
    State,
    SUM(Sales) AS Revenue,
    SUM(Profit) AS Profit
FROM superstore
GROUP BY State
ORDER BY Revenue DESC;

--Loss Making states
SELECT TOP 10
    State,
    SUM(Profit) AS Total_Profit
FROM superstore
GROUP BY State
HAVING SUM(Profit) < 0
ORDER BY Total_Profit ASC;

--Duplicate Orders
SELECT Order_ID, COUNT(*) AS DUPLICATE_ORDER
FROM Superstore
GROUP BY Order_ID
HAVING COUNT(*) > 1
ORDER BY DUPLICATE_ORDER DESC
   

--Discount Impact Analysis
SELECT
    Discount,
    AVG(Profit) AS Avg_Profit,
    AVG(Sales) AS Avg_Sales
FROM superstore
GROUP BY Discount
ORDER BY Discount ASC;

--6. Data Validation

--Total Rows
Select COUNT(*) AS TOTAL_ROWS
FROM Superstore

--Null Check
SELECT
SUM(CASE WHEN Sales IS NULL THEN 1 ELSE 0 END) AS Sales_Null,
SUM(CASE WHEN Profit IS NULL THEN 1 ELSE 0 END) AS Profit_Null,
SUM(CASE WHEN Customer_ID IS NULL THEN 1 ELSE 0 END) AS Customer_Null
FROM superstore;


--Negative Profit Orders
SELECT * FROM superstore WHERE Profit < 0;

