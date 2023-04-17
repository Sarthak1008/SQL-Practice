-- WRITE A SQL FUNCTION THAT HAS 1 PARAMETER OF TYPE NUMERIC(8,2) AND RETURNS CHAR(18). USE ONE OF THE LOGICAL 
-- STATEMENT WE DISCUSSED IN CLASS TO IMPLEMENT A FUNCTION THAT DOES THE FOLLOWING
use evaluation;
delimiter //
CREATE FUNCTION TICKETITEMS (item NUMERIC(8,2))
RETURNS char(20)
deterministic
BEGIN
	declare myitem char(20);
	if item < 1000 then
		set myitem="Small Ticket Item";
	elseif (item > 1000 and item < 10000 ) then
		set myitem="Medium Ticket Size";
	elseif item>10000 then
		set myitem="Big Ticket Item";
	else
		set myitem="For Sale";
	end if;
		return(myitem);
END //
delimiter ;
select TICKETITEMS(10000);

delimiter $$
CREATE FUNCTION DOLLAR_TO_RUPEE(item numeric(8,2))
RETURNS VARCHAR(30)
deterministic
BEGIN
	declare myitem NUMERIC(8,2);
    SET myitem = item*82.222;
    return myitem;
end $$
delimiter ;
select DOLLAR_TO_RUPEE(1000);

delimiter $$
CREATE FUNCTION RUPEE_TO_DOLLAR(item numeric(8,2))
RETURNS VARCHAR(30)
deterministic
BEGIN
	declare myitem NUMERIC(8,2);
    SET myitem = item/82.222;
    return myitem;
end $$
delimiter ;
select RUPEE_TO_DOLLAR(1000);

delimiter $$
CREATE FUNCTION DATES()
RETURNS DATE
DETERMINISTIC
BEGIN
	declare myitem date;
    set myitem = date(now());
    return myitem;
end $$
delimiter ;
select DATES();

delimiter $$
CREATE FUNCTION TIMES()
RETURNS TIME
DETERMINISTIC
BEGIN
	declare myitem TIME;
    set myitem = TIME(now());
    return myitem;
end $$
delimiter ;
select TIMES();

delimiter $$
CREATE FUNCTION DATES_DAYS(item date)
RETURNS int
DETERMINISTIC
BEGIN
	declare myitem int;
    set myitem = extract(DAY FROM item);
    return myitem;
end $$
delimiter ;

select DATES_DAYS('2023-03-21');

delimiter $$
CREATE FUNCTION MINUTES(item TIME)
RETURNS int
DETERMINISTIC
BEGIN
	declare myitem int;
    set myitem = minute(item);
    return myitem;
end $$
delimiter ;

SELECT MINUTES(TIME(NOW()));

delimiter $$
CREATE FUNCTION HOURS(item TIME)
RETURNS int
DETERMINISTIC
BEGIN
	declare myitem int;
    set myitem = HOUR(item);
    return myitem;
end $$
delimiter ;

SELECT HOURS(TIME(NOW()));

delimiter $$
CREATE FUNCTION SECONDS(item TIME)
RETURNS int
DETERMINISTIC
BEGIN
	declare myitem int;
    set myitem = SECOND(item);
    return myitem;
end $$
delimiter ;

SELECT SECONDS(TIME(NOW()));

delimiter $$
CREATE FUNCTION HOUR_AND_MINUTE(item TIME)
RETURNS varchar(5)
DETERMINISTIC
BEGIN
	declare hours int;
    declare minutes int;
    declare st varchar(5);
    set hours = HOUR(item);
    SET minutes = MINUTE(ITEM);
    SET st = concat(hours,':',minutes);
    return st;
end $$
delimiter ;

SELECT HOUR_AND_MINUTE(TIME(NOW()));

delimiter $$
CREATE FUNCTION MINUTE_AND_SECOND(item TIME)
RETURNS varchar(5)
DETERMINISTIC
BEGIN
	declare seconds int;
    declare minutes int;
    declare st varchar(5);
    set seconds = second(item);
    SET minutes = MINUTE(ITEM);
    SET st = concat(minutes,':',seconds);
    return st;
