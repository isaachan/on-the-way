IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql

-- Define seq_metadatas table --
IF OBJECT_ID('SEQ_METADATAS', 'U') IS NOT NULL
DROP TABLE SEQ_METADATAS

CREATE TABLE SEQ_METADATAS (
  name VARCHAR(20) PRIMARY KEY NOT NULL,
  increase INT NOT NULL DEFAULT 1,
  currentValue INT NOT NULL DEFAULT 1
)

GO

-- Define create_seq procedure --
IF OBJECT_ID('CREATE_SEQ', 'P') IS NOT NULL
DROP PROC CREATE_SEQ
GO

CREATE PROCEDURE CREATE_SEQ
  @name VARCHAR(20)
AS
  IF (SELECT (1) FROM SEQ_METADATAS WHERE NAME = @name) IS NOT NULL
  RAISERROR (
    'SEQ you try to create is aleady exist.',
    1,
    16
  )

  INSERT INTO SEQ_METADATAS (name) VALUES (@name)
GO

-- Define drop_seq procedure --
IF OBJECT_ID('DROP_SEQ') IS NOT NULL
DROP PROC DROP_SEQ
GO

CREATE PROCEDURE DROP_SEQ
  @name VARCHAR(20)
AS
  IF (SELECT (1) FROM SEQ_METADATAS WHERE NAME = @name) IS NULL
  RAISERROR (
    'SEQ you try to delete is not exist.',
    1,
    16
  )
  DELETE FROM SEQ_METADATAS WHERE NAME = @name
GO

-- Define next_value procedure --
IF OBJECT_ID('NEXT_VALUE') IS NOT NULL
DROP PROC NEXT_VALUE
GO

CREATE PROCEDURE NEXT_VALUE
  @name VARCHAR(20)
AS
  DECLARE @returnValue INT
  DECLARE @increase INT
  
  SET @returnValue = (SELECT TOP 1 currentValue FROM SEQ_METADATAS WHERE NAME = @name)
  SET @increase = (SELECT TOP 1 increase FROM SEQ_METADATAS WHERE NAME = @name)

  UPDATE SEQ_METADATAS SET currentValue = (@returnValue + @increase) WHERE NAME = @name

  RETURN @returnValue
GO

