# AdventureWorks SQL Customer & Sales Analysis
## SQL analysis project using the AdventureWorks sample database to demonstrate querying, joins, and data analysis skills.

### Table of Contents
- [projectOverview](#project-overview)
- [Dataset](#Dataset)
- [ProjectObjectives](#Project-Objectives)
- [Skills&ToolsUsed](#Skills&Tools-Used)
- [AnalysisPerformed](#Analysis-Performed)
- 




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
	
### Skills & Tools Used
- SQL Server
- SQL JOINs
- Aggregates (SUM, AVG, COUNT)
- Filtering (WHERE, HAVING)
- Pattern matching (LIKE)
- Data grouping and sorting

### Analysis Performed

#### Customer Order Details
##### RETRIEVE FIRST NAME, LAST NAME, DEMOGRAPHICS,STORE ID,TERRITORYID AND ACCOUNT NUMBER OF CUSTOMERS
```sql
SELECT PP.FIRSTNAME, PP.LASTNAME,PP.DEMOGRAPHICS,SC.STOREID,
SC.TerritoryID,SC.AccountNumber 
FROM PERSON.PERSON AS PP
INNER JOIN SALES.CUSTOMER SC
ON PP.BusinessEntityID = SC.CUSTOMERID;
```
