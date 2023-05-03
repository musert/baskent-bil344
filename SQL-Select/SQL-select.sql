----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------

-- Q1: Find/retrieve the ids and GPAs of students
select sid, gpa
from students 

-- Q2: Find/retrieve enrollment information of students
select * 
from enrolled

-- Q3: Find/retrieve the student's name who enrolled in course id BIL344    
-- Solution w/join
select S.name
from students S, enrolled E
where E.cid='BIL344' AND S.sid = E.sid

    insert into enrolled(sid, cid, grade)
  values(101, 'BIL344', 'B+');

-- Q4: Find/retrieve the student's name who enrolled in course id BIL344  
-- Solution w/nested query
select S.name
from students S
where S.sid IN (select E.sid
                from enrolled E
                where E.cid='BIL344') --(S.sid = 101) OR (S.sid = 102) OR (S.sid = 103) OR (S.sid = 104)

-- Q5: Find/retrieve the student's name who enrolled in courses named OS or OOP
-- Solution w/join
select S.name
from courses C, enrolled E, students S
where (C.cname='OS' OR C.cname='OOP') AND C.cid=E.cid AND E.sid=S.sid

-- Q6: Find/retrieve the student's name who enrolled in courses named OS or OOP    
-- Solution w/nested query
select S.name
from students S
where S.sid IN (select E.sid
                from enrolled E
            	where E.cid IN (select C.cid
                				from courses C
                 				where C.cname='OS' OR C.cname='OOP' ) )
    
-- Q7: Find/retrieve the student's name who enrolled in at least one course
select S.name
from students S, enrolled E
where S.sid=E.sid

-- Q8: Find/retrieve the student's name who got two different grades from the same course
select S.name
from students S, enrolled E1, enrolled E2  -- S X E1 X E2
where E1.grade <> E2.grade AND E1.cid = E2.cid AND S.sid = E1.sid AND S.sid=E2.sid

-- String pattern matching: LIKE command and % and _ wildcards
-- % meaning zero or more arbitrary characters and _ stands for exactly one arbitrary character

-- Q9: Find students whose name contain "el"   
select *
from students
where name LIKE '%el%'

-- Q10: Find students whose name start with "A"   
select *
from students
where name LIKE 'A%'

-- Q11: Find students whose name end with "A"   
select *
from students
where name LIKE '%A'

-- Q12: Find students whose name starts with "A" and contain exactly 3 characters      
select *
from students
where name LIKE 'A__'

-- Q13: Find/retrieve the student's name who enrolled in the course with the name OS and OOP
select S.name
from courses C, enrolled E, students S
where C.cname='OS' AND C.cid=E.cid AND E.sid=S.sid
INTERSECT
select S.name
from courses C, enrolled E, students S
where C.cname='OOP' AND C.cid=E.cid AND E.sid=S.sid

-- Q14: Find/retrieve the student's name who enrolled in the course with the name OS or OOP
select S.name
from courses C, enrolled E, students S
where C.cname='OS' AND C.cid=E.cid AND E.sid=S.sid
UNION
select S.name
from courses C, enrolled E, students S
where C.cname='OOP' AND C.cid=E.cid AND E.sid=S.sid

-- Q15: Find/retrieve the student's name who enrolled in the course with the name OS  but not OOP
select S.name
from courses C, enrolled E, students S
where C.cname='OS' AND C.cid=E.cid AND E.sid=S.sid
MINUS -- or EXCEPT 
select S.name
from courses C, enrolled E, students S
where C.cname='OOP' AND C.cid=E.cid AND E.sid=S.sid

-- Q16: The default for UNION queries eliminates duplicates. To retain duplicates:
select S.name
from courses C, enrolled E, students S
where C.cname='OS' AND C.cid=E.cid AND E.sid=S.sid
UNION ALL
select S.name
from courses C, enrolled E, students S
where C.cname='OOP' AND C.cid=E.cid AND E.sid=S.sid

-- Q17: Find/retrieve the student's name and id who has the highest GPA
-- op ALL, op ANY  --> op:operators such as =, <, >, <= ..
select sid, name
from students
where GPA >= ALL (select GPA from students)

-- Q18: Find/retrieve the student's name and id whose GPA is better than some students called Sinem.
select sid, name
from students
where GPA > ANY (select GPA from students where name='Sinem')

-- Q19: Find/retrieve the names of students who have enrolled all courses
-- We are using correlated nested query
-- Solution 1:
select s.name
from students s
where not exists ( (select c.cid from courses c) 
			EXCEPT -- use MINUS in Oracle
		   (select e.cid from enrolled e where e.sid=s.sid) 
		 )
-- Solution 2:
select s.name
from students s
where not exists ( select c.cid 
		   from courses c 
		   where not exists ( select e.cid 
		   		      from enrolled e 
		   		      where e.cid=c.cid AND e.sid=s.sid))
-- Q20: Count the number of different student names
select count(distinct name)
from students

-- Q21: Calculate the average GPA of all students
select avg(GPA)
from students

-- Q22: Find/retrieve the student's name and id who has the lowest GPA
select sid, name
from students
where GPA = (select min(GPA) from students)

-- Q23: Calculate the number of courses for each credit
select credit, count(*)
from courses
group by credit

-- Q24: Calculate the number of courses for each credit that have at least 2 courses
select credit, count(*)
from courses
group by credit
having count(*) >=2


-- Grouping on multiple columns
create table temp
(
  a number,
  b number,
  c number,
  d number,
 primary key(a,b,c,d)
)

insert into temp
values(1,2,3,7)

select * from temp

select a,b,c, count(*)
from temp
group by a, b, c
