-- JOINING TWO TABLES 
--using inner joins/joins
SELECT * FROM PERSON.PERSON;
select * from SALES.CUSTOMER;

SELECT * 
FROM PERSON.PERSON AS PP
INNER JOIN SALES.CUSTOMER AS SC
ON PP.BusinessEntityID = SC.CUSTOMERID;

---RETRIEVE FIRST NAME, LAST NAME, DEMOGRAPHICS,STORE ID,TERRITORYID AND 
---ACCOUNT NUMBER OF CUSTOMERS
SELECT PP.FIRSTNAME, PP.LASTNAME,PP.DEMOGRAPHICS,SC.STOREID,
SC.TerritoryID,SC.AccountNumber 
FROM PERSON.PERSON AS PP
INNER JOIN SALES.CUSTOMER SC
ON PP.BusinessEntityID = SC.CUSTOMERID;


---RETRIEVE THE NAMES OF CUSTOMERS WHOSE FIRST NAME STARTS FROM "D"
---AND LAST NAMES ENDS WITH "M",AND ARRANGE THEM FROM HIGHEST TO LOWEST
SELECT PP.FIRSTNAME, PP.LASTNAME
FROM PERSON.PERSON AS PP
INNER JOIN SALES.Customer AS SC
ON PP.BusinessEntityID = SC.CUSTOMERID
WHERE PP.FIRSTNAME LIKE 'D%'
AND PP.LASTNAME LIKE '%M'
ORDER BY PP.FIRSTNAME DESC, PP.LASTNAME DESC;


---RETRIEVE THE NAMES OF CUSTOMERS WHOSE FIRST NAME STARTS FROM "D"
---OR LAST NAMES ENDS WITH "M",AND ARRANGE THEMFROM HIGHEST TO LOWEST
SELECT PP.FIRSTNAME, PP.LASTNAME
FROM SALES.Customer AS SC
INNER JOIN PERSON.PERSON AS PP
ON PP.BusinessEntityID = SC.CUSTOMERID
WHERE PP.FIRSTNAME LIKE 'D%'
OR PP.LASTNAME LIKE '%M'
ORDER BY PP.FIRSTNAME ASC, PP.LASTNAME ASC;


---RETRIEVE ALL CUSTOMERS WHOSE PERSON TYPE APPEARS MORE THAN 
---ONCE ACROSS ALL LINKED RECORDS 
SELECT PP.PERSONTYPE, COUNT(*) AS TOTALPERSON_TYPE
FROM PERSON.PERSON AS PP
JOIN SALES.CUSTOMER AS SC
ON PP.BusinessEntityID = SC.CUSTOMERID
GROUP BY PP.PERSONTYPE
HAVING COUNT(*) > 1
ORDER BY PP.PERSONTYPE ASC


-- JOINING TWO TABLES 
--using inner joins/left joins/right joins
---
SELECT * FROM PERSON.PERSON;
select * from SALES.SalesOrderHeader;

SELECT * 
FROM PERSON.PERSON AS PP
JOIN SALES.SalesOrderHeader AS SOH
ON PP.BusinessEntityID = SOH.SalesPersonID

---LIST ALL PERSONS WHO HAVE NEVER PLACED ANY ORDER
SELECT PP.BusinessEntityID, PP.FIRSTNAME,PP.LASTNAME
FROM PERSON.PERSON PP
LEFT JOIN SALES.SalesOrderHeader SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE SOH.SalesOrderID IS NULL;

---FIND PERSONS WHOSE NAMES HAS ATLEAST A VOWEL AND 
---COUNT THEIR ORDERS IN DESCENDING ORDER
SELECT PP.FIRSTNAME, PP.LASTNAME,
COUNT (SOH.SalesOrderID) AS TOTAL_ORDER
FROM PERSON.PERSON PP
JOIN SALES.SalesOrderHeader SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.FIRSTNAME LIKE '%[AEIOU]%'
GROUP BY PP.FIRSTNAME, PP.LASTNAME
ORDER BY TOTAL_ORDER DESC;

