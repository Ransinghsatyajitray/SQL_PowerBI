-- QUERY 1: 
CREATE DATABASE UNIVERSITY_DATABASE1

-- QUERY 2:
USE UNIVERSITY_DATABASE1

-- QUERY 3:
CREATE TABLE TBLCOURSES
(
COURSE_ID INT PRIMARY KEY,			-- THIS COLUMN DOES NOT ALLOW DUPLICATES. DOES NOT ALLOW NULL VALUES. 
COURSE_NAME VARCHAR(30) NOT NULL,	-- THIS COLUMN DOES NOT ALLOW NULL VALUES
COURSE_DUR INT CHECK (COURSE_DUR = 120  OR COURSE_DUR = 180) -- THIS COLUMN ALLOWS EITHER 120 OR 180 ONLY.
)

-- QUERY 4: 
INSERT INTO TBLCOURSES VALUES (101, 'COMPUTERS', 120),  (102, 'ROBOTICS', 180)
INSERT INTO TBLCOURSES values (103, 'CIVIL', 180)

-- QUERY 5: 
SELECT * FROM TBLCOURSES



-- QUERY 6: 
CREATE TABLE TBLSTUDENTS
(
STD_ID INT UNIQUE,			-- THIS COLUMN DOES NOT ALLOW DUPLCIATES. BUT ALLOW UPTO 1 NULL VALUE
STD_NAME VARCHAR(30),		-- THIS COLUMN ALLOW NULL VALUES
STD_AGE TINYINT CHECK (STD_AGE >= 18),	-- TINYINT : USED TO STORE SMALLER INTEGER VALUES. RANGE: 0 TO 255
STD_COURSE_ID INT REFERENCES tblcourses(course_id)   -- THIS IS FOR FOREIGN KEY. STUDENTS TABLE DEPENDS ON COURSES TABLE
)

-- QUERY 7: 
INSERT  INTO  TBLSTUDENTS VALUES (1001, 'SAI', 34, 101),        (1002, 'JON', 34, 101)   
INSERT  INTO  TBLSTUDENTS VALUES (1003, 'JOHNE', 34, 102), (1004, 'JOHNY', 34, 102)   
INSERT  INTO  TBLSTUDENTS VALUES (1005, 'AMIN', 34, 102), (1006, 'AMINI', 34, 102)   

-- QUERY 8: 
SELECT * FROM TBLSTUDENTS

-- CANDIDATE KEY : SUCH KEYS USED FOR DEFINING UNQIUE VALUES IN A COLUMN. 
-- MEANS : PRIMARY KEY, UNIQUE KEY


-- REQ 1 : HOW TO REPORT ALL COURSES & RESPECTIVE (MATCHING) STUDENTS IN EACH COURSE ?

-- TO GET THE RESULT ONE BESIDE THE OTHER : WE NEED TO USE "JOINS".
SELECT * FROM TBLCOURSES
INNER JOIN
TBLSTUDENTS 
ON
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID


-- REQ 2 : HOW TO REPORT ALL COURSES WITH AND WITHOUT STUDENTS ?
SELECT * FROM TBLCOURSES				-- THIS IS LEFT TABLE
LEFT OUTER JOIN
TBLSTUDENTS								-- THIS IS RIGHT TABLE
ON
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID


SELECT * FROM TBLSTUDENTS 				-- THIS IS LEFT TABLE
RIGHT OUTER JOIN
TBLCOURSES								-- THIS IS RIGHT TABLE
ON
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID





-- REQ 3 : HOW TO REPORT ALL COURSES  WITHOUT STUDENTS ?
SELECT * FROM TBLCOURSES				-- THIS IS LEFT TABLE
LEFT OUTER JOIN
TBLSTUDENTS								-- THIS IS RIGHT TABLE
ON										-- THIS KEYWORD IS USED TO SPECIFY CONDITIONS DURING JOIN
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID
WHERE									-- THIS KEYWORD IS USED TO SPECIFY CONDITIONS AFTER JOIN
TBLSTUDENTS.STD_COURSE_ID IS NULL	


-- REQ 4 : HOW TO REPORT ALL COURSES  WITH STUDENTS ?
SELECT * FROM TBLCOURSES				-- THIS IS LEFT TABLE
LEFT OUTER JOIN
TBLSTUDENTS								-- THIS IS RIGHT TABLE
ON										-- THIS KEYWORD IS USED TO SPECIFY CONDITIONS DURING JOIN
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID
WHERE									-- THIS KEYWORD IS USED TO SPECIFY CONDITIONS AFTER JOIN
TBLSTUDENTS.STD_COURSE_ID IS NOT NULL	



-- REQUIREMENT 1: HOW TO REPORT LIST OF ALL COURSES AND RESPECTIVE STUDENTS?
SELECT * FROM TBLCOURSES		-- THIS IS THE LEFT TABLE
INNER JOIN						-- THIS JOIN IS USED TO REPORT MATCHING DATA
TBLSTUDENTS						-- THIS IS THE RIGHT TABLE
ON
TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID


