---- ���������� � ������������� ������� ----

---- 1-1 ������� -----

use UNIVER;

go

create function COUNT_STUDENTS(@faculty varchar(20)) returns int
as
begin
	declare @count int = (select count(*)
		from FACULTY f inner join GROUPS g
			on f.FACULTY = g.FACULTY
		inner join STUDENT s
			on g.IDGROUP = s.IDGROUP
		where f.FACULTY like @faculty);
	return @count;
end;

declare @resultFunc int = dbo.COUNT_STUDENTS('��');
print('���������� ��������� �� ���������� �� : ' + cast(@resultFunc as varchar(3)));

drop function COUNT_STUDENTS;

---- 1-2 ������� -----

alter function COUNT_STUDENTS(@faculty varchar(20) = null, @prof varchar(20) = null) returns int
as
begin
	declare @count int = (select count(*)
		from FACULTY f 
		inner join GROUPS g
			on f.FACULTY = g.FACULTY
		inner join STUDENT s
			on g.IDGROUP = s.IDGROUP
		where f.FACULTY like @faculty and g.PROFESSION = isnull(@prof, g.PROFESSION));
	return @count;
end;


select f.FACULTY, p.PROFESSION, dbo.COUNT_STUDENTS(f.faculty, p.PROFESSION)[����������]
	from FACULTY f inner join PROFESSION p
		on f.FACULTY = p.FACULTY
			
declare @resultFunc int = dbo.COUNT_STUDENTS('��', '1-40 01 02');
print('���������� ��������� �� ���������� �� ������������� 1-40 01 02 : ' + cast(@resultFunc as varchar(3)));

---- 2 ������� ----

create function FSUBJECT(@p varchar(20)) returns varchar(300)
as
begin
	declare getStr cursor local static
		for select s.SUBJECT
				from SUBJECT s
					where s.PULPIT like @p
	declare @retStr varchar(300) = '',
			@locStr varchar(20) = '';
	open getStr;
	fetch getStr into @locStr;
	while @@FETCH_STATUS = 0
	begin
		set @retStr = concat(trim(@locStr), ' ,', @retStr);
		fetch getStr into @locStr;
	end;
	return @retStr;
end;

select PULPIT, dbo.FSUBJECT(PULPIT) from PULPIT

drop function FSUBJECT;

---- 3 ������� ----

create function FFACPUL(@faculty varchar(20), @pulpit varchar(20)) returns table
as return 
(select f.FACULTY, p.PULPIT
					from FACULTY f left outer join PULPIT p
						on p.FACULTY = f.FACULTY
							where p.PULPIT like isnull(@pulpit, p.PULPIT)
									and f.FACULTY like isnull(@faculty, f.FACULTY));


select * from dbo.FFACPUL(NULL, NULL);
select * from dbo.FFACPUL('��', NULL);
select * from dbo.FFACPUL(NULL, '����');
select * from dbo.FFACPUL('���', '��');
select * from dbo.FFACPUL('���', '����');

drop function FFACPUL;

---- 4 ������� ----

create function FCTEACHER(@pulpit varchar(20)) returns int
as
begin
	declare @count int = (select count(*) 
							from PULPIT p inner join TEACHER t
								on t.PULPIT = p.PULPIT
							where p.PULPIT = isnull(@pulpit, p.PULPIT));
	return @count;
end;

select PULPIT[�������], dbo.FCTEACHER(PULPIT)[���������� ��������������] from PULPIT;
select dbo.FCTEACHER(NULL) [���������� ��������������]

drop function FCTEACHER;

----- 6 ������� -----