---FIND ORDERS WHERE SALESPERSON's FIRSTNAME HAS 4 CHARACTERS AND 
--- THE LAST NAME HAS AT LEAST THREE CHRACTERS 
SELECT SOH.SALESORDERID, SOH.ORDERDATE,
PP.FIRSTNAME, PP.LASTNAME
FROM PERSON.PERSON PP
RIGHT JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.FIRSTNAME LIKE '____' AND PP.LASTNAME LIKE '___%';

---RETRIEVE ALL ORDERS PLACED BY SALESPERSONS WHOSE LAST NAMES 
---ENDS WITH EXACTLY THREE LETTERS
SELECT SOH.SALESORDERID, SOH.ORDERDATE,
PP.FIRSTNAME, PP.LASTNAME
FROM PERSON.PERSON PP
JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.LASTNAME LIKE '%___';


---LIST ALL ORDERS WITH A TOTAL DUE GREATER THAN 50,000 PLACED BY 
---SALESPERSON WHOSE FIRST NAME HAS EXACTLY FIVE CHARACTERS 
SELECT SOH.SALESORDERID, SOH.ORDERDATE, SOH.TotalDue,
PP.FIRSTNAME, PP.LASTNAME
FROM PERSON.PERSON PP
JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.FIRSTNAME LIKE '_____'
AND SOH.TotalDue>50000
ORDER BY SOH.TotalDue DESC;

---FIND THE TOTAL SALES OF PERSONS WHOSE LAST NAME STARTS WITH A
---OR WHO HAVE PLACED ONE ONLINE ORDER (ONLINEORDERFLAG = 1)
SELECT PP.LASTNAME, SUM(SOH.TOTALDUE) AS TOTAL_SALES
FROM PERSON.PERSON PP
JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.LASTNAME LIKE 'A%' OR SOH.OnlineOrderFlag = 1
GROUP BY PP.LASTNAME
HAVING SUM(SOH.TOTALDUE) > 20000 
ORDER BY  TOTAL_SALES DESC;

---RETRIEVE TOP FIVE SALESPERSONS WHOSE CUSTOMER ID ENDS 3 OR 6
SELECT TOP 5
PP.FIRSTNAME,
PP.LASTNAME,
SOH.CUSTOMERID
FROM PERSON.PERSON PP
JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE CUSTOMERID LIKE '%3'  OR CUSTOMERID LIKE '%6';

---FIND ALL ORDERS BETWEEN 2014-2015 FOR SALESPERSONS WHOSE FISRT NAME HAS 
---EXACTLY FIVE CHARACTERS 
SELECT SOH.SalesOrderID,SOH.OrderDate,SOH.TOTALDUE,PP.FIRSTNAME,PP.LASTNAME
FROM PERSON.PERSON PP
JOIN SALES.SALESORDERHEADER SOH
ON PP.BusinessEntityID = SOH.SalesPersonID
WHERE PP.FIRSTNAME LIKE '_____'
AND YEAR (SOH.OrderDate) BETWEEN 2014 AND 2015

---Compare Average TotalDue for Salespersons with 3-letter vs 6-letter First Names
SELECT 
    CASE 
        WHEN LEN(pp.FirstName) = 3 THEN '3-letter name'
        WHEN LEN(pp.FirstName) = 6 THEN '6-letter name'
    END AS NameType,
    AVG(soh.TotalDue) AS AvgTotalDue
FROM Person.Person pp
JOIN Sales.SalesOrderHeader soh
    ON pp.BusinessEntityID = soh.SalesPersonID
WHERE LEN(pp.FirstName) IN (3, 6)
GROUP BY CASE 
             WHEN LEN(pp.FirstName) = 3 THEN '3-letter name'
             WHEN LEN(pp.FirstName) = 6 THEN '6-letter name'
         END;

---SUBQUERIES
---Retrieve all orders where the total amount (TotalDue) is higher than the average order amount.
SELECT SalesOrderID, OrderDate, TotalDue
FROM Sales.SalesOrderHeader
WHERE TotalDue > (
    SELECT AVG(TotalDue)
    FROM Sales.SalesOrderHeader) 
    ORDER BY TotalDue DESC;

---Find the names of customers who have placed at least one online order (OnlineOrderFlag = 1).
SELECT P.FirstName, P.LastName
FROM Person.Person P
WHERE P.BusinessEntityID IN (
    SELECT CustomerID
    FROM Sales.SalesOrderHeader
    WHERE OnlineOrderFlag >= 1);


