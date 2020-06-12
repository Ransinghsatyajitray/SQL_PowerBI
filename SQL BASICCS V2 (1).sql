-- QUERY 1: HOW TO CREATE NEW DATABASE?   
CREATE   DATABASE 	EmployeeDatabase	

	-- WHENEVER WE CREATE A DATABASE INSIDE SQL SERVER TWO FILES ARE AUTO CREATED.
	-- 1. MDF	:	PRIMARY DATA FILE.	USED TO STORE THE TABLE DATA
	-- 2. LDF	:	LOG FILE			USED TO STORE MONITORING OR AUDIT INFORMATION.

-- QUERY 2: HOW TO CONNECT TO ABOVE DATABASE? 
USE  EmployeeDatabase					


-- QUERY 3: HOW TO CREATE NEW TABLE IN ABOVE DATABASE?	
CREATE TABLE EMPLOYEE_INFO			
 (
	EmployeeID       INT,			-- this column stores DIGITS : 0, -10, 99, etc..
    EmployeeName     CHAR (30),		-- this column stores up to 30 CHARACTERS 
	EmployeeCountry  VARCHAR(40),	-- this column stores up to 40 CHARACTERS 
	EmployeeSalary   INT			-- this column stores DIGITS : 0, -10, 99, etc..
)

-- QUERY 5: BATCH : A COLLECTION OF SQL STATEMENTS
INSERT 	INTO  EMPLOYEE_INFO VALUES (1001, 'AMIN', 'CANADA', 45678)	
INSERT   EMPLOYEE_INFO VALUES (1002, 'JOHN',  'CANADA', 60000), (1003, 'JEFF',  'USA', 36363)
INSERT   INTO  EMPLOYEE_INFO VALUES (1004, 'JACK',  'CANADA', 60000)
INSERT   INTO  EMPLOYEE_INFO VALUES (1005, 'JEFF',  'USA', NULL),  (1006, 'JENY',  'USA', NULL)

-- NULL	: UNDEFINED VALUE (UNKNOWN VALUE).

-- QUERY 6: HOW TO REPORT ABOVE INSERTED DATA IN THE TABLE ?
SELECT * FROM EMPLOYEE_INFO				-- * MEANS TO REPORT ALL COLUMNS



-- QUERY 7: HOW TO REPORT ALL EMPLOYEES FROM CANADA ?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeCountry= 'CANADA'	-- WHERE: USED TO SPECIFY CONDITIONS

-- QUERY 8: HOW TO REPORT ALL EMPLOYEES FROM USA OR CANADA ?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeCountry= 'USA'  OR  EmployeeCountry = 'CANADA'

-- QUERY 9: HOW TO REPORT ALL EMPLOYEES WITH SALARY BETWEEN 30000 AND 60000?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeSalary BETWEEN 30000 AND 60000 -- BETWEEN : OPERATOR

-- QUERY 10: HOW TO REPORT ALL EMPLOYEES WITH SALARY NOT BETWEEN 30000 AND 40000?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeSalary NOT BETWEEN 30000 AND 40000

-- QUERY 11: HOW TO REPORT ALL EMPLOYEES WHOSE FIRST NAME IS 'AMIN'?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeName = 'AMIN'

-- QUERY 12: HOW TO REPORT ALL EMPLOYEES WHOSE NAME STARTS WITH LETTER 'J'?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeName LIKE 'J%'

/*
% MEANS ANY NUMBER OF CHARACTERS
_ MEANS SINGLE CHARACTER
*/

-- QUERY 13: HOW TO REPORT ALL EMPLOYEES WHOSE NAME NOT START WITH LETTER 'J'?
SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeName NOT LIKE 'J%'

-- QUERY 14: HOW TO REPORT ALL EMPLOYEES WHOSE NAME CONTAINS 4 CHARACTERS ?
 SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeName LIKE '____'	-- SPECIFY 4 UNDERSCORES

-- HOW TO REPORT ALL EMPLOYEES WHOSE NAME CONTAINS STARTS WITH LETTER J AND HAS 4 CHARACTERS ?
 SELECT  *  FROM EMPLOYEE_INFO WHERE EmployeeName LIKE 'J___'



 -- QUERY 15: HOW TO REPORT ALL EMPLOYEES WITH ASCENDING ORDER OF SALARIES? 
SELECT  *  FROM EMPLOYEE_INFO ORDER BY EmployeeSalary  ASC  -- LOW TO HIGH

-- QUERY 16: HOW TO REPORT ALL EMPLOYEES WITH DESCENDING ORDER OF SALARIES? 
SELECT  *  FROM EMPLOYEE_INFO ORDER BY EmployeeSalary   DESC   -- HIGH TO LOW

