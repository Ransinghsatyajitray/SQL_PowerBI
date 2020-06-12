CREATE DATABASE DB_TASK
GO
USE DB_TASK
GO

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


-- TASK 1:  HOW TO REPORT LIST OF ALL FLIGHTS WITH RESERVATIONS?
SELECT * FROM FLIGHT 
JOIN			-- INNER JOIN
Reservation 
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code 


-- TASK 2:  HOW TO REPORT LIST OF ALL FLIGHTS WITHOUT RESERVATIONS?
SELECT * FROM FLIGHT 
LEFT OUTER JOIN			
Reservation 
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code 
WHERE
Reservation.Aircraft_Code  IS NULL 


-- TASK 3:  HOW TO REPORT LIST OF ALL RESERVATIONS WITH & WITHOUT FLIGHTS?
SELECT * FROM FLIGHT 
RIGHT OUTER JOIN			
Reservation 
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code 



-- TASK 4:  HOW TO REPORT LIST OF ALL RESERVATIONS WITHOUT FLIGHTS?
SELECT * FROM FLIGHT 
RIGHT OUTER JOIN			
Reservation 
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code 
WHERE
FLIGHT.CRAFT_CODE  IS NULL 


-- TASK 5:  HOW TO REPORT LIST OF ALL FLIGHTS WITH SUCH RESERVATIONS FOR MAXIMUM NUMBER OF SEATS?
SELECT * FROM Reservation 
LEFT OUTER JOIN			
FLIGHT 
ON
FLIGHT.CRAFT_CODE = Reservation.Aircraft_Code 
WHERE
Reservation.No_of_Seats = (SELECT MAX(NO_OF_SEATS) FROM Reservation)

/*
WHEN TO USE WHICH JOIN:

JOIN TYPES:
1.	INNER JOIN			:	TO REPORT MATCHING DATA
2.  OUTER JOINS			:	TO REPORT MATCHING DATA & MISSING DATA
3.  CROSS JOIN			:	TO REPORT ALL POSSIBLE VALUES [M X N combinations]

JOIN OPTIONS:
4.	MERGE JOIN			:	THIS OPTION IS USED TO JOIN BIGGER TABLES
5.	LOOP JOIN			:	THIS OPTION IS USED TO JOIN SMALLER TBALES
6.	HASH JOIN			:	THIS OPTION IS USSED TO JOIN HEAP TABLES [SUCH TABLES WITHOUT ANY INDEX]
*/