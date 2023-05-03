----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------

-- Insert new records into the students table  
  insert into students(sid, name, gpa)
  values(101, 'Ali', 3.5);
  insert into students(sid, name, gpa)
  values(102, 'Ayse', 3.9);
  insert into students(sid, name, gpa)
  values(103, 'Veli', 1.9);
  insert into students(sid, name, gpa)
  values(104, 'Metin', 3.1);
  insert into students(sid, name, gpa)
  values(105, 'Onur', 2.3);
  insert into students(name, sid) -- you can change the order of columns while inserting a record
  values('Dilek', 106);

-- Insert new records into the courses table  
  insert into courses(cid, cname, credit)
  values('BIL344', 'DBMS', 7);
  insert into courses(cid, cname, credit)
  values('BIL343', 'OOP', 5);
  insert into courses(cid, cname, credit)
  values('BIL334', 'OS', 5);

-- Insert new records into the enrolled table  
  insert into enrolled(sid, cid, grade)
  values(101, 'BIL344', 'B+');
  insert into enrolled(sid, cid, grade)
  values(101, 'BIL344', 'C');
  insert into enrolled(sid, cid, grade)
  values(101, 'BIL343', 'A');
  insert into enrolled(sid, cid, grade)
  values(101, 'BIL334', 'C');
  insert into enrolled(sid, cid, grade)
  values(103, 'BIL334', 'B');
  insert into enrolled(sid, cid, grade)
  values(104, 'BIL344', 'A-');

-- Delete record(s) from enrolled table
-- Where clause is optional.
-- Without where, the command deletes all records
  delete
  from enrolled
  where sid=101 -- delete records with sid equal to 101

-- Update record(s)
  update student
  set grade='A' -- updates the grade of the record
  where sid=103 -- with sid equal to 103

-- Retrieve records from tables
  select * from courses 
  select * from enrolled
  select * from students order by name -- alphabetical order by name asc/desc
