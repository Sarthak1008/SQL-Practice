
create database ORGG;
show databases;
use ORGG;

create table Worker (
	WORKER_ID int not null primary key auto_increment,
    FIRST_NAME varchar(25),
    LAST_NAME varchar(25),
    SALARY int(15),
    JOINING_DATE datetime,
    DEPARTMENT char(25)
);

INSERT INTO Worker
	(WORKER_ID,FIRST_NAME,LAST_NAME,SALARY,JOINING_DATE,DEPARTMENT) values
		(001, 'Monika', 'Arora', 100000, '14-02-22 08.00.00', 'HR'),
        (002, 'Atharva', 'Kothekar', 80000, '14-02-22 08.00.00', 'IT'),
        (003, 'Prathmesh', 'Shukla', 90000, '14-02-22 08.00.00', 'IT'),
        (004, 'Pranav', 'Soni', 70000, '14-02-22 08.00.00', 'IT'),
        (005, 'Vishal', 'Singh', 100000, '14-02-22 08.00.00', 'Admin'),
        (006, 'Sujal', 'Vajire', 90000, '14-02-22 08.00.00', 'Account'),
        (007, 'Vedang', 'Gaur', 100000, '14-02-22 08.00.00', 'Account'),
        (008, 'Karan', 'Aggarwal', 600000, '14-02-22 08.00.00', 'Admin');
    
select * from worker;

create table Bonus (
WORKER_REF_ID INT,
BONUS_AMOUNT int(10),
BONUS_DATE datetime,
foreign key (WORKER_REF_ID)
	references Worker(WORKER_ID)
    ON DELETE CASCADE
);

insert into Bonus 
	(WORKER_REF_ID,BONUS_AMOUNT,BONUS_DATE) values
		(001, 5000, '16-02-23'),
        (002, 3000, '16-02-23'),
        (003, 4000, '16-02-23'),
        (001, 5500, '17-02-23'),
        (002, 7000, '17-02-23');
        
create table Title (
WORKER_REF_ID INT,
WORKER_TITLE char(25),
AFFECTED_FROM datetime,
foreign key (WORKER_REF_ID)
	references Worker(WORKER_ID)
    ON DELETE CASCADE
);

drop table Title;

insert into Title 
	(WORKER_REF_ID,WORKER_TITLE,AFFECTED_FROM) values
		(001, 'Manager', '16-02-23 00:00:00'),
        (002, 'Executive', '16-02-23 00:00:00'),
        (008, 'Executive', '16-02-23 00:00:00'),
        (005, 'Asst. Manager', '17-02-23 00:00:00'),
        (004, 'Executive', '17-02-23 00:00:00'),
        (007, 'Lead', '17-02-23 00:00:00'),
        (006, 'Lead', '17-02-23 00:00:00'),
        (003, 'Lead', '17-02-23 00:00:00');
        



select FIRST_NAME, SALARY from worker;

select 55 + 11; -- without refering a table, no FROM clause / DUAL TABLE
select now();
select lcase('HELLO');

select * from Worker;

select * from worker where SALARY > 80000;

-- salary between 80,000 and 3,00,000 both inclusive
select * from worker where SALARY between 80000 and 300000;

select * from worker where DEPARTMENT = 'HR';

-- reduce OR statements
-- HR AND ADMIN
select * from worker where DEPARTMENT = 'HR' or DEPARTMENT = 'admin' or DEPARTMENT = 'IT';
-- better way -  to reduce multiple ORs
select * from worker where DEPARTMENT in ('HR', 'IT');

-- not
select * from worker where DEPARTMENT not in ('HR', 'IT');

-- is NULL is used to specify which entry has NULL value in it

-- WILDCARD '%pa%' - "abcpasss" / 'pabggh'
-- WILDCARD '_pa_' - 'rpad'

-- WILDCARD
select * from worker where first_name like '%i%';
select * from worker where first_name like '_i%';

