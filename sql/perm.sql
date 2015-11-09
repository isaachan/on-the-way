IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

IF OBJECT_ID('Alpha', 'U') IS NOT NULL
DROP TABLE Alpha
GO

CREATE TABLE Alpha (
  ltr CHAR(1) PRIMARY KEY CHECK (ltr BETWEEN 'A' AND 'Z')
)
GO

IF OBJECT_ID('Perm9', 'U') IS NOT NULL
DROP TABLE Perm9
GO

CREATE TABLE Perm9 (p CHAR(9) NOT NULL PRIMARY KEY)
GO

IF OBJECT_ID('Permute', 'P') IS NOT NULL
DROP PROC Permute
GO

CREATE PROCEDURE Permute (
  @a1 CHAR(1), @a2 CHAR(1), @a3 CHAR(1),
  @a4 CHAR(1), @a5 CHAR(1), @a6 CHAR(1),
  @a7 CHAR(1), @a8 CHAR(1), @a9 CHAR(1)
)
AS
DELETE Alpha
INSERT INTO Alpha VALUES (@a1), (@a2), (@a3), (@a4), (@a5), (@a6), (@a7), (@a8), (@a9) 

DELETE Perm9
INSERT INTO Perm9
  SELECT A1.ltr + A2.ltr + A3.ltr + A4.ltr + A5.ltr + A6.ltr + A7.ltr + A8.ltr + A9.ltr
  FROM Alpha AS A1, Alpha AS A2, Alpha AS A3,
       Alpha AS A4, Alpha AS A5, Alpha AS A6,
       Alpha AS A7, Alpha AS A8, Alpha AS A9
  WHERE A1.ltr NOT IN (A2.ltr, A3.ltr, A4.ltr, A5.ltr, A6.ltr, A7.ltr, A8.ltr, A9.ltr)
    AND A2.ltr NOT IN (A3.ltr, A4.ltr, A5.ltr, A6.ltr, A7.ltr, A8.ltr, A9.ltr)
    AND A3.ltr NOT IN (A4.ltr, A5.ltr, A6.ltr, A7.ltr, A8.ltr, A9.ltr)
    AND A4.ltr NOT IN (A5.ltr, A6.ltr, A7.ltr, A8.ltr, A9.ltr)
    AND A5.ltr NOT IN (A6.ltr, A7.ltr, A8.ltr, A9.ltr)
    AND A6.ltr NOT IN (A7.ltr, A8.ltr, A9.ltr)
    AND A7.ltr NOT IN (A8.ltr, A9.ltr)
    AND A8.ltr NOT IN (A9.ltr)  
GO

EXEC Permute 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I'

SELECT * FROM Alpha
GO
