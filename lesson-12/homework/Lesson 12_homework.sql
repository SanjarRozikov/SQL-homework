--Easy Questions (20)

--1. What is the result of Ascii('A') in SQL?
select ASCII('A') --65

--2. Write a SQL query to get the length of the string 'Hello World' using Len().
select len('Hello world') --11

--3.How do you reverse a string 'OpenAI' using SQL?
SELECT REVERSE('OpenAI') --IAnepO

--4. What function would you use to add 5 spaces before a string in SQL?
select RTRIM('     5 spaces') --     5 spaces
--or
select CONCAT(SPACE(5), '5 spaces') --     5 spaces

--5. How can you remove leading spaces from the string ' SQL Server'?
SELECT LTRIM('   SQL Server') --SQL Server

--6.Write a query that converts the string 'sql' to uppercase.
select UPPER('sql') --SQL

--7.What function would you use to extract the first 3 characters of the string 'Database'?
select LEFT('Database',3) --Dat

--8.How can you get the last 4 characters from the string 'Technology'?
select RIGHT('Technology',4) --logy

--9.Use Substring() to get characters from position 3 to position 6 in the string 'Programming'.
select SUBSTRING('Programming',3,4) --ogramm

--10.Write a query to concatenate the strings 'SQL' and 'Server' using Concat().
select CONCAT('SQL','Server') --SQLServer

--11.How can you replace all occurrences of 'apple' with 'orange' in the string 'apple pie'?
select REPLACE('apple orange','orange','pie') --apple pie

--12. Write a query to find the position of the first occurrence of the word 'learn' in the string 'Learn SQL with LearnSQL'.
select SUBSTRING('Learn SQL with LearnSQL',1,5) --Learn

--13. What function can you use to check if the string 'Server' contains 'er' using SQL?
select RIGHT('Server',2) --er
--or
select SUBSTRING('Server',5,6) --er

--14.How can you split the string 'apple,orange,banana' into individual words using String_split()?
select value
FROM STRING_SPLIT('apple,orange,banana', ',')

--15. What is the result of the expression Power(2, 3)?
select POWER(2,3) --8

--16. Write a query that calculates the square root of 16 using SQL.
select sqrt(16) --4

--17. How do you get the current date and time in SQL?
select CURRENT_TIMESTAMP -- 2025-04-06 11:17:56.417

--18. What SQL function would you use to get the current UTC date and time?
select GETUTCDATE() --2025-04-06 06:21:41.963

--19. How can you get the day of the month from the date '2025-02-03'?
select MONTH('2025-02-03') --2

--20. Write a query to add 10 days to the date '2025-02-03' using Dateadd().
select DATEADD(DAY,10,'2025-02-03') --2025-02-13 00:00:00.000

--Medium Questions (20)

--1. Use Char() to convert the ASCII value 65 to a character.
select CHAR(65) --A

--2. What is the difference between Ltrim() and Rtrim() in SQL?
--LTRIM() - removes leading spaces (spaces at the beginning) from the string. Also removes spaces from the left side of the string
--RTRIM() - Removes trailing spaces (spaces at the end) from the string. Also removes spaces from the right side of the string

--3. Write a query to find the position of the substring 'SQL' in the string 'Learn SQL basics'.
select SUBSTRING('Learn SQL basics',7,3) --SQL

--4. Use Concat_ws() to join 'SQL' and 'Server' with a comma between them.
select CONCAT_WS (',','SQL','Server') --SQL,Server

--5. How would you replace the substring 'test' with 'exam' using Stuff()?
select STUFF('test',1,4,'exam')

--6. Write a SQL query to get the square of 7 using Square().
select SQUARE(7) --49

--7. How do you get the first 5 characters from the string 'International'?
select LEFT('International', 5) --Inter

--8. Write a query to get the last 2 characters of the string 'Database'.
select RIGHT('Database',2) --se

--9. What is the result of Patindex('%n%', 'Learn SQL')?
select PATINDEX('%n%','Learn SQL') --5

--10. How do you calculate the difference in days between '2025-01-01' and '2025-02-03' using Datediff()?
select DATEDIFF(DAY,'2025-01-01','2025-02-03') --33


--11. Write a query to return the month from the date '2025-02-03' using Month().
select MONTH('2025-02-03') --2

--12. Use DatePart() to extract the year from the date '2025-02-03'.
select DATEPART(YEAR,'2025-02-03') --2025

--13. How can you get the current system time without the date part in SQL?
SELECT CONVERT(TIME, GETDATE()) --00:11:28.0700000

--14. What does the function Sysdatetime() return in SQL?
select SYSDATETIME() --2025-04-07 00:12:12.1837828

--15. How would you find the next occurrence of 'Wednesday' from today's date using Dateadd()?
select DATEADD(DAY,2,GETDATE()) --2025-04-09 00:16:03.223

--16. What is the difference between Getdate() and Getutcdate()?
--Getdate() - Returns the current date and time of the server's local time zone.
--Getutcdate()- Returns the current date and time in UTC (Coordinated Universal Time).

--17. Use Abs() to get the absolute value of -15 in SQL.
select ABS('-15') --15

--18. How would you round the number 4.57 to the nearest whole number using Ceiling()?
select CEILING(4.57) --5

--19. Write a SQL query to get the current time using Current_Timestamp.
select CURRENT_TIMESTAMP --2025-04-07 00:20:11.453

--20. Use DateName() to return the day name for the date '2025-02-03'.
select DATENAME(DAY,'2025-02-03') --3

--Difficult Questions (20)

--1. Write a query to reverse the string 'SQL Server' and then remove the spaces.
select reverse(CONCAT('SQL','Server')) --revreSLQS

--2. Write a query that uses String_agg() to concatenate all the values in the 'City' column of a table into a single string, separated by commas.
SELECT STRING_AGG('City', ', ') AS AllCities
FROM Budget

--3. Write a SQL query that checks if a string contains both 'SQL' and 'Server' using Charindex().
SELECT
  CASE
    WHEN CHARINDEX('SQL', SQLServer) > 0 AND CHARINDEX('Server', SQLServer) > 0
    THEN 'Contains both'
    ELSE 'Does not contain both'
  END AS CheckResult
FROM SQLServer;

--4. How would you use Power() to calculate the cube of 5?
select POWER(5,3) --125

--5. Write a query that splits a string 'apple;orange;banana' by the semicolon and returns each word as a separate row.
select value
FROM STRING_SPLIT('apple,orange,banana', ',')

--6. Use Trim() to remove both leading and trailing spaces from the string ' SQL '
select TRIM(' SQL ') --SQL

--7. Write a SQL query to calculate the difference in hours between two timestamps using Datediff().
select DATEDIFF(HOUR, '2025-04-06 20:28:55.320','2025-04-07 20:24:26.870') --24

--8. How would you calculate the number of months between '2023-05-01' and '2025-02-03' using Datepart()?
select 
  (DATEPART(YEAR, '2025-02-03') - DATEPART(YEAR, '2023-05-01')) * 12 +
  (DATEPART(MONTH, '2025-02-03') - DATEPART(MONTH, '2023-05-01')) AS MonthsBetween --21

--9. Write a query to find the position of the substring 'SQL' from the end of the string 'Learn SQL Server' using Reverse() and Charindex().
SELECT LEN('Learn SQL Server') - CHARINDEX('LQS', REVERSE('Learn SQL Server')) - LEN('SQL') + 2 --7

--10. Use String_split() to split a comma-separated string 'apple,orange,banana' and return each word in a separate row.
select value 
from string_split('apple,orange,banana',',')

--11. How would you find the number of days from '2025-01-01' to the current date using Datediff()?
select DATEDIFF(DAY,'2025-01-01',GETDATE()) --96

--12. Write a SQL query that returns the first 4 characters of the string 'Data Science' using Left().
select LEFT('Data Science',4) --Data

--13. How can you calculate the square root of 225 and round it to the nearest whole number using Sqrt() and Ceiling()?
select ceiling(round(SQRT(225),0))

--14. Write a query that concatenates two strings with a pipe ('|') separator using Concat_ws().

select CONCAT_WS('|','Hello','world' ) --Hello|world

--15. Use Patindex() to find the position of the first occurrence of any digit in the string 'abc123xyz'.
select PATINDEX('%[0,1,2,3,4,5,6,7,8,9]%','abc123xyz') --4
--or
select PATINDEX('%[0-9]%','abc123xyz') --4

--16. How would you find the second occurrence of the substring 'SQL' in the string 'SQL Server SQL' using Charindex()?
select CHARINDEX('SQL', 'SQL Server SQL',CHARINDEX('SQL', 'SQL Server SQL')+1) --12

--17. Write a SQL query to get the year from the current date using DatePart().
select DATEPART(YEAR,GETDATE()) --2025

--18. How do you subtract 100 days from the current date using Dateadd()?
select DATEADD(DAY, -100,GETDATE()) --2024-12-28 16:25:43.327

--19. Use DateName() to extract the day of the week from the date '2025-02-03'.
select DATENAME(WEEKDAY,'2025-02-03') --Monday

--20. Write a query to get the square of a number using the Power() function and return it in the result set.
select SQUARE(POWER(2,3)) --64






























