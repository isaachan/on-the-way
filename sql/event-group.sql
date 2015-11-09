IF DB_ID('thinking_in_sql') IS NULL
CREATE DATABASE thinking_in_sql
GO

USE thinking_in_sql

IF OBJECT_ID('Events') IS NOT NULL
    DROP TABLE Events
GO

CREATE TABLE Events (
    event_time INT NOT NULL PRIMARY KEY
)

INSERT INTO Events VALUES
    (500), (505), (510), (535),
    (910), (939), (944), (977)
GO

BEGIN

DECLARE @interval INT
SET @interval = 30

DECLARE @result_table TABLE (
    start_time INT NOT NULL,
    end_time INT NOT NULL,
    grp_id INTEGER IDENTITY(1,1) NOT NULL PRIMARY KEY CLUSTERED
)

INSERT INTO @result_table (start_time, end_time)
    SELECT MIN(start_time) AS start_time, end_time
    FROM (
      SELECT CASE
                  WHEN D.start_time IN
                            (SELECT DISTINCT
                               (SELECT TOP 1 event_time
                                FROM Events
                                WHERE event_time >= B.event_time
                                AND event_time < B.event_time + @interval
                                ORDER BY event_time DESC)
                         AS end_time
                             FROM Events AS B)
                  THEN D.end_time
                  ELSE D.start_time
             END AS start_time,
         end_time
      FROM (
        SELECT A.event_time AS start_time,
              (SELECT TOP 1 event_time
               FROM Events
               WHERE event_time >= A.event_time
               AND event_time < A.event_time + @interval
               ORDER BY event_time DESC) AS end_time
        FROM Events AS A) AS D) AS E
    GROUP BY end_time;

SELECT event_time, grp_id
FROM Events INNER JOIN @result_table ON event_time BETWEEN start_time AND end_time

END
