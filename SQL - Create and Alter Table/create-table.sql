----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------

-- Create students table
create table students(
  sid number,
  name varchar2(50),
  gpa number,
  primary key(sid)
)

-- Create courses table
create table courses(
  cid varchar2(10),
  cname varchar2(50),
  credit number,
  primary key(cid)
)

-- Create enrolled table
 create table enrolled(
  sid number,
  cid varchar2(10),
  grade char(2) default 'C', -- If no grade value is entered, then this default value is set for the record being inserted. 
  primary key(sid, cid, grade)
)


-- Deletes table. Be careful before dropping a table. Deleting a table will result in loss of complete information stored in the table!
  drop table enrolled

-- desc command displays the structure of a table
  desc students
  
  -- Modified "Enrolled" table: foreign keys with default action (no action) added
 create table enrolled(
  sid number,
  cid varchar2(10),
  grade char(2),
  primary key(sid, cid),
  foreign key (sid) references students (sid),
  foreign key (cid) references courses (cid)
)