-- REQUIREMENT 2: HOW TO REPORT LIST OF ALL COURSES WITH AND WITHOUT STUDENTS?
SELECT * FROM TBLCOURSES		-- THIS IS THE LEFT TABLE
LEFT OUTER JOIN					-- THIS JOIN IS USED TO REPORT MATCHING DATA & MISSING DATA
TBLSTUDENTS						-- THIS IS THE RIGHT TABLE
ON TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID

SELECT * FROM TBLSTUDENTS 		-- THIS IS THE LEFT TABLE
RIGHT OUTER JOIN				-- THIS JOIN IS USED TO REPORT MATCHING DATA & MISSING DATA
TBLCOURSES						-- THIS IS THE RIGHT TABLE
ON TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID


-- REQUIREMENT 3: HOW TO REPORT LIST OF ALL COURSES WITHOUT STUDENTS?
SELECT * FROM TBLCOURSES		-- THIS IS THE LEFT TABLE
LEFT OUTER JOIN					-- THIS JOIN IS USED TO REPORT MATCHING DATA & MISSING DATA
TBLSTUDENTS						-- THIS IS THE RIGHT TABLE
ON		TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID
WHERE	TBLSTUDENTS.STD_COURSE_ID IS NULL 


-- REQUIREMENT 4: HOW TO REPORT LIST OF ALL COURSES WITH STUDENTS?
SELECT * FROM TBLCOURSES		-- THIS IS THE LEFT TABLE
LEFT OUTER JOIN					-- THIS JOIN IS USED TO REPORT MATCHING DATA & MISSING DATA
TBLSTUDENTS						-- THIS IS THE RIGHT TABLE
ON		TBLSTUDENTS.STD_COURSE_ID = TBLCOURSES.COURSE_ID
WHERE	TBLSTUDENTS.STD_COURSE_ID IS NOT NULL 


-- REQ: HOW TO REPORT LIST OF ALL COURSE AND RESPECTIVE STUDENTS FOR THOSE COURSES WITH MAXIMUM DURATION?







-- EXAMPLES FOR FULL OUTER JOIN
create table Reservation
(
Aircraft_Code varchar(10), 
No_of_Seats int,
Class_Code varchar(10)
)

INSERT INTO Reservation VALUES ('AI01', 11, 'ECO'), ('AI02', 22, 'ECO')
INSERT INTO Reservation VALUES ('AI03', 33, 'ECO'), ('AI04', 44, 'ECO')


CREATE TABLE FLIGHT
(	CRAFT_CODE VARCHAR(30),
	SOURCE VARCHAR(30),
	DESTINATION VARCHAR(30)
)

INSERT INTO FLIGHT VALUES ('AI01', 'HYB', 'NYC'), ('AI03', 'HYB', 'LSA'), ('AI05', 'HYB', 'LSA')


-- REQ 6: HOW TO REPORT LIST OF ALL FLIGHTS WITH AND WITHOUT RESERVATIONS?
-- HOW TO REPORT LIST OF ALL RESERVATIONS WITH AND WITHOUT FLIGHTS?
SELECT * FROM FLIGHT
FULL OUTER JOIN			-- ALL LEFT, MATCHING RIGHT. NOT MATCH RIGHT: NULL ++ ALL RIGHT, MATCHING LEFT. NON MATCH LEFT: NULL
Reservation
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code


-- REQ 7: HOW TO REPORT LIST OF ALL FLIGHTS AND RESERVATIONS?
SELECT * FROM FLIGHT CROSS JOIN Reservation
SELECT * FROM FLIGHT CROSS APPLY Reservation
SELECT * FROM FLIGHT , Reservation


/*
WHEN TO USE WHICH JOIN:

JOIN TYPES:
1.	INNER JOIN			:	TO REPORT MATCHING DATA
2.  OUTER JOINS			:	TO REPORT MATCHING DATA & MISSING DATA
		LEFT,RIGHT		:	ONE - WAY COMPARISON
		FULL			:	TWO - WAY COMPARISON
3.  CROSS JOIN			:	TO REPORT ALL POSSIBLE VALUES [M X N combinations]
*/

-- TASK 1:  HOW TO REPORT LIST OF ALL FLIGHTS WITH RESERVATIONS?
-- TASK 2:  HOW TO REPORT LIST OF ALL FLIGHTS WITHOUT RESERVATIONS?
-- TASK 3:  HOW TO REPORT LIST OF ALL RESERVATIONS WITH & WITHOUT FLIGHTS?
-- TASK 4:  HOW TO REPORT LIST OF ALL RESERVATIONS WITHOUT FLIGHTS?
-- TASK 5:  HOW TO REPORT LIST OF ALL FLIGHTS WITH SUCH RESERVATIONS FOR MAXIMUM NUMBER OF SEATS?