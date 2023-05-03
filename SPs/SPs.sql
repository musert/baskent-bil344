----------------------------------------------------------
-- BIL344 Database Systems
-- 2023 Spring
-- Assoc. Prof. Mustafa Sert | msert@baskent.edu.tr
-- https://www.baskent.edu.tr/~msert/
-- https://github.com/musert/ | https://musert.github.io/
----------------------------------------------------------
-- Database Schema for the examples: Oracle's built-in EMP and DEPT tables

-- Procedure with input arguments
CREATE OR REPLACE PROCEDURE change_salary1(no IN NUMBER, sl IN NUMBER)
IS
BEGIN
  UPDATE EMP2
  SET SAL = sl
  WHERE EMPNO = no;
END;

select * from user_procedures

select * from emp2

-- to test the procedure
BEGIN
  change_salary1(7902, 4500);
END;

-- Procedure with output arguments
CREATE OR REPLACE PROCEDURE change_salary2(no IN NUMBER, sl IN NUMBER, done OUT BOOLEAN)
IS
  temp NUMBER;
BEGIN
  UPDATE EMP2  SET SAL = sl WHERE EMPNO = no; 
  SELECT sal INTO temp FROM emp2 WHERE empno = no; 
  IF temp = sl THEN
    done := TRUE;
  ELSE
    done := FALSE;
  END IF;
END;

-- to test the procedure
DECLARE 
  result BOOLEAN := FALSE;
BEGIN
  change_salary2(7902, 10200, result);
  IF result  THEN   -- DBMS_OUTPUT.PUT_LINE is NOT overloaded for boolean types
    DBMS_OUTPUT.PUT_LINE('Salary changed');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('not done!');
  END IF;
END;

-- Define a function
CREATE OR REPLACE FUNCTION isEven(num NUMBER) return BOOLEAN
IS 
BEGIN
  IF (num MOD 2) = 0 THEN
    return TRUE;
  ELSE
    return FALSE;
  END IF;
END;

-- to test the function
DECLARE
  result BOOLEAN := FALSE;
BEGIN
  result := isEven(19);
  IF result  THEN   -- DBMS_OUTPUT.PUT_LINE is NOT overloaded for boolean types
    DBMS_OUTPUT.PUT_LINE('EVEN');
  ELSE 
    DBMS_OUTPUT.PUT_LINE('ODD');
  END IF;
END;

-- Demonstrating loops
CREATE OR REPLACE FUNCTION mySum(n NUMBER) return NUMBER
IS 
  i NUMBER;
  total NUMBER:= 0;
BEGIN
  FOR i IN 1 .. n LOOP
    total := total + i;
  END LOOP;
  RETURN total;
END;

-- To test the function
BEGIN
  DBMS_OUTPUT.PUT_LINE('Total is: ' || mySum(5));
END;
-- Alternative method
select mySum(11) from dual