---List salespersons whose total sales are greater than the average of all salespersons.
SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
FROM Sales.SalesOrderHeader
GROUP BY SalesPersonID
HAVING SUM(TotalDue) > (
    SELECT AVG(TotalSales)
    FROM (
        SELECT SUM(TotalDue) AS TotalSales
        FROM Sales.SalesOrderHeader
        GROUP BY SalesPersonID ) AS AvgSales)
ORDER BY TotalSales DESC;


---Find the Most Frequent Customer
SELECT TOP 1 CustomerID, COUNT(*) AS OrderCount
FROM Sales.SalesOrderHeader
GROUP BY CustomerID
HAVING COUNT(*) = (
    SELECT MAX(OrderFrequency)
    FROM (
        SELECT COUNT(*) AS OrderFrequency
        FROM Sales.SalesOrderHeader
        GROUP BY CustomerID
    ) AS Sub
)
ORDER BY OrderCount DESC;


---Find total sales for each salesperson and order the results from highest to lowest.
SELECT 
    P.FirstName, P.LastName AS SalesPerson,
    T.TotalSales
FROM (
    SELECT SalesPersonID, SUM(TotalDue) AS TotalSales
    FROM Sales.SalesOrderHeader
    GROUP BY SalesPersonID
) AS T
JOIN Person.Person P
    ON P.BusinessEntityID = T.SalesPersonID
ORDER BY T.TotalSales DESC;


--JOINING OF THREE TABLES

--RETREIVE ALL CUTOMER ID, NAMES AND THEIR TOTAL SALES, INCLUDING CUSTOMERS WHO HAVE NOT 
--PLACED ANY ORDER
SELECT * FROM SALES.Customer; --CustomerID, Person_ID
SELECT * FROM SALES.SalesOrderHeader;  --CustomerID
SELECT * FROM Person.Person; -- Person_ID


select SC.CustomerID, SUM(SOH.Totaldue) AS Total_sales
from sales.customer SC --(you can use AS if you want or not )
LEFT JOIN Sales.SalesOrderHeader SOH 
ON SOH.CustomerID = SC.CustomerID
left join Person.Person PP
on PP.BusinessEntityID = SC.PersonID
group by SC.CustomerID

--SHOW THE NAMES, CUSTOMER ID AND THEIR TOTAL SALES 
select SC.CustomerID,PP.firstname, PP.lastname,
   round (SUM(SOH.Totaldue), 0) AS Total_sales
from sales.customer SC --(you can use AS if you want or not )
LEFT JOIN Sales.SalesOrderHeader SOH 
ON SOH.CustomerID = SC.CustomerID
left join Person.Person PP
on PP.BusinessEntityID = SC.PersonID
group by SC.CustomerID, PP.firstname, PP.lastname
order by Total_sales desc;

---Display each customer's full name, their sales order ID, and the total amount due
SELECT 
    p.FirstName, p.LastName ,
    soh.SalesOrderID,
    soh.TotalDue
FROM Sales.Customer Sc
JOIN Person.Person p 
    ON sc.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON sc.CustomerID = soh.CustomerID;

---List customers whose LastName ends with “s” and total sales exceed 20,000.
SELECT 
    p.FirstName, p.LastName AS CustomerName,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
WHERE p.LastName LIKE '%s'
GROUP BY p.FirstName, p.LastName
HAVING SUM(soh.TotalDue) > 20000
ORDER BY TotalSales DESC;

---Find the top 5 customers with the highest total sales
SELECT TOP 8
    p.FirstName + ' ' + p.LastName AS CustomerName,
    SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSales DESC;


--- Find customers whose first name has exactly 4 letters and
---who have placed more than one order
SELECT 
    p.FirstName,
    p.LastName,
    COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
WHERE p.FirstName LIKE '____'   -- exactly 4 characters
GROUP BY p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 1;

---retrieve customers with at least one order less than 35,000 and show their average order value
SELECT 
    p.FirstName, p.LastName AS CustomerName,
    AVG(soh.TotalDue) AS AvgOrderValue
FROM Sales.Customer c
JOIN Person.Person p 
    ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh 
    ON c.CustomerID = soh.CustomerID
WHERE soh.TotalDue < 35000
GROUP BY p.FirstName, p.LastName