-- QUERY 17: HOW TO REPORT TOP 3 EMPLOYEES WITH HIGHEST SALARY ?
SELECT  TOP 3 *  FROM EMPLOYEE_INFO ORDER BY EmployeeSalary DESC

-- QUERY 18: HOW TO REPORT 3RD AND REMAINING EMPLOYEES ? 
 SELECT * FROM EMPLOYEE_INFO ORDER BY EMPLOYEEID ASC OFFSET 4 ROWS		

-- QUERY 19: HOW TO REPORT UNIQUE (DISTINCT) EMPLOYEES ? 
 SELECT * FROM EMPLOYEE_INFO 
  SELECT EmployeeID, EmployeeName, EmployeeCountry, EmployeeSalary FROM EMPLOYEE_INFO 
   SELECT EmployeeSalary FROM EMPLOYEE_INFO 
	SELECT DISTINCT EmployeeSalary FROM EMPLOYEE_INFO 

-- QUERY 20: HOW TO REPORT MAXIMUM SALARY OUT OF (FOR) ALL EMPLOYEES ? 
SELECT MAX (EmployeeSalary) FROM EMPLOYEE_INFO  -- MAX() IS A PREDEFINED FUNCTION

SELECT MAX( EmployeeSalary ) AS  MAXIMUM_SALARY FROM EMPLOYEE_INFO
-- AS : ALIAS. MEANS A TEMPORARY NAME GIVEN TO A COLUMN OR TABLE OR QUERY


-- QUERY 21: HOW TO REPORT LIST OF ALL EMPLOYEES WITH MAXIMUM SALARY? 
SELECT  * FROM EMPLOYEE_INFO 
WHERE	EmployeeSalary = 60000


-- SUB QUERY : TO DEFINE ONE QUERY INSIDE ANOTHER QUERY
SELECT  * FROM EMPLOYEE_INFO 
WHERE	EmployeeSalary = (SELECT MAX (EmployeeSalary) FROM EMPLOYEE_INFO)

-- IN ABOVE QUERY, THE INNER SUB QUERY IS EXECUTED FIRST. RESULT IS GIVEN TO OUTER QUERY


/*
CREATE DATABASE
USE DATABASE

CREATE TABLE
INSERT DATA
SELECT
	=
	OR
	BETWEEN				NOT BETWEEN
	LIKE				NOT LIKE
	%					_

	ORDER BY
	ASC					DESC
	TOP					OFFSET

	DISTINCT
	AS
	SUB QUERY	*/





-- QUERY 22:  HOW TO FIND THE LIST OF ALL EMPLOYEES WITH UNKNOWN SALARY VALUES ? 
SELECT * FROM EMPLOYEE_INFO WHERE EmployeeSalary IS NULL

-- QUERY 23:  HOW TO REPLACE UNKNOWN SALARIES WITH A SPECIFIC VALUE. EXAMPLE : 10000 ? 
UPDATE EMPLOYEE_INFO SET EmployeeSalary  = 10000 WHERE EmployeeSalary  IS NULL

SELECT * FROM EMPLOYEE_INFO

-- QUERY 24:   HOW TO REMOVE THE LIST OF ALL EMPLOYEES FROM TABLE  [Logged by ldf FILE]
DELETE FROM EMPLOYEE_INFO WHERE EmployeeSalary = 10000

SELECT * FROM EMPLOYEE_INFO

-- QUERY 25:   HOW TO REMOVE THE LIST OF ALL EMPLOYEES FROM TABLE  [NOT Logged by ldf FILE] 
TRUNCATE TABLE EMPLOYEE_INFO		-- REMOVES ALL ROWS FROM THE TABLE AT ONCE 


-- QUERY 26:   	HOW TO ADD NEW COLUMN TO EXISTING TABLE?
ALTER TABLE EMPLOYEE_INFO ADD   [EMP  LOCATION]   VARCHAR(30)

-- QUERY 27:	HOW TO MODIFY THE STRUCTURE OF EXISING COLUMN IN THE EXISTING TABLE?
ALTER TABLE EMPLOYEE_INFO ALTER COLUMN   [EMP  LOCATION]   VARCHAR(3000)

-- QUERY 28:	HOW TO REMOVE AN EXISING COLUMN FROM THE EXISTING TABLE?
ALTER TABLE EMPLOYEE_INFO DROP COLUMN    [EMP  LOCATION]

-- QUERY 29:	HOW TO REMOVE THE TABLE FROM DATABASE?
DROP TABLE EMPLOYEE_INFO

-- QUERY 30:	HOW TO REMOVE THE DATABASE FROM THE SERVER (INSTANCE)?
USE MASTER 
GO
DROP DATABASE EmployeeDatabase