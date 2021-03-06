CREATE DATABASE DBTRAN11
GO

USE DBTRAN11

create table Reservation
(
Aircraft_Code varchar(10), 
No_of_Seats int, 
Class_Code varchar(10)
)


-- ITEM 1:	EXAMPLES FOR AUTOCOMMIT TRANSACTIONS. means AUTO SAVE.  
INSERT INTO Reservation VALUES ('AI01', 21, 'ECO')			-- TRANSACTION 1
INSERT INTO Reservation VALUES ('AI02', 22, 'ECO')			-- TRANSACTION 2

-- ITEM 2:	EXAMPLES FOR EXPLICIT TRANSACTIONS
-- MANUAL START AND MANUAL END OF TRANSACTION
BEGIN TRANSACTION T1
INSERT INTO Reservation VALUES ('AI127', 21, 'ECO')
INSERT INTO Reservation VALUES ('AI128', 22, 'ECO')
IF @@ERROR = 0		-- THIS "GLOBAL VARIABLE" REPORTS ERROR NUMBER OF PREVIOUS STATEMENT
COMMIT				-- to SAVE the above two rows in the table
ELSE			
ROLLBACK			-- to UNDO the save of above two rows


-- ITEM #3: 	EXAMPLE FOR IMPLICIT TRANSACTION
-- AUTO START OF TRANSACTION BUT MANUAL END.
SET IMPLICIT_TRANSACTIONS ON				-- THIS IS TO ENABLE IMPLICIT TRANSACTIONS. START TRANSACTION AUTOMATICALLY	
INSERT INTO Reservation VALUES ('AI127', 21, 'ECO')
INSERT INTO Reservation VALUES ('AI129', 23, 'ECO')
IF @@ERROR = 0	
COMMIT
ELSE			
ROLLBACK

SET IMPLICIT_TRANSACTIONS OFF		-- THIS IS TO DISABLE IMPLICIT TRANSACTIONS. this is a session level setting.



TRUNCATE TABLE Reservation
SELECT * FROM Reservation			-- 0 ROWS

INSERT INTO Reservation VALUES ('AI01', 21, 'ECO')			-- TRANSACTION 1
INSERT INTO Reservation VALUES ('AI02', 22, 'ECO')			-- TRANSACTION 2
INSERT INTO Reservation VALUES ('AI03', 21, 'ECO')			-- TRANSACTION 3
INSERT INTO Reservation VALUES ('AI04', 22, 'ECO')			-- TRANSACTION 4

SELECT * FROM Reservation			-- 4 ROWS


-- ITEM #4: OPEN TRANSACTIONS : TRANSACTIONS WHICH ARE STARTED BUT NOT COMMITTED NOR ROLLEDBACK.  
-- IMPACT OF OPEN TRANSACTIONS : QUERY BLOCKING. MEANS, THE QUERY FOR OTHER SESSIONS RUN FOREVER.
BEGIN TRANSACTION T1
INSERT INTO Reservation VALUES ('AI05', 21, 'ECO')
INSERT INTO Reservation VALUES ('AI06', 22, 'ECO')


/*
IN OTHER SESSION:

SELECT * FROM Reservation

-- LOCK HINTS : THESE ARE USED TO AVOID QUERY BLOCKING

SELECT * FROM Reservation WITH (NOLOCK)		-- PREVIOUSLY COMITTED DATA + RECENT UNCOMITTED DATA

SELECT * FROM Reservation WITH (READPAST)	-- PREVIOUSLY COMITTED DATA ONLY

*/


-- HOW TO RESOLVE QUERY BLOCKING?
COMMIT 