end $$
delimiter ;

SELECT MINUTE_AND_SECOND(TIME(NOW()));

delimiter $$
CREATE FUNCTION HOUR_AND_MINUTE_AND_SECOND(item TIME)
RETURNS varchar(8)
DETERMINISTIC
BEGIN
	declare hours int;
    declare minutes int;
    declare seconds int;
    declare st varchar(8);
    set hours = HOUR(item);
    SET minutes = MINUTE(ITEM);
    SET seconds = second(ITEM);
    SET st = concat(hours,':',minutes,':',seconds);
    return st;
end $$
delimiter ;

SELECT HOUR_AND_MINUTE_AND_SECOND(TIME(NOW()));

delimiter $$


drop function DATES_DAYS;
select DATES_DAYS('2023-03-21');

delimiter $$
CREATE FUNCTION DATES_MONTH(item date)
RETURNS int
deterministic
BEGIN
	declare myitem int;
    set myitem = extract(Month from item);
    return myitem;
end $$
delimiter ;

select DATES_MONTH('2023-03-21');

delimiter $$
CREATE FUNCTION NUM_TO_DATE(item int)
RETURNS DATE
DETERMINISTIC
BEGIN
	declare day_part int;
    declare month_part int;
    declare year_part int;
    SET day_part = substr(item,1,2);
    SET month_part = substr(item,3,2);
    SET year_part = CONCAT(20,substr(item,5,2));
    RETURN STR_TO_DATE(CONCAT(year_part, '/', month_part, '/', day_part), '%Y/%m/%d');
END $$
delimiter ;

select NUM_TO_DATE(170698);
    

delimiter $$
CREATE FUNCTION DATES_YEAR(item date)
RETURNS int
deterministic
BEGIN
	declare myitem int;
    set myitem = extract(YEAR from item);
    return myitem;
end $$
delimiter ;

select DATES_YEAR('2023-03-21');

delimiter $$
CREATE FUNCTION GRADE(marks int)
RETURNS VARCHAR(1)
DETERMINISTIC
BEGIN
	declare grades varchar(1);
    if (marks <100 AND marks >90) then
		SET grades="A";
	elseif (marks <=90 AND marks >80) then
		SET grades="B";
	elseif (marks <=80 AND marks >70) then
		SET grades="C";
	elseif (marks <=70 AND marks >60) then
		SET grades="D";
	else
		SET grades="E";
	end if;
		return grades;
END $$
delimiter ;

SELECT GRADE(92);
SELECT GRADE(85);
SELECT GRADE(75);
SELECT GRADE(68);
SELECT GRADE(55);
SELECT GRADE(22);

delimiter $$
CREATE FUNCTION AREA_OF_RECTANGLE(base int,height int)
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE area int;
    SET area = (base*height)/2;
    return area;
END $$
delimiter ;

SELECT AREA_OF_RECTANGLE(10,5);

delimiter $$
CREATE FUNCTION AREA_OF_SQUARE(side int)
RETURNS int
DETERMINISTIC
BEGIN
	DECLARE area int;
    SET area = side*side;
    return area;
END $$
delimiter ;

SELECT AREA_OF_SQUARE(10);

delimiter $$
CREATE FUNCTION AREA_OF_CIRCLE(radius int)
RETURNS numeric(8,2)
DETERMINISTIC
BEGIN
	DECLARE area int;
    SET area = round((pow(radius,2)*22)/7,2);
    return area;
END $$
delimiter ;

SELECT AREA_OF_CIRCLE(10);

delimiter $$
CREATE FUNCTION FAHRENIT_TO_CELSIUS(degree int)
RETURNS numeric(8,2)
DETERMINISTIC
BEGIN
	DECLARE celsius int;
    SET celsius = round(((degree-32)*5)/9,2);
    return celsius;
END $$
delimiter ;

SELECT FAHRENIT_TO_CELSIUS(10);

delimiter $$
CREATE FUNCTION CELSIUS_TO_FAHRENIT(degree int)
RETURNS numeric(8,2)
DETERMINISTIC
BEGIN
	DECLARE fahrenit numeric(8,2);
    SET fahrenit = ((degree*9)/5)+32;
    return fahrenit;
