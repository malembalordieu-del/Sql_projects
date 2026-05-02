USE sales
-- 1 Regional Performance
SELECT 
Region,
SUM(Sales)AS total_sales,
SUM(Profit)AS total_profit
FROM orders
GROUP BY Region;

-- 2 Shipping Mode Analysis
SELECT `Ship Mode`,
COUNT(DISTINCT `Order ID`)AS number_of_order,
AVG(Sales) AS average_sale_per_order
FROM orders
GROUP BY `Ship Mode`;

-- 3 Customer Segment Insights
SELECT Segment,
SUM(Profit)AS total_profit,
AVG(Discount)AS average_discount
FROM orders
GROUP BY Segment;

-- 4 Loss-Making Sub-Categories
SELECT `Sub-Category`,
SUM(Profit) AS total_profits
FROM orders
GROUP BY `Sub-Category`
HAVING SUM(Profit) < 0;

-- 5 Top 5 States by Sales
SELECT State,
SUM(Sales) AS total_sales
FROM orders
GROUP BY State
ORDER BY total_sales DESC
LIMIT 5;

-- 5 High-Discount Categories
SELECT Category,
AVG(Discount) AS Avg_Discount
FROM orders
GROUP BY Category
HAVING AVG(Discount) > 0.15;

-- Stretch Exercise (Optional)
SELECT 
    `Sub-Category`,
    SUM(Sales) AS Total_Sales,
    SUM(Profit) AS Total_Profit,
    AVG(Profit) AS Avg_Profit_Per_Order,
    COUNT(DISTINCT `Order ID`) AS Order_Count
FROM orders
WHERE Region = 'West'
GROUP BY `Sub-Category`
HAVING SUM(Profit) > 1000
ORDER BY Total_Profit DESC
LIMIT 5;
