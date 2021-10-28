# SQL Homework - Employee Database: A Mystery in Two Parts

![sql.png](sql.png)

## Background

It is a beautiful spring day, and it is two weeks since you have been hired as a new data engineer at Pewlett Hackard. Your first major task is a research project on employees of the corporation from the 1980s and 1990s. All that remain of the database of employees from that period are six CSV files.

In this assignment, you will design the tables to hold data in the CSVs, import the CSVs into a SQL database, and answer questions about the data. In other words, you will perform:

1. Data Modeling and Data Engineering

2. Data Analysis

### Before You Begin

1. Create a new repository for this project called `sql-challenge`. **Do not add this homework to an existing repository**.

2. Clone the new repository to your computer.

3. Inside your local git repository, create a directory for the SQL challenge. Use a folder name to correspond to the challenge: **EmployeeSQL**.

4. Add your files to this folder.

5. Push the above changes to GitHub.

## Instructions

### Data Modeling

Inspect the CSVs and sketch out an ERD of the tables. Feel free to use a tool like [http://www.quickdatabasediagrams.com](http://www.quickdatabasediagrams.com).

### Data Engineering

* Use the information you have to create a table schema for each of the six CSV files. Remember to specify data types, primary keys, foreign keys, and other constraints.

 


  * For the primary keys check to see if the column is unique, otherwise create a [composite key](https://en.wikipedia.org/wiki/Compound_key). Which takes two primary keys in order to uniquely identify a row.

  * Be sure to create tables in the correct order to handle foreign keys.

* Import each CSV file into the corresponding SQL table. **Note** be sure to import the data in the same order that the tables were created and account for the headers when importing to avoid errors.

### My thorough README.md file
   1. Open all CSC files in excel to determine data types and primary keys for fields in each file. Primary key is the relation from one to other tables.
   2. Open https://quickdatabasediagrams.com : Create Schemata (the order of column headers are matter) and assign primary key and data type ( foreign could be auto create by tool when drawing lines)
   3. Start connecting Primary Key from one table to other table with the same name or same data field (but field name is not the same) just like diasy chain
   4. When you think that you can join one table to other to get the data you want, you need to Export --> Postgresqpl to project folder and rename it as EmployeeSQL.sql     
   5. Using Postgesql: Create Table: Employee_db and open EmployeeSQL.sql and run to create table if have error(s), identify error (s) and then change them and repeat step 4.
   6. When tables create correctly, run SELECT * FROM "each table" to verify table headers
   7. Right click on each table (Employee_db-->Schemas-->Tables) and import data (CSV files, comma delimitted) for each table and run SELECT * FROM "each table name" to verify data.
   8. After all table import correctly and start doing Data Analysis 
    
   




      
### Data Analysis

Once you have a complete database, create queries to do the following:

1. List the following details of each employee: employee number, last name, first name, sex, and salary.
   
SELECT e.emp_no as "employee number", e.last_name as "last name", e.first_name as "first name", e.sex, s.salary
FROM employees as e, salaries as s
WHERE e.emp_no = s.emp_no;
   

2. List first name, last name, and hire date for employees who were hired in 1986.
SELECT first_name as "first name", last_name as "last name", hire_date as "hire date"
FROM employees
WHERE hire_date like '%1986';

3. List the manager of each department with the following information: department number, department name, the manager's employee number, last name, first name.
SELECT dept_emp.dept_no as "department number", departments.dept_name as "department name", 
       dept_manager.emp_no as "the manager's employee number", 
       employees.last_name as "last name", employees.first_name as "first name"
FROM dept_emp, departments, dept_manager, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_manager.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no;
4. List the department of each employee with the following information: employee number, last name, first name, and department name.
SELECT dept_emp.emp_no as "employee number", employees.last_name as "last name", employees.first_name as "first name",
       departments.dept_name as "department name"
FROM employees, dept_emp, departments
WHERE dept_emp.emp_no = employees.emp_no
      AND dept_emp.dept_no = departments.dept_no;
5. List first name, last name, and sex for employees whose first name is "Hercules" and last names begin with "B."
SELECT employees.first_name as "first name", employees.last_name as "last name", employees.sex
FROM employees
WHERE employees.first_name = 'Hercules'
      AND employees.last_name like 'B%';
6. List all employees in the Sales department, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no as "employee number",    
       employees.last_name as "last name", employees.first_name as "first name", 
	   departments.dept_name as "department name"
FROM dept_emp, departments, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no
	  AND departments.dept_name = 'Sales';
7. List all employees in the Sales and Development departments, including their employee number, last name, first name, and department name.
SELECT dept_emp.emp_no as "employee number",    
       employees.last_name as "last name", employees.first_name as "first name", 
	   departments.dept_name as "department name"
FROM dept_emp, departments, employees
WHERE dept_emp.dept_no = departments.dept_no
      AND dept_emp.emp_no = employees.emp_no
	  AND (departments.dept_name = 'Sales' OR departments.dept_name = 'Development');
8. In descending order, list the frequency count of employee last names, i.e., how many employees share each last name.
SELECT last_name as "last name", count(last_name) as "count employee share last name"
FROM employees
GROUP BY last_name
ORDER BY "count employee share last name" desc
## Bonus (Optional)

As you examine the data, you are overcome with a creeping suspicion that the dataset is fake. You surmise that your boss handed you spurious data in order to test the data engineering skills of a new employee. To confirm your hunch, you decide to take the following steps to generate a visualization of the data, with which you will confront your boss:

1. Import the SQL database into Pandas. (Yes, you could read the CSVs directly in Pandas, but you are, after all, trying to prove your technical mettle.) This step may require some research. Feel free to use the code below to get started. **Be sure to make any necessary modifications for your username, password, host, port, and database name:**

   ```sql
   from sqlalchemy import create_engine
   engine = create_engine('postgresql://localhost:5432/<your_db_name>')
   connection = engine.connect()
   ```

* Consult [SQLAlchemy documentation](https://docs.sqlalchemy.org/en/latest/core/engines.html#postgresql) for more information.

* If using a password, do not upload your password to your GitHub repository. See [https://www.youtube.com/watch?v=2uaTPmNvH0I](https://www.youtube.com/watch?v=2uaTPmNvH0I) and [https://help.github.com/en/github/using-git/ignoring-files](https://help.github.com/en/github/using-git/ignoring-files) for more information.

2. Create a histogram to visualize the most common salary ranges for employees.
employees_data = pd.read_sql("SELECT * FROM employees", connection)
bins = [40000, 50000, 60000, 70000, 80000, 90000, 100000, 110000, 120000, 130000]
plt.figure(figsize=(12,6))
plt.hist(salaries_data['salary'], bins, histtype='bar', color = 'g', rwidth=0.5)
plt.xlabel('Salary Range',fontsize=14)
plt.xticks(bins)
plt.ylabel('Counts', fontsize=14)
plt.title('The Most Common Salary Ranges',fontsize=20)
plt.grid(axis='y', alpha = 0.4)
plt.legend(bins)
plt.show()
3. Create a bar chart of average salary by title.
employees_salaries = pd.merge(employees_data, salaries_data, on="emp_no", how="inner")
employees_salaries

#Combine employees_salaries and title table with left_on 
combine_data = pd.merge(employees_salaries, title_data, how='left', left_on = 'emp_title_id', right_on = 'title_id')
combine_data

#group by title and average salary ( both ways working)
#combine_data = combine_data.groupby(['title'])['salary'].mean()
group_combine_data = combine_data.groupby(['title']).mean()['salary']

#formating the number in dataframe
combine_data_df = pd.DataFrame({'Average Salary': group_combine_data})
combine_data_df['Average Salary'] = round(combine_data_df['Average Salary'],2)
combine_data_df
#Create a bar chart of average salary by title.
combine_data_df = combine_data_df.sort_values("Average Salary", ascending = False)
combine_data_df.plot(kind='bar', figsize=(12,6), color = 'b', width = 0.4)
plt.ylabel('Average Salary', fontsize=14)
plt.title('Average Salary by Title',fontsize=20)
plt.grid(axis='y', alpha = 0.4)
plt.xlabel('Title',fontsize=14)
## Epilogue

Evidence in hand, you march into your boss's office and present the visualization. With a sly grin, your boss thanks you for your work. On your way out of the office, you hear the words, "Search your ID number." You look down at your badge to see that your employee ID number is 499942.

## Submission

* Create an image file of your ERD.

* Create a `.sql` file of your table schemata.

* Create a `.sql` file of your queries.

* (Optional) Create a Jupyter Notebook of the bonus analysis.

* Create and upload a repository with the above files to GitHub and post a link on BootCamp Spot.

* Ensure your repository has regular commits and a thorough README.md file

## Rubric

[Unit 9 Rubric - SQL Homework - Employee Database: A Mystery in Two Parts](https://docs.google.com/document/d/1OksnTYNCT0v0E-VkhIMJ9-iG0_oXNwCZAJlKV0aVMKQ/edit?usp=sharing)

- - -

## References

Mockaroo, LLC. (2021). Realistic Data Generator. [https://www.mockaroo.com/](https://www.mockaroo.com/)

- - -

© 2021 Trilogy Education Services, LLC, a 2U, Inc. brand. Confidential and Proprietary. All Rights Reserved.
