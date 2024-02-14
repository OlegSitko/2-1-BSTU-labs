use UNIVER;
go
--1 ������ ��������� �� ������� ����. � ����� ������ ���� ��������
--������� �������� ��������� �� ������� SUBJECT � ���� ������ ����� �������. 
declare @LS char(200), @z char(1000) = ' ';
declare ListSubj cursor for select SUBJECT_NAME from SUBJECT
open ListSubj 
fetch ListSubj into @LS
print '������ ���������';
while @@FETCH_STATUS = 0
begin 
set @z = RTRIM(@LS) + ',
' + @z;
fetch ListSubj into @LS
end
print @z;
close ListSubj

--2 ��������, ��������������� ������� ����������� ������� �� ���������� �� ������� ���� ������ UNIVER
DECLARE @tv char(200);
DECLARE Capacity CURSOR LOCAL for SELECT AUDITORIUM_CAPACITY from AUDITORIUM ;
    
OPEN Capacity;	  
fetch  Capacity into @tv; 	
print '1. '+@tv;   
go
DECLARE @tv char(200), @cena real;     	
fetch  Capacity into @tv; 	
print '2. '+@tv;  
go   
 -- ����� �������� � ������ ������ ������

 -- ������ �� ���� ������� ����� ���� �������� � �� ����� ��������
 DECLARE @tv char(200);
DECLARE Capacity CURSOR Global for SELECT AUDITORIUM_CAPACITY from AUDITORIUM ;
OPEN Capacity;	  
fetch  Capacity into @tv; 	
print '1. '+@tv;   
go
DECLARE @tv char(200), @cena real;     	
fetch  Capacity into @tv; 	
print '2. '+@tv;  
go  

--3
--������� ����������� �������� �� ������������

declare @LS char(300), @z char(1000) = ' ';
declare ListSubj1 cursor local static for select SUBJECT_NAME from SUBJECT
open ListSubj1
fetch ListSubj1 into @LS
while @@FETCH_STATUS = 0
begin 
set @z = RTRIM(@LS) + ',
' + @z;
fetch ListSubj1 into @LS
end
print @z;
print  '������ ���������: ' + cast(@@CURSOR_ROWS as varchar(5));
begin
update SUBJECT 
set SUBJECT_NAME = '�����������������������'
where SUBJECT = '���';
end;
close ListSubj1

--
declare @LS char(300), @z char(1000) = ' ';
declare ListSubj1 cursor local static for select SUBJECT_NAME from SUBJECT
open ListSubj1
fetch ListSubj1 into @LS
while @@FETCH_STATUS = 0
begin 
set @z = RTRIM(@LS) + ',
' + @z;
fetch ListSubj1 into @LS
end
print @z;
print  '������ ���������: ' + cast(@@CURSOR_ROWS as varchar(5));
begin
update SUBJECT 
set SUBJECT_NAME = '�����������������������'
where SUBJECT = '���';
end;
close ListSubj1

--4
--��������, ��������������� �������� ��������� � �������������� ������ ������� � ��������� SCROLL 
DECLARE  @tc int, @rn char(50);  
DECLARE Primer1 cursor local dynamic SCROLL for SELECT row_number() over (order by SUBJECT) N,
SUBJECT_NAME  FROM SUBJECT 
where PULPIT = '����' 
OPEN Primer1;
FETCH  Primer1 into  @tc, @rn;                 
print '1 ������: ' + cast(@tc as varchar(3))+ ' '+ rtrim(@rn);      
fetch NEXT from Primer1 into @tc, @rn; 
print '��������� ������: ' + cast(@tc as varchar(3))+ ' '+rtrim(@rn);
FETCH  LAST from  Primer1 into @tc, @rn;       
print '��������� ������: ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn);
FETCH  ABSOLUTE 5 from  Primer1 into @tc, @rn;       
print '5 ������: ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn);
CLOSE Primer1;

