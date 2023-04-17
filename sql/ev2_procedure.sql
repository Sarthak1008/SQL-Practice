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

delimiter $$
CREATE PROCEDURE add_class(IN classid INT,IN classname VARCHAR(50),IN teacherid INT,IN roomnumber VARCHAR(10),IN starttime TIME, IN endtime TIME)
BEGIN
INSERT INTO class_table (class_id, class_name, teacher_id, room_number, start_time, end_time)
VALUES (classid,classname,teacherid,roomnumber,starttime,endtime);
END $$
delimiter ;

call add_class(5, 'Maths',2,103, '11:30:00', '01:20:00');


delimiter $$
CREATE PROCEDURE update_student_grade(IN student_id INT,IN classsid INT,IN new_grade VARCHAR(5))
BEGIN
UPDATE grades
SET grade = new_grade
WHERE student_id = student_id AND class_id= classid;
END $$
DELIMITER ;

drop procedure update_student_grade;