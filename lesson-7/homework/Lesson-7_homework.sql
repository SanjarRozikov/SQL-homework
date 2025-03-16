--EASY-LEVEL TASKS

--Task 1 
SELECT MIN (Price) as min_price
FROM Products2

--Task 2
SELECT MAX (Salary) as max_salary
FROM Employees 

--Task 3 
SELECT COUNT (*) as count_customer
FROM Customers

--Task 4 
SELECT COUNT(DISTINCT Category) as unique_products
FROM Products

--Task 5
SELECT SUM (SaleAmount) as Total_salary
from Sales

--Task 6 
select AVG (age) as average_age
from Employees

--Task 7 
SELECT DepartmentID, COUNT(*) AS employee_count
FROM Employees
GROUP BY DepartmentID;

--Task 8 
SELECT Category, 
MIN (Price) as min_price,
MAX (Price) as max_price
FROM Products
GROUP BY Category

--Task 9 
Select SaleID,
SUM (SaleAmount) as Total_Sale
from Sales
GROUP BY SaleID

--Task 10 
SELECT DepartmentID, COUNT(*) AS employee_count
FROM Employees
GROUP BY DepartmentID
HAVING COUNT(*) > 5;


--MEDIUM-LEVEL TASKS

--Task 11
SELECT ProductID,
SUM (SaleAmount) as Total_Sales,
AVG ([SaleAmount]) as Average_Sales
from Sales
group by ProductID


--Task 12
SELECT COUNT(EmployeeID) AS employee_count
FROM Employees
--other part was skipped because of no information is found 


--Task 13
SELECT DepartmentID,
MAX (Salary) as Highest_Salary,
MIN (Salary) as Lowest_Salary
from Employees
group by DepartmentID


--Task 14
Select DepartmentID,
AVG (Salary) as Average_Salary
from Employees
group by DepartmentID


--Task 15
select DepartmentID,
AVG (Salary) as Average_Salary,
Count(*) as Count_Employee
from Employees
group by DepartmentID


--Task 16
Select category,
AVG (Price) as Average_Price
from Products
group by Category
Having AVG (Price) > 100


--Task 17
SELECT COUNT(DISTINCT ProductID) as product_count
FROM Sales
Having 'SalesAmount' > '1000'


--Task 18
Select YEAR,
SUM (Sales) as Total_Sales
from Sales
group by YEAR


--Task 19
SELECT TotalAmount, COUNT(DISTINCT customerid) AS customer_count
FROM Orders
GROUP BY TotalAmount;


--Task 20
select * from Employees

Select DepartmentID,
SUM (Salary) as Total_Salary
from Employees
group by DepartmentID
Having SUM (Salary) > 100000


--HARD-LEVEL TASKS


--Task 21
select * from Products
SELECT category,
AVG (price) AS avg_sales
FROM Products
GROUP BY Category
HAVING AVG(Price) > 200;


--Task 22
select EmployeeID,
SUM (Salary) as Total_Salary
from Employees
group by EmployeeID
Having SUM (Salary) > 50000


--Task 23
Select DepartmentID,
SUM (Salary) as Total_Salary,
AVG (Salary) as AVG_Salary
from Employees
group by DepartmentID
Having AVG (Salary) > 60000


--Task 24
SELECT 
    CustomerID, 
    MAX(OrderValue) AS MaxOrderValue, 
    MIN(OrderValue) AS MinOrderValue
FROM Orders
GROUP BY CustomerID
HAVING MAX(OrderValue) >= 50;


--Task 25
SELECT 
    Region, 
    SUM(SalesAmount) AS TotalSales, 
    COUNT(DISTINCT ProductID) AS DistinctProductsSold
FROM Sales
GROUP BY Region
HAVING COUNT(DISTINCT ProductID) > 10;


--Task 26
SELECT 
    p.ProductCategory, 
    p.ProductName, 
    MIN(o.OrderQuantity) AS MinOrderQuantity, 
    MAX(o.OrderQuantity) AS MaxOrderQuantity
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductCategory, p.ProductName;


--Task 27
SELECT * 
FROM (
    SELECT Region, YEAR(SalesDate) AS SalesYear, SalesAmount
    FROM Sales
) AS SourceTable
PIVOT (
    SUM(SalesAmount) 
    FOR SalesYear IN ([2021], [2022], [2023])
) AS PivotTable;

--Task 28
SELECT Year, Quarter, SalesAmount
FROM (
    SELECT Year, Q1, Q2, Q3, Q4 
    FROM Sales
) AS SourceTable
UNPIVOT (
    SalesAmount FOR Quarter IN (Q1, Q2, Q3, Q4)
) AS UnpivotTable;

--Task 29
SELECT p.ProductCategory, p.ProductID, COUNT(o.OrderID) AS OrderCount
FROM Orders o
JOIN Products p ON o.ProductID = p.ProductID
GROUP BY p.ProductCategory, p.ProductID
HAVING COUNT(o.OrderID) > 50;

--Task 30
SELECT EmployeeID, 
       ISNULL(Q1, 0) AS Q1, 
       ISNULL(Q2, 0) AS Q2, 
       ISNULL(Q3, 0) AS Q3, 
       ISNULL(Q4, 0) AS Q4
FROM (
    SELECT EmployeeID, SalesAmount, 
           CASE 
               WHEN Quarter IN (1) THEN 'Q1'
               WHEN Quarter IN (2) THEN 'Q2'
               WHEN Quarter IN (3) THEN 'Q3'
               WHEN Quarter IN (4) THEN 'Q4'
           END AS QuarterName
    FROM EmployeeSales
) AS SourceTable
PIVOT (
    SUM(SalesAmount) FOR QuarterName IN (Q1, Q2, Q3, Q4)
) AS PivotTable;