-- SORTING
SELECT * FROM Worker order by SALARY; -- ascending
SELECT * FROM Worker order by SALARY desc; -- descending

-- DISTINCT
select distinct department from worker;

-- DATA GROUPING
-- Find number of workers working in different department
-- Group By keyword is often used with some aggregation function
select department, count(department) from worker group by department;

-- find average salary per department
select department, avg(salary) from worker group by department;

-- find min salary per department
select department, min(salary) from worker group by department;

-- find max salary per department
select department, max(salary) from worker group by department;

-- find sum of salariries per department
select department, sum(salary) from worker group by department;

-- GROUP BY HAVING
-- department and its count having more than 2 workers

select department, count(department) from worker group by department having count(department) > 1;

-- DLL KEY CONSTRAINTS
-- PRIMARY KEY
-- FORIEGN KEY
-- UNIQUE - attribute that is unique in nature
-- check table

create database temp;
use temp;

create table account(
	id int primary key,
    name varchar(255) unique,
    balance int,
    constraint acc_balance_chk check(balance > 1000)
);

insert into account(id, name, balance) values
	(1, 'A', 10000);
    
insert into account(id, name, balance) values
	(2, 'B', 5000);

drop table account;

-- DEFAULT CONSTRAINT
-- eg. amazon prime status can be 0;

create table account(
	id int primary key,
    name varchar(255) unique,
    balance int not null default 0
);

insert into account(id, name) values
	(1, 'A');
    
insert into account(id, name) values
	(2, 'B');

--  ADD NEW COLUMN
Alter table account add interest float not null default 0;

-- modify
alter table account modify interest double not null default 0;
desc account;

-- change column - RENAME THE COLUMN
alter table account rename column interest to account_interest;

-- DROP COLUMN
alter table account drop column saving_interest;

-- RENAME THE TABLE
alter table account rename to account_details;

-- DML commands

create database temp;
use temp;
create table customer (
id int primary key,
cname varchar(200),
Address varchar(255),
Gender char(2),
city varchar(255),
Pincode integer
);

insert into customer(id, cname, Address, Gender, city, Pincode) values
	(1251, 'Ram Kumar', 'Dilbag Nagar', 'M', 'Jalandar', 144002);
    
insert into customer values (1, 'Tushar Toteja', 'Mumbai', 'M', 'Kharghar', 410210);

insert into customer(id, cname) 
values (121, 'Raj');

-- UPDATE
UPDATE customer set Address='Gudgaon', Gender='M' where id = 121;

-- UPDATE MULTIPLE ROWS

--  The sql_safe_updates variable is used to enable or disable the safe update mode of MySQL. The safe 
-- update mode is disabled by default. 

-- The SET statement 1 affects statement processing as follows: Enabling sql_safe_updates causes UPDATE and 
-- DELETE statements to produce an error if they do not specify a key constraint in the WHERE clause, or 
-- provide a LIMIT clause, or both.
set SQL_SAFE_UPDATES = 1;
update customer set pincode = 410210;

-- You can use the SET statement to disable the safe update as shown below: SET SQL_SAFE_UPDATES = 0; Now you 
-- should be able to execute an UPDATE or DELETE statement without a WHERE clause.
set SQL_SAFE_UPDATES = 0;

-- DELETE 
delete from customer where id = 121;
delete from customer;

-- Referential Constraints
create table Order_details (
Order_id integer primary key auto_increment,
delivery_date DATE,
cust_id int,
foreign key(cust_id) references customer(id)
);

insert into Order_details 
values (1, '2019-04-12', 1251);

-- now if we do this
delete from Customer where id = 1251; -- Error Code: 1451. Cannot delete or update a parent row: a foreign key constraint fails (`temp`.`order_details`, CONSTRAINT `order_details_ibfk_1` FOREIGN KEY (`cust_id`) REFERENCES `customer` (`id`))

-- But, to avoid this we can do 2 things:
-- 1st method to use ON DELETE CASCADE
create table Order_details (
Order_id integer primary key,
delivery_date DATE,
cust_id int,
foreign key(cust_id) references customer(id) on delete cascade
);
insert into Order_details 
values (1, '2019-04-12', 1251);

