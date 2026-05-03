USE retails;

SELECT *
FROM customers;

SELECT *
FROM orders;

SELECT *
FROM products;

-- SECTION A — INNER JOINS 
-- 1: Retrieve all orders with customer, city, product name, and sales amount
SELECT 
    orders.Order_ID,
    customers.Customer_Name,
    customers.City,
    products.Product_Name,
    orders.Sales
FROM orders
INNER JOIN customers
    ON orders.Customer_ID = customers.Customer_ID
INNER JOIN products
    ON orders.Product_ID = products.Product_ID;

-- 2. Show each customer’s total sales and total profit.
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    SUM(orders.Sales) AS Total_Sales,
    SUM(orders.Profit) AS Total_Profits
FROM customers
INNER JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
GROUP BY customers.Customer_ID, customers.Customer_Name;

-- Question 3: Show top 10 highest-value orders with segment and product category
SELECT
    orders.Order_ID,
    orders.Sales,
    customers.Segment,
    products.Category
FROM orders
INNER JOIN customers
    ON orders.Customer_ID = customers.Customer_ID
INNER JOIN products
    ON orders.Product_ID = products.Product_ID
ORDER BY orders.Sales DESC
LIMIT 10;

-- 4: List all orders in the Technology category with profit above 100
SELECT
    orders.Order_ID,
    products.Product_Name,
    products.Category,
    orders.Profit
FROM orders
INNER JOIN products
    ON orders.Product_ID = products.Product_ID
WHERE products.Category ='Technology'
AND orders.Profit >100;

-- 5: Show each customer's total orders and total quantity purchased
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    COUNT(orders.Order_ID) AS Total_orders,
    SUM(orders.Quantity) AS Total_Quantity
FROM orders
INNER JOIN customers
    ON orders.Customer_ID = customers.Customer_ID
GROUP BY customers.Customer_ID,customers.Customer_Name;

-- 6: Find customers who purchased more than one product category
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    COUNT(DISTINCT products.Category) AS Total_Category
FROM customers
INNER JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
INNER JOIN products
    ON products.Product_ID = orders.Product_ID
GROUP BY customers.Customer_ID, customers.Customer_Name
HAVING COUNT(DISTINCT products.Category)> 1;


-- SECTION B — FULL OUTER JOIN 
-- 7: Full list of customers and orders including unmatched records
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    orders.Order_ID
FROM customers
LEFT JOIN orders
    ON customers.Customer_ID =orders.Customer_ID
UNION
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    orders.Order_ID
FROM customers
RIGHT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID;

-- 8: Full comparison of products and orders
SELECT
    products.Product_ID,
    products.Product_Name,
    orders.Order_ID
FROM products
LEFT JOIN orders
    ON products.Product_ID = orders.Product_ID
UNION
SELECT
    products.Product_ID,
    products.Product_Name,
    orders.Order_ID
FROM products
RIGHT JOIN orders
    ON products.Product_ID = orders.Product_ID;

-- 9: Full audit of customer-product interactions
SELECT
    customers.Customer_Name,
    products.Product_Name,
    orders.Order_ID
FROM customers
LEFT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
LEFT JOIN products
    ON products.Product_ID = orders.Product_ID
UNION
SELECT
    customers.Customer_Name,
    products.Product_Name,
    orders.Order_ID
FROM customers
RIGHT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
RIGHT JOIN products
    ON products.Product_ID = orders.Product_ID;

-- 10: Full dataset of segments and categories purchased
SELECT
    customers.Segment,
    products.Category
FROM customers
LEFT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
LEFT JOIN products
    ON orders.Product_ID = products.Product_ID
UNION
SELECT
    customers.Segment,
    products.Category
FROM customers
RIGHT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
RIGHT JOIN products
    ON orders.Product_ID = products.Product_ID;

-- 11: Full comparison of customers and regions including unmatched
SELECT
    customers.Customer_Name,
    customers.Region,
    orders.Sales
FROM customers
LEFT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
UNION
SELECT
    customers.Customer_Name,
    customers.Region,
    orders.Sales
FROM customers
RIGHT JOIN orders
    ON customers.Customer_ID = orders.Customer_ID;

