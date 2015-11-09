IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

IF OBJECT_ID('ParseList', 'P') IS NOT NULL
DROP PROC ParseList
GO

IF OBJECT_ID('Outputs', 'U') IS NOT NULL
DROP TABLE Outputs
GO

CREATE TABLE Outputs (
  output VARCHAR(100)
)

GO

CREATE PROCEDURE ParseList 
  @inputString VARCHAR(100)
AS
  DECLARE @slicer INT
  SET @inputString = @inputString + ","
  WHILE LEN(@inputString) > 0
  BEGIn
    SET @slicer = 1
    WHILE SUBSTRING(@inputString, @slicer, 1) <> ',' 
    BEGIN  
      SET @slicer = @slicer + 1
    END

    DECLARE @outputString VARCHAR(100)    
    SET @outputString = SUBSTRING(@inputString, 1, @slicer - 1)
    -- Consumer @outputString --
    -- SELECT ">>> " + @outputString
    INSERT INTO Outputs VALUES (@outputString)    

    SET @inputString = SUBSTRING(@inputString, @slicer + 1, (LEN(@inputString) - @slicer))
  END
GO

EXEC ParseList "abcd,efgh,ijk,lmno"
EXEC ParseList "1,2,3"
EXEC ParseList "x"
EXEC ParseList ""
GO

SELECT * FROM Outputs