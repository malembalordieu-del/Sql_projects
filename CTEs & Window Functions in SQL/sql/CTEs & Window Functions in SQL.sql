USE arel;

SELECT *
FROM employees;

-- Employees with more than 3 years experience

-- 1 Using Sub Querries
SELECT Department, AVG(`Monthly Salary`) AS Average_Salary
FROM (SELECT * FROM employees WHERE Years >3) Experienced_Employees
GROUP BY Department;

SELECT Center, ROUND(AVG(`Overtime Hours`),2) AS Average_OvertimeHours
FROM(SELECT * FROM employees WHERE Years >5) Job_Rate
GROUP BY Center;

SELECT Gender,AVG(`Annual Salary`) AS Average_Salary
FROM (SELECT * FROM employees WHERE `Job Rate`>2)as Good_workers
GROUP BY Gender;
SELECT Gender, ROUND(AVG(`Monthly Salary`),2) AS Average_Monthly_Salary
FROM(SELECT * FROM employees WHERE `Job Rate` >4) AS Good_workers
GROUP BY Gender;

-- Get the top 5 employees from UAE who earn more than 30k annually
-- Get employees from UAE 
SELECT *
FROM employees
WHERE Country = 'United Arab Emirates';
-- Employees who earn more than 30 k annually
SELECT `First Name`,`Last Name`, `Annual Salary`
FROM employees
WHERE `Annual Salary`>30000;


WITH UAE_Employees AS(
SELECT *
FROM employees
WHERE Gender = 'Male'
)
SELECT `First Name`, `Last Name`, Gender, Country,`Annual Salary`
FROM UAE_Employees
WHERE `Annual Salary`>30000
ORDER  BY `Annual Salary` DESC
LIMIT 5;

-- 
WITH most_paid_employees AS (
    SELECT *
    FROM employees
    WHERE `Monthly Salary` > 2500
)
SELECT `First Name`, `Last Name`, department, country, `Monthly Salary`, `Annual Salary`
FROM most_paid_employees
WHERE `Annual Salary` > 20000
ORDER BY `Annual Salary` DESC;
-- 

WITH Mosted_Spending_employees AS
(
SELECT *
FROM employees
WHERE `Monthly Salary` >1500
)
SELECT `First Name`, `Last Name`, Department, Country, `Annual Salary`
FROM Mosted_Spending_employees
WHERE `Annual Salary` >20000
ORDER BY `Annual Salary` DESC;

-- Get the most experienced (above 5)employees who earn more than 2k a month (top10)
WITH Most_Experience AS(
SELECT *
FROM employees
WHERE Years >=5
)
SELECT `First Name`,`Last Name`, Years,`Monthly Salary`
FROM Most_Experience
WHERE `Monthly Salary` >2000
ORDER BY `Monthly Salary` DESC;


-- Window Functions vs GROUP BY
-- Example with GROUP BY:
SELECT Department,COUNT(*) AS Total_department
FROM employees
GROUP BY Department;

-- Window Functions (New!)
SELECT `First Name`, `Last Name`, Department, `Monthly Salary`,
    COUNT(*) OVER(PARTITION BY Department) AS Total_department
FROM employees
LIMIT 10;
-- 
SELECT Department, `Monthly Salary`, `Annual Salary`,
    COUNT(*) OVER(PARTITION BY Department) AS Total_Department
FROM employees;

SELECT *
FROM employees;

SELECT Center, `Job Rate`, `Overtime Hours`,
    COUNT(*) OVER(PARTITION BY Center) AS total_Center
FROM employees;
    

-- Understanding the Parts: OVER(), PARTITION BY, ORDER BY
-- Average salary per department, shown on every row
SELECT `First Name`, `Last Name`, Department, `Monthly Salary`,
ROUND(AVG(`Monthly Salary`)OVER(PARTITION BY Department),2) AS Average_Department_Salary
FROM employees
WHERE Department IN ('IT', 'Sales')
ORDER BY `Monthly Salary` DESC;

-- ORDER BY (inside OVER)
-- Rank employees by salary in IT department
SELECT `First Name`, `Last Name`, Department, `Monthly Salary`,
ROW_NUMBER() OVER(PARTITION BY Department ORDER BY  `Monthly Salary` DESC) AS Sale_Rank
FROM employees
WHERE Department='IT';

-- RANK()
-- Rank employees by JobRate (performance rating)
SELECT `First Name`, `Last Name`, `Job Rate`,
    RANK() OVER(ORDER BY `Job Rate` DESC) AS Job_Rating_Rank
FROM employees;

-- DENSE_RANK()
-- Rank employees by JobRate using DENSE_RANK
SELECT `First Name`, `Last Name`, Department,`Job Rate`,
    DENSE_RANK() OVER(ORDER BY `Job Rate` DESC) AS Job_Rating_DenseRank
FROM employees;

SELECT `First Name`, `Last Name`, Gender, Department, `Monthly Salary`,
    DENSE_RANK() OVER(ORDER BY `Monthly Salary` DESC) AS Highest_Earner
FROM employees
LIMIT 10;

--  Average salary per department, shown on every row
SELECT `First Name`, `Last Name`, Department, `Monthly Salary`,
    ROUND(AVG(`Monthly Salary`) OVER(PARTITION BY Department, `Monthly Salary`),2) AS Average_Department_Salary
FROM employees
WHERE Department IN('IT','Sales');

-- Show employees with their department salary rank
SELECT `First Name`, `Last Name`, Department, `Monthly Salary`,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY `Monthly Salary` DESC) AS salary_rank
FROM employees;

-- 
SELECT `First Name`, `Last Name`, Department, `Annual Salary`,
    ROW_NUMBER() OVER(PARTITION BY Department ORDER BY `Annual Salary` DESC) AS _Annual_salary_rank
FROM employees;


-- Rank employees by JobRate (performance rating)
SELECT `First Name`, `Last Name`, `Job Rate`,
    RANK() OVER(ORDER BY `Job Rate` DESC) AS Rate_position
FROM employees;

SELECT `First Name`, `Last Name`, `Job Rate`,
    DENSE_RANK() OVER(ORDER BY `Job Rate` DESC) AS Rate_position
FROM employees;