delete from Customer where id = 1251;

-- 2nd method to use ON DELETE SET NULL
create table Order_details (
Order_id integer primary key,
delivery_date DATE,
cust_id int,
-- On Delete Set Null clause sets all the records of the column which is defined as a foreign key in the 
-- child table to Null if the corresponding record in the parent table is deleted.
foreign key(cust_id) references customer(id) on delete set null
);

insert into Order_details 
values (1, '2019-04-12', 1251);

delete from Customer where id = 1251;

-- REPLACE COMMAND
-- Data already present, Replace
-- Data not present, INSERT

replace into Customer (id,city)
	values (1251, 'Colony');
    
replace into customer set id = 1333, cname = 'Harish', City = 'Utah';

-- if row is not present, replace will add a new row while update will do nothing

-- JOINS
-- INNER JOIN

create database EMPLOYEE;
use employee;

create table Employee (
	id int not null primary key auto_increment,
    fname varchar(25),
    lname varchar(25),
    Age int(4),
    emailID varchar(100),
    PhoneNo varchar(21),
    City varchar(100)
);

insert into employee values
	(1, 'Aman', 'Proto', 32, 'aman@gmail.com', 9999944444, 'Delhi'),    
    (2, 'Yagya', 'Narayan', 44, 'yagya@gmail.com', 8888877777, 'Palam'),
	(3, 'Rahul', 'BD', 22, 'rahul@gmail.com', 8888877799, 'Kolkata'),
	(4, 'Jatin', 'Hermit', 31, 'jatin@gmail.com', 8008877777, 'Raipur'),
	(5, 'PK', 'Pandey', 21, 'pk@gmail.com', 8888877007, 'Noida');
    
create table Client (
	id int not null primary key auto_increment,
    fname varchar(25),
    lname varchar(25),
    Age int(4),
    emailID varchar(100),
    PhoneNo varchar(21),
    City varchar(100),
    empID int,
	foreign key (empID)
	references Employee(id)
    ON DELETE CASCADE
);

insert into client values
	(1, 'Mac', 'Rogers', 47, 'mac@gmail.com', '9000944444', 'Kharghar', 3),    
    (2, 'Max', 'Poirier', 27, 'max@gmail.com', '7000877777', 'Noida', 3),
	(3, 'Peter', 'Jain', 24, 'peter@gmail.com', '8866677799', 'Jaipur', 1),
	(4, 'Sushant', 'Aggarwal', 23, 'sushant@gmail.com', '6008877777', 'Kandiwali', 5),
	(5, 'Pratap', 'Singh', 36, 'pratap@gmail.com', '5888877007', 'Andheri', 2);

create table Project (
	id int not null primary key auto_increment,
    
    empID int,
    name varchar(255),
    startdate date,
    clientID int,
	foreign key (empID)
	references Employee(id),
    foreign key (clientID)
	references Client(id)
);

insert into project values
	(1, 1, 'A', '2021-04-21', 3),
    (2, 2, 'B', '2021-03-12', 1),
    (3, 3, 'C', '2021-01-16', 5),
    (4, 3, 'D', '2021-04-27', 2),
    (5, 5, 'E', '2021-05-01', 4);
    
-- INNER JOIN
-- Enlist all the employees IDs, names along with the project allocated to them

select e.id, e.fname, e.lname, p.id, p.name from employee as e
INNER JOIN project as p 
ON e.id = p.empID;
	
-- Fetch out all the employee ID and their contact details who have 
-- been working from delhi with the client name workng in jaipur

select e.id, e.fname, e.emailID, e.PhoneNo, c.id, c.fname, c.lname from employee as e
INNER JOIN client as c
ON e.id = c.empid
WHERE e.city = 'Delhi' and c.city = 'Jaipur';

-- LEFT JOIN
-- fetch out each project allocated to each employee
select * from employee 
LEFT JOIN project
ON employee.id = project.empid;

