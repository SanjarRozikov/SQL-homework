-- HOMEWORK 9
--EASY-LEVEL TASK

--Task 1. Write a query to join Employees and Departments using an INNER JOIN, and apply a WHERE clause to show only employees whose salary is greater than 5000.

SELECT 
    e.EmployeeID,
    e.Name,
    e.Salary,
    d.DepartmentID,
    d.DepartmentName
FROM [lesson9_homework].[dbo].[Employees] e
INNER JOIN [lesson9_homework].[dbo].[Departments] d 
    ON e.departmentid = d.departmentid
WHERE e.Salary > 5000;

--Task 2.Write a query to join Customers and Orders using an INNER JOIN, and apply the WHERE clause to return only orders placed in 2023.

select 
c.FirstName,
c.LastName,
c.city,
o.ProductID,
o.TotalAmount,
o.OrderDate,
c.CustomerID as CustomerCustomerID ,
o.CustomerID as OrdersCustomerID
from [lesson9_homework].[dbo].[Customers] c
INNER JOIN [lesson9_homework].[dbo].[Orders] o 
ON c.CustomerID = o.CustomerID
where YEAR (OrderDate) = 2023 

--Task 3.Write a query to demonstrate a LEFT OUTER JOIN between Employees and Departments, showing all employees and their respective departments (including employees without departments).

select * from Employees e 
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID

--Task 4. Write a query to perform a RIGHT OUTER JOIN between Products and Suppliers, showing all suppliers and the products they supply (including suppliers without products).

Select * from Products p
RIGHT JOIN Suppliers s ON p.SupplierID = s.SupplierID 

--Task 5.Write a query to demonstrate a FULL OUTER JOIN between Orders and Payments, showing all orders and their corresponding payments (including orders without payments and payments without orders).

select * from Orders o 
FULL JOIN Payments p ON o.OrderID = p.OrderID

--Task 6. Write a query to perform a SELF JOIN on the Employees table to display employees and their respective managers (showing EmployeeName and ManagerName).

--Select * from employees

SELECT 
    e.EmployeeID,
    e.Name AS EmployeeName,
    m.EmployeeID AS ManagerID,
    m.Name AS ManagerName
FROM [lesson9_homework].[dbo].[Employees] e
JOIN [lesson9_homework].[dbo].[Employees] m 
    ON e.ManagerID = m.EmployeeID;

--Task 7.Write a query to join Students and Courses using INNER JOIN, and use the WHERE clause to show only students enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)
	
	--Select * from Students
	--Select * from Enrollments
	--select * from Courses
	

select
s.StudentID,
s.Name,
s.Age,
s.Major,
c.CourseName,
c.Instructor
from Students s
JOIN Enrollments sc on s.StudentID = sc.StudentID
JOIN Courses c on c.CourseID = sc.CourseID
where CourseName = 'Math 101'

--Task 8. Write a query that uses INNER JOIN between Customers and Orders, and filters the result with a WHERE clause to show customers who have placed more than 3 items at once.

--Select * from Customers
--Select * from Orders

select 
c.City,
c.State,
c.Country,
o.Orderdate,
o.TotalAmount,
o.Quantity,
c.CustomerID as CustomersCustomerID,
o.CustomerID as OrdersCustomerID
from [Lesson9_homework].[dbo].[Customers] c
INNER JOIN [Lesson9_homework].[dbo].[Orders] o
ON c.CustomerID = o.CustomerID
where Quantity > 3

--Task 9.Write a query to join Employees and Departments using a LEFT OUTER JOIN and use the WHERE clause to filter employees in the 'HR' department(Human Resources).

--Select * from Employees
--Select * from Departments

SELECT 
    e.EmployeeID,
    e.Name,
    e.Salary,
    d.DepartmentID,
    d.DepartmentName
FROM [lesson9_homework].[dbo].[Employees] e
LEFT JOIN [lesson9_homework].[dbo].[Departments] d 
    ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName = 'Human Resources';


--MEDIUM-LEVEL TASKS

--Task 10. Write a query to perform an INNER JOIN between Employees and Departments, and use the HAVING clause to show employees who belong to departments with more than 10 employees

--select * from Departments
--select * from Employees

SELECT 
    d.DepartmentID,
    d.DepartmentName,
    COUNT(e.EmployeeID) AS EmployeeCount
FROM [lesson9_homework].[dbo].[Employees] e
INNER JOIN [lesson9_homework].[dbo].[Departments] d 
    ON e.DepartmentID = d.DepartmentID
GROUP BY d.DepartmentID, d.DepartmentName
HAVING COUNT(e.EmployeeID) > 10;

