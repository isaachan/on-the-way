IF DB_ID('thinking_in_sql') IS NULL
    CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

IF OBJECT_ID('BarcodeCheckSum', 'FN') IS NOT NULL
    DROP FUNCTION BarcodeCheckSum
GO

CREATE FUNCTION dbo.BarcodeCheckSum (@barCode VARCHAR(12))
RETURNS INT
AS
BEGIN
    -- Ignore the checking that barCode is numberic and length is 12

    DECLARE @barcode_checkers INT
    SET @barcode_checkers = 0

    DECLARE @idx INT
    SET @idx = 1
    
    DECLARE @sgn INT
    
    WHILE ( @idx <= 12 )
    BEGIN
	IF (@idx % 2) = 0
	SET @sgn = -1

	IF (@idx % 2) = 1
	SET @sgn = 1

	SET @barcode_checkers = @barcode_checkers + CAST(SUBSTRING(@barCode, @idx, 1) AS INT) * @sgn
	SET @idx = @idx + 1
    END
    
    RETURN(ABS(@barcode_checkers % 10))
END
GO

PRINT dbo.BarcodeCheckSum('283723281122')
PRINT dbo.BarcodeCheckSum('123412341234')

--------------------------------------------------------------
-- Code below is to implement the same functionility in 
-- total different way, the SQL way
--------------------------------------------------------------

IF OBJECT_ID ('Sequnce', 'U') IS NOT NULL
    DROP TABLE Sequnce
GO

CREATE TABLE Sequnce (
    Idx INT PRIMARY KEY NOT NULL
)

INSERT INTO Sequnce VALUES
    (1), (2), (3), (4),
    (5), (6), (7), (8),
    (9), (10), (11), (12)
GO

IF OBJECT_ID('BarcodeCheckSum2', 'FN') IS NOT NULL
    DROP FUNCTION BarcodeCheckSum2
GO

CREATE FUNCTION dbo.BarcodeCheckSum2 (@barCode VARCHAR(12))
RETURNS INT
BEGIN
    RETURN(
        SELECT ABS(
	         SUM(
		   CAST(SUBSTRING(@barCode, S.Idx, 1) AS INT) * (CASE (S.Idx % 2) WHEN 1 THEN -1 ELSE 1 END)
		 ) % 10
	       )
        FROM Sequnce AS S
    )
END
GO

PRINT dbo.BarcodeCheckSum2('283723281122')
PRINT dbo.BarcodeCheckSum2('123412341234')
