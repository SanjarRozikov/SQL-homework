--EASY LEVEL TASKS

--1. Write a query that uses an alias to rename the ProductName column as Name in the Products table.
select ProductName as Name
from products

--2. Write a query that uses an alias to rename the Customers table as Client for easier reference.
select * from Customers as Client 

--3. Use UNION to combine results from two queries that select ProductName from Products and ProductName from Products_Discounted.
select ProductName
from Products
UNION
select ProductName
from Products_Discounted

--4. Write a query to find the intersection of Products and Products_Discounted tables using INTERSECT.
select Price
from Products
INTERSECT
select Price
from Products_Discounted

--5. Write a query to select distinct customer names and their corresponding Country using SELECT DISTINCT.
select distinct Country
from Customers

--6. Write a query that uses CASE to create a conditional column that displays 'High' if Price > 1000, and 'Low' if Price <= 1000 from Products table.
select 
ProductID,
ProductName,
Price,
	Case
		When Price > 1000 then 'High'
        else 'Low'
	end as [Prices]
from products

--7. Use IIF to create a column that shows 'Yes' if Stock > 100, and 'No' otherwise (Products_Discounted table, StockQuantity column).
select 
ProductID, 
ProductName,
StockQuantity,
IIF( StockQuantity > 100, 'Yes', 'No')
from Products_Discounted

--MEDIUM LEVEL TASKS

--8. Use UNION to combine results from two queries that select ProductName from Products and ProductName from OutOfStock tables.
select ProductName 
from Products
UNION
select ProductName
from OutOfStock

--9. Write a query that returns the difference between the Products and Products_Discounted tables using EXCEPT.
select * from Products
except
select * from Products_Discounted

--10. Create a conditional column using IIF that shows 'Expensive' if the Price is greater than 1000, and 'Affordable' if less, from Products table.
select price, 
IIF(Price > 1000,'Expensive', 'Affordable')
from Products

--11. Write a query to find employees in the Employees table who have either Age < 25 or Salary > 60000.
select * from Employees
where Age < 25 or Salary > 60000

--12. Update the salary of an employee based on their department, increase by 10% if they work in 'HR' or EmployeeID = 5
UPDATE Employees
SET Salary = Salary * 1.10
WHERE DepartmentName = 'HR' OR EmployeeID = 5;
select * from Employees

--HARD-LEVEL TASKS

--13. Use INTERSECT to show products that are common between Products and Products_Discounted tables.
select Category
from Products
INTERSECT
select Category
from Products_Discounted

--14. Write a query that uses CASE to assign 'Top Tier' if SaleAmount > 500, 'Mid Tier' if SaleAmount BETWEEN 200 AND 500, and 'Low Tier' otherwise. (From Sales table)
select 
SaleID,
ProductID,
CustomerID,
SaleAmount,
CASE 
	when SaleAmount > 500 then 'Top Tier'
	when SaleAmount<500 and SaleAmount>200 then 'Mid Tier'
	else 'Low Tier'
	end as [SALES_AMOUNT]
from Sales

--15. Use EXCEPT to find customers' ID who have placed orders but do not have a corresponding record in the Invoices table.
select CustomerID 
from Orders
EXCEPT
select CustomerID
from Invoices

--16. Write a query that uses a CASE statement to determine the discount percentage based on the quantity purchased. Use orders table. Result set should show  customerid, quantity and discount percentage. The discount should be applied as follows:
        --1 item: 3% 
        --Between 1 and 3 items : 5% 
        --Otherwise: 7% 
SELECT 
    CustomerID,
    Quantity,
    CASE 
        WHEN Quantity = 1 THEN '3%'
        WHEN Quantity > 1 AND Quantity <= 3 THEN '5%'
        ELSE '7%'
    END AS DiscountPercentage
FROM Orders;
















