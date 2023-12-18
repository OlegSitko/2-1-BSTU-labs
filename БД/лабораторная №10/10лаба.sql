--1

use UNIVER;
go
exec SP_HELPINDEX '[dbo].[AUDITORIUM]' 
exec SP_HELPINDEX '[dbo].[AUDITORIUM_TYPE]'
exec SP_HELPINDEX '[dbo].[FACULTY]'
exec SP_HELPINDEX '[dbo].[GROUPS]'
exec SP_HELPINDEX '[dbo].[PROFESSION]'
exec SP_HELPINDEX '[dbo].[PROGRESS]'
exec SP_HELPINDEX '[dbo].[PULPIT]'
exec SP_HELPINDEX '[dbo].[STUDENT]'
exec SP_HELPINDEX '[dbo].[SUBJECT]'
exec SP_HELPINDEX '[dbo].[TEACHER]'
exec SP_HELPINDEX '[dbo].[TIMETABLE]'
go

-- 
DROP TABLE #TempTable1;
GO

CREATE TABLE #TempTable1 (
	ID int,
	SomeData int
);
GO

DECLARE @Counter int = 0;
WHILE (@Counter < 100000)
BEGIN
	INSERT INTO #TempTable1(ID, SomeData)
	VALUES(@Counter, FLOOR(10000 * RAND()));
	SET @Counter = @Counter + 1;
END
GO

checkpoint;
DBCC DROPCLEANBUFFERS;
CREATE CLUSTERED INDEX #TempTable1_CL ON #TempTable1(SomeData asc);
GO

DROP INDEX #TempTable1_CL ON #TempTable1;
GO

SELECT * FROM #TempTable1 WHERE SomeData BETWEEN 2500 AND 5000;
GO


