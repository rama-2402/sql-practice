/* INSERTING TABLES */
/* https://www.w3resource.com/mysql-exercises/create-table-exercises/ */

show databases;
use lco_films;
select database();
show tables;


create database if not exists w_database;

3
create table countries (
    country_id INT Not Null,
    country_name varchar(20) Not Null,
    region_id Int Not Null
);

4
create table dup_countries as select * from countries;

5
drop table countries;
create table countries (
    country_id varchar(4) not null,
    country_name varchar(40) default null,
    region_id decimal(5,0) default null
);

6
create table jobs(
    job_id varchar(5) Not Null,
    job_title varchar(40) not null,
    min_salary decimal(7,2),
    max_salary decimal(8,2),
    check(max_salary<=25000)
);

desc jobs;

7
drop table countries;
create table countries (
    country_id varchar(4) not null,
    country_name varchar(40) default null,
    region_id decimal(5,0) default null,
    check(country_name in ('India','China','Italy'))
);

desc countries;

8
create table job_history(
    employee_id varchar(5) not null,
    start_data Date not null,
    end_date date not null,
    job_id varchar(5) not null,
    department_id varchar(5) not null,
    check(end_date like '--/--/----')
);  

9
drop table countries;
create table countries (
    country_id varchar(4) Unique,
    country_name varchar(40) default null,
    region_id decimal(5,0) default null,
    check(country_name in ('India','China','Italy'))
);
desc countries;

10
drop table jobs;
create table jobs(
    job_id varchar(5) Not Null primary key,
    job_title varchar(40) not null default '',
    min_salary decimal(7,2) default 8000,
    max_salary decimal(8,2) default null
);
desc jobs;


11, 12.
drop table countries;
create table if not exists countries (
    country_id INT Not Null AUTO_INCREMENT,
    country_name varchar(20) Not Null,
    region_id varchar(5),
    primary key (country_id)
);

desc countries;


13
drop table countries;
create table if not exists countries (
    country_id INT Not Null AUTO_INCREMENT,
    country_name varchar(20) Not Null,
    region_id INT NOT NULL,
    primary key (country_id, region_id)
);

desc countries;


14
drop table job_history;
create table job_history(
    employee_id varchar(10) not null,
    start_date Date not null,
    end_date date not null,
    job_id varchar(5) not null,
    department_id varchar(5) not null,
    primary key(employee_id),
    foreign key (job_id) references jobs (job_id) ON DELETE CASCADE
);

desc job_history;


15.
drop table departments;
create table if not exists departments(
    department_id decimal(4,0) NOT NULL,
    department_name varchar(30) NOT NULL,
    manager_id decimal(6,0) NOT NULL,
    location_id decimal(4,0) NOT NULL,
    primary key(department_id, manager_id)
);

desc departments;

drop table employees;
create table if not exists employees(
    employee_id varchar(5) Not Null,
    first_name varchar(10) Not Null,
    last_name varchar(10) NOT NULL,
    email varchar(20) NOT NULL,
    phone_number varchar(20) NOT NULL,
    hire_date DATE NOT NULL,
    job_id varchar(5) NOT NULL,
    salary decimal(6,2) NOT NULL,
    commission varchar(10) NOT NULL,
    manager_id decimal(6,0) NOT NULL,
    department_id decimal(4,0) NOT NULL,
    primary key (employee_id),
    foreign key (department_id, manager_id) references departments (department_id, manager_id) on delete cascade
); 

desc employees;

/*********************************************************************/
/*                 SQL INSERT INTO DETAILS                           */
/* https://www.w3resource.com/mysql-exercises/insert-into-statement/ */
/*********************************************************************/

1. inserting random data to countries table 

show databases;
show tables;

-- first modifying the data type of the table to required format--
ALTER TABLE countries
MODIFY country_id varchar(2),
MODIFY country_name  varchar(40) NULL,
MODIFY region_id decimal(10,0);

INSERT INTO countries 
(country_id, country_name, region_id) VALUES
(01,"india",01),
(02,"usa",02),
(03,"thailand",03);

3. create a copy of the country table 

CREATE TABLE IF NOT EXISTS countries_new AS SELECT * FROM countries;


6. insert rows into countries_new table and then copy a row from countries_new to countries table

INSERT INTO countries_new 
(country_id, country_name, region_id) VALUES
('C1', "India", 1001),
('C2', "USA", 1007),
('C3', "UK", 1003);

INSERT INTO countries
SELECT * FROM countries_new WHERE country_id = "C1";

