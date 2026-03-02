# Experiment 6 – Implementation of Views in SQL

---

## Student Details

- **Student Name:** Pratham  
- **UID:** 25MCI10178  
- **Branch:** MCA (AI & ML)  
- **Section/Group:** 25MAM_KAR-1_A  
- **Semester:** II  
- **Date of Performance:** 24/02/26  
- **Subject Name:** Technical Training  
- **Subject Code:** 25CAP-652  

---

## Experiment Aim

To learn how to create, query, and manage views in SQL to simplify database queries and provide a layer of abstraction for end-users.

---

## Tools Used

- Oracle  
- MS SQL Server (SSMS)  
- PostgreSQL  

---

## Objectives

- **Data Abstraction:** Hide complex table joins and calculations behind a simple virtual table interface.  
- **Enhanced Security:** Restrict user access to sensitive columns using views instead of direct table access.  
- **Query Simplification:** Create views that pre-join multiple tables for easier reporting.  
- **View Management:** Understand syntax for creating, replacing, and managing views efficiently.  

---

# Experiment Steps

---

## Create Base Tables

### Create Departments Table

```sql
CREATE TABLE Departments (
    dept_id INTEGER PRIMARY KEY,
    dept_name VARCHAR(50)
);
```

### Insert Data into Departments

```sql
INSERT INTO Departments (dept_id, dept_name) VALUES
(1, 'HR'),
(2, 'IT'),
(3, 'Finance');
```
<img width="444" height="179" alt="image" src="https://github.com/user-attachments/assets/f71f623a-d412-461d-9e1e-b20625fdbe71" />

---

### Create Employees Table

```sql
CREATE TABLE Employees (
    emp_id INTEGER PRIMARY KEY,
    emp_name VARCHAR(50),
    city VARCHAR(50),
    salary INTEGER,
    status VARCHAR(20),
    dept_id INTEGER REFERENCES Departments(dept_id)
);
```

### Insert Data into Employees

```sql
INSERT INTO Employees (emp_id, emp_name, city, salary, status, dept_id) VALUES
(101, 'Rahul', 'Delhi', 50000, 'Active', 1),
(102, 'Anita', 'Mumbai', 60000, 'Active', 2),
(103, 'Aman', 'Chandigarh', 45000, 'Inactive', 2),
(104, 'Priya', 'Delhi', 70000, 'Active', 3);
```

<img width="1090" height="213" alt="image" src="https://github.com/user-attachments/assets/283fc924-f384-476f-8020-92c5e4e3f57b" />

---

# Step 1: Creating a Simple View for Data Filtering

### Description

Implementing a view to provide a quick list of active employees without exposing the entire table structure.

### Create View

```sql
CREATE VIEW Active_Employees_View AS
SELECT emp_id, emp_name, city, salary
FROM Employees
WHERE status = 'Active';
```

### Query the View

```sql
SELECT * FROM Active_Employees_View;
```
<img width="841" height="173" alt="image" src="https://github.com/user-attachments/assets/12a23c2c-0f6e-4e77-8735-aec8b44151d7" />

---

# Step 2: Creating a View for Joining Multiple Tables

### Description

Simplifying the retrieval of data distributed across Employees and Departments tables.

### Create Join View

```sql
CREATE OR REPLACE VIEW Employee_Department_View AS
SELECT e.emp_id,
       e.emp_name,
       e.city,
       e.salary,
       d.dept_name
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id;
```

### Query the View

```sql
SELECT * FROM Employee_Department_View;
```
<img width="976" height="223" alt="image" src="https://github.com/user-attachments/assets/4a56c3cb-ba0d-4aaf-9e37-5c0924517f80" />

---

# Step 3: Advanced Summarization View

### Description

Creating a view to provide department-level statistics automatically.

### Create Summary View

```sql
CREATE VIEW Department_Summary_View AS
SELECT d.dept_name,
       COUNT(e.emp_id) AS total_employees,
       AVG(e.salary) AS average_salary,
       SUM(e.salary) AS total_salary
FROM Employees e
JOIN Departments d
ON e.dept_id = d.dept_id
GROUP BY d.dept_name;
```

### Query the View

```sql
SELECT * FROM Department_Summary_View;
```
<img width="952" height="203" alt="image" src="https://github.com/user-attachments/assets/c3edc96c-56d2-433a-8621-d16d309a35c4" />

---

# Results

- Successfully created simple view for filtering active employees.
- Successfully created join view combining Employees and Departments.
- Successfully created summarization view showing department-level statistics.
- Verified all views using SELECT statements.

---

# Learning Outcomes

- Learned to create and manage SQL Views.
- Understood how views provide data abstraction and security.
- Gained knowledge of joining tables inside views.
- Implemented aggregation functions within views.
- Understood practical applications of views in real-world database systems.
This experiment demonstrated the creation and management of SQL Views including simple filtering views, join views, and summarization views. Views improve security, simplify queries, and provide logical abstraction between users and database tables. The experiment successfully achieved all stated objectives.

---
