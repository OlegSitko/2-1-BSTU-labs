------ ���������� �������� �������� --------

----- 1 ������� ------

use UNIVER;

go

create procedure PSUBJECT
as
begin
	declare GetStr cursor local static 
		for select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s;
	declare @countStr int = (select count(*) from SUBJECT),
			@code varchar(10) = '',
			@nameSubj varchar(100) = '',
			@namePulpit varchar(50) = '',
			@N int = 1;
	print('N' + space(3) + '���' + space(7) + '����������' + space(46) + '�������');
	open GetStr;
	fetch GetStr into @code, @nameSubj, @namePulpit;
	while(@@FETCH_STATUS = 0)
	begin
		print(cast(@N as varchar(3)) + space(4 - len(cast(@N as varchar(3)))) + trim(@code) + space(11 - len(trim(@code))) + trim(@nameSubj) + 
		space(56 - len(trim(@nameSubj))) + trim(@namePulpit));
		fetch GetStr into @code, @nameSubj, @namePulpit;
		set @N = @N + 1;
	end;
	close GetStr;
	return @countStr;
end;

declare @ret int = 0;

exec @ret = PSUBJECT;
print('���������� �����: ' + cast(@ret as varchar(3)));

drop procedure PSUBJECT;

----- 2 ������� ------

alter procedure PSUBJECT @p varchar(20) = null, @c int output
as
begin
	print('���������: @p = ' + @p + ' @c = ' + cast(@c as varchar(3)));
	declare GetStr cursor local static 
		for select s.SUBJECT, s.SUBJECT_NAME, s.PULPIT from SUBJECT s;
	declare @countStr int = (select count(*) from SUBJECT s),
			@code varchar(10) = '',
			@nameSubj varchar(100) = '',
			@namePulpit varchar(50) = '',
			@N int = 1;
	print('N' + space(3) + '���' + space(7) + '����������' + space(46) + '�������');
	open GetStr;
	fetch GetStr into @code, @nameSubj, @namePulpit;
	while(@@FETCH_STATUS = 0)
	begin
		if(@p = @namePulpit)
		begin
			print(cast(@N as varchar(3)) + space(4 - len(cast(@N as varchar(3)))) + trim(@code) + space(11 - len(trim(@code))) + trim(@nameSubj) + 
			space(56 - len(trim(@nameSubj))) + trim(@namePulpit));
			set @c = @c + 1;
			set @N = @N + 1;
		end;
		fetch GetStr into @code, @nameSubj, @namePulpit;
	end;
	close GetStr;
	return @countStr;
end;

declare @ret int = 0,
		@k int = 0,
		@p varchar(20) = '����';
exec @ret = PSUBJECT @p = '����', @c = @k output
print('���������� ��������� �����: ' + cast(@ret as varchar(3)));
print('���������� ���������� ��������� ������� ' + @p + ' : ' + cast(@k as varchar(3)));

---- 3 ������� ----

create table #SUBJECT
(
	code_S char(10) primary key,
	name_S varchar(100),
	name_P char(20)
)

alter procedure PSUBJECT @p varchar(20) = null
as
begin
	print('���������: @p = ' + @p);
	declare @count int = (select count(*) from SUBJECT),
			@count2 int = (select count(*) from SUBJECT s where s.PULPIT = @p);
	print('�� ' + cast(@count as varchar(3)) + ' ������� �������� ' + cast(@count2 as varchar(3)) + ' �������.');
	select * from SUBJECT s where s.PULPIT = @p;
end;

insert #SUBJECT exec PSUBJECT @p = '����';

select * from #SUBJECT;

---- 4 ������� ----

create procedure PAUDITORIUM_INSERT @a char(20), @n varchar(50), @c int = 0, @t char(10)
as
begin
	begin try
		insert into AUDITORIUM
					values(@a, @n, @c, @t);
		return 1;
	end try

	begin catch
		print('����� ������ : ' + cast(error_number() as varchar(6)));
		print('��������� : ' + error_message());
		print('������� : ' + cast(error_severity() as varchar(6)));
		print('����� : ' + cast(error_state() as varchar(8)));
		print('����� ������ : ' + cast(error_line() as varchar(8)));
		if(error_procedure() is not null)
		begin
			print('��� ��������� : ' + error_procedure());
		end;
		return -1;
	end catch
end;	

declare @inProc int;

