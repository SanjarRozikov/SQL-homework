
--EASY-LEVEL TASKS

--1. Write a SQL query to split the Name column by a comma into two separate columns: 
--   Name and Surname.(TestMultipleColumns)
SELECT 
    LEFT(Name, CHARINDEX(',', Name) - 1) AS Name,
    LTRIM(RIGHT(Name, LEN(Name) - CHARINDEX(',', Name))) AS Surname
FROM TestMultipleColumns;

--2. Write a SQL query to find strings from a table where the string itself 
--contains the % character.(TestPercent)
SELECT *
FROM TestPercent
WHERE Strs LIKE '%\%%' ESCAPE '\';

--3.In this puzzle you will have to split a string based on dot(.).(Splitter)
SELECT 
    LEFT(Vals, CHARINDEX('.', Vals) - 1) AS Part1,
    SUBSTRING(Vals, CHARINDEX('.', Vals) + 1, 
              CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1) - CHARINDEX('.', Vals) - 1) AS Part2,
    RIGHT(Vals, LEN(Vals) - CHARINDEX('.', Vals, CHARINDEX('.', Vals) + 1)) AS Part3
FROM 
    Splitter;

--4. Write a SQL query to replace all integers (digits) 
--in the string with 'X'.(1234ABC123456XYZ1234567890ADS)

SELECT TRANSLATE('1234ABC123456XYZ1234567890ADS', '0123456789', 'XXXXXXXXXX') AS ReplacedString;

--5. Write a SQL query to return all rows where the 
--value in the Vals column contains more than two dots (.).(testDots)
SELECT *
FROM MultipleVals
WHERE LEN(Vals) - LEN(REPLACE(Vals, '.', '')) > 2;

--6. Write a SQL query to count the spaces present in the string.(CountSpaces)

SELECT 
  texts,
  LEN(texts) - LEN(REPLACE(texts, ' ', '')) AS space_count
FROM CountSpaces;

--7. Write a SQL query that finds out employees who earn more than their managers.(Employee)

SELECT e.Name AS EmployeeName, e.Salary AS EmployeeSalary, m.Name AS ManagerName, m.Salary AS ManagerSalary
FROM Employee e
JOIN Employee m ON e.ManagerId = m.Id
WHERE e.Salary > m.Salary;

--8. Find the employees who have been with the company for more than 10 years, 
--but less than 15 years. Display their Employee ID, First Name, Last Name, Hire Date, 
--and the Years of Service (calculated as the number of years between the current date 
--and the hire date).(Employees)

SELECT 
  EmployeeID,
  FirstName,
  LastName,
  HireDate,
  FLOOR(DATEDIFF(CURDATE(), HireDate) / 365) AS YearsOfService
FROM Employees
WHERE FLOOR(DATEDIFF(CURDATE(), HireDate) / 365) > 10
  AND FLOOR(DATEDIFF(CURDATE(), HireDate) / 365) < 15;

  --Medium Tasks
--1. Write a SQL query to separate the integer values and the character values into two different columns.(rtcfvty34redt)
CREATE FUNCTION dbo.GetDigits (@str VARCHAR(MAX))
RETURNS VARCHAR(MAX)
AS
BEGIN
    DECLARE @i INT = 1, @result VARCHAR(MAX) = ''
    WHILE @i <= LEN(@str)
    BEGIN
        IF SUBSTRING(@str, @i, 1) LIKE '[0-9]'
            SET @result += SUBSTRING(@str, @i, 1)
        SET @i += 1
    END
    RETURN @result
END

