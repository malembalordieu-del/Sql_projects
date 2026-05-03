
USE sales;

-- How many products in total were chairs?
-- 1. How many products in total were chairs?
SELECT
    COUNT(*) AS TOTAL_CHAIRS
FROM orders
WHERE  `Sub-Category` ='Chairs';  

-- 2. Create a new column that combines Customer Name and City into a single label.
SELECT
    `Customer Name`,
    City,
    CONCAT(`Customer Name`,'-',City)AS Total_label
FROM orders;

-- 3. Find all states whose names start with the letter 'C'.
SELECT DISTINCT State 
FROM orders
WHERE State LIKE 'C%';

-- 4. Calculate the profit margin for each product and round it to 2 decimals.
SELECT
    `Product Name`,
    Sales,
    Profit,
    ROUND((Profit / Sales)*100,2)AS Profits_Margin
FROM orders;

-- 5. Find the average discount given per order and round it to 2 decimals.
SELECT
    ROUND(AVG(Discount),2)AS Average_Discount_Per_Order
FROM orders;

-- 6. Identify the top 5 orders with the highest total sales.
SELECT
    `Order ID`,
    ROUND(SUM(Sales),2)AS Total_Sales
FROM orders
GROUP BY `Order ID`
ORDER BY Total_Sales DESC
LIMIT 5;   

-- 7. Calculate monthly total sales and profit using month names.
SELECT
    MONTHNAME(`Order Date`)AS Month_Name,
    SUM(Sales)AS total_Sales,
    SUM(Profit)AS total_Profits
FROM orders
GROUP BY MONTHNAME(`Order Date`),MONTH(`Order Date`)
ORDER BY total_Sales DESC;

SELECT
    MONTHNAME(`Order Date`)AS Month_Name,
    ROUND(SUM(Sales),2)AS total_Sales,
    ROUND(SUM(Profit),2)AS total_Profits
FROM orders
GROUP BY MONTHNAME(`Order Date`),MONTH(`Order Date`)
ORDER BY total_Sales DESC;

-- 8. Determine which year had the highest profit.
SELECT
    YEAR(`Order Date`)AS Year,
    SUM(Profit)AS Total_Profits
FROM orders
GROUP BY YEAR(`Order Date`)
ORDER BY Total_Profits DESC;

SELECT
    YEAR(`Order Date`)AS Year,
    ROUND(SUM(Profit),2)AS Total_Profits
FROM orders
GROUP BY YEAR(`Order Date`)
ORDER BY Total_Profits DESC;

-- 9. Find the average shipping days per category.
SELECT
    Category,
    ROUND(AVG(DATEDIFF(`Ship Date`,`Order Date`)),2)AS Average_Shipping_Day
FROM orders
GROUP BY Category;

SELECT
    Category,
    ROUND(AVG(DATEDIFF(`Ship Date`,`Order Date`)),2)AS Average_Shipping_Day
FROM orders
GROUP BY Category
ORDER BY Average_Shipping_Day DESC;

-- 10. Count how many orders were placed in the last 30 days.
-- Assume today is '2017-04-03'.
SELECT
    COUNT(DISTINCT `Order ID`)AS Order_last_30_Days
FROM orders
WHERE `Order ID` BETWEEN DATE_SUB('2015-04-03',INTERVAL 30 DAY)
AND '2015-05-03';