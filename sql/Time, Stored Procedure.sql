SELECT ADDDATE('2015-09-05', INTERVAL 20 DAY);
SELECT DATE_ADD('2015-09-05', INTERVAL 20 DAY);
SELECT ADDDATE('2008-01-02', INTERVAL 4 YEAR);
SELECT DATE_ADD('2008-01-02', INTERVAL 4 YEAR);

SELECT ADDTIME('10:40:32.88558', '06:04:01.222222');
SELECT ADDTIME('06:23:15.99999', '12:25:11.11111');

SELECT CONVERT_TZ('2019-11-21 15:30:00','+00:00','+10:00');

SELECT CURDATE();
SELECT CURRENT_DATE;
SELECT CURRENT_DATE();

SELECT CURRENT_TIME();
SELECT CURRENT_TIME;

SELECT CURRENT_TIMESTAMP();
SELECT CURRENT_TIMESTAMP;

SELECT CURTIME();

SELECT DATE_FORMAT('2015-09-05', '%W %M %Y');
 SELECT DATE_FORMAT('2015-09-05', '%a %b %c');
 
SELECT DATE_SUB('2015-09-05', INTERVAL 20 DAY);
SELECT DATE_SUB('2008-01-02', INTERVAL 4 YEAR);

SELECT DAY(CURDATE());

SELECT DAYNAME('2019-05-25');
SELECT DAYNAME('1998-11-21');

SELECT EXTRACT(YEAR FROM '2019-05-25');
SELECT EXTRACT(DAY FROM '1998-11-21');

SELECT MAKETIME(13, 45, 25);

use employee;
call get_employee_info(32);
call output_count(@r);
select @r as TR;

call inout_eg(@emp, 32);
select @emp as Total;

-- FUNCTIONS
-- Mathematical Functions
SELECT ABS(-32);

SELECT CEILING(1.23);

SELECT COS(PI());

SELECT DEGREES(PI() / 2);

SELECT EXP(2); -- Returns the value of e (the base of natural logarithms) raised to the power of X. 

SELECT FLOOR(1.23), FLOOR(-1.23);

SELECT LOG(2); -- If called with one parameter, this function returns the natural logarithm of X.

SELECT LOG(10,100); -- If called with two parameters, this function returns the logarithm of X to the base B.

SELECT MOD(234, 10);
SELECT 253 % 7;
SELECT 29 MOD 9;

SELECT POW(2,2);

SELECT SQRT(4);

-- Cast Functions
SELECT CAST("11:35:00" AS Time), CAST(TIME "11:35:00" AS TimeStamp);

-- Functions That Create JSON Values
SELECT JSON_ARRAY(1, "abc", NULL, TRUE, CURTIME());

SELECT JSON_OBJECT('id', 87, 'name', 'carrot');

-- CREATING A FUNCTION
delimiter $$
Create function Emp_Age_Category(age int)
returns varchar(30)
deterministic
BEGIN
	declare ageCategory varchar(30);
    If age > 35 THEN
		SET ageCategory = 'Old';
	elseif (age <= 35 and age >= 25) then
		set ageCategory = 'Middle-age';
	elseif age < 25 then
		set ageCategory = 'Young';
	end if;
    return (ageCategory);
END$$
delimiter ;

select * from employee;
select fname, Age, Emp_Age_Category(Age) from employee order by Age;
