delimiter $$
CREATE PROCEDURE add_teacher(IN teacher_id INT,IN first_name VARCHAR(50),IN last_name VARCHAR(50),IN email VARCHAR(100),IN phone INT,IN address VARCHAR (50))
BEGIN
	INSERT INTO teacher_table (teacher_id,first_name,last_name,email,phone,address) VALUES (teacher_id,first_name, last_name, email,phone,address);
END $$
delimiter ;

-- drop procedure add_teacher;

call add_teacher(3,"sarthak","aggarwal","encbc",83730383,"nbchhcjd");

use ev2;
set SQL_SAFE_UPDATES = 0;
delimiter $$
CREATE PROCEDURE update_class_start_time(IN id INT,IN new_start_time TIME)
BEGIN
	UPDATE class_table
    SET start_time = new_start_time
    WHERE class_table.class_id = id;
END $$
delimiter ;
-- drop procedure update_class_start_time;
call update_class_start_time(1,'09:00:00');
set SQL_SAFE_UPDATES = 0;


-- ⦁	Write a function to calculate the total number of students who attended a given class.

-- 1.    Write a query to get the name and email of all students who attended all classes with a grade higher than 90.
SELECT S.FIRST_NAME, S.EMAIL FROM STUDENT_TABLE S JOIN ATTENDANCE_TABLE A USING(STUDENT_ID) JOIN 
GRADES G USING(STUDENT_ID) WHERE G.GRADE > 90 GROUP BY 1,2 ;

-- 2.  Write a query to get the name and email of all students who attended the classes taught by a teacher named "John Doe" and received a grade higher than 80.
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join grades using(student_id)
join teacher_table using(teacher_id)
where teacher_table.first_name = 'John' AND attendance_table.status = 'Present' AND grades.grade > 80 group by 1,2;

-- 3.    Write a query to get the name and email of all students who did not attend any class taught by a teacher named "Jane Smith".
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join teacher_table using(teacher_id)
where teacher_table.first_name = 'Jane' AND attendance_table.status = 'Absent' group by 1,2;

-- 4.    Write a query to get the name and email of all students who attended the same classes
-- not done 
-- as another student with the same first name.

-- 5.    Write a query to get the name and email of all students who attended classes that took place in 
select a.class_id, count(distinct a.student_id) from student_table s join attendance_table a using(student_id)
join class_table c using(class_id) join grades g using(student_id) join teacher_table t using(teacher_id)
group by a.class_id;

-- 6.    Write a query to get the name and email of all students who attended a class taught by a 
-- teacher they share a last name with.
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join grades using(student_id)
join teacher_table using(teacher_id)
where student_table.last_name = teacher_table.last_name group by 1,2;

-- 7.    Write a query to get the name and email of all students who received a grade higher 
-- than the average grade of all students in the same class.
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join grades using(student_id)
join teacher_table using(teacher_id)
where grades.grade > (select avg(grade) from grades) group by 1,2;

-- 8.    Write a query to get the name and email of all students who attended at least one class
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join grades using(student_id)
join teacher_table using(teacher_id)
where student_table.last_name = teacher_table.last_name group by 1,2;

-- 9.    Write a query to get the name and email of all students who attended the same 
-- class as a student who received a grade lower than 60.
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join grades using(student_id)
where attendance_table.class_id = grades.class_id AND grades.grade < 60;

-- 10.    Write a query to get the name and email of all students who attended classes taught by all teachers.

select s.first_name, s.last_name, s.email from student_table s join attendance_table a using(student_id)
group by s.first_name,s.last_name,s.email having count(a.student_id)>=2;

-- 11.    Write a query to get the name and email of all students who attended the class named "Mathematics" 
-- on 2022-01-15.
select student_table.first_name,student_table.email from student_table
join attendance_table using (student_id)
where attendance_table.class_id = 1 AND attendance_table.date = '2022-02-15';

-- 12.    Write a query to get the name of the teacher who taught the class with the highest number of attendees.
select a.class_id from student_table s join attendance_table a using (student_id) join class_table c
using(class_id) group by a.class_id having count(distinct a.student_id) >1;

-- 13.    Write a query to get the average grade of all students in the class named "Science".
SELECT AVG(grades.grade) FROM grades
JOIN STUDENT_TABLE S USING(STUDENT_ID)
JOIN CLASS_TABLE C USING(CLASS_ID)
WHERE CLASS_NAME = 'SCIENCE';

-- 14.    Write a query to get the name and email of all students who attended the classes taught by a teacher 
-- named "John Doe".
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using (class_id)
join teacher_table using(teacher_id)
where attendance_table.status = 'Present' AND teacher_table.first_name = 'John';

-- 15.    Write a query to get the name of the class with the highest average grade.
SELECT DISTINCT C.CLASS_NAME FROM CLASS_TABLE C
JOIN GRADES G USING(CLASS_ID)
WHERE G.GRADE > (SELECT AVG(GRADE) FROM GRADE_TABLE);

-- 16.    Write a query to get the name and email of all students who did not attend any class in the month of 
-- February 2022.
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join teacher_table using(teacher_id)
where month(attendance_table.date) = 02 AND attendance_table.status = 'Absent';

-- 17.    Write a query to get the name and email of all students who attended both the class named
-- "Mathematics" and the class named "Science".
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join teacher_table using(teacher_id)
where class_table.class_name = 'Mathematics' AND class_table.class_name = 'Science' ;

-- 18.    Write a query to get the name and email of all students who attended at least one class but did not get any grade.
select s.first_name,s.last_name,s.email from student_table s join attendance_table a using(student_id)
join class_table c using(class_id) join grades g using(class_id) where a.status="Present" and g.grade = "NULL";

-- 19.    Write a query to get the name and email of all students who attended all classes taught by a teacher 
-- named "Jane Smith".
select student_table.first_name, student_table.email from student_table
join attendance_table using(student_id)
join class_table using(class_id)
join teacher_table using(teacher_id)
where teacher_table.first_name = 'Jane' AND attendance_table.status = 'Present' ;

-- 20.    Write a query to get the number of students who attended each class.
select a.class_id, count(distinct a.student_id) from student_table s join attendance_table a using(student_id)
join class_table c using(class_id) join grades g using(student_id) join teacher_table t using(teacher_id)
group by a.class_id;

delimiter $$
create function totalClassAttended(classid int)
returns int
deterministic
begin
	declare avge int;
    declare myitem int;
    select count(*) into avge from attendance_table where class_id=classid and status="Present";
    SET myitem = avge;
    return myitem;
end $$;
delimiter ;


-- ⦁	Write a function to calculate the number of classes missed by a student.

select totalClassAttended(1);

delimiter $$
create function totalClassNotAttended(classid int)
returns int
deterministic
begin
	declare avge int;
    declare myitem int;
    select count(*) into avge from attendance_table where class_id=classid and status="Absent";
    SET myitem = avge;
    return myitem;
end $$;
delimiter ;

select totalClassNotAttended(1);

-- ⦁	Write a function to calculate the average grade of all students in a given class.
delimiter $$
create function AvgClass(classid int)
returns numeric(8,2)
deterministic
begin
	declare avge numeric(8,2);
    declare myitem numeric(8,2);
    select avg(grade) into avge from grades where grade is not null and classid=class_id group by class_id;
    SET myitem = avge;
    return myitem;
end $$;
delimiter ;
select AvgClass(1);