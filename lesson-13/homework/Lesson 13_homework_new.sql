


--Lesson 13 ----Practice: String Functions, Mathematical Functions, Date and time Functions

--Easy Tasks

--1.You need to write a query that outputs "100-Steven King", meaning emp_id + first_name + last_name in that format using employees table.

SELECT 
    CONCAT(100, '-', 'Steven', ' ', 'King') AS EmployeeInfo
FROM 
    employees;

--2.Update the portion of the phone_number in the employees table, within the phone number the substring '124' will be replaced by '999'
select REPLACE ('9989010350124','124','999')
from employees

--3. That displays the first name and the length of the first name for all employees whose name starts with the letters 'A', 'J' or 'M'. 
--   Give each column an appropriate label. 
--   Sort the results by the employees' first names.(Employees)
select * from employees
SELECT 
    first_name AS [First Name],
    LEN(first_name) AS [Name Length]
FROM 
    employees
WHERE 
    LEFT(first_name, 1) IN ('A', 'J', 'M')
ORDER BY 
    first_name;

--4. Write an SQL query to find the total salary for each manager ID.(Employees table)
SELECT manager_id, SUM(salary) AS total_salary
FROM Employees
GROUP BY manager_id;

--5. Write a query to retrieve the year and the highest value from the 
--   columns Max1, Max2, and Max3 for each row in the TestMax table
SELECT Year1,
       GREATEST(Max1, Max2, Max3) AS highest_value
FROM TestMax;

--6. Find me odd numbered movies description is not boring.(cinema)
SELECT *
FROM Cinema
WHERE id % 2 = 1
  AND description != 'boring';

--7. You have to sort data based on the Id but Id with 0 should always be the last row. 
--   Now the question is can you do that with a single order by column.(SingleOrder)
SELECT *
FROM SingleOrder
ORDER BY id desc, 
Vals;

--8. Write an SQL query to select the first non-null value from a set of columns. 
--   If the first column is null, move to the next, and so on. 
--   If all columns are null, return null.(person)
SELECT COALESCE(ssn, passportid, itin) AS name
FROM Person;

--9. Find the employees who have been with the company for more than 10 years, but less than 15 years. 
--Display their Employee ID, First Name, Last Name, Hire Date, and the Years of Service 
--(calculated as the number of years between the current date and the hire date, rounded to two decimal places).(Employees)
SELECT 
    employee_id,
    first_name,
    last_name,
    hire_date,
    ROUND(DATEDIFF(DAY, hire_date, GETDATE()) / 365.0, 2) AS years_of_service
FROM Employees
WHERE 
    (DATEDIFF(DAY, hire_date, GETDATE()) / 365.0) > 10
    AND (DATEDIFF(DAY, hire_date, GETDATE()) / 365.0) < 15
ORDER BY employee_id;

--10. Find the employees who have a salary greater than 
--the average salary of their respective department.(Employees)
select department_ID, AVG(salary)
from Employees
group by DEPARTMENT_ID,SALARY
having salary > AVG(salary)

--MEDIUM-LEVEL TASKS

--1. Write an SQL query that separates the uppercase letters, 
--lowercase letters, numbers, and other characters from the given 
--string 'tf56sd#%OqH' into separate columns.

select 
UPPER ('tf56sd#%OqH') as UPPER_CASE,
LOWER ('tf56sd#%OqH') as LOWER_CASE,
LEN ('tf56sd#%OqH') as LENGHT_CASE,
REVERSE ('tf56sd#%OqH') AS REVERSE_CASE

--2. Split column FullName into 3 part ( Firstname, Middlename, and Lastname).(Students Table)
SELECT
    FullName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 3) AS FirstName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 2) AS MiddleName,
    PARSENAME(REPLACE(FullName, ' ', '.'), 1) AS LastName
FROM
    Students;

--3. For every customer that had a delivery to California, 
--   provide a result set of the customer orders that were delivered to Texas. (Orders Table)
SELECT o1.*
FROM Orders o1
JOIN Orders o2
  ON o1.CustomerID = o2.CustomerID
WHERE 
    CHARINDEX('California', o2.DeliveryState) > 0  
    AND CHARINDEX('Texas', o1.DeliveryState) > 0

--4. Write an SQL query to transform a table where each product has a total quantity into 
--a new table where each row represents a single unit of that product.
--For example, if A and B, it should be A,B and B,A.(Ungroup)
WITH Numbers AS (
    SELECT 1 AS n
    UNION ALL SELECT 2
    UNION ALL SELECT 3
    UNION ALL SELECT 4
    UNION ALL SELECT 5
    -- add more if needed
),
Products AS (
    SELECT 'A' AS Product, 2 AS Quantity
    UNION ALL
    SELECT 'B', 2
)

-- Step 2: Expand using JOIN
SELECT 
    p.Product
FROM 
    Products p
JOIN 
    Numbers n ON n.n <= p.Quantity
ORDER BY 
    p.Product;

--5.Write an SQL statement that can group concatenate the following values.(DMLTable)
SELECT 
    CONCAT(SequenceNumber, ' ', String) AS Concatenate
