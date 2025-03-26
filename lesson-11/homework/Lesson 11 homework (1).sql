--EASY-LEVEL TASKS

--Task 1: Basic INNER JOIN
--Question: Retrieve all employee names along with their corresponding department names.

--select * from Employees
--select * from Departments

SELECT
e.EmployeeID,
e.Name,
d.DepartmentName
FROM [Lesson11_homework].[dbo].[Employees] e
INNER JOIN [Lesson11_homework].[dbo].[Departments] d
ON e.DepartmentID = d.DepartmentID

--Task 2: LEFT JOIN
--Question: List all students along with their class names, including students who are not assigned to any class.

--select * from Students
--select * from Classes

SELECT 
s.StudentID,
s.StudentName,
s.ClassID,
c.ClassName
FROM [Lesson11_homework].[dbo].[Students] s 
LEFT JOIN [Lesson11_homework].[dbo].[Classes] c 
ON s.ClassID = c.ClassID

--Task 3: RIGHT JOIN
--Question: List all customers and their orders, including customers who haven’t placed any orders.

select * from Orders o
RIGHT JOIN Customers c
ON o.CustomerID = c.CustomerID

--Task 4: FULL OUTER JOIN
--Question: Retrieve a list of all products and their sales, including products with no sales and sales with invalid product references.

--select * from Products
--select * from Sales

select * from Products p
FULL OUTER JOIN Sales s 
ON p.ProductID = s.ProductID

--Task 5: SELF JOIN
--Question: Find the names of employees along with the names of their managers.

--select * from Employees

select a.*, 
isnull (b.Name,'CEO') as [ManagerName] from Employees a
left join Employees b 
ON a.ManagerID = b.EmployeeID

--Task 6: CROSS JOIN
--Question: Generate all possible combinations of colors and sizes.

--select * from Colors
--select * from Sizes

select * from Colors c
CROSS JOIN Sizes s

----Task 7: Join with WHERE Clause
--Question: Find all movies released after 2015 and their associated actors.

--We should create a bridge table
CREATE TABLE MovieActors (
    MovieID INT,
    ActorID INT,
    PRIMARY KEY (MovieID, ActorID),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID),
    FOREIGN KEY (ActorID) REFERENCES Actors(ActorID) 
);

INSERT INTO MovieActors VALUES
(1,101),
(2,102),
(3,103);

select * from Movies
select * from MovieActors
select * from Actors

SELECT 
m.MovieID,
m.Title,
m.ReleaseYear,
a.ActorID,
a.Name
FROM Movies m 
JOIN [Lesson11_homework].[dbo].[MovieActors] ma
ON m.MovieID = ma.MovieID
JOIN [Lesson11_homework].[dbo].[Actors] a
ON a.ActorID = ma.ActorID
WHERE m.ReleaseYear > 2015;


--Task 8: MULTIPLE JOINS
--Question: Retrieve the order date, customer name, and the product ID for all orders.

--select * from Orders
--select * from Customers
--select * from OrderDetails

SELECT
o.OrderID,
o.CustomerID,
o.OrderDate,
c.CustomerName,
od.OrderDetailID,
od.ProductID
FROM [Lesson11_homework].[dbo].[Orders] o
JOIN [Lesson11_homework].[dbo].[Customers] c
ON o.CustomerID = c.CustomerID 
JOIN [Lesson11_homework].[dbo].[OrderDetails] od
ON o.OrderID = od.OrderID

--Task 9: JOIN with Aggregation
--Question: Calculate the total revenue generated for each product.

--select * from Sales
--select * from Products

SELECT 
    s.ProductID,
    p.ProductName,
    SUM(s.Quantity * p.Price) AS TotalPrice  
FROM [Lesson11_homework].[dbo].[Sales] s
INNER JOIN [Lesson11_homework].[dbo].[Products] p 
ON s.ProductID = p.ProductID
GROUP BY s.ProductID, p.ProductName  
ORDER BY TotalPrice DESC;
