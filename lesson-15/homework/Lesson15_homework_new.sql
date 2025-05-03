--Level 1: Basic Subqueries

--Find Employees with Minimum Salary
--1. Task: Retrieve employees who earn the minimum salary in the company. 
--Tables: employees (columns: id, name, salary)

SELECT id, name, salary
FROM employees
WHERE salary = (
    SELECT MIN(salary)
    FROM employees
);

--2. Find Products Above Average Price
--Task: Retrieve products priced above the average price. Tables: products (columns: id, product_name, price)
SELECT 
	id,
	product_name,
	price
FROM products
WHERE price > (SELECT AVG(price) FROM products)

--3. Find Employees in Sales Department Task: Retrieve employees who work in the "Sales" 
--department. Tables: employees (columns: id, name, department_id), 
--departments (columns: id, department_name)
SELECT 
	e.id, 
	e.name, 
	d.department_name
FROM employees e
INNER JOIN departments d 
ON e.department_id = d.id
WHERE d.department_name = 'Sales';

--4. Task: Retrieve customers who have not placed any orders. 
--Tables: customers (columns: customer_id, name), orders (columns: order_id, customer_id)
SELECT 
	c.customer_id,
	c.name,
	o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL 

SELECT customer_id, name
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id FROM orders
);

--5. Task: Retrieve products with the highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)
SELECT 
	id,
	product_name,
	price,
	category_id
FROM products
WHERE price = (SELECT MAX(price) FROM products)

--6. Task: Retrieve employees working in the department with the highest average salary. 
--Tables: employees (columns: id, name, salary, department_id), departments (columns: id, department_name)

SELECT * FROM employees
where salary >
(
SELECT 
	e.id,
	e.name,
	AVG(salary) AS AVG_SALARY,
	e.department_id,
	d.id,
	d.department_name
FROM employees e
LEFT JOIN departments d
ON e.department_id = d.id
GROUP BY e.id,e.name,e.department_id,d.id,d.department_name
)



--7. Task: Retrieve employees earning more than the average salary in their department. 
--Tables: employees (columns: id, name, salary, department_id)

SELECT 
	id,
	name,
	salary,
	department_id
FROM employees
WHERE SALARY > (SELECT AVG(salary) from employees)

--8. Task: Retrieve students who received the highest grade in each course. 
--Tables: students (columns: student_id, name), grades (columns: student_id, course_id, grade)
SELECT 
	s.student_id, 
	s.name, 
	g.course_id, 
	g.grade
FROM grades g
JOIN students s ON g.student_id = s.student_id
WHERE g.grade = (
    SELECT MAX(grade)
    FROM grades g2
    WHERE g2.course_id = g.course_id
);

--9. Find Third-Highest Price per Category Task: Retrieve products with the third-highest price in each category. 
--Tables: products (columns: id, product_name, price, category_id)

SELECT id, product_name, price, category_id
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY category_id ORDER BY price DESC) AS rank_in_category
    FROM products
) ranked
WHERE rank_in_category = 3;

--10. Task: Retrieve employees with salaries above the company average but below the maximum in their department. 
--Tables: employees (columns: id, name, salary, department_id)

SELECT 
	e.id, 
	e.name, 
	e.salary, 
	e.department_id
FROM employees e
WHERE e.salary > 
(
    SELECT AVG(salary) FROM employees
)
AND 
e.salary < (
    SELECT MAX(salary)
    FROM employees d
    WHERE d.department_id = e.department_id
);