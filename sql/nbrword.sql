IF EXISTS (SELECT 1 FROM SYS.DATABASES WHERE NAME='thinking_in_sql')
DROP DATABASE thinking_in_sql
GO

CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql
GO

CREATE TABLE NbrWords (
  seq INTEGER PRIMARY KEY,
  nbr_word VARCHAR(30) NOT NULL
);

INSERT NbrWords VALUES(1, "one");
INSERT NbrWords VALUES(2, "two");
INSERT NbrWords VALUES(3, "three");
INSERT NbrWords VALUES(4, "four");
INSERT NbrWords VALUES(5, "five");
INSERT NbrWords VALUES(6, "six");
INSERT NbrWords VALUES(7, "seven");
INSERT NbrWords VALUES(8, "eight");
INSERT NbrWords VALUES(9, "nine");
INSERT NbrWords VALUES(10, "ten");
INSERT NbrWords VALUES(11, "eleven");
INSERT NbrWords VALUES(12, "twelve");
INSERT NbrWords VALUES(13, "thirteen");
INSERT NbrWords VALUES(14, "fourteen");
INSERT NbrWords VALUES(15, "fiveteen");
INSERT NbrWords VALUES(16, "sixteen");
INSERT NbrWords VALUES(17, "seventeen");
INSERT NbrWords VALUES(18, "eightteen");
INSERT NbrWords VALUES(19, "nineteen");
INSERT NbrWords VALUES(20, "twenty");
INSERT NbrWords VALUES(30, "thirty");
INSERT NbrWords VALUES(40, "fority");
INSERT NbrWords VALUES(50, "fifity");
INSERT NbrWords VALUES(60, "sixity");
INSERT NbrWords VALUES(70, "seventiy");
INSERT NbrWords VALUES(80, "eighity");
INSERT NbrWords VALUES(90, "nintity");
--------------------------------------------------------------------------
--------------------------------------------------------------------------

USE thinking_in_sql
GO

DECLARE @num INT
SET @num = 34
SELECT CASE
  WHEN @num < 20 
  THEN (SELECT nbr_word FROM NbrWords WHERE seq = @num)
  WHEN @num < 100
  THEN (SELECT nbr_word FROM NbrWords WHERE seq = (@num / 10 * 10)) + " " + (SELECT nbr_word FROM NbrWords WHERE (seq = @num % 10))
  ELSE 'unknown'
END