IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

IF OBJECT_ID('Personal', 'U') IS NOT NULL
DROP TABLE Personal
GO

CREATE TABLE Personal (
  name VARCHAR(10) NOT NULL,
  slary DECIMAL NOT NULL,
  commission DECIMAL
)

GO

INSERT INTO Personal VALUES ('hankai', 100.0, 10.0)
INSERT INTO Personal VALUES ('liyilin', 115.0, 0.0)
INSERT INTO Personal VALUES ('zhang3', 100.0, 5.0)
INSERT INTO Personal VALUES ('li4', 100.0, NULL)
