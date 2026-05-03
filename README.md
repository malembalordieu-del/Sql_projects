# SQL Projects — Malemba Lordieu

A hands-on SQL learning portfolio covering foundational to advanced querying techniques. Follow the steps below in order — each module builds on the previous one.

---

## How to Get Started

### What You Need

- A SQL client such as [MySQL Workbench](https://www.mysql.com/products/workbench/), [DBeaver](https://dbeaver.io/), or [pgAdmin](https://www.pgadmin.org/)
- Or use a free browser-based tool like [DB Fiddle](https://www.db-fiddle.com/) — no installation needed

### Clone the Repository

```bash
git clone https://github.com/malembalordieu-del/Sql_projects.git
cd Sql_projects
```

---

## Step-by-Step Learning Path

Work through the folders in this order:

---

### Step 1 — Sorting & Filtering in SQL
**Folder:** `Sorting & Filtering in SQL/`

Start here. Learn how to retrieve specific data using conditions and control how results are ordered.

Key concepts: `WHERE`, `ORDER BY`, `LIMIT`, `DISTINCT`

```sql
SELECT name, salary
FROM employees
WHERE department = 'Sales'
ORDER BY salary DESC;
```

---

### Step 2 — Aggregations, GROUP BY, and HAVING
**Folder:** `Aggregations, GROUP BY, and HAVING/`

Learn how to summarise data and filter grouped results.

Key concepts: `SUM`, `COUNT`, `AVG`, `MAX`, `MIN`, `GROUP BY`, `HAVING`

```sql
SELECT department, COUNT(*) AS total_staff, AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 50000;
```

---

### Step 3 — DATE, MATH & STRING Functions
**Folder:** `DATE_MATH_STRING_Function/`

Learn how to manipulate text, numbers, and dates directly in SQL.

Key concepts: `UPPER`, `LOWER`, `ROUND`, `DATEDIFF`, `SUBSTRING`, `NOW()`

```sql
SELECT
  UPPER(first_name) AS name,
  ROUND(salary * 1.1, 2) AS new_salary,
  DATEDIFF(NOW(), hire_date) AS days_employed
FROM employees;
```

---

### Step 4 — STRING, MATH & DATE Functions Assignment
**Folder:** `MALEMBA-ASSIGMENT-STRING,MATH&DATE FUNCTIONS/`

A combined assignment applying all three function types together. Complete this after Step 3.

---

### Step 5 — SQL JOINS & Subqueries
**Folder:** `SQL JOINS & Sub Queries Assignment/`

Learn to pull data from multiple tables and nest queries inside other queries.

Key concepts: `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN`, subqueries

```sql
SELECT o.order_id, c.customer_name, o.total_amount
FROM orders o
INNER JOIN customers c ON o.customer_id = c.id
WHERE o.total_amount > (SELECT AVG(total_amount) FROM orders);
```

---

### Step 6 — CTEs & Window Functions
**Folder:** `CTEs & Window Functions in SQL/`

The most advanced module. Learn to write clean, readable complex queries and perform calculations across rows.

Key concepts: `WITH` (CTEs), `ROW_NUMBER()`, `RANK()`, `PARTITION BY`, `LAG()`, `LEAD()`

```sql
WITH ranked_sales AS (
  SELECT
    salesperson,
    total_sales,
    RANK() OVER (ORDER BY total_sales DESC) AS sales_rank
  FROM sales
)
SELECT * FROM ranked_sales WHERE sales_rank <= 5;
```

---

### Step 7 — Full Project Assignment
**Folder:** `Malemba Full Project Assignment in SQL/`

The capstone project. This brings together everything from all previous steps into a complete, real-world SQL analysis.

---

## Tips for Working Through This

- Open each folder and read any notes or comments inside the `.sql` files before running them
- Run scripts one query at a time to understand each result
- Try modifying values, conditions, and column names to test your understanding
- Each `sales/` or `sql/` subfolder contains the sample data needed to run that module's queries

---

## Author

**Malemba Lordieu**
[GitHub Profile](https://github.com/malembalordieu-del)