--Task 11. Write a query to perform a LEFT OUTER JOIN between Products and Sales, and use the WHERE clause to filter only products with no sales.

--select * from Products
--select * from Sales

SELECT 
    p.ProductID,
    p.ProductName,
    p.Price
FROM [lesson9_homework].[dbo].[Products] p
LEFT JOIN [lesson9_homework].[dbo].[Sales] s 
    ON p.ProductID = s.ProductID
WHERE s.SaleID IS NULL;

--Task 12. Write a query to perform a RIGHT OUTER JOIN between Customers and Orders, and filter the result using the HAVING clause to show only customers who have placed at least one order

--select * from Customers
--select * from Orders

select 
c.CustomerID,
c.Country,
COUNT (o.OrderID) as Orders
FROM [lesson9_homework].[dbo].[Customers] c
RIGHT JOIN [lesson9_homework].[dbo].[Orders] o 
    ON c.CustomerID = o.CustomerID
GROUP BY c.CustomerID, c.Country
HAVING COUNT(o.OrderID) >= 1;

--Task 13. Write a query that uses a FULL OUTER JOIN between Employees and Departments, and filters out the results where the department is NULL.

--select * from Employees
--select * from Departments

select
e.EmployeeID,
e.Name,
e.Salary
from [Lesson9_homework].[dbo].[Employees] e
FULL OUTER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID is null

-- Task 14. Write a query to perform a SELF JOIN on the Employees table to show employees who report to the same manager.

--select * from Employees

select 
a.*, 
b.Name as [ManagerName] 
from Employees a
join Employees b 
ON a.ManagerID = b.EmployeeID
AND a.EmployeeID <> b.EmployeeID
WHERE a.ManagerID IS NOT NULL;

--Task 15. Write a query to perform a LEFT OUTER JOIN between Orders and Customers, followed by a WHERE clause to filter orders placed in the year 2022

--select * from Orders
--select * from Customers

select 
c.FirstName,
c.LastName,
c.city,
o.ProductID,
o.TotalAmount,
o.OrderDate,
c.CustomerID as CustomerCustomerID ,
o.CustomerID as OrdersCustomerID
from [lesson9_homework].[dbo].[Customers] c
INNER JOIN [lesson9_homework].[dbo].[Orders] o 
ON c.CustomerID = o.CustomerID
where YEAR (OrderDate) = 2022

--Task 16. Write a query to use the ON clause with INNER JOIN to return only the employees from the 'Sales' department whose salary is greater than 50000.

--select * from Employees
--select * from Departments

SELECT 
    e.EmployeeID,
    e.Name,
    e.Salary,
    d.DepartmentID,
    d.DepartmentName
FROM [lesson9_homework].[dbo].[Employees] e
INNER JOIN [lesson9_homework].[dbo].[Departments] d 
    ON e.departmentid = d.departmentid
WHERE e.Salary > 5000;

--Task 17. Write a query to join Employees and Departments using INNER JOIN, and use WHERE to filter employees whose department''s DepartmentName is 'IT'

--select * from Employees
--select * from Departments

SELECT 
	e.EmployeeID,
    e.Name,
    e.Salary,
    d.DepartmentID,
    d.DepartmentName
FROM [lesson9_homework].[dbo].[Employees] e
INNER JOIN [lesson9_homework].[dbo].[Departments] d 
    ON e.departmentid = d.departmentid
WHERE d.DepartmentName = 'IT';

--Task 18. Write a query to join Orders and Payments using a FULL OUTER JOIN, and use the WHERE clause to show only the orders that have corresponding payments

--select * from Orders
--select * from Payments

SELECT
p.PaymentID,
p.Amount,
p.PaymentMethod,
o.CustomerID,
o.OrderID,
o.ProductID
FROM [Lesson9_homework].[dbo].[Orders] o
FULL OUTER JOIN [Lesson9_homework].[dbo].[Payments] p
ON o.OrderID = p.OrderID
WHERE p.OrderID IS NOT NULL

--Task 19. Write a query to perform a LEFT OUTER JOIN between Products and Orders, and use the WHERE clause to show products that have no orders

--select * from Products
--select * from Orders

SELECT 
p.ProductID,
p.ProductName,
p.Price,
o.OrderID,
o.CustomerID,
o.ProductID,
o.TotalAmount
FROM [Lesson9_homework].[dbo].[Products] p
LEFT OUTER JOIN [Lesson9_homework].[dbo].[Orders] o
ON p.ProductID = o.ProductID
WHERE o.OrderID IS NULL

