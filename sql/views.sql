IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

IF OBJECT_ID('Payroll', 'V') IS NOT NULL
DROP VIEW Payroll
GO

CREATE VIEW Payroll(employee, payment)
--AS SELECT name AS employee, (slary + commission)
AS SELECT name AS employee, (slary + COALESCE(commission, 0.00))
   FROM Personal
GO

SELECT * FROM Payroll