FROM 
    DMLTable;

--6. Write an SQL query to determine the 
--Employment Stage for each employee based on their HIRE_DATE. 
--The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)

SELECT 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    HIRE_DATE,
    CASE
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) < 1 THEN 'New Hire'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 1 AND 5 THEN 'Junior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 5 AND 10 THEN 'Mid-Level'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) BETWEEN 10 AND 20 THEN 'Senior'
        WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 20 THEN 'Veteran'
    END AS EmploymentStage
FROM 
    Employees;

--7. Find the employees who have a salary greater than the average salary of their respective department(Employees)
select department_ID, AVG(salary)
from Employees
group by DEPARTMENT_ID,SALARY
having salary > AVG(salary)

--8. Find all employees whose names (concatenated first and last) 
--   contain the letter "a" and whose salary is divisible by 5(Employees)
SELECT 
    EMPLOYEE_ID, 
    FIRST_NAME, 
    LAST_NAME, 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) AS FullName,
    Salary
FROM 
    Employees
WHERE 
    CONCAT(FIRST_NAME, ' ', LAST_NAME) LIKE '%a%' 
    AND Salary % 5 = 0;

--9. The total number of employees in each department and the percentage of 
--those employees who have been with the company for more than 3 years(Employees)
SELECT 
    DEPARTMENT_ID,
    COUNT(*) AS TotalEmployees,
    SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) AS EmployeesWithMoreThan3Years,
    (SUM(CASE WHEN DATEDIFF(YEAR, HIRE_DATE, GETDATE()) > 3 THEN 1 ELSE 0 END) * 100.0 / COUNT(*)) AS PercentageMoreThan3Years
FROM 
    Employees
GROUP BY 
    DEPARTMENT_ID;

--10. Write an SQL statement that determines the most and least experienced 
--    Spaceman ID by their job description.(Personal)
SELECT 
    SpacemanID, 
    JobDescription,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfExperience
FROM 
    Personal
WHERE 
    JobDescription = 'Spaceman'
ORDER BY 
    YearsOfExperience DESC
LIMIT 1;

-- Least Experienced Spaceman by Job Description
SELECT 
    Spaceman_ID, 
    JobDescription,
    DATEDIFF(YEAR, HireDate, GETDATE()) AS YearsOfExperience
FROM 
    Personal
WHERE 
    JobDescription = 'Spaceman'
ORDER BY 
    YearsOfExperience ASC
LIMIT 1;

select * from Personal

--HARD-LEVEL TASKS

--1. Write an SQL query that replaces each 
--row with the sum of its value and the previous row's value. (Students table)
SELECT 
    StudentID,
    CAST(FullName AS VARCHAR) + ' + ' + 
    COALESCE(CAST(LAG(fullname) OVER (ORDER BY StudentID) AS VARCHAR), '0') AS ValueWithPreviousSum
FROM 
    Students;
--2. Given the following hierarchical table, write an SQL statement that determines the 
--   level of depth each employee has from the president. (Employee table)
WITH EmployeeHierarchy AS (
    SELECT 
        EmployeeID, 
        EmployeeName, 
        ManagerID, 
        0 AS Level
    FROM Employee
    WHERE ManagerID IS NULL  -- Assume president has no manager
    UNION ALL
    SELECT 
        e.EmployeeID, 
        e.EmployeeName, 
        e.ManagerID, 
        eh.Level + 1 AS Level
    FROM Employee e
    INNER JOIN EmployeeHierarchy eh ON e.ManagerID = eh.EmployeeID
)
SELECT 
    EmployeeID,
    FirstName,
    Level
FROM EmployeeHierarchy
ORDER BY Level, EmployeeID;

--3. You are given the following table, which contains a VARCHAR column that contains mathematical equations. 
--Sum the equations and provide the answers in the output.(Equations)

SELECT 
    Equation,
    CAST(SUM(CAST(Equation AS INT)) AS INT) AS Total
FROM Equations
GROUP BY Equation;

--4. Given the following dataset, find the students that share the same birthday.(Student Table)
SELECT 
    s1.StudentName AS Student1Name, 
    s2.StudentName AS Student2Name,
    s1.Birthday
FROM 
    Student s1
JOIN 
    Student s2 ON DATEPART(MM, s1.Birthday) = DATEPART(MM, s2.Birthday)
    AND DATEPART(DAY, s1.Birthday) = DATEPART(DAY, s2.Birthday)
    AND s1.StudentName < s2.StudentName;
--5. You have a table with two players (Player A and Player B) and their scores. If a pair of players have multiple entries, aggregate their scores into a single row for each unique pair of players. 
--Write an SQL query to calculate the total score for each unique player pair(PlayerScores)
SELECT 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA
        ELSE PlayerB
    END AS Player1,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB
        ELSE PlayerA
    END AS Player2,
    SUM(Score) AS TotalScore
FROM 
    PlayerScores
GROUP BY 
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerA
        ELSE PlayerB
    END,
    CASE 
        WHEN PlayerA < PlayerB THEN PlayerB
        ELSE PlayerA
    END
ORDER BY TotalScore DESC;




