use evaluation;
delimiter $$
CREATE PROCEDURE get_table()
BEGIN
SELECT * FROM customer;
END $$
delimiter ;

call get_table();
drop procedure get_table;

delimiter $$
CREATE PROCEDURE get_country(countrys varchar(25))
BEGIN
SELECT * FROM customer where country=countrys;
END $$
delimiter ;

call get_country('USA');

delimiter $$
CREATE PROCEDURE get_name_like(a varchar(1),b varchar(1))
BEGIN
declare st varchar(3);
set st=concat(a,b,'%');
SELECT * FROM customer where customername like st;
END $$
delimiter ;
call get_name_like('m','a');

delimiter $$
CREATE PROCEDURE get_city(citys varchar(100))
BEGIN
SELECT * FROM customer as c where c.city=citys;
END $$
delimiter ;
call get_city('London');

delimiter $$
CREATE PROCEDURE get_combined(cname varchar(100),productsid int)
BEGIN
SELECT * FROM customer as c inner join orderdetail as o on c.customerid=o.orderdetailID where customername=cname and productID=productsid;
END $$
delimiter ;
call get_combined('KJ',6);

delimiter $$
CREATE PROCEDURE get_upper()
BEGIN
SELECT upper(customername) FROM customer;
END $$
delimiter ;
call get_upper();


delimiter $$
CREATE PROCEDURE get_sales()
BEGIN
declare sales int;
SELECT (price*unit) as sales FROM product;
END $$
delimiter ;
call get_sales();

delimiter $$
CREATE PROCEDURE get_date()
BEGIN
SELECT date(orderdate),day(orderdate),month(orderdate),year(orderdate) FROM orders;
END $$
delimiter ;
call get_date();

delimiter $$
CREATE PROCEDURE get_order_that_year(years int)
BEGIN
SELECT * FROM orders WHERE YEAR(orderdate)=years;
END $$
delimiter ;

call get_order_that_year(2017);

delimiter $$
CREATE PROCEDURE get_order_that_month(months int)
BEGIN
SELECT * FROM orders WHERE month(orderdate)=months;
END $$
delimiter ;

call get_order_that_month(1);

delimiter $$
CREATE PROCEDURE get_order_that_day(days int)
BEGIN
SELECT * FROM orders WHERE day(orderdate)=days;
END $$
delimiter ;

call get_order_that_day(21);

delimiter $$
CREATE PROCEDURE get_order_that_dayname(daynames varchar(30))
BEGIN
SELECT * FROM orders WHERE dayname(date(orderdate))=daynames;
END $$
delimiter ;
call get_order_that_dayname("Sunday");

delimiter $$
CREATE PROCEDURE get_order_that_year2(years int)
BEGIN
SELECT * FROM orders WHERE EXTRACT(YEAR FROM orderdate)=years;
END $$
delimiter ;

call get_order_that_year2(2017);

delimiter $$
CREATE PROCEDURE right_join()
BEGIN
SELECT * FROM customer as c right join orderdetail as o on c.customerid=o.orderdetailID;
END $$
delimiter ;

call right_join();

delimiter $$
CREATE PROCEDURE left_join()
BEGIN
SELECT * FROM customer as c left join orderdetail as o on c.customerid=o.orderdetailID;
END $$
delimiter ;
call left_join();

delimiter $$
CREATE PROCEDURE self_join()
BEGIN
SELECT * FROM customer as c join customer as o on c.customerid=o.customerid;
END $$
delimiter ;

call self_join();
use evaluation;

delimiter $$
CREATE PROCEDURE cross_joins()
BEGIN
SELECT * FROM customer cross join orders;
END $$
delimiter ;

call cross_joins();

delimiter $$
CREATE PROCEDURE get_that_table(tablex varchar(25))
BEGIN
set @t1=concat('select * from ',tablex);
prepare stm from @t1;
execute stm;
DEALLOCATE PREPARE stm;
END $$
delimiter ;

call get_that_table('customer');

delimiter $$
CREATE PROCEDURE get_that_table_with_parameter(tablex varchar(25),parameterx varchar(25))
BEGIN
set @t1=concat('select ',parameterx,' from ',tablex);
prepare stm from @t1;
execute stm;
DEALLOCATE PREPARE stm;
END $$
delimiter ;
use evaluation;
call get_that_table_with_parameter('customer','city');

delimiter $$
CREATE PROCEDURE get_that_table_with_parameter_with_where(tablex varchar(25),parameterx varchar(25),whichs varchar(25))
BEGIN
set @t1=concat('select ',parameterx,' from ',tablex,' WHERE ',parameterx,'=','"',whichs,'"');
prepare stm from @t1;
execute stm;
DEALLOCATE PREPARE stm;
END $$
delimiter ;

call get_that_table_with_parameter_with_where('customer','city','London');

delimiter $$
CREATE PROCEDURE get_that_table_count_with_parameter_with_where(tablex varchar(25),parameterx varchar(25),whichs varchar(25))
BEGIN
set @t1=concat('select count(',parameterx,') from ',tablex,' WHERE ',parameterx,'=','"',whichs,'"');
prepare stm from @t1;
execute stm;
DEALLOCATE PREPARE stm;
END $$
delimiter ;

call get_that_table_count_with_parameter_with_where('customer','city','London');
use evaluation;
delimiter $$
CREATE PROCEDURE get_that_table_count_with_parameter_with_like(tablex varchar(25),parameterx varchar(25),whichs varchar(25))
BEGIN
set @t1=concat('select ',parameterx,' from ',tablex,' WHERE ',parameterx,' like ','"',whichs,'%"');
prepare stm from @t1;
execute stm;
DEALLOCATE PREPARE stm;
END $$
delimiter ;

call get_that_table_count_with_parameter_with_like('customer','city','L');

DELIMITER $$
CREATE PROCEDURE sp_Inout(out out_variable varchar(25), In countrys varchar(10))
BEGIN
    select contactname INTO out_variable from customer where country= countrys;
END $$
DELIMITER ;
call sp_Inout(@t1,"Uk");
select @t1;


DELIMITER $$
CREATE PROCEDURE In_parameter(IN product_name VARCHAR(255))
BEGIN
	SELECT * FROM product WHERE productname = product_name;
END $$
DELIMITER ;

call In_parameter("Lip Gloss");

-- Joining 4 tables using self join
SELECT c.customername,d.customername,e.address from customer as c inner join customer as d on c.customerid=d.customerid inner join customer as e on e.customerid=d.customerid inner join customer as f on f.customerid=e.customerid;

-- Joining 4 tables using inner join
SELECT c.customername,d.customername,e.address,f.productname from customer as c inner join customer as d on c.customerid=d.customerid inner join customer as e on e.customerid=d.customerid inner join product as f on f.productID=e.customerid;

-- Joining 4 tables using cross join
SELECT c.customername,o.orderdate,od.quantity from customer as c cross join orders as o cross join orderdetail as od;

-- Joining 4 tables using inner join
SELECT * from customer as e left join product as f on f.productID=e.customerid left join orderdetail as od on e.customerid=od.orderdetailID left join orders as o on o.orderid=e.customerid;

delimiter //
create procedure sp15(in a int, out exp varchar(45))
begin
	if (a>30) then
		set exp="experienced";
        else
			set exp="not so expirienced";
		end if;
end //
delimiter ;
-- drop procedure sp15;