END $$
delimiter ;

SELECT CELSIUS_TO_FAHRENIT(-12);

delimiter //
create function f10()
returns varchar(45)
deterministic
begin
	declare a varchar(45);
    select customername into a from customer where customerid=1;
    return a;

end //
delimiter ;
-- drop function f10;
select f10();

use evaluation;
-- Create a function that takes in a string as a parameter and returns the string in reverse order.

delimiter $$
create function reverse_string(st varchar(25))
returns varchar(25)
deterministic
begin
	declare reverse_st varchar(25);
    set reverse_st = reverse(st);
    return reverse_st;
end $$
delimiter ;

select reverse_string('Sarthak');

use evaluation;

delimiter $$
create function factorial(n int)
returns int
deterministic
begin
	declare result int default 1;
    declare i int default n;
    while i>0 do
		set result = result*i;
        set i = i-1;
    end while;
    return result;
end $$
delimiter ;

delimiter $$
create function isPalindrome(n int)
returns boolean
deterministic
begin
	declare result int;
	set result = reverse(n);
	if(n=result) then
		return true;
    else
		return false;
	end if;
		return false;
end $$
delimiter ;

-- drop function isPalindrome;
select isPalindrome(110011);
-- in mysql  boolean is shown using 1 and 0.1 means true and 0 means false;


delimiter $$
create function isPrime(n int)
returns boolean
deterministic
begin
	declare result int;
    declare i int default 2;
    declare j int default 0;
	while(n>i) do
		if(mod(n,i)=0) then
			return false;
		else
			set i=i+1;
		end if;
			return true;
		end while;
end $$
delimiter ;
drop function isPrime;
select isPrime(11);

delimiter $$
create function isPower(base int,power int)
returns int
deterministic
begin
	declare result int default base;
    declare i int default 0;
	while(power-1>i) do
		set result = result*base;
        set i=i+1;
	end while;
	return result;
end $$
delimiter ;
drop function isPower;
select isPower(2,3);

delimiter $$
create function isPower(base int,power int)
returns int
deterministic
begin
	declare result int default base;
    declare i int default 0;
	while(power-1>i) do
		set result = result*base;
        set i=i+1;
	end while;
	return result;
end $$
delimiter ;
drop function isPower;
select isPower(2,3);

delimiter $$
create function isgcd(num1 int,num2 int)
returns int
deterministic
begin
	declare number1 int default num1;
    declare number2 int default num2;
    declare gcd int default 1;
    declare j int default 0;
    declare i int default 2;
    if(num1>=num2) then
		set j=num2;
    else
		set j = num1;
	end if;
		return j;
	while(j>i) do
		if(mod(number1,i)=0 and mod(number2,i)=0) then
			set gcd=i;
		else
			set i=i+1;
		end if;
			return gcd;
	end while;
end $$
delimiter ;
drop function isgcd;
select isgcd(10,2);


delimiter $$
create function count_vowels(st varchar(25))
returns int
deterministic
begin
    declare c int default 0;
    declare s varchar(1);
    declare i int default 1;
    while (i <= length(st)) do
        set s = substring(st, i, 1);
        if (s = 'A' or s = 'E' or s = 'O' or s = 'U' or s = 'I') then
            set c = c + 1;
        end if;
        set i = i + 1;
    end while;
    return c;
end $$
delimiter ;


drop function count_vowels;
select count_vowels('E');

-- delimiter $$
-- create function fibonaci(n int)
-- returns int
-- deterministic
-- begin
-- 	if(n=0) then
-- 		return 0;
-- 	elseif(n=1) then
-- 		return 1;
-- 	else
-- 		return fibonaci(n-1)+fibonaci(n-2);
-- 	end if;
-- 		return 1;
-- end $$
-- delimiter ;

-- select fibonaci(2);

delimiter $$
create function SimpleInterest(p int,r int,t int)
returns int
deterministic
begin
	declare amount int;
    set amount = p+((p*r*t)/100);
    return amount;
end $$
delimiter ;
-- drop function SimpleInterest;
select SimpleInterest(100,10,1);