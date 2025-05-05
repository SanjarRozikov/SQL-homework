--Easy Tasks

--1. Create a numbers table using a recursive query from 1 to 1000.
;WITH CTE AS 
(
    SELECT 1 AS number
    UNION ALL
    SELECT number + 1
    FROM Numbers1
    WHERE number < 1000
)
SELECT * FROM CTE;

--2. Write a query to find the total sales per employee using a derived table.(Sales, Employees)
select * from Sales
select * from Employees


SELECT s.ProductID, s.SalesAmount,s.SaleDate
FROM Sales s
INNER JOIN
(
SELECT 
	EmployeeID,
	DepartmentID,
	SUM(SALARY) AS TOTAL_SALES
FROM Employees
GROUP BY EmployeeID,DepartmentID
) AS d
ON s.EmployeeID = d.EmployeeID

--3. Create a CTE to find the average salary of employees.(Employees)
;WITH CTE AS 
(
SELECT 
	EmployeeID,
	AVG(Salary) as AVG_SALARY
FROM Employees
GROUP BY EmployeeID
)
SELECT AVG_SALARY FROM CTE

--4. Write a query using a derived table to find the highest sales for each product.(Sales, Products)
SELECT p.ProductID, p.productname, s.max_sales
FROM Products p
JOIN (
    SELECT ProductID, MAX(SalesAmount) AS max_sales
    FROM Sales
    GROUP BY productid
) s ON p.productid = s.productid;

--5. Beginning at 1, write a statement to double the number for each record, 
--the max value you get should be less than 1000000.

;WITH CTE AS (
    SELECT 1 AS num
    UNION ALL
    SELECT num * 2
    FROM CTE
    WHERE num * 2 < 1000000
)
SELECT * FROM CTE;

--6.Use a CTE to get the names of employees who have made more than 5 sales.(Sales, Employees)
;WITH CTE AS (
SELECT p.ProductID, p.productname, s.CNT
FROM Products p
JOIN (
    SELECT ProductID, COUNT(*) AS CNT
    FROM Sales
    GROUP BY productid
) s ON p.productid = s.productid
 )
 SELECT * FROM CTE
 WHERE ProductID > 5 

 --7. Write a query using a CTE to find all products with sales greater than $500.(Sales, Products)
SELECT * FROM Sales
SELECT * FROM Products

;WITH CTE AS 
(
SELECT 
	s.SalesID,
	s.SalesAmount,
	p.ProductName,
	p.Price
FROM Sales AS s 
INNER JOIN Products AS p
ON s.ProductID = p.ProductID
WHERE p.Price > 500
)
SELECT * FROM CTE

;WITH ProductSales AS (
    SELECT 
        s.productid, 
        SUM(s.SalesAmount) AS total_sales
    FROM Sales s
    GROUP BY s.productid
)
SELECT 
    p.productid, 
    p.productname, 
    ps.total_sales
FROM ProductSales ps
JOIN Products p ON p.productid = ps.productid
WHERE ps.total_sales > 500;

--8. Create a CTE to find employees with salaries above the average salary.(Employees)
SELECT * FROM Employees

;WITH CTE AS 
(
SELECT 
	AVG(Salary) AS AVG_SALARY
FROM Employees
) 
SELECT * FROM Employees
WHERE SALARY > (SELECT AVG_SALARY FROM CTE)


--Medium Tasks

--1. Write a query using a derived table to find the top 5 employees by the number of orders made.(Employees, Sales)
SELECT TOP 5
	e.EmployeeID, 
	o.total_orders
FROM Employees e
JOIN (
    SELECT employeeid, COUNT(*) AS total_orders
    FROM Sales
    GROUP BY employeeid
) AS o ON e.EmployeeID = o.employeeid
ORDER BY o.total_orders DESC

--2.Write a query using a derived table to find the sales per product category.(Sales, Products)
SELECT 
    p.categoryid,
    SUM(Price) AS total_sales_per_category
FROM Products p
JOIN (
    SELECT productid, SUM(SalesAmount) AS total_sales
    FROM Sales
    GROUP BY productid
) AS s ON p.productid = s.productid
GROUP BY p.categoryid;

--3. Write a script to return the factorial of each value next to it.(Numbers1)
;WITH Factorials AS (
    SELECT number, 1 AS factorial, 1 AS step
    FROM Numbers1

    UNION ALL

    SELECT f.number, f.factorial * f.step AS factorial, f.step + 1
    FROM Factorials f
    WHERE f.step < f.number
)
SELECT number, MAX(factorial) AS factorial
FROM Factorials
GROUP BY number
ORDER BY number;