-- HARD-LEVEL TASKS

-- Task 20. Write a query using a JOIN between Employees and Departments, followed by a WHERE clause to show employees whose salary is higher than the average salary of all employees.

--select * from Employees
--select * from Departments

SELECT
e.EmployeeID,
e.Salary,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID 
WHERE e.Salary > (SELECT AVG(Salary) FROM [lesson9_homework].[dbo].[Employees]);

--Task 21. Write a query to perform a LEFT OUTER JOIN between Orders and Payments, and use the WHERE clause to return all orders placed before 2020 that have not been paid yet.

--select * from Orders
--select * from Payments

SELECT 
o.OrderID,
o.OrderDate,
o.TotalAmount,
p.PaymentID,
p.PaymentDate
FROM [Lesson9_homework].[dbo].[Orders] o
LEFT OUTER JOIN [Lesson9_homework].[dbo].[Payments] p
ON o.OrderID = p.OrderID 
WHERE o.OrderDate < '2020-01-01' 
      AND p.PaymentID IS NULL;

--Task 22. Write a query to perform a FULL OUTER JOIN between Products and Categories, and use the WHERE clause to filter only products that have no category assigned.

--select * from Products
--select * from Categories

SELECT
p.ProductID,
p.ProductName,
p.Price,
c.CategoryID,
c.CategoryName
FROM [Lesson9_homework].[dbo].[Products] p
FULL OUTER JOIN [Lesson9_homework].[dbo].[Categories] c
ON p.Category = c.CategoryID
WHERE c.CategoryID IS NULL

--Task 23. Write a query to perform a SELF JOIN on the Employees table to find employees who report to the same manager and earn more than 5000.

--select * from Employees

select 
a.*, 
b.Name as [ManagerName] 
from Employees a
join Employees b 
ON a.ManagerID = b.EmployeeID
WHERE a.Salary > 5000
      AND b.Salary > 5000
      AND a.ManagerID IS NOT NULL;

--Task 24. Write a query to join Employees and Departments using a RIGHT OUTER JOIN, and use the WHERE clause to show employees from departments where the department name starts with ‘M’.

--select * from Employees
--select * from Departments

SELECT 
e.EmployeeID,
e.Name,
d.DepartmentID,
d.DepartmentName
FROM [Lesson9_homework].[dbo].[Employees] e
RIGHT OUTER JOIN [Lesson9_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentName LIKE 'M%';

--Task 25.Write a query to join Products and Sales, and use WHERE to filter only sales greater than 1000.

--select * from Products
--select * from Sales

SELECT 
p.ProductID,
p.ProductName,
p.Price,
s.SaleAmount as Sales
FROM [Lesson9_homework].[dbo].[Products] p
JOIN [Lesson9_homework].[dbo].[Sales] s
ON p.ProductID = s.ProductID
WHERE  s.SaleAmount > 1000

--Task 26. Write a query to perform a LEFT OUTER JOIN between Students and Courses, and use the WHERE clause to show only students who have not enrolled in 'Math 101'.(USE ENROLLMENTS TABLE AS A BRIDGE TABLE)


	--select * from Students
	--select * from Enrollments
	--select * from Courses
	
select
s.StudentID,
s.Name,
s.Age,
s.Major,
c.CourseName,
c.Instructor
from Students s
LEFT OUTER JOIN Enrollments sc on s.StudentID = sc.StudentID
LEFT OUTER JOIN Courses c on c.CourseID = sc.CourseID
WHERE c.CourseName != 'Math 101'

--Task 27. Write a query using a FULL OUTER JOIN between Orders and Payments, followed by a WHERE clause to filter out the orders with no payment.

--select * from Orders
--select * from Payments

SELECT 
p.PaymentID,
p.PaymentDate,
p.Amount,
p.PaymentMethod,
o.OrderID,
o.ProductID
FROM [Lesson9_homework].[dbo].[Orders] o
FULL OUTER JOIN [Lesson9_homework].[dbo].[Payments] p
ON o.OrderID = p.OrderID 
WHERE p.PaymentID IS NOT NULL

--Task 28.Write a query to join Products and Categories using an INNER JOIN, and use the WHERE clause to filter products that belong to either 'Electronics' or 'Furniture'.

--select * from Products
--select * from Categories

SELECT 
p.ProductName,
p.Price,
c.CategoryName
FROM [Lesson9_homework].[dbo].[Products] p
JOIN [Lesson9_homework].[dbo].[Categories] c
ON p.Category = c.CategoryID
WHERE c.CategoryName = 'Electronics' OR c.CategoryName = 'Furniture'