--2. write a SQL query to find all dates' Ids with higher temperature 
--compared to its previous (yesterday's) dates.(weather)

SELECT 
  Id
FROM (
  SELECT 
    Id,
    RecordDate,
    Temperature,
    LAG(Temperature) OVER (ORDER BY RecordDate) AS PrevTemp
  FROM Weather
) AS temp_diff
WHERE Temperature > PrevTemp;

--3. Write an SQL query that reports the first login date for each player.(Activity)
SELECT 
  player_id,
  MIN(event_date) AS first_login_date
FROM Activity
GROUP BY player_id;

--4. Your task is to return the third item from that list.(fruits)
;WITH SplitFruits AS (
  SELECT 
    value AS fruit,
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS rn
  FROM (
    SELECT value
    FROM fruits
    CROSS APPLY STRING_SPLIT(fruit_list, ',')
  ) AS split
)
SELECT fruit AS third_fruit
FROM SplitFruits
WHERE rn = 3;

--5. Write a SQL query to create a table where each character from the string 
--will be converted into a row.(sdgfhsdgfhs@121313131)
;WITH Numbers AS (
  SELECT TOP (LEN('sdgfhsdgfhs@12131313'))
    ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS n
  FROM sys.all_objects  -- or use a numbers table if available
)
INSERT INTO char_table (position, character)
SELECT 
  n,
  SUBSTRING('sdgfhsdgfhs@12131313', n, 1)
FROM Numbers;

--6. You are given two tables: p1 and p2. Join these tables on the id column. 
--The catch is: when the value of p1.code is 0, replace it with the value of p2.code.(p1,p2)
SELECT 
  p1.id,
  CASE 
    WHEN p1.code = 0 THEN p2.code
    ELSE p1.code
  END AS code
FROM p1
JOIN p2 ON p1.id = p2.id;

--7. Write an SQL query to determine the Employment Stage for each employee based on their 
--HIRE_DATE. The stages are defined as follows:
--If the employee has worked for less than 1 year → 'New Hire'
--If the employee has worked for 1 to 5 years → 'Junior'
--If the employee has worked for 5 to 10 years → 'Mid-Level'
--If the employee has worked for 10 to 20 years → 'Senior'
--If the employee has worked for more than 20 years → 'Veteran'(Employees)
SELECT 
  EmployeeID,
  FirstName,
  LastName,
  HIRE_DATE,
  CASE 
    WHEN DATEDIFF(CURRENT_DATE, HIRE_DATE) < 365 THEN 'New Hire'  -- Less than 1 year
    WHEN DATEDIFF(CURRENT_DATE, HIRE_DATE) BETWEEN 365 AND 1825 THEN 'Junior'  -- 1 to 5 years
    WHEN DATEDIFF(CURRENT_DATE, HIRE_DATE) BETWEEN 1826 AND 3650 THEN 'Mid-Level'  -- 5 to 10 years
    WHEN DATEDIFF(CURRENT_DATE, HIRE_DATE) BETWEEN 3651 AND 7300 THEN 'Senior'  -- 10 to 20 years
    ELSE 'Veteran'  -- More than 20 years
  END AS EmploymentStage
FROM Employees;

--8. Write a SQL query to extract the integer value that appears at the start of the 
--string in a column named Vals.(GetIntegers)

SELECT 
  Vals,
  CAST(SUBSTRING(Vals, 1, PATINDEX('%[^0-9]%', Vals) - 1) AS INT) AS ExtractedInteger
FROM GetIntegers
WHERE PATINDEX('%[^0-9]%', Vals) > 0;

--Difficult Tasks

--1. In this puzzle you have to swap the first two letters of the comma separated string.(MultipleVals)
SELECT 
  Vals,
  STUFF(Vals, 1, 2, SUBSTRING(Vals, 2, 1) + SUBSTRING(Vals, 1, 1)) AS SwappedVals
FROM MultipleVals;

--2. Write a SQL query that reports the device that is first logged in for each player.(Activity)
SELECT 
  player_id,
  device_id,
  MIN(event_date) AS first_login_date
FROM Activity
GROUP BY player_id, device_id
ORDER BY player_id, first_login_date;

--3. You are given a sales table. Calculate the week-on-week percentage of sales per 
--area for each financial week. For each week, the total sales will be considered 100%, 
--and the percentage sales for each day of the week should be calculated based on the 
--area sales for that week.(WeekPercentagePuzzle)

WITH WeeklySales AS (
    -- Calculate total sales per area for each financial week
    SELECT 
        YEAR(sale_date) AS sale_year,
        WEEK(sale_date, 1) AS financial_week, -- 1 indicates the week starts on Monday
        area,
        SUM(sales_amount) AS total_sales_area
    FROM sales
    GROUP BY YEAR(sale_date), WEEK(sale_date, 1), area
),
DailySales AS (
    -- Calculate daily sales per area and financial week
    SELECT 
        sale_date,
        YEAR(sale_date) AS sale_year,
        WEEK(sale_date, 1) AS financial_week,
        area,
        sales_amount
    FROM sales
)
-- Calculate the percentage of sales per day for each area in each financial week
select * from WeekPercentagePuzzle
SELECT 
    d.date,
    d.financialweek,
    d.area,
    d.salesRemote,
    ROUND((d.salesLocal / ws.total_sales_area) * 100, 2) AS sales_percentage
FROM DailySales d
JOIN WeeklySales ws
    ON d.financial_week = ws.financial_week
    AND d.area = ws.area
    AND d.sale_year = ws.sale_year
ORDER BY d.financial_week, d.sale_date, d.area;