7. INSERT INTO JOB TABLE TO CHECK FOR PRIMARY KEY VALUES

INSERT INTO jobs 
(job_id, job_title, min_salary, max_salary) VALUES
("J1", "ML DA", 15000, 30000);


12. INSERT ROW IN JOB_HISTORY TABLE FROM THE JOBS TABLE

INSERT INTO job_history 
(employee_id, start_date, end_date, job_id, department_id) VALUES
("E001", "2018-12-17", "2022-12-17", "J1", "ML DA");




/*******************************************************************************/
/*                        SQL UPDATE DETAILS                                   */
/* https://www.w3resource.com/mysql-exercises/update-table-statement/index.php */
/*******************************************************************************/

1. SQL TO CHANGE THE EMAIL VALUE TO 'NOT AVAILABLE' FOR ALL ENTRIES IN EMPLOYEES TABLE

UPDATE employees SET email = 'not available';

2. UPDATE VALUE TO 'NOT AVAILABLE' AND 0.01 FOR EMAIL AND COMMISSION COLUMNS

UPDATE employees set email='not available', commission=0.01;

3. UPDATE VALUE TO 'NOT AVAILABLE' AND 0.01 FOR EMAIL AND COMMISSION COLUMNS for department_id 110*/

UPDATE employees set email='available', commission=1.00 WHERE department_id=110;

4. 

UPDATE employees set email='available' WHERE department_id=80 AND commission<.20;

5.

UPDATE employees set email='available' WHERE department_id = (SELECT department_id FROM departments WHERE department_name='Accounting');

6.

UPDATE employees SET salary=8000 WHERE employee_id=105 AND salary<5000;

7.

UPDATE employees SET job_id='SH_CLERK' WHERE department_id=30 AND job_id NOT LIKE 'SH%';

8.

UPDATE employees SET salary = CASE department_id 
    WHEN 40 THEN salary+(salary*.25)
    WHEN 90 THEN salary+(salary*.15)
    WHEN 110 THEN salary+(salary*.10)
    ELSE salary
END
WHERE department_id IN (40,90,110);

9.

UPDATE employees set salary = salary+(salary*.20), commission=commission+(commission*.10) WHERE job_id=(
    SELECT job_id FROM jobs WHERE job_id='PU_CLERK'
);

UPDATE jobs SET min_salary=min_salary+2000, max_salary=max_salary+2000 WHERE job_id='PU_CLERK';

ANOTHER METHOD

UPDATE jobs,employees
SET jobs.min_salary=jobs.min_salary+2000,
jobs.max_salary=jobs.max_salary+2000,
employees.salary=employees.salary+(employees.salary*.20),
employees.commission_pct=employees.commission_pct+.10
WHERE jobs.job_id='PU_CLERK'
AND employees.job_id='PU_CLERK';


/*******************************************************************************/
/*                        SQL ALTER DETAILS                                    */
/* https://www.w3resource.com/mysql-exercises/update-table-statement/index.php */
/*******************************************************************************/

1. RENAMING TABLE

RENAME TABLE countries TO country_new;

2. ADDING COLUMN 
ALTER TABLE country_new ADD COLUMN reg_id decimal(10,0) NOT NULL;

3. ADDING COLUMN FIRST
ALTER TABLE country_new ADD COLUMN reg_id_location decimal(10,0) NOT NULL FIRST;

4. ADDING COLUMN AFTER SOME COLUMN
ALTER TABLE country_new ADD COLUMN reg_id_dup decimal(10,0) NOT NULL AFTER country_name;

5. CHANDING DATA TYPE
ALTER TABLE country_new MODIFY reg_id_dup INT NOT NULL;

6. DROP COLUMN 
ALTER TABLE country_new DROP COLUMN reg_id_dup;

7. RENAME COLUMN
ALTER TABLE country_new RENAME COLUMN reg_id_location to reg_id_renamed;



/*******************************************************************************/
/*                             HR DATABASE                                     */
/*  https://www.w3resource.com/mysql-exercises/basic-simple-exercises/index.php*/
/*******************************************************************************/

1.
SELECT first_name AS 'First Name', last_name AS 'Last Name' FROM employees;

2.
SELECT DISTINCT department_id FROM employees;

3.
SELECT * FROM employees ORDER BY first_name;

4.
SELECT 
    CONCAT(first_name,' ',last_name) AS 'Names', 
    salary, 
    Round((salary * .15),2) as 'PF' 
FROM employees;

5.
SELECT 
employee_id AS 'ID',
CONCAT(first_name,' ',last_name) AS 'Names',
salary
FROM employees
ORDER BY salary;


