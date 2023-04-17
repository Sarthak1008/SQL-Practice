create database evaluation;
use evaluation;

create table customer (
customerid int primary key,
customername varchar(100),
contactname varchar(100),
address varchar(255),
city varchar(50),
postalcode varchar(10),
country varchar(50)
);

insert into customer
	(customerid,customername,contactname,address,city,postalcode,country) values
		(001, 'Mary A', 'Mary Austin','338 City Road','London','ECIV 2NK','UK'),
        (002, 'KJ', 'Karl Jung','Graefestr 2','Berlin','10967','Germany'),
        (003, 'Jamie_Wats', 'James Watson','3116 Massachusetts Avenue','Washington','20004','USA');
        
create table orders (
orderid int primary key,
customerID int not null,
orderdate date
);

insert into orders
	(orderid,customerID,orderdate) values
		(10308, 5,'2017-01-21'),
        (10309, 80,'2017-01-22'),
        (10310, 97,'2017-01-22');
        
create table orderDetail (
orderdetailID int primary key,
orderID int not null,
productID int not null,
quantity int not null
);

insert into orderDetail
	(orderdetailID,orderID,productID,quantity) values
		(1, 12508,5,1),
        (2, 12508,6,10),
        (3, 12509,25,50);
        
create table product (
productID int primary key,
productname varchar(100),
supplierID int not null,
CategoryId int not null,
unit int not null,
Price int not null
);

insert into product
	(productID,productname,supplierID,CategoryId,unit,Price) values
		(1,'Lip Gloss',1,1,2,20),
        (2,'Eyeshadow Makeup',1,2,1,10),
        (3,'Lip Balm',2,1,1,5);

SELECT * FROM Customer;
SELECT CustomerName,Address FROM CUSTOMER;
SELECT DISTINCT COUNTRY FROM CUSTOMER;
SELECT * FROM PRODUCT WHERE PRICE >20;
SELECT * FROM Customer WHERE Address IS NULL;
SELECT * FROM CUSTOMER WHERE COUNTRY = "Germany" OR COUNTRY="UK";
SELECT * FROM CUSTOMER WHERE NOT COUNTRY = "USA";
SELECT * FROM PRODUCT WHERE SupplierID=1 AND CategoryID = 2;
 SELECT * FROM PRODUCT ORDER BY PRICE DESC;
SELECT * FROM CUSTOMER LIMIT 50;
SELECT * FROM Customer WHERE CustomerName LIKE "b%";
SELECT orderdetailId from orderdetail group by orderdetailId having count(orderdetailId) > 1;
delimiter $$
CREATE FUNCTION convert_to_grams(weight double)
RETURNS double
deterministic
BEGIN
	declare kg double;
     SET kg = weight *1000;
     return kg;
END 
delimiter $$;