--5 
--������, ��������������� ���������� ����������� CURRENT OF � ������ WHERE
--� �������������� ���������� UPDATE � DELETE.
declare @N int, @S char(200), @PD varchar(100); 
declare Kursor cursor local dynamic
for select NOTE, PDATE, SUBJECT from PROGRESS for update;
open Kursor
fetch Kursor into @N, @PD, @S;
while @@FETCH_STATUS = 0
begin
delete PROGRESS where CURRENT OF Kursor;
fetch Kursor into @N, @PD, @S;

update PROGRESS set NOTE = NOTE + 1 where CURRENT OF Kursor;
fetch Kursor into @N, @PD, @S;
end
select @N, @PD, @S;
close Kursor;

--6 
--�� ������� PROGRESS ��������� ������, ���������� ���������� � ���������, ���������� ������ ���� 4 (������������ ����������� ������ PROGRESS, STUDENT, GROUPS). 
insert into PROGRESS(SUBJECT, IDSTUDENT, PDATE, NOTE)
values 
('����', 1005, '2023-12-29', 3),
('����', 1010, '2023-12-20', 3),
('����', 1020, '2023-12-22', 1),
('����', 1013, '2023-12-12', 3),
('����', 1007, '2023-12-21', 2)

declare ProgressCursor cursor local dynamic for 

select STUDENT.NAME, PROGRESS.NOTE, GROUPS.IDGROUP
from PROGRESS
inner join STUDENT on  STUDENT.IDSTUDENT = PROGRESS.IDSTUDENT
inner join GROUPS on GROUPS.IDGROUP = STUDENT.IDGROUP
where PROGRESS.NOTE < 5 
for update;

declare @Student nvarchar(200), @Note int, @Group int
select * from PROGRESS


open ProgressCursor
fetch ProgressCursor into @Student, @Note, @Group
while @@FETCH_STATUS = 0
begin 
	delete from PROGRESS where current of ProgressCursor;
	fetch ProgressCursor into @Student, @Note, @Group;
end

select * from PROGRESS
go

--� ������� PROGRESS ��� �������� � ���������� ������� IDSTUDENT �������������� ������ (�����������-�� �� �������).
insert into PROGRESS 
values 
('����', 1005, '2023-12-29', 6)

declare ProgressCursor cursor local dynamic for 
select PROGRESS.IDSTUDENT, PROGRESS.NOTE from PROGRESS
where PROGRESS.IDSTUDENT = 1005
for update;
select * from PROGRESS

declare @id int, @Note int
open ProgressCursor 
fetch ProgressCursor into @id, @Note
while @@FETCH_STATUS = 0
begin
update  PROGRESS  set NOTE = NOTE + 1 where Current of  ProgressCursor
fetch ProgressCursor into @id, @Note
end
select * from PROGRESS

delete PROGRESS where IDSTUDENT = 1005

--8 ����� �� �������
declare ReportCursor cursor local static for
	select FACULTY.FACULTY as '���������', PULPIT.PULPIT as '�������',
(select COUNT(*) from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT) as '���������� ��������������',
(select STRING_AGG(LTRIM(RTRIM(SUBJECT.SUBJECT)), ', ') from SUBJECT where SUBJECT.PULPIT = PULPIT.PULPIT) AS '��������'
from
FACULTY 
inner join PULPIT on PULPIT.FACULTY = FACULTY.FACULTY
group by FACULTY.FACULTY, PULPIT.PULPIT;

declare
	@PrevFaculty nvarchar(7) = '',
	@Faculty nvarchar(7),
	@Pulpit nvarchar(7),
	@TeacherCount int,
	@Subjects nvarchar(150);
open ReportCursor;

fetch ReportCursor into @Faculty, @Pulpit, @TeacherCount, @Subjects;
while @@FETCH_STATUS = 0
begin
	if @Faculty <> @PrevFaculty
	begin
		print '���������: ' + @Faculty;
		set @PrevFaculty = @Faculty;
	end
	print '	�������: ' + @Pulpit;
	print '	���������� ��������������: ' + cast(@TeacherCount as nvarchar(5));
	print '	����������: ' + ISNULL(@Subjects, '���') + '.';
	fetch ReportCursor into @Faculty, @Pulpit, @TeacherCount, @Subjects;
end
go