--EASY LEVEL TASKS

--Task 1. Write a query to perform an INNER JOIN between Orders and Customers using AND in the ON clause to filter orders placed after 2022
--select * from Orders
--select * from Customers

SELECT 
o.OrderID,
o.OrderDate,
c.City,
c.Country
FROM [Lesson9_homework].[dbo].[Orders] o 
INNER JOIN [Lesson9_homework].[dbo].[Customers] c
ON o.CustomerID = c.CustomerID
AND YEAR (o.OrderDate) > 2022

--Task 2. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department.
select * from Employees
select * from Departments

SELECT 
d.DepartmentID,
d.DepartmentName,
e.Name,
e.Salary
FROM [Lesson9_homework].[dbo].[Employees] e
JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID 
AND (d.DepartmentName = 'Sales' OR d.DepartmentName ='Marketing');

--Task 3. Write a query to demonstrate a CROSS APPLY between Departments and a derived table that shows their Employees, top-performing employee (e.g., top 1 Employee who gets the most salary).
--select * from Departments
--select * from Employees

SELECT * from Departments d
CROSS APPLY
(SELECT TOP 1
EmployeeID,
Salary
FROM Employees e
WHERE e.DepartmentID=d.DepartmentID
ORDER BY Salary DESC) e

--Task 4. Write a query to join Customers and Orders using AND in the ON clause to filter customers who have placed orders in 2023 and who lives in the USA.
--select * from Customers
--select * from Orders

SELECT 
c.CustomerID,
c.Country,
o.OrderDate
FROM [Lesson9_homework].[dbo].[Customers] c
INNER JOIN [Lesson9_homework].[dbo].[Orders] o
ON c.CustomerID = o.CustomerID
AND YEAR (o.OrderDate) = 2023 AND c.Country = 'USA';

--Task 5. Write a query to join a derived table (SELECT CustomerID, COUNT(*) FROM Orders GROUP BY CustomerID) with the Customers table to show the number of orders per customer.
--select * from Orders
--select * from Customers

SELECT 
    c.CustomerID,
    c.FirstName,
    o.OrderCount
FROM [lesson9_homework].[dbo].[Customers] c
JOIN 
(
    SELECT CustomerID, COUNT(*) AS OrderCount
    FROM [lesson9_homework].[dbo].[Orders]
    GROUP BY CustomerID
) o 
ON c.CustomerID = o.CustomerID
AND o.OrderCount > 0;

--Task 6. Write a query to join Products and Suppliers using OR in the ON clause to show products supplied by either 'Gadget Supplies' or 'Clothing Mart'.
--select * from Products
--select * from Suppliers

SELECT 
p.ProductID,
p.ProductName,
p.Price,
s.SupplierName,
s.ContactName
FROM [Lesson9_homework].[dbo].[Products] p
INNER JOIN [Lesson9_homework].[dbo].[Suppliers] s
ON p.SupplierID = s.SupplierID
AND (s.SupplierName = 'Gadget Supplies' OR s.SupplierName = 'Clothing Mart');

--Task 7. Write a query to demonstrate the use of OUTER APPLY between Customers and a derived table that returns each Customers''s most recent order.
--select * from Orders
--select * from Customers

SELECT 
    c.CustomerID,
    c.FirstName,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM [lesson9_homework].[dbo].[Customers] c
OUTER APPLY 
(
    SELECT TOP 1 OrderID, OrderDate, TotalAmount
    FROM [lesson9_homework].[dbo].[Orders] o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY o.OrderDate DESC
) AS o;

--MEDIUM-LEVEL TASKS

--Task 8. Write a query that uses the AND logical operator in the ON clause to join Orders and Customers, and filter customers who placed an order with a total amount greater than 500.
--select * from Orders
--select * from Customers

SELECT 
o.OrderID,
o.TotalAmount,
c.City,
c.Country
FROM [Lesson9_homework].[dbo].[Orders] o
INNER JOIN [Lesson9_homework].[dbo].[Customers] c
ON o.CustomerID = c.CustomerID 
AND o.TotalAmount > 500

--Task 9. Write a query that uses the OR logical operator in the ON clause to join Products and Sales to filter products that were either sold in 2022 or the SaleAmount is more than 400.
--select * from Products
--select * from Sales

SELECT 
p.ProductID,
p.ProductName, 
p.Price,
s.SaleDate,
s.SaleAmount 
FROM [Lesson9_homework].[dbo].[Products] p
INNER JOIN [Lesson9_homework].[dbo].[Sales] s
ON p.ProductID = s.ProductID
AND (YEAR(s.SaleDate) = 2022 OR s.SaleAmount > 400);

--Task 10. Write a query to join a derived table that calculates the total sales (SELECT ProductID, SUM(Amount) FROM Sales GROUP BY ProductID) with the Products table to show total sales for each product.
--select * from Sales
--select * from Products

SELECT 
    p.ProductID,
    COALESCE(s.TotalSales, null) AS TotalSales
FROM [lesson9_homework].[dbo].[Products] p
JOIN 
(
    SELECT 
	ProductID, 
	SUM(SaleAmount) AS TotalSales
    FROM [lesson9_homework].[dbo].[Sales]
    GROUP BY ProductID
) s 
ON p.ProductID = s.ProductID 
AND s.TotalSales > 0;

--Task 11. Write a query to join Employees and Departments using AND in the ON clause to filter employees who belong to the 'HR' department and whose salary is greater than 50000.
--select * from Employees
--select * from Departments