create function FACULTY_REPORT(@c int) returns @fr table
	                        ( [���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                                                                 [���������� ���������] int, [���������� ��������������] int )
	as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                                                    where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  (select count(PULPIT) from PULPIT where FACULTY = @f),
	            (select count(IDGROUP) from GROUPS where FACULTY = @f),   dbo.COUNT_STUDENTS(@f, default),
	            (select count(PROFESSION) from PROFESSION where FACULTY = @f)   ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;

create function COUNT_PULPIT(@f varchar(30)) returns int
as
begin
	declare @count int = (select count(*) from PULPIT p where p.FACULTY = @f);
	return @count;
end;

create function COUNT_GROUP(@f varchar(30)) returns int
as
begin
	declare @count int = (select count(*) from GROUPS g where g.FACULTY = @f);
	return @count;
end;

create function COUNT_STUDENT(@f varchar(30)) returns int
as
begin
	declare @count int = (select count(*) from STUDENT s inner join GROUPS g
											on s.IDGROUP = g.IDGROUP where g.FACULTY = @f);
	return @count;
end;

create function COUNT_PROFFESION(@f varchar(30)) returns int
as
begin
	declare @count int = (select count(*) from PROFESSION p where p.FACULTY = @f);
	return @count;
end;

alter function FACULTY_REPORT(@c int) returns @fr table
	                        ( [���������] varchar(50), [���������� ������] int, [���������� �����]  int, 
	                                                                 [���������� ���������] int, [���������� ��������������] int )
	as begin 
                 declare cc CURSOR static for 
	       select FACULTY from FACULTY 
                                                    where dbo.COUNT_STUDENTS(FACULTY, default) > @c; 
	       declare @f varchar(30);
	       open cc;  
                 fetch cc into @f;
	       while @@fetch_status = 0
	       begin
	            insert @fr values( @f,  dbo.COUNT_PULPIT(@f),
	            dbo.COUNT_GROUP(@f),   dbo.COUNT_STUDENT(@f),
	            dbo.COUNT_PROFFESION(@f)   ); 
	            fetch cc into @f;  
	       end;   
                 return; 
	end;

select * 
	from dbo.FACULTY_REPORT(10);

drop function FACULTY_REPORT;




-- ������� �7*
DROP PROCEDURE PRINT_REPORTX;
GO

CREATE PROCEDURE PRINT_REPORTX
	@f char(10) = NULL,
	@p char(10) = NULL
AS BEGIN
	IF (@f IS NULL) AND (@p IS NOT NULL) BEGIN
		SET @f = (SELECT FACULTY FROM PULPIT WHERE PULPIT = @p);
		IF (@f IS NULL) OR (LEN(@f) < 1) BEGIN
			;THROW 51000, '������ � ����������', 1;
			RETURN -1;
		END
	END
	DECLARE ReportCursor CURSOR LOCAL STATIC FOR
		SELECT
			FACULTY AS '���������',
			PULPIT AS '�������',
			dbo.FCTEACHER(PULPIT) AS '���������� ��������������',
			dbo.FSUBJECTS(PULPIT) AS '��������'
		FROM
			dbo.FFACPUL(@f, @p)
		GROUP BY
			FACULTY,
			PULPIT
	;
	DECLARE
		@PrevFaculty nvarchar(7) = '',
		@Faculty nvarchar(7),
		@Pulpit nvarchar(7),
		@TeacherCount int,
		@Subjects nvarchar(150),
		@PulpitCount int = 0
	;
	OPEN ReportCursor;
	FETCH ReportCursor INTO @Faculty, @Pulpit, @TeacherCount, @Subjects;
	WHILE @@FETCH_STATUS = 0
	BEGIN
		IF @Faculty <> @PrevFaculty
		BEGIN
			PRINT '���������: ' + @Faculty;
			SET @PrevFaculty = @Faculty;
		END
		SET @PulpitCount = @PulpitCount + 1;
		PRINT '	�������: ' + @Pulpit;
		PRINT '		���������� ��������������: ' + cast(@TeacherCount as nvarchar(5));
		PRINT '		����������: ' + COALESCE(NULLIF(@Subjects, ''), '���') + '.';
		FETCH ReportCursor INTO @Faculty, @Pulpit, @TeacherCount, @Subjects;
	END
	RETURN @PulpitCount;
END;
GO

DECLARE @Ret int;
EXEC @Ret = PRINT_REPORTX @f='��', @p='����';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORTX @f='���';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORTX @p='��';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORTX @p='��';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
GO

