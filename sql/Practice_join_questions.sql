create database practice;
use practice;
CREATE TABLE users (
 id INT(11) NOT NULL AUTO_INCREMENT,
 name VARCHAR(50) NOT NULL,
 email VARCHAR(100) NOT NULL,
 PRIMARY KEY (id)
);

CREATE TABLE orders (
id INT(11) NOT NULL AUTO_INCREMENT,
user_id INT(11) NOT NULL,
amount DECIMAL(10,2) NOT NULL,
order_date DATE NOT NULL,
PRIMARY KEY (id),
FOREIGN KEY (user_id) REFERENCES users(id)
);

INSERT INTO users (name, email) VALUES ('John Smith', 'john@example.com'),('Jane Doe', 'jane@example.com'),('Bob Johnson', 'bob@example.com');

INSERT INTO users (name, email) VALUES ('Sarah Johnson', 'sarah@example.com'),('Tom Smith', 'tom@example.com'),('Emily Davis', 'emily@example.com'),('William Brown', 'william@example.com');

select * from users;

INSERT INTO orders (user_id, amount, order_date) VALUES(1, 50.00, '2022-01-01'),(2, 100.00, '2022-02-15'),(3, 75.00, '2022-03-10'),(1, 25.00, '2022-03-20'),(2, 150.00, '2022-04-05'),(3, 50.00, '2022-05-01');

select * from orders;

# Write a query that returns the name of all users who have never placed an order.
SELECT u.name FROM users as u left join orders as o on u.id=o.id where o.id not in (o.user_id) or o.id is null;

# Write a query that returns the total amount of money spent by each user, sorted in descending order by total amount.
SELECT user_id,sum(amount) FROM ORDERS GROUP BY user_id order by sum(amount) desc;

# Write a query that returns the name and email address of all users who have placed at least one order with a total amount greater than $100.
select * from users as u left join orders as o on u.id = o.user_id where o.id is not null and o.amount>100 ;

# Write a query that returns the total number of orders placed by each user in the month of March 2022.
(SELECT user_id,count(user_id) FROM ORDERS where month(order_date)=3 and year(order_date)=2022 group by user_id);

# Write a query that returns the name and email address of all users who have placed orders in both January 2022 and April 2022.

# Write a query that returns the average order amount for each user who has placed at least two orders.
SELECT avg(o.amount) FROM users as u left join orders as o on u.id=o.id group by o.user_id having count(o.user_id)>1; 
use practice;

# Write a query that returns the name and email address of all users who have placed an order with a total amount greater than the average order amount for all users.
SELECT u.name,u.email FROM users as u left join orders as o on u.id=o.id where o.id in (o.user_id) and o.amount> (SELECT AVG(amount) from orders);

# Write a query that returns the name and email address of all users who have placed at least one order and have not placed an order in the past 30 days.
SELECT u.name,u.email FROM users as u left join orders as o on u.id=o.id where o.id in(o.user_id) and datediff(o.order_date,'2022-05-01')<30;
# Write a query that returns the name and email address of all users who have placed at least one order and have never placed an order in the month of May.
SELECT * FROM users as u left join orders as o on u.id=o.id where MONTH(order_date) not in (5) and u.id in (o.user_id);

with sarthak as ( 
select u.name,o.amount from users u join orders o on u.id=o.user_id)
select name,sum(amount) from sarthak group by name; 
use practice;
select case
when o.amount is null then 0
when o.amount=100 then 10
else 1
end as st,u.name,o.amount from users u left join orders o on u.id=o.user_id;