SELECT 
e.EmployeeID,
e.Name,
e.Salary,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
INNER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID 
AND d.DepartmentName = 'Human Resources' 
AND e.Salary > 50000;


--Task 12. Write a query to use OUTER APPLY to return all customers along with their most recent orders, including customers who have not placed any orders.
--select * from Customers
--select * from Orders

SELECT 
    c.CustomerID,
    o.OrderID,
    o.OrderDate,
    o.TotalAmount
FROM [lesson9_homework].[dbo].[Customers] c
OUTER APPLY 
(
    SELECT TOP 1 OrderID, OrderDate, TotalAmount
    FROM [lesson9_homework].[dbo].[Orders] o
    WHERE o.CustomerID = c.CustomerID
    ORDER BY o.OrderDate DESC
) AS o;


--Task 13. Write a query to join Products and Sales using AND in the ON clause to filter products that were sold in 2023 and StockQuantity is more than 50.
--select * from Products
--select * from Sales

SELECT 
p.ProductName,
p.Price,
p.StockQuantity,
s.CustomerID,
s.SaleDate as SOLD,
s.SaleAmount
FROM [Lesson9_homework].[dbo].[Products] p
INNER JOIN [Lesson9_homework].[dbo].[Sales] s
ON p.ProductID = s.ProductID
AND YEAR(s.SaleDate) = 2023
AND p.StockQuantity > 50;


--Task 14. Write a query to join Employees and Departments using OR in the ON clause to show employees who either belong to the 'Sales' department or hired after 2020.
--select * from Employees
--select * from Departments

SELECT 
e.EmployeeID,
e.Salary,
e.HireDate as HIRED,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
INNER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Sales' OR YEAR (e.HireDate) > 2020);

--Task 15. Write a query to demonstrate the use of the AND logical operator in the ON clause between Orders and Customers, and filter orders made by customers who are located in 'USA' and lives in an address that starts with 4 digits.
--select * from Orders
--select * from Customers

SELECT 
o.OrderID,
c.Address,
c.Country
FROM [Lesson9_homework].[dbo].[Orders] o
INNER JOIN [Lesson9_homework].[dbo].[Customers] c
ON o.CustomerID = c.CustomerID 
AND c.Country = 'USA'
AND c.Address LIKE '[0-9][0-9][0-9][0-9]%'

--Task 16. Write a query to demonstrate the use of OR in the ON clause when joining Products and Sales to show products that are either part of the 'Electronics' category or Sale amount is greater than 350.
--select * from Products
--select * from Categories
--select * from Sales

SELECT 
    p.ProductName,
    p.ProductId,
    p.Category,
    c.CategoryName,
    s.SaleAmount
FROM [lesson9_homework].[dbo].[Products] p
INNER JOIN [lesson9_homework].[dbo].[Categories] c 
    ON p.Category = c.CategoryID
INNER JOIN [lesson9_homework].[dbo].[Sales] s 
    ON p.ProductID = s.ProductID
	AND (c.CategoryName = 'Electronics' OR s.SaleAmount > 350);


--Task 17. Write a query to join a derived table that returns a count of products per category (SELECT CategoryID, COUNT(*) FROM Products GROUP BY CategoryID) with the Categories table to show the count of products in each category.
--select * from Products
--select * from Categories

SELECT 
    c.CategoryID,
    c.CategoryName,
    p.ProductCount
FROM [lesson9_homework].[dbo].[Categories] c
JOIN 
    (SELECT Category, COUNT(*) AS ProductCount 
     FROM [lesson9_homework].[dbo].[Products] 
     GROUP BY Category) p
ON c.CategoryID = p.Category;

--Task 18. Write a query to join Orders and Customers using AND in the ON clause to show orders where the customer is from 'Los Angeles' and the order amount is greater than 300.
--select * from Orders
--select * from Customers

SELECT 
o.OrderID,
o.TotalAmount,
c.CustomerID,
c.City
FROM [Lesson9_homework].[dbo].[Orders] o
INNER JOIN [Lesson9_homework].[dbo].[Customers] c
ON o.CustomerID = c.CustomerID 
AND c.City = 'Los Angeles'
AND o.TotalAmount > 300;

--Task 19. Write a query to join Employees and Departments using a complex OR condition in the ON clause to show employees who are in the 'HR' or 'Finance' department, or have at least 4 wowels in their name.
--select * from Employees
--select * from Departments

SELECT 
e.EmployeeID,
e.Name,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
INNER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Human Resources' OR d.DepartmentName = 'Finance');

--Task 20. Write a query to join Sales and Products using AND in the ON clause to filter products that have both a sales quantity greater than 100 and a price above 500.
--select * from Sales
--select * from Products

SELECT
s.SaleID,
s.SaleAmount as SalesQuantity,
p.ProductName,
p.Price
FROM [Lesson9_homework].[dbo].[Sales] s
INNER JOIN [Lesson9_homework].[dbo].[Products] p
ON s.ProductID = p.ProductID 
AND s.SaleAmount > 100
AND p.Price > 500;

--Task 21. Write a query to join Employees and Departments using OR in the ON clause to show employees in either the 'Sales' or 'Marketing' department, and with a salary greater than 60000.
--select * from Employees
--select * from Departments

SELECT 
e.EmployeeID,
e.Salary,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
INNER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID
AND (d.DepartmentName = 'Sales' OR d.DepartmentName = 'Marketing')
AND e.Salary > 60000;

