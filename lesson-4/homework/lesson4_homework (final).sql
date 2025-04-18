--EASY-LEVEL TASKS

--1. Write a query to select the top 5 employees from the Employees table.
select Top 5 * from Employees

--2. Use SELECT DISTINCT to select unique ProductName values from the Products table.
select distinct ProductName 
from Products

--3. Write a query that filters the Products table to show products with Price > 100.
select * from Products
where Price > 100

--4. Write a query to select all CustomerName values that start with 'A' using the LIKE operator.
select 
CONCAT(FirstName, ' ', LastName) AS CustomerName 
from Customers
where CONCAT(FirstName, ' ', LastName) like 'A%'

--5. Order the results of a Products query by Price in ascending order.
select Price from Products
order by Price asc

--6. Write a query that uses the WHERE clause to filter for employees with Salary >= 60000 and Department = 'HR'.
select  salary, DepartmentName
from Employees
where Salary >= 60000 and DepartmentName = 'HR'

--7. Use ISNULL to replace NULL values in the Email column with the text "noemail@example.com".From Employees table
select isnull (email,'noemail@example.com') as email
from Employees

--8. Write a query that shows all products with Price BETWEEN 50 AND 100.
select ProductName, Category,Price
from Products
where Price between 50 and 100

--9. Use SELECT DISTINCT on two columns (Category and ProductName) in the Products table.
select distinct Category, ProductName
from Products

--10. After SELECT DISTINCT on two columns (Category and ProductName) Order the results by ProductName in descending order.
select distinct Category, ProductName
from Products
order by ProductName desc

--MEDIUM-LEVEL TASKS


--11.Write a query to select the top 10 products from the Products table, ordered by Price DESC.
select top 10 * from Products
order by Price desc

--12. Use COALESCE to return the first non-NULL value from FirstName or LastName in the Employees table.

select coalesce (Lastname, null) as non_null
 from Employees

--13. Write a query that selects distinct Category and Price from the Products table.
select distinct Category, Price
from Products

--14. Write a query that filters the Employees table to show employees 
--    whose Age is either between 30 and 40 or Department = 'Marketing'.

select EmployeeID,Age,DepartmentName
from Employees
where age between 30 and 40 or DepartmentName = 'Marketing'

--15. Use OFFSET-FETCH to select rows 11 to 20 from the Employees table, ordered by Salary DESC.

select DepartmentName, Salary, Age, Country
from Employees
order by Salary 
offset 11 rows fetch next 20 rows only 

--16. Write a query to display all products with Price <= 1000 and Stock > 50, 
--    sorted by Stock in ascending order.

select * from Products
where Price <= 1000 and StockQuantity >50
order by StockQuantity asc

--17. Write a query that filters the Products table for 
--    ProductName values containing the letter 'e' using LIKE.

select ProductName
from Products
WHERE ProductName LIKE '%e%';

--18. Use IN operator to filter for employees who work in either 'HR', 'IT', or 'Finance'.
select * from Employees
where DepartmentName in ('HR', 'IT', 'Finance')

--19. Use ORDER BY to display a list of customers ordered by City 
--    in ascending and PostalCode in descending order.Use customers table

select city,PostalCode
from Customers
order by 
city asc, 
PostalCode desc

--HARD-LEVEL TASKS

--20. Write a query that selects the top 10 products with the highest sales, 
--    using TOP(10) and ordered by SalesAmount DESC.

SELECT TOP 10 
    SaleAmount AS Highest_Sales
FROM Sales
ORDER BY SaleAmount DESC;

--21. Combine FirstName and LastName into one column named FullName in the Employees table. (only in select statement)

SELECT 
    FirstName + ' ' + LastName AS FullName
FROM Employees;

--22. Write a query to select the distinct Category, ProductName, and Price 
--    for products that are priced above $50, using DISTINCT on three columns.

select distinct 
		Category, 
		ProductName, 
		Price
from Products
where price > 50 

--23. Write a query that selects products whose Price is less than 10% of the average price in the Products table. 
--   (Do some research on how to find average price of all products)

SELECT *
FROM Products
WHERE Price < (
    SELECT AVG(Price) * 0.10
    FROM Products
)
ORDER BY Price ASC, ProductName ASC;

--24. Use WHERE clause to filter for employees whose 
--    Age is less than 30 and who work in either the 'HR' or 'IT' department.

select
DepartmentName, Salary, age
from Employees
where age <30 and (DepartmentName = 'HR' or DepartmentName = 'IT');

--25. Use LIKE with wildcard to select all customers whose Email contains the domain '@gmail.com'.

SELECT *
FROM Customers
WHERE Email LIKE '%@gmail.com';

--26. Write a query that uses the ALL operator to find employees 
--    whose salary is greater than all employees in the 'Sales' department.

SELECT *
FROM Employees
WHERE Salary > ALL (
    SELECT Salary
    FROM Employees
    WHERE DepartmentName = 'Sales'
);

--27. Write a query that filters the Orders table for orders placed in the last 180 days using BETWEEN and CURRENT_DATE. (Search how to get the current date)

SELECT *
FROM Orders
WHERE OrderDate BETWEEN DATEADD(DAY, -180, GETDATE()) AND GETDATE();
