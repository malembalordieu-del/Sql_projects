USE sales;
SELECT *
FROM orders;
SELECT `Product Name`
FROM orders;

-- STRING FUNCTIONS
-- (1)UPPER()& LOWER()
SELECT 
    `Customer Name`,
    UPPER(`Customer Name`) AS Customer_Name
FROM orders; 

SELECT 
    `Customer Name`,
    LOWER(`Customer Name`) AS Customer_Name
FROM orders; 

SELECT
`Customer Name`,
UPPER(`Customer Name`) AS Customer_Name
FROM orders;

-- TRIM()

SELECT 
    `Customer Name`,
    TRIM(`Customer Name`) AS Customer_Name
FROM orders;

-- CONCAT()
SELECT
    `Customer Name`,
    CONCAT(State,"-",City)AS LOCATION
FROM orders;

-- LEFT & RIGHT
SELECT
    `Product Name`,
    LEFT(`Product Name`, 15)AS SHORT_PRODUCT_NAME
FROM orders
LIMIT 5;

SELECT
    `Product Name`,
    RIGHT(`Product Name`, 15)AS SHORT_PRODUCT_NAME
FROM orders
LIMIT 5;

SELECT
    `Postal Code`,
    RIGHT(`Postal Code`, 3) AS LAST_THREE_DIGIT
FROM orders
LIMIT 5;

-- REPLACE()
SELECT
    DISTINCT Category,
    REPLACE(Category,'Office Supplies','Office Stationary') AS NEW_CATEGORU
FROM orders;   

-- LIKE
-- STATES WHOSE NAME START WITH 'C'
SELECT DISTINCT State
FROM orders
WHERE State LIKE 'C%';

UPDATE orders
SET `Order Date` = STR_TO_DATE(`Order Date`, '%m/%d/%Y');

ALTER TABLE orders
MODIFY `Order Date` DATE;


UPDATE orders
SET `Ship Date` = STR_TO_DATE(`Ship Date`, '%m/%d/%Y');

ALTER TABLE orders
MODIFY `Ship Date` DATE;


-- date functioin
-- Year
-- Sales per 
SELECT DISTINCT YEAR(`Order Date`)AS ORDER_DATE,
SUM(Sales) AS TOTAL_SALES
FROM orders
GROUP BY YEAR(`Order Date`);