-- RIGHT JOIN
-- list down all the projects along with employees name and their respective allocated email id
select p.*, e.fname, e.lname, e.emailID from employee as e
RIGHT JOIN project as p
ON e.id = p.empID;

-- CROSS JOIN
-- List down all the possible combinations of employees and projects that can be assigned
select e.id, e.fname, e.lname, p.id, p.name from employee as e
CROSS JOIN project as p;

-- Can we use INNER JOIN without using the join keyword?
-- YES
select e.id, e.fname, e.lname, p.id, p.name from employee as e, project as p 
WHERE e.id = p.empID;

-- SET OPERATIONS
create database company;
use company;

create table dept1 (
	empID int primary key auto_increment, 
    name varchar(255),
    role varchar(255)
);

insert into dept1 values
	(1, 'A', 'engineer'),
    (2, 'B', 'salesman'),
    (3, 'C', 'manager'),
    (4, 'D', 'salesman'),
    (5, 'E', 'engineer');
    
create table dept2 (
	empID int primary key auto_increment, 
    name varchar(255),
    role varchar(255)
);

insert into dept2 values
    (3, 'C', 'manager'),
    (6, 'F', 'marketing'),
    (7, 'G', 'salesman');
    
-- SET OPERATIONS
-- List out all the employees in the company
select * from dept1
UNION ALL
select * from dept2;

-- List out all the employees from all the departments that work as salesman
select * from dept1 where role = 'salesman'
UNION
select * from dept2 where role = 'salesman';

-- INTERSECTION SET OPERATION
-- List out all the employees that work in all the departments
select dept1.* from dept1 inner join dept2 using(empID);

-- MINUS SET OPERATION
-- List out all the employees working in department 1 but not in department 2;
select dept1.* from dept1 LEFT JOIN dept2 using(empID) where dept2.empID is null;


-- SUBQUERIES
-- ALternative to joins
-- We have two parts, Outer query and inner query
-- First inner query is executed then the outer

-- USING THE DATASET WE CREATED AT THE TIME OF JOINS
USE employee;

-- Employees AGE > 30
select * from employee where age in (select age from employee where age > 30);
-- In the above eg, the subquery executes first and provides the list of ages > 30, then the outer query runs for each age

-- employee details working in more than 1 project
select * from employee where id in (
select empID from project group by empID having count(empID) > 1);

-- Single Value Subquery
-- employee details having age > avg(age)
select avg(age) from employee;
select * from employee where age > (
	select avg(age) from employee
);

-- Adding subquery after the from clause
-- select max age person whose first name conatins a
select max(age) from (select * from employee where fname like '%a%');
-- we get an error
-- Error Code: 1248. Every derived table must have its own alias
select max(age) from (select * from employee where fname like '%a%') AS temp;


-- CORELATED SUBQUERY
-- Inner query refers the Outer query
-- Find 3rd oldest employee
select * from employee e1 
where 3 = (
	select count(e2.age) from employee e2
    where e2.age >= e1.age    
);

-- VIEWS, created to give different views of the same database to different people
select * from employee;

-- Creating a view
CREATE VIEW custom_view AS SELECT fname, age from employee;
create view org_view as select d.empID, d.name from dept1 as d 
join dept2 t using(empID);

select * from org_view;

-- Viewing the VIEW
select * from custom_view;

-- Altering the View
ALTER VIEW custom_view as select fname, lname, age from employee;

-- Drop the view
DROP VIEW IF exists custom_view;


-- Q) Difference between SUBSTRING and substr
-- SUBSTR : This function returns a portion of a string from a given start point to an end point. 
-- If a substring length is not given, then SUBSTR returns all the characters till the end of string (from the starting position specified).

-- SUBSTRING function accepts three-parameter like String, start, length

-- ASG - RANK SQL
use company;
Create table employee(
name varchar(255),
salary int
);

Create table employee1(
id int,
salary int
);

insert into employee values ("A",30000),("B",30000),("C",25000);
insert into employee1 values (1,30000),(2,30000),(3,25000);
insert into employee1 values (4,10000),(5,10000),(6,10000);
insert into employee1 values (7,8000),(8,8000),(9,7000),(10,8000);
select e1.id, e1.salary from employee1 e join employee1 e1 on e.salary=e1.salary;
use company;
select * from employee1 e join employee1 e1 on e.salary=e1.salary;
select e1.salary from employee1 e join employee1 e1 on e.salary=e1.salary where( e.id<e1.id and abs(e.id-e1.id)=1);  
(select e1.salary from employee1 e join employee1 e1 on e.id=e1.id where e.salary=e.salary and abs(e.id-e1.id)>1);
select e1.id from employee1 e join employee1 e1 on e.id=e1.id where e.salary=e1.salary and abs(e.id-e1.id)=1;

select * from employee1 order by id;


select e1.salary from employee1 e join employee1 e1 on e.id = e1.id + 1 and e.salary = e1.salary join employee1 e3 on e.id = e3.id + 2 and e.salary = e3.salary;

-- TASK TO APPLY to find 4 consecutive salary entries.
insert into employee1 values (11,8999),(12,8999),(13,8999),(14,8999);
select e1.salary from employee1 e join employee1 e1 on e.id = e1.id + 1 and e.salary = e1.salary 
join employee1 e2 on e.id = e2.id + 2 and e.salary = e2.salary
join employee1 e3 on e.id = e3.id + 3 and e.salary = e3.salary;

use temp;
CREATE TABLE rank_demo (  
    first_name VARCHAR(60),  
    last_name VARCHAR(40),  
    city VARCHAR(30)  
);

INSERT INTO rank_demo (first_name, last_name, city)         
VALUES ('Luisa', 'Evans', 'Texas'),         
('Paul', 'Ward', 'Alaska'),         
('Peter', 'Bennett', 'California'),      
('Carlos', 'Patterson', 'New York'),         
('Rose', 'Huges', 'Florida'),    
('Marielia', 'Simmons', 'Texas'),  
('Antonio', 'Butler', 'New York'),         
('Diego', 'Cox', 'California');

SELECT first_name, last_name, city,   
RANK () OVER (ORDER BY city) AS Rank_No   
FROM rank_demo;    

SELECT first_name, last_name, city,   
RANK () OVER (PARTITION BY city ORDER BY first_name) AS Rank_No   
FROM rank_demo; -- 1,2,2,4

SELECT first_name, last_name, city,   
ROW_NUMBER() OVER(ORDER BY city) AS my_rank   
FROM rank_demo;  -- 1,2,3,4

SELECT first_name, last_name, city,   
DENSE_RANK() OVER(ORDER BY city) AS my_rank   
FROM rank_demo;     -- 1,2,2,3

create table EmpDup(empid int,name varchar(20));
insert into EmpDup values(1,'Tushar'),
     (1,'Tushar'),
    (2,'Chris'),
    (3,'Bill'),
    (3,'Bill'),
    (3,'Bill');
    
alter table EmpDup add sno int unique not null auto_increment;
select *,
    RANK() OVER ( PARTITION BY empid,name ORDER BY sno ) as ranking
    From EmpDup;
select * from (select *,
    RANK() OVER ( PARTITION BY empid,name ORDER BY sno ) as ranking
    From EmpDup) as a where ranking > 1;

select * from EmpDup E 
inner join (select *,
    RANK() OVER ( PARTITION BY empid,name ORDER BY sno ) as ranking
    From EmpDup) as a on E.sno = a.sno
    where a.ranking > 1;
    
delete E from EmpDup E 
inner join (select *,
    RANK() OVER ( PARTITION BY empid,name ORDER BY sno ) as ranking
    From EmpDup) as a on E.sno = a.sno
    where a.ranking > 1;
    
select * from EmpDup;

alter table EmpDup 
drop  column sno;
    

    
    