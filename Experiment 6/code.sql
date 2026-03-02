CREATE TABLE Departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(50)
);
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');
CREATE TABLE Employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    city VARCHAR(50),
    salary INTEGER,
    status VARCHAR(20),
    dept_id INTEGER REFERENCES Departments(dept_id)
);
INSERT INTO Employees (emp_id, emp_name, city, salary, status, dept_id) VALUES
(101, 'Rahul', 'Delhi', 50000, 'Active', 1),
(102, 'Anita', 'Mumbai', 60000, 'Active', 2),
(103, 'Aman', 'Chandigarh', 45000, 'Inactive', 2),
(104, 'Priya', 'Delhi', 70000, 'Active', 3);
select * from employees;
select * from departments;


CREATE VIEW Active_Employees_View AS
SELECT emp_id, emp_name, city, salary
FROM Employees
WHERE status = 'Active';
INSERT INTO Active_Employees_View
VALUES (105, 'Vikas', 'Agra', 55000);
SELECT * FROM Active_Employees_View;


CREATE OR REPLACE VIEW Employee_Department_View AS
SELECT e.emp_id,
       e.emp_name,
       e.city,
       e.salary,
       d.dept_name
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id;
SELECT * FROM Employee_Department_View;


CREATE VIEW Department_Summary_View AS
SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS average_salary,
       SUM(e.salary) AS total_salary
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
SELECT * FROM Department_Summary_View;
