----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------
-- Database Schema for the examples:
-- Sailors(sid, sname, age, rating)  PK: sid
-- Boats(bid, bname, color) PK: bid
-- Reserves(sid, bid, day) PK: (sid,bid,day) FK: sid->Sailors(sid), bid->Boats(bid)

-- views
create view SailorView as 
select sid as sailor_id, sname as sailor_name, rating, age 
from sailors
where rating > 7

select * from sailorview

select * from user_views

insert into sailorview
values(103, 'Ayse', 9, 22)

insert into sailorview
values(105, 'Deniz', 3, 17)

select * from sailors


drop view sailorview

create view SailorView as 
select sid as sailor_id, sname as sailor_name, rating, age 
from sailors
where rating > 7
with check option

insert into sailorview
values(107, 'Ezgi', 5, 18)

update sailorview
set rating = 10
where sailor_id=58

-- read only view
create or replace view SailorView as 
select sid as sailor_id, sname as sailor_name, rating, age 
from sailors
where rating > 7
with read only

delete 
from sailorview 
where sailor_id=58

-- Views on multiple base tables
create or replace view RedBoatReservations as
select s.sid, s.sname, b.color, r.day
from sailors s, reserves r, boats b
where s.sid=r.sid AND r.bid=b.bid AND b.color='Red'

select * from RedBoatReservations 

-cannot update views views that are based on multiple base tables.

delete from RedBoatReservations where sid=64

select * from reserves


insert into RedBoatReservations 
values(109, 'Test', 'Red', '05-05-2022')

update RedBoatReservations 
set day = '3/3/2022'
where day = '11/12/2003'