6.
SELECT sum(salary) FROM employees;

7. 
SELECT max(salary) AS 'Max Salary',
min(salary) AS 'Min Salary'
FROM employees;

8.
SELECT
COUNT(employee_id) AS 'Employee Count',
Round(AVG(salary),2) AS 'Average Salary'
FROM employees;

10.
SELECT
COUNT( DISTINCT job_id) 
FROM employees;

11.
SELECT
UPPER(first_name) AS 'First Name',
UPPER(last_name) AS 'Last Name'
FROM employees;

12.
SELECT
SUBSTRING(first_name, 1,3)
FROM employees;

13.
SELECT 171+214+625 Result;

15.
SELECT
TRIM(first_name)
FROM employees;

16.
SELECT
LENGTH(first_name)
FROM employees;

17.
select first_name FROM employees WHERE first_name REGEXP '[0-9]';

18.
SELECT * FROM employees LIMIT 10;

19.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
Round(salary/12, 2) AS 'Monthly Salary'
FROM employees;

/*******************************/
/*Restrincting and Sorting data*/
/*******************************/

1.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
salary FROM employees 
WHERE
salary BETWEEN 10000 AND 15000
ORDER BY Names;

2.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
department_id AS 'Dept ID' FROM employees 
WHERE
department_id=30 OR department_id=100
ORDER BY Names;

3.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
salary,
department_id AS 'Dept ID' FROM employees 
WHERE
salary NOT BETWEEN 10000 AND 15000 AND
department_id=30 OR department_id=100
ORDER BY Names;

4.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
hire_date AS 'HIRE DATE'
FROM employees
WHERE YEAR(hire_date) = '1987';

5.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
first_name AS 'First Name'
FROM employees
WHERE first_name LIKE '%b%' AND first_name LIKE '%c%';

6.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
job_id as 'JOB',
salary AS 'Salary'
FROM employees
WHERE job_id IN 
(
    SELECT job_id FROM jobs WHERE 
    job_title = 'Programmer' OR job_title = 'Shipping Clerk'
)
AND
salary NOT IN(45000,10000,15000);

7.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
last_name AS 'Last Name'
FROM employees
WHERE
LENGTH(last_name)=6;

8.
SELECT CONCAT(first_name, ' ', last_name) AS "Names",
last_name AS 'Last Name'
FROM employees
WHERE
last_name LIKE '__e%';

9.
SELECT DISTINCT employees.job_id AS "ID",
jobs.job_title 
FROM employees, jobs
WHERE employees.job_id = jobs.job_id
ORDER BY employees.job_id;

10.
SELECT CONCAT(first_name, ' ', last_name) AS "Names" FROM employees
WHERE
last_name IN ('Blake', 'Scott', 'King', 'Ford');




/************************************/
/* Aggregate Functions and Group by */
/************************************/

4.
SELECT 
Max(salary) as 'Max Salary' 
FROM employees
WHERE job_id = (
    SELECT job_id FROM jobs WHERE job_title='Programmer'
) GROUP BY job_id;

5.
SELECT
ROUND(AVG(salary),2) as 'Average Salary',
COUNT(employee_id) as 'Headcount'
FROM employees
WHERE department_id=90;

6.
SELECT 
MAX(salary) as 'Max salary',
MIN(salary) as 'Min salary',
SUM(salary) as 'Total salary',
AVG(salary) as 'Average salary'
FROM employees;

7. 
SELECT 
job_id,
COUNT(*) AS 'No Count'
FROM employees
GROUP BY job_id;

8.
SELECT
(MAX(salary)-MIN(salary)) AS 'Difference'
FROM employees;

9.
SELECT
manager_id,
MIN(salary)
FROM employees
GROUP BY manager_id;

10.
SELECT
department_id,
SUM(salary)
FROM employees
GROUP BY department_id;

11. 
SELECT
job_id,
ROUND(AVG(salary),2)
FROM employees
WHERE job_id != (
    SELECT job_id FROM jobs WHERE job_title='Programmer'
) 
GROUP BY job_id;

12.
SELECT 
job_id,
MAX(salary) as 'Max salary',
MIN(salary) as 'Min salary',
SUM(salary) as 'Total salary',
AVG(salary) as 'Average salary'
FROM employees
WHERE department_id != 90
GROUP BY job_id;

13.
SELECT
job_id,
MAX(salary)
FROM employees
GROUP BY job_id
HAVING MAX(salary) >= 4000;

14.
SELECT
department_id,
AVG(salary),
COUNT(department_id)
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) > 10;













