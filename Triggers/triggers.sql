----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------
-- Database Schema for the examples: Oracle's built-in EMP and DEPT tables

-- Example 1: Create a trigger for logging 

-- First create a log table
create table DEPT_LOG(
log_date DATE,
action VARCHAR2(50)
);


-- Define a statement-level trigger for logging
-----------------------------------------------------
CREATE OR REPLACE TRIGGER WRITE_LOG
AFTER INSERT OR UPDATE OR DELETE
ON DEPT
DECLARE
log_action DEPT_LOG.action%TYPE;
BEGIN
  IF INSERTING THEN
    log_action := 'Insert done';
  ELSIF UPDATING THEN
    log_action := 'Update done';
  ELSIF DELETING THEN 
    log_action := 'Delete done';
  ELSE
    DBMS_OUTPUT.PUT_LINE('This code is unreachable');
  END IF;
  INSERT INTO DEPT_LOG(log_date, action)
    VALUES(SYSDATE, log_action);
END;

-- Example update command to fire the trigger
UPDATE DEPT
SET DNAME ='CenG', LOC='ANKARA'
WHERE DEPTNO=35;

-- Example 2: Create a database object that generates a number sequence

CREATE SEQUENCE generate_pk_seq
minvalue 1
maxvalue 99
start with 1
increment by 1
cache 5;

-- Define a row-level trigger to obtain a primary key value from the sequence
CREATE OR REPLACE TRIGGER DEPT_PK_TRIG
BEFORE INSERT ON DEPT
FOR EACH ROW
BEGIN
   :NEW.DEPTNO := generate_pk_seq.nextval;
END;

-- Example insert command to fire the trigger
insert into dept(dname, loc) values ('ceng', 'Ankara')


-- Example 3: Define a trigger to display sum salary after any modification on emp2

-- create a copy of emp table
create table emp2 as select * from emp

-- Define the trigger
CREATE OR REPLACE TRIGGER DISP_SAL_TRIG
AFTER INSERT OR UPDATE OR DELETE ON EMP2
DECLARE
   SUM_SAL NUMBER;
BEGIN
   SELECT SUM(SAL) INTO SUM_SAL
   FROM EMP2;
   DBMS_OUTPUT.PUT_LINE('Total salary: ' || SUM_SAL);
END;

-- Fire the trigger
update emp2
set sal = 8000
where empno=7369

-- See the result
select * from emp2

-- Example 4: Demonstrate the difference between the row- and statement-level triggers

-- Define a statement-level trigger
create or replace trigger statement_trig before update on emp2
  begin
     dbms_output.put_line('Before Update Statement Trigger');
  end;
-- Define a row-level trigger
create trigger rowlevel_trig before update on emp2
  for each row
   begin
     dbms_output.put_line('Before Update Row Level Trigger');
   end;
   
-- Fire the trigger and observe the output    
update emp2
set deptno=50
where deptno=20
