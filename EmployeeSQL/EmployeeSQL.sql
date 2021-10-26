-- Exported from QuickDBD: https://www.quickdatabasediagrams.com/
-- Link to schema: https://app.quickdatabasediagrams.com/#/d/8BymvI
-- NOTE! If you have used non-SQL datatypes in your design, you will have to change these here.


CREATE TABLE "departments" (
    "dept_no" VARCHAR   NOT NULL,
    "dept_name" VARCHAR   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" INT   NOT NULL,
	"dept_no" VARCHAR   NOT NULL,
    CONSTRAINT "pk_dept_emp" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "dept_manager" (
    "dept_no" VARCHAR   NOT NULL,
    "emp_no" INT   NOT NULL,
    CONSTRAINT "pk_dept_manager" PRIMARY KEY (
        "dept_no","emp_no"
     )
);

CREATE TABLE "employees" (
    "emp_no" INT   NOT NULL,
    "emp_title_id" VARCHAR   NOT NULL,
    "birth_date" VARCHAR   NOT NULL,
    "first_name" VARCHAR   NOT NULL,
    "last_name" VARCHAR   NOT NULL,
    "sex" VARCHAR   NOT NULL,
    "hire_date" VARCHAR   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" INT   NOT NULL,
    "salary" INT   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "titles" (
    "title_id" VARCHAR   NOT NULL,
    "title" VARCHAR   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_no" FOREIGN KEY("emp_no")
REFERENCES "salaries" ("emp_no");

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

SELECT * FROM departments

SELECT * FROM dept_emp

SELECT * FROM dept_manager

SELECT * FROM employees

SELECT * FROM salaries

SELECT * FROM titles

---Data Analysis
--1.
SELECT e.emp_no as "employee number", e.last_name as "last name", e.first_name as "first name", e.sex, s.salary
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no;

--2.
SELECT first_name as "first name", last_name as "last name", hire_date as "hire date"
FROM employees
WHERE hire_date like '%1986';

--3.
SELECT dept_emp.dept_no as "department number", departments.dept_name as "department name", 
       dept_manager.emp_no as "the manager's employee number", 
       employees.last_name as "last name", employees.first_name as "first name"
FROM dept_emp, departments, dept_manager, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_manager.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no;

--4.
SELECT dept_emp.emp_no as "employee number", employees.last_name as "last name", employees.first_name as "first name",
       departments.dept_name as "department name"
FROM employees, dept_emp, departments
WHERE dept_emp.emp_no = employees.emp_no
      AND dept_emp.dept_no = departments.dept_no;

--5.
SELECT employees.first_name as "first name", employees.last_name as "last name", employees.sex
FROM employees
WHERE employees.first_name like 'Hercules'
      AND employees.last_name like 'B%';

--6.
SELECT dept_emp.emp_no as "employee number",    
       employees.last_name as "last name", employees.first_name as "first name", 
	   departments.dept_name as "department name"
FROM dept_emp, departments, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no
	  AND departments.dept_name like 'Sales';
	  
--7.
SELECT dept_emp.emp_no as "employee number",    
       employees.last_name as "last name", employees.first_name as "first name", 
	   departments.dept_name as "department name"
FROM dept_emp, departments, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no
	  AND (departments.dept_name like 'Sales' OR departments.dept_name like 'Development');

--8.
SELECT last_name as "last name", count(last_name) as "count employee share last name"
FROM employees
GROUP BY last_name
ORDER BY "count employee share last name" desc


