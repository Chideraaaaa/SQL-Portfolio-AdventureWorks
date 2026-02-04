# AdventureWorks SQL Customer & Sales Analysis
## SQL analysis project using the AdventureWorks sample database to demonstrate querying, joins, and data analysis skills.
### Project Overview

This project demonstrates SQL skills using the AdventureWorks sample database.
The focus is on customer behavior and sales performance, using SQL queries to extract, filter, aggregate, and analyze relational data.

### Dataset
	•	Database: AdventureWorks
	•	Source: Microsoft Sample Database
	•	Tables used:
	•	Sales.Customer – customer records
	•	Person.Person – customer personal information
	•	Sales.SalesOrderHeader – sales order details

### Project Objectives
	•	Analyze customer purchasing behavior
	•	Identify high-value customers
	•	Practice SQL joins across multiple tables
	•	Apply filtering, grouping, and aggregation techniques
  ### Skills & Tools Used
	•	SQL Server
	•	SQL JOINs
	•	Aggregates (SUM, AVG, COUNT)
	•	Filtering (WHERE, HAVING)
	•	Pattern matching (LIKE)
	•	Data grouping and sorting

### Analysis Performed

#### Customer Order Details

Objective: Display each customer’s full name, their sales order ID, and the total amount due.
SELECT p.FirstName, p.LastName, soh.SalesOrderID, soh.TotalDue
FROM Sales.Customer sc
JOIN Person.Person p ON sc.PersonID = p.BusinessEntityID
JOIN Sales.SalesOrderHeader soh ON sc.CustomerID = soh.CustomerID;
