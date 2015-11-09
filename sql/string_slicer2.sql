IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

-- Define Sequence table --
-- This table used by ParseList2 --
IF OBJECT_ID('SEQUENCE', 'U') IS NOT NULL
DROP TABLE SEQUENCE
GO

CREATE TABLE SEQUENCE (
  seq INT NOT NULL PRIMARY KEY
)

INSERT INTO SEQUENCE VALUES (1)
INSERT INTO SEQUENCE VALUES (2)
INSERT INTO SEQUENCE VALUES (3)
INSERT INTO SEQUENCE VALUES (4)
INSERT INTO SEQUENCE VALUES (5)
INSERT INTO SEQUENCE VALUES (6)
INSERT INTO SEQUENCE VALUES (7)
INSERT INTO SEQUENCE VALUES (8)
INSERT INTO SEQUENCE VALUES (9)
INSERT INTO SEQUENCE VALUES (10)
INSERT INTO SEQUENCE VALUES (11)
INSERT INTO SEQUENCE VALUES (12)
INSERT INTO SEQUENCE VALUES (13)
INSERT INTO SEQUENCE VALUES (14)
INSERT INTO SEQUENCE VALUES (15)
INSERT INTO SEQUENCE VALUES (16)
INSERT INTO SEQUENCE VALUES (17)
INSERT INTO SEQUENCE VALUES (18)
INSERT INTO SEQUENCE VALUES (19)
INSERT INTO SEQUENCE VALUES (20)

GO

-- Define ParmList table --
-- This table stores parsed results.

IF OBJECT_ID('ParmList') IS NOT NULL
DROP TABLE ParmList
GO

CREATE TABLE ParmList (
  location INT NOT NULL,
  parm VARCHAR(20) NOT NULL
)

GO

-- Define ParseList2 procedure -- 
-- This procedure solves the problem using the 'SQL' way
IF OBJECT_ID('ParseList2') IS NOT NULL
DROP PROC ParseList2
GO

CREATE PROCEDURE ParseList2
  @inputString VARCHAR(20)
AS
  INSERT INTO ParmList
    SELECT S1.seq AS location,
           SUBSTRING(@inputString, S1.seq, (S2.seq-S1.seq)) AS parm
    FROM Sequence AS S1, Sequence AS S2
    WHERE SUBSTRING(@inputString, S1.seq, 1) = ','
      AND SUBSTRING(@inputString, S2.seq, 1) = ','
      AND S2.seq = (SELECT MIN(S3.seq)
                         FROM Sequence AS S3
			 WHERE S1.seq < S3.seq
			   AND SUBSTRING(@inputString, S3.seq, 1) = ','
                        )
      AND S1.seq <= S2.seq
      AND S2.seq < LEN(@inputString)
GO

EXEC ParseList2 'abc,def,ghi,jkl,mno,pqr,stu'
SELECT * FROM ParmList