exec @inProc = PAUDITORIUM_INSERT @a = '1223-1', @n = '��', @c = 40, @t = 'AUD';
print('���������� ���������� ���������: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '1443-1', @n = '�e�', @c = 99, @t = 'ttt';
print('���������� ���������� ���������: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '1-1', @n = '��-�', @c = 100, @t = 'AUD2';
print('���������� ���������� ���������: ' + cast(@inProc as varchar(3)));
exec @inProc = PAUDITORIUM_INSERT @a = '999-1', @n = '��-��', @c = 400, @t = 'AUD3';
print('���������� ���������� ���������: ' + cast(@inProc as varchar(3)));

select * from AUDITORIUM;

delete from AUDITORIUM where AUDITORIUM like '1223-1'; 
delete from AUDITORIUM where AUDITORIUM like '1-1'; 

---- 5 ������� ----

create procedure SUBJECT_REPORT @p char(10)
as
begin
	begin try
		declare subj cursor local static 
				for select s.SUBJECT from SUBJECT s where s.PULPIT = @p;
		declare @count int = (select count(*) from SUBJECT s where s.PULPIT like @p),
				@resStr varchar(300) = '',
				@locSubj varchar(50) = '',
				@locCount int = 0;
		if(@count = 0)
		begin
			raiserror('������ � ����������!', 11, 1) --- 1 - ��������� 2 - �����������(0 - 25) 3 - ��������� ������
		end;
		open subj;
		fetch subj into @locSubj;
		while(@@FETCH_STATUS = 0)
		begin
			set @resStr = concat(trim(@locSubj), ', ', @resStr);
			fetch subj into @locSubj;
			set @locCount = @locCount + 1;  
		end;
		close subj;
		print('������ ��������� ��� ������� : ' + @p);
		print(space(3) + @resStr);
		return @count;
	end try

	begin catch
		print '������ � ����������!';
		if ERROR_PROCEDURE() is not null
		begin
			print '��� ��������� : ' + error_procedure();
		end;
		return @locCount;
	end catch
end;

declare @result int = 0;

exec @result = SUBJECT_REPORT @p = '����';
print('���������� ���������: ' + cast(@result as varchar(3)));

exec @result = SUBJECT_REPORT @p = 'fail';
print('���������� ���������: ' + cast(@result as varchar(3)));

drop procedure SUBJECT_REPORT;

---- 6 ������� ----

create procedure PAUDITORIUM_INSERTX @a char(20), @n varchar(50), @c int = 0, @t char(10), @tn varchar(50)
as
begin try
	declare @rc int = 1;
	set transaction isolation level serializable
	begin tran
		insert into AUDITORIUM_TYPE
					values(@t, @tn);
		exec @rc = PAUDITORIUM_INSERT @a = @a, @n = @n, @c = @c, @t = @t
	commit tran;
	return @rc;
end try
begin catch
	print('����� ������ : ' + cast(error_number() as varchar(6)));
	print('��������� : ' + error_message());
	print('������� : ' + cast(error_severity() as varchar(6)));
	print('����� : ' + cast(error_state() as varchar(8)));
	print('����� ������ : ' + cast(error_line() as varchar(8)));
	if(error_procedure() is not null)
	begin
		print('��� ��������� : ' + error_procedure());
	end;
	if @@TRANCOUNT > 0 rollback tran;
	return -1;
end catch

declare @rc int;
exec @rc = PAUDITORIUM_INSERTX @a = '1223-1', @n = 'AUD66', @c = 40, @t = 'AUD66', @tn = 'new type';
print('���������� � ����� : ' + cast(@rc as varchar(3)));
exec @rc = PAUDITORIUM_INSERTX @a = '1223-1', @n = '��', @c = 40, @t = 'AUD662', @tn = 'new type2';
print('���������� � ����� : ' + cast(@rc as varchar(3)));

select * from AUDITORIUM;
select * from AUDITORIUM_TYPE;

delete from AUDITORIUM where AUDITORIUM like '1223-1'; 
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE like 'AUD66'; 
delete from AUDITORIUM_TYPE where AUDITORIUM_TYPE like 'AUD662'; 


-- ������� �8*
DROP PROCEDURE PRINT_REPORT;
GO

CREATE PROCEDURE PRINT_REPORT
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
			f.FACULTY AS '���������',
			p.PULPIT AS '�������',
			(
				SELECT COUNT(*) 
				FROM TEACHER t 
				WHERE t.PULPIT = p.PULPIT
			) AS '���������� ��������������',
			(
				SELECT STRING_AGG(LTRIM(RTRIM(s.SUBJECT)), ', ') 
				FROM SUBJECT s 
				WHERE s.PULPIT = p.PULPIT
			) AS '��������'
		FROM
			FACULTY f
			INNER JOIN PULPIT p ON p.FACULTY = f.FACULTY
		WHERE
			(f.FACULTY LIKE @f OR @f IS NULL)
			AND (p.PULPIT LIKE @p OR @p IS NULL)
		GROUP BY
			f.FACULTY,
			p.PULPIT
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
		PRINT '		����������: ' + ISNULL(@Subjects, '���') + '.';
		FETCH ReportCursor INTO @Faculty, @Pulpit, @TeacherCount, @Subjects;
	END
	RETURN @PulpitCount;
END;
GO

DECLARE @Ret int;
EXEC @Ret = PRINT_REPORT @f='��', @p='����';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORT @f='���';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORT @p='��';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
EXEC @Ret = PRINT_REPORT @p='��';
PRINT '���������� ������ � ������: ' + cast(@Ret AS varchar(5));
GO
