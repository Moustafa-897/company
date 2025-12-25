CREATE DATABASE company_db;

CREATE TABLE employees(
    emp_id INT AUTO_INCREMENT PRIMARY KEY,
    emp_name varchar(50),
    department varchar(50),
    salary int,
    manager_id int,
    city varchar(50)
);

INSERT INTO employees (emp_name,department,salary,manager_id,city) VALUES('Noor', 'HR', 50000, 3, 'Beirut'), ('Hassan', 'IT', 60000, 4, 'Baalback'), ('Hady', 'HR', 70000, NULL, 'Beirut'), ('Ali', 'IT', 80000, NULL, 'Tripoli'), ('Mouhammad', 'Sales', 45000, 6, 'Saida'), ('Zayn', 'Sales', 65000, NULL, 'Beqaa');

SELECT DISTINCT department FROM employees;

SELECT emp_name,salary FROM employees WHERE salary>50000 AND department IN ('IT', 'HR');

SELECT emp_name FROM employees WHERE emp_name LIKE "H%"

SELECT emp_name, salary
FROM employees
ORDER BY salary DESC
LIMIT 3;

SELECT department, SUM(salary) AS TotalSalary
FROM employees
GROUP BY department;

SELECT department, SUM(salary) AS TotalSalary
FROM employees
GROUP BY department WITH ROLLUP;

SELECT emp_name, city FROM employees WHERE city = 'Beirut'
UNION
SELECT emp_name, city FROM employees WHERE city = 'Beqaa';

SELECT e.emp_name AS EmployeeName, m.emp_name AS ManagerName
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.emp_id;

SELECT emp_name, salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

CREATE VIEW IT_Employees AS
SELECT emp_name, department, salary
FROM employees
WHERE department = 'IT';

SELECT * FROM IT_Employees;

DELIMITER //
CREATE PROCEDURE GetAllEmployees()
BEGIN
    SELECT * FROM employees;
END //
DELIMITER ;

CALL GetAllEmployees();

DELIMITER //
CREATE PROCEDURE GetEmployeesByDepartment(IN deptName VARCHAR(100))
BEGIN
    SELECT * FROM employees WHERE department = deptName;
END //
DELIMITER ;

CALL GetEmployeesByDepartment('HR');

DELIMITER //
CREATE PROCEDURE GetEmployeesBySalary(IN minSalary DECIMAL(10, 2))
BEGIN
    SELECT * FROM employees WHERE salary > minSalary;
END //
DELIMITER ;

CALL GetEmployeesBySalary(60000);