--4. This script uses recursion to split a string into rows of substrings for each character in the string.(Example)
;WITH  SplitString AS (
    SELECT 
        1 AS pos,
        SUBSTRING('HELLO', 1, 1) AS char
    UNION ALL
    SELECT 
        pos + 1,
        SUBSTRING('HELLO', pos + 1, 1)
    FROM SplitString
    WHERE pos < LEN('HELLO')  
)
SELECT pos, char
FROM SplitString;

--5. Use a CTE to calculate the sales difference between the current month and the previous month.(Sales)
;WITH MonthlySales AS (
    SELECT 
        CAST(YEAR(saledate) AS VARCHAR(4)) + '-' + RIGHT('0' + CAST(MONTH(saledate) AS VARCHAR(2)), 2) AS sale_month,
        SUM(SalesAmount) AS total_sales
    FROM Sales
    GROUP BY YEAR(saledate), MONTH(saledate)
),
SalesWithDifference AS (
    SELECT 
        sale_month,
        total_sales,
        LAG(total_sales) OVER (ORDER BY sale_month) AS previous_month_sales
    FROM MonthlySales
)
SELECT 
    sale_month,
    total_sales,
    previous_month_sales,
    total_sales - ISNULL(previous_month_sales, 0) AS sales_difference
FROM SalesWithDifference
ORDER BY sale_month;

--6. Create a derived table to find employees with sales over $45000 in each quarter.(Sales, Employees)

SELECT 
    e.EmployeeID AS employee_id,
    e.FirstName,
    qtr_sales.quarter,
    qtr_sales.total_sales
FROM Employees e
JOIN (
    SELECT 
        employeeid,
        CONCAT(YEAR(saledate), '-Q', DATEPART(QUARTER, saledate)) AS quarter,
        SUM(SalesAmount) AS total_sales
    FROM Sales
    GROUP BY employeeid, YEAR(saledate), DATEPART(QUARTER, saledate)
    HAVING SUM(SalesAmount) > 45000
) AS qtr_sales
ON e.EmployeeID = qtr_sales.employeeid
ORDER BY employee_id, quarter;


--Difficult tasks

--1. This script uses recursion to calculate Fibonacci numbers
;WITH Fibonacci AS (
    SELECT 1 AS n, 0 AS fib1, 1 AS fib2
    UNION ALL
    SELECT n + 1, fib2, fib1 + fib2
    FROM Fibonacci
    WHERE n < 20
)
SELECT n, fib1 AS fibonacci
FROM Fibonacci;

--2. Find a string where all characters are the same and the length is greater than 1.(FindSameCharacters)
SELECT *
FROM FindSameCharacters
WHERE LEN(Vals) > 1
  AND Vals = REPLICATE(LEFT(Vals, 1), LEN(Vals));

--3. Create a numbers table that shows all numbers 1 through n and their order gradually increasing by the next number in the sequence.(Example:n=5 | 1, 12, 123, 1234, 12345)
DECLARE @n INT = 5;

;WITH Numbers AS (
    SELECT 1 AS num, CAST('1' AS VARCHAR(MAX)) AS sequence
    UNION ALL
    SELECT num + 1, sequence + CAST(num + 1 AS VARCHAR)
    FROM Numbers
    WHERE num + 1 <= @n
)
SELECT sequence
FROM Numbers;

--4. Write a query using a derived table to find the employees who have made the most sales in the last 6 months.(Employees,Sales)
SELECT 
    e.EmployeeID AS employee_id,
    e.FirstName,
    sales_by_employee.total_sales
FROM Employees e
JOIN (
    SELECT 
        employeeid,
        SUM(SalesAmount) AS total_sales
    FROM Sales
    WHERE saledate >= DATEADD(MONTH, -6, GETDATE())  
    GROUP BY employeeid
) AS sales_by_employee
ON e.EmployeeID = sales_by_employee.employeeid
ORDER BY sales_by_employee.total_sales DESC
LIMIT 1; 

--5. Write a T-SQL query to remove the duplicate integer values present in the string column. Additionally, remove the single integer character that appears in the string.(RemoveDuplicateIntsFromNames)

;WITH CleanedStrings AS (
    SELECT 
        id,
        name,
    
        REPLACE(name, '1', '') AS cleaned_name 
    FROM RemoveDuplicateIntsFromNames
    WHERE name LIKE '%1%'  1'
)
SELECT * FROM CleanedStrings;


