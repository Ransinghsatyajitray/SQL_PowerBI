
USE [PRODUCTDATABASE]
GO

SELECT * FROM CUSTOMERS_DATA 
SELECT * FROM PRODUCTS_DATA 
SELECT * FROM TIME_DATA 
SELECT * FROM SALES_DATA 

-- Q1:	HOW TO REPORT YEAR WISE TOTAL SALES?
-- Q2:  HOW TO REPORT YEAR WISE, QUARTER WISE TOTAL SALES AND TOTAL TAX?
-- Q3:  HOW TO REPORT YEAR WISE, QUARTER WISE, MONTH WISE TOTAL SALES AND TOTAL TAX?
-- Q4:  HOW TO REPORT YEAR WISE, QUARTER WISE TOTAL SALES AND TOTAL TAX FOR JUNE MONTH ?
-- Q5:  HOW TO REPORT CLASS WISE, COLOR WISE PRODUCTS FOR EACH YEAR BASED ON ASC ORDER OF SALES?
-- Q6: HOW TO REPORT TOTAL SALES FOR SUCH PRODUCTS WITH MAXIMUM NUMBER OF SALES?
-- Q7: HOW TO REPORT TOTAL SALES FOR SUCH PRODUCTS EXCEPT WITH MINIMUM NUMBER OF SALES?
-- Q8: HOW TO COMBINE THE RESULTS FROM ABOVE TWO QUERIES.
-- Q9: HOW TO ADDRESS POSSIBLE BLOCKING ISSUES FROM ABOVE TWO QUERIES?
-- Q10: HOW TO REPORT YEAR WISE, CUSTOMER WISE, PRODUCT WISE TOTAL SALES AND TOTAL TAX ABOVE 1000 USD?




-- Q1:	HOW TO REPORT YEAR WISE TOTAL SALES?
SELECT T.CalendarYear, SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
GROUP BY T.CalendarYear


-- Q2:  HOW TO REPORT YEAR WISE, QUARTER WISE TOTAL SALES AND TOTAL TAX?
SELECT T.CalendarYear, T.CalendarQuarter, 
SUM(S.SalesAmount) AS TOTAL_SALES, SUM(S.TAXAMT) AS TOTAL_TAX
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
GROUP BY T.CalendarYear, T.CalendarQuarter



-- Q3:  HOW TO REPORT YEAR WISE, QUARTER WISE, MONTH WISE TOTAL SALES AND TOTAL TAX?
SELECT T.CalendarYear, T.CalendarQuarter, T.EnglishMonthName,
SUM(S.SalesAmount) AS TOTAL_SALES, SUM(S.TAXAMT) AS TOTAL_TAX
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
GROUP BY T.CalendarYear, T.CalendarQuarter,  T.EnglishMonthName


-- Q4:  HOW TO REPORT YEAR WISE, QUARTER WISE TOTAL SALES AND TOTAL TAX FOR JUNE MONTH ?
SELECT T.CalendarYear, T.CalendarQuarter, 
SUM(S.SalesAmount) AS TOTAL_SALES, SUM(S.TAXAMT) AS TOTAL_TAX
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
WHERE T.EnglishMonthName = 'JUNE'
GROUP BY T.CalendarYear, T.CalendarQuarter


-- REQUIREMENT : HOW TO REPORT SALES BASED ON A GIVEN YEAR?
CREATE PROC USP_REP_SALES  @MONTH VARCHAR(30)
AS
SELECT T.CalendarYear, T.CalendarQuarter, 
SUM(S.SalesAmount) AS TOTAL_SALES, SUM(S.TAXAMT) AS TOTAL_TAX
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
WHERE T.EnglishMonthName = @MONTH
GROUP BY T.CalendarYear, T.CalendarQuarter


EXEC USP_REP_SALES 'JUNE'					EXEC USP_REP_SALES 'MAY'				EXEC USP_REP_SALES 'MARCH'	

--	ATTENDEES FOR POWER BI & MSBI : WE COMPLETED T-SQL CONCEPTS BY TODAY.		
			-- CONSTRAINTS
			-- JOINS
			-- CASE STUDY CONCEPTS	:	GROUP BY, HAVING, JOINS, LOCK HINTS
		
-- PARTICIPANTS FOR T-SQL PROGRAMMING (SQL DEVELOPERS) :  MEETING TOMORROW AS USUAL. WE SHALL START PROGRAMMING CONCEPTS.





-- Q5:  HOW TO REPORT CLASS WISE, COLOR WISE PRODUCTS FOR EACH YEAR BASED ON ASC ORDER OF SALES?
SELECT 
P.Class, P.Color, T.CalendarYear, 
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
GROUP BY P.Class, P.Color, T.CalendarYear
ORDER BY TOTAL_SALES ASC


-- Q6: HOW TO REPORT TOTAL SALES FOR SUCH PRODUCTS WITH MAXIMUM NUMBER OF SALES?

-- STEP 1: IDENTIFY THE PRODUCTS THAT HAVE MAX SALE VALUE:
SELECT 
P.EnglishProductName,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
GROUP BY P.EnglishProductName

CREATE VIEW VW_SALE_PROIDUCTS 
AS
SELECT 
P.EnglishProductName,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
GROUP BY P.EnglishProductName


SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
				WHERE TOTAL_SALES = (SELECT MAX(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)

-- STEP 2: 
SELECT 
P.EnglishProductName, P.Color, P.Class,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
WHERE
P.EnglishProductName IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MAX(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
GROUP BY P.EnglishProductName, P.Color, P.Class




-- Q7: HOW TO REPORT TOTAL SALES FOR SUCH PRODUCTS EXCEPT WITH MINIMUM NUMBER OF SALES?
SELECT 
P.EnglishProductName, P.Color, P.Class,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
WHERE
P.EnglishProductName NOT IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MIN(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
GROUP BY P.EnglishProductName, P.Color, P.Class



-- Q8: HOW TO COMBINE THE RESULTS FROM ABOVE TWO QUERIES ?
SELECT 
P.EnglishProductName, P.Color, P.Class,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey
WHERE
P.EnglishProductName NOT IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MIN(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
OR
P.EnglishProductName IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MAX(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
GROUP BY P.EnglishProductName, P.Color, P.Class



-- Q9: HOW TO ADDRESS POSSIBLE BLOCKING ISSUES FROM ABOVE TWO QUERIES?   SOLUTION : USE LOCK HINTS
SELECT 
P.EnglishProductName, P.Color, P.Class,
SUM(S.SalesAmount) AS TOTAL_SALES 
FROM SALES_DATA  AS S (READPAST)
INNER JOIN PRODUCTS_DATA AS P (READPAST)
ON
P.ProductKey = S.ProductKey
WHERE
P.EnglishProductName NOT IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MIN(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
OR
P.EnglishProductName IN (
							SELECT EnglishProductName FROM VW_SALE_PROIDUCTS 
							WHERE TOTAL_SALES = (SELECT MAX(TOTAL_SALES) FROM VW_SALE_PROIDUCTS)
						)
GROUP BY P.EnglishProductName, P.Color, P.Class



-- Q10: HOW TO REPORT YEAR WISE, CUSTOMER WISE, PRODUCT WISE TOTAL SALES AND TOTAL TAX ABOVE 1000 USD?
SELECT 
T.CalendarYear,  C.FirstName + '  ' + C.LastName AS FULLNAME, P.EnglishProductName,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
INNER JOIN CUSTOMERS_DATA AS C
ON
C.CustomerKey = S.CustomerKey
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey 
GROUP BY T.CalendarYear,  C.FirstName + '  ' + C.LastName, P.EnglishProductName
HAVING SUM(S.SalesAmount) > 1000


CREATE VIEW VW_EXCEL_ACCESS
AS
SELECT 
T.CalendarYear,  C.FirstName + '  ' + C.LastName AS FULLNAME, P.EnglishProductName,
SUM(S.SalesAmount) AS TOTAL_SALES
FROM SALES_DATA  AS S
INNER JOIN TIME_DATA AS T
ON
S.OrderDateKey = T.TimeKey 
INNER JOIN CUSTOMERS_DATA AS C
ON
C.CustomerKey = S.CustomerKey
INNER JOIN PRODUCTS_DATA AS P
ON
P.ProductKey = S.ProductKey 
GROUP BY T.CalendarYear,  C.FirstName + '  ' + C.LastName, P.EnglishProductName
HAVING SUM(S.SalesAmount) > 1000

SELECT * FROM VW_EXCEL_ACCESS

/*
STEPS FOR IMPORTING SQL DATABASE DATA  INTO EXCEL?
	LAUNCH EXCEL > DATA RIBBON > OTHER SOURCES > SQL SERVER > SPECIFY SERVER NAME, DATABASE NAME > 
	CONNECT > SELECT VIEW CREATED ABOVE > PIVOT TABLE & CHART > OK. THIS CREATES ON ODC CONNECTION
	OFFICE DATA CONNECTION.
	SELECT REQUIRED FIELDS. REPORT IS AUTO GENERATED.
*/

/*
NORMAL FORMS	:	A MECHANISM TO IDENTIFY THE TABLES, RELATIONS AND DATA TYPES.
					ENSURE PROPER DIVSION OF BUSINESS DATA INTO MULTIPLE TABLES.

1 NF	:	FIRST NORMAL FORM. EVERY COLUMN SHOULD BE ATOMIC. MEANS, STORES SINGLE VALUE.  tblPopulation

2 NF	:	SECOND NORMAL FORM. EVERY TABLE SHOULD BE IN FIRST NORMAL FORM
			EVERY TABLE SHOULD BE HAVING A CANDIDATE KEY (pk / uq). USED FOR FUNCTIONAL DEPENDANCY.

3 NF	:	THIRD NORMAL FORM. EVERY TABLE SHOULD BE IN SECOND NORMAL FORM
			EVERY TABLE SHOULD BE HAVING A FOREIGN KEY. USED FOR MULTI-VALUED DEPENDANCY.

BCNF NF	:	BOYCE-CODD NORMAL FORM. EVERY TABLE SHOULD BE IN THIRD NORMAL FORM
			EVERY TABLE SHOULD BE HAVING MORE THAN ONE FOREIGN KEY. USED FOR MULTI-VALUED DEPENDANCY.
			AND MANY TO ONE RELATION.
------------------------------------
4 NF	:	FOURTH NORMAL FORM. EVERY TABLE SHOULD BE IN THIRD NORMAL FORM
			AND ATLEAST ONE SELF REFERENCE. MEANS A TABLE REFERENCING ITSELF. */

ETNF	:	ENTITY TUPLE NORMAL FORM. THIS IS AN EXTENSION OF 4TH NORMAL FORM.
			A TABLE CAN HAVE CANDIDATE KEY ON MORE THAN ONE COLUMN = "COMPOSITE KEYS"
			EXAMPLE :	PRIMARY KEY (COL1, COL2)				UNQUE KEY (COL1, COL2)			*/








