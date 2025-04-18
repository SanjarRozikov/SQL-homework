create database lesson1_homework
use lesson1_homework

--EASY LEVEL

--1.Define the following terms: data, database, relational database, and table.

Data refers to raw facts or information, often unprocessed. It can be numbers, text, images, or other values collected for analysis.
🔹 Example: "John", 35, New York, 5000

A database is an organized collection of data that is stored and accessed electronically. It allows data to be easily entered, managed, and retrieved.
🔹 Think of it like a digital filing cabinet.

A relational database is a type of database that stores data in tables with rows and columns, where each table is related to others through keys (like primary and foreign keys).
🔹 Example: One table for Employees, another for Departments, and they are linked by department_id.

A table is a structured set of data in a relational database. It consists of:

Rows (records)
Columns (fields)

--2. List five key features of SQL Server.
--Relational Database Management
--Stored Procedures and Triggers
-- Security and Authentication
--High Availability and Backup
--Integrated Tools for BI and Analytics

--3. What are the different authentication modes available when connecting to SQL Server? (Give at least 2)
--Windows Authentication
--SQL Server Authentication


--MEDIUM LEVEL

--1.Create a new database in SSMS named SchoolDB.
create database SchoolDB

--2. Write and execute a query to create a table called Students with columns: StudentID (INT, PRIMARY KEY), Name (VARCHAR(50)), Age (INT).
create table Students (
StudentID INT PRIMARY KEY, 
Name VARCHAR(50), 
Age INT
);

--3. Describe the differences between SQL Server, SSMS, and SQL.
--SQL Server is stores and manages data (type RDBMS)
--SSMS is User interface to manage SQL Server(type Tool/IDE)
--SQL is Communicate with the database (type Language) 

--HARD LEVEL

--1. Research and explain the different SQL commands: DQL, DML, DDL, DCL, TCL with examples.
--DQL	Data Query Language	Retrieve data	SELECT
--DML	Data Manipulation Language	Modify data	INSERT, UPDATE, DELETE
--DDL	Data Definition Language	Define DB structure	CREATE, ALTER, DROP
--DCL	Data Control Language	Permissions & access	GRANT, REVOKE
--TCL	Transaction Control Lang	Manage transactions	COMMIT, ROLLBACK

--2. Write a query to insert three records into the Students table.
INSERT INTO Students (StudentID, Name, Age)
VALUES 
    (1, 'Alice Johnson', 18),
    (2, 'Brian Smith', 19),
    (3, 'Carla Gomez', 20);

--3.Create a backup of your SchoolDB database and restore it. (write its steps to submit)
Backup:

Right-click SchoolDB → Tasks → Back Up…

Select Full backup, choose .bak file path → Click OK.

Restore:

Right-click Databases → Restore Database…

Select .bak file from device → Rename if needed → Click OK.

