# AdventureWorks SQL Customer & Sales Analysis
## SQL analysis project using the AdventureWorks sample database to demonstrate querying, joins, and data analysis skills.

### Table of Contents
- [projectOverview](#project-overview)
- [Dataset](#Dataset)
- [ProjectObjectives](#Project-Objectives)
- [Skills&ToolsUsed](#Skills&Tools-Used)
- [AnalysisPerformed](#Analysis-Performed)



### Project Overview
---

This project demonstrates SQL skills using the AdventureWorks sample database.
The focus is on customer behavior and sales performance, using SQL queries to extract, filter, aggregate, and analyze relational data.

### Dataset
	•	Database: AdventureWorks
	•	Source: Microsoft Sample Database
	•	Tables used;
	1 Sales.Customer – customer records
	2 Person.Person – customer personal information
	3 Sales.SalesOrderHeader – sales order details

### Project Objectives
	•	Analyze customer purchasing behavior
	•	Identify high-value customers
	•	Practice SQL joins across multiple tables
	•	Apply filtering, grouping, and aggregation techniques
	
### Skills & Tools 
	•	SQL Server
	•	SQL JOINs
	•	Aggregates (SUM, AVG, COUNT)
	•	Filtering (WHERE, HAVING)
	•	Pattern matching (LIKE)
	•	Data grouping and sorting
	
### Analysis Performed

#### 1. Customer Order Details
Objective: Display each customer’s full name, their sales order ID, and the total amount due.f
```sql
SELECT PP.FIRSTNAME, PP.LASTNAME,PP.DEMOGRAPHICS,SC.STOREID,
SC.TerritoryID,SC.AccountNumber 
FROM PERSON.PERSON AS PP
INNER JOIN SALES.CUSTOMER SC
ON PP.BusinessEntityID = SC.CUSTOMERID;
```
**Explanation**:
- Combined Customer, Person, and SalesOrderHeader tables using JOINs
- Retrieved customer names, order IDs, and total due amounts
	
#### 2. Customers with Last Name Ending in ‘s’ and High Sales
Objective: List customers whose last name ends with “s” and whose total sales exceed 20,000.
```sql
SELECT p.FirstName, p.LastName AS CustomerName, SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE p.LastName LIKE '%s'
GROUP BY p.FirstName, p.LastName
HAVING SUM(soh.TotalDue) > 20000
ORDER BY TotalSales DESC;
```
**Explanation**:
- Used WHERE to filter last names ending with “s”
-  Used GROUP BY and HAVING to find customers with total sales above 20,000

#### 3. Top Customers by Total Sales
Objective: Find the top 8 customers with the highest total sales.
```sql
SELECT TOP 8 p.FirstName + ' ' + p.LastName AS CustomerName, SUM(soh.TotalDue) AS TotalSales
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
GROUP BY p.FirstName, p.LastName
ORDER BY TotalSales DESC;
```
**Explanation**:
- Aggregated total sales per customer
- Sorted in descending order to identify top-performing customers

#### 4. Customers with Four-Letter First Names & Multiple Orders
Objective: Find customers whose first name has exactly 4 letters and who have placed more than one order.
```sql
SELECT p.FirstName, p.LastName, COUNT(soh.SalesOrderID) AS OrderCount
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE p.FirstName LIKE '____'
GROUP BY p.FirstName, p.LastName
HAVING COUNT(soh.SalesOrderID) > 1;
```
**Explanation**:
- Used LIKE '____' to filter first names with exactly 4 letters
- Counted orders per customer and used HAVING to return those with more than one order

#### 5. Average Order Value for Orders Less Than 35,000
Objective: Retrieve customers with at least one order less than 35,000 and calculate their average order value.
```sql
SELECT p.FirstName, p.LastName AS CustomerName, AVG(soh.TotalDue) AS AvgOrderValue
FROM Sales.Customer c
JOIN Person.Person p ON c.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON c.CustomerID = soh.CustomerID
WHERE soh.TotalDue < 35000
GROUP BY p.FirstName, p.LastName;
```
**Explanation**;
- Filtered orders below 35,000
- Calculated average order value per customer to analyze purchasing behavior

	---
### Key Insights
	•	A small group of customers contributes a significant portion of total sales
	•	Repeat customers place multiple orders, indicating loyalty
	•	Filtering and aggregation help identify high-value customer segment













	








