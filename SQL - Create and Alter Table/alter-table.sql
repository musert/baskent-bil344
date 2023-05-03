----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------

-- Alter table command is used to modify the structure of an existing table

-- we add a new column named semester to the enrolled table
alter table enrolled
add semester date

-- we change the domain (type) of the semester column to a variable-length character
alter table enrolled
modify semester varchar2(10)

-- we remove the semester column from the enrolled table
alter table enrolled
drop column semester

-- Below we add a foreign key constraint to the existing enrolled table
alter table enrolled
add foreign key (sid) references students (sid)
-- In order to add foreign key with the cascade option
-- add foreign key (sid) references students (sid) on delete cascade  

-- To modify multiple columns
alter table <table-name>
modify (
  column-1 type constraint,
  column-2 type constraint,
  ...
  column-n type constraint
);

-- To add multiple columns
alter table <table-name>
add (
  column-1 type constraint,
  column-2 type constraint,
  ...
  column-n type constraint
);

-- To modify multiple columns
alter table <table-name>
drop (column-1, column-2, ..., column-n)
);