-- 12: Full reconciliation between products and orders
SELECT
    products.Product_ID,
    products.Product_Name,
    orders.Order_ID,
    orders.Sales
FROM products
LEFT JOIN orders
    ON products.Product_ID = orders.Product_ID
UNION
SELECT
    products.Product_ID,
    products.Product_Name,
    orders.Order_ID,
    orders.Sales
FROM products
RIGHT JOIN orders
    ON products.Product_ID = orders.Product_ID;


-- SECTION C — SUBQUERIES 
-- 13: Products priced above the overall average price
SELECT
    Product_ID,
    Product_Name,
    Price
FROM products
WHERE Price >(SELECT AVG(Price) FROM products);

-- 14: Orders with sales above the average of their product category
SELECT
    orders.Order_ID,
    orders.Sales,
    products.Category
FROM orders
INNER JOIN products
    ON orders.Product_ID = products.Product_ID
WHERE orders.Sales>(
    SELECT AVG(orders2.Sales)
    FROM orders AS orders2
    INNER JOIN products AS products2
        ON orders2.Product_ID = products2.Product_ID
        WHERE products2.Category = products.Category
    );


-- 15: Customers whose total spending is above the customer average
SELECT
    customers .Customer_ID,
    customers.Customer_Name,
    SUM(orders.Sales) AS Total_Spending
FROM customers
INNER JOIN orders
    ON orders.Customer_ID = customers.Customer_ID
GROUP BY customers.Customer_ID, customers.Customer_Name
HAVING SUM(orders.Sales) >(
    SELECT AVG(Total_Spending)
    FROM(
        SELECT SUM(orders.Sales) AS Total_Spending
        FROM orders
        GROUP BY orders.Customer_ID
    )AS Spending_Table
    );

-- 16: Products priced below their category average price
SELECT 
    products.Product_ID,
    products.Product_Name,
    products.Price,
    products.Category
FROM products
WHERE products.Price < (
    SELECT AVG(product2.Price)
    FROM products AS product2
    WHERE products.Category = products.Category
);

-- 17: Show each customer's spending and compare to average
SELECT
    customers.Customer_ID,
    customers.Customer_Name,
    SUM(orders.Sales) AS total_spend,
    CASE
        WHEN SUM(orders.Sales) >(
            SELECT AVG(total_spending)
            FROM(
                SELECT SUM(orders.Sales) AS total_spending
                FROM orders
                GROUP by orders.Customer_ID
            )AS Spending_Table
        )THEN 'Above Average'
        ELSE 'Below Average'
    END AS Spending_Status
FROM customers
INNER JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
GROUP BY customers.Customer_ID, customers.Customer_Name;

-- 18: Top 3 customer segments by revenue using a subquery
SELECT
    Segment,
    Total_revenue
FROM (
    SELECT 
        customers.Segment,
        SUM(orders.Sales) AS Total_revenue
    FROM customers
    INNER JOIN orders
        ON customers.Customer_ID = orders.Customer_ID
    GROUP BY customers.Segment
    )AS Segment_Table
ORDER BY Total_revenue DESC
LIMIT 3;

-- 19: Customers with multiple category purchases and above-average spending
SELECT
    customers.Customer_ID,
    customers.Customer_Name
FROM customers
INNER JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
INNER JOIN products
    ON orders.Product_ID = products.Product_ID
GROUP BY customers.Customer_ID, customers.Customer_Name
HAVING 
    COUNT(DISTINCT products.Category) >= 2
    AND SUM(orders.Sales) >(
        SELECT AVG(Total_Spending)
        FROM(
            SELECT SUM(orders.Sales) AS Total_Spending
            FROM orders
            GROUP BY orders.Customer_ID
            ) AS Spending_Table
        );

-- 20: Customers who purchased products priced above category average
SELECT DISTINCT
    customers.Customer_ID,
    customers.Customer_Name
FROM customers
INNER JOIN orders
    ON customers.Customer_ID = orders.Customer_ID
INNER JOIN products
    ON orders.Product_ID = products.Product_ID
WHERE products.Price >(
    SELECT AVG(products2.Price)
    FROM products AS products2
    WHERE products2.Category = products.Category
    );