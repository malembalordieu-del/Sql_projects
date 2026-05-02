USE sales;

SELECT *
FROM orders;
-- FILTERING IN SQL USING WHERE
-- All sales From EAST REGIONS
SELECT *
FROM orders
WHERE Region ="East";
-- Hight Sales Orders (Above 500)
SELECT *
FROM orders
WHERE Sales >= 500;

-- Cities with more than $500 Profits
SELECT City,Profit
FROM orders
WHERE Profit >= 500;

-- SALES MADE I  2019

SELECT *
FROM orders
WHERE `Order Date` BETWEEN "01-01-2019" AND "12-31-2019";

-- SORTIN DATA IN SQL (ORDER BY)

-- HIGHEDH SALE FIRST
SELECT *
FROM orders
ORDER BY Sales DESC;

-- MOST PROFITABLE ORDERS
SELECT *
FROM orders
ORDER BY Profit DESC;

-- HIGHESET SALES BY STATES (FIRST 5 ROWS)
SELECT State, Sales
FROM orders
ORDER BY Profit DESC
LIMIT 5;


