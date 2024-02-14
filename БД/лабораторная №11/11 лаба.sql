use UNIVER;
go
--1 список дисциплин на кафедре ИСиТ. В отчет должны быть выведены
--краткие названия дисциплин из таблицы SUBJECT в одну строку через запятую. 
declare @LS char(200), @z char(1000) = ' ';
declare ListSubj cursor for select SUBJECT_NAME from SUBJECT
open ListSubj 
fetch ListSubj into @LS
print 'Список Дисциплин';
while @@FETCH_STATUS = 0
begin 
set @z = RTRIM(@LS) + ',
' + @z;
fetch ListSubj into @LS
end
print @z;
close ListSubj

--2 сценарий, демонстрирующий отличие глобального курсора от локального на примере базы данных UNIVER
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
 -- локал работает в рамках одного пакета

 -- глобал во всех пакетах может быть объявлен и он будет работать
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
--отличие статических курсоров от динамических

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
print  'Список Дисциплин: ' + cast(@@CURSOR_ROWS as varchar(5));
begin
update SUBJECT 
set SUBJECT_NAME = 'ыыыыыыыыыыыыыыыыыыыыыыы'
where SUBJECT = 'ВТЛ';
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
print  'Список Дисциплин: ' + cast(@@CURSOR_ROWS as varchar(5));
begin
update SUBJECT 
set SUBJECT_NAME = 'ыыыыыыыыыыыыыыыыыыыыыыы'
where SUBJECT = 'ВТЛ';
end;
close ListSubj1

--4
--сценарий, демонстрирующий свойства навигации в результирующем наборе курсора с атрибутом SCROLL 
DECLARE  @tc int, @rn char(50);  
DECLARE Primer1 cursor local dynamic SCROLL for SELECT row_number() over (order by SUBJECT) N,
SUBJECT_NAME  FROM SUBJECT 
where PULPIT = 'ИСиТ' 
OPEN Primer1;
FETCH  Primer1 into  @tc, @rn;                 
print '1 строка: ' + cast(@tc as varchar(3))+ ' '+ rtrim(@rn);      
fetch NEXT from Primer1 into @tc, @rn; 
print 'следующая строка: ' + cast(@tc as varchar(3))+ ' '+rtrim(@rn);
FETCH  LAST from  Primer1 into @tc, @rn;       
print 'последняя строка: ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn);
FETCH  ABSOLUTE 5 from  Primer1 into @tc, @rn;       
print '5 строка: ' +  cast(@tc as varchar(3))+' '+ rtrim(@rn);
CLOSE Primer1;

--5 
--курсор, демонстрирующий применение конструкции CURRENT OF в секции WHERE
--с использованием операторов UPDATE и DELETE.
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
--из таблицы PROGRESS удаляются строки, содержащие информацию о студентах, получивших оценки ниже 4 (использовать объединение таблиц PROGRESS, STUDENT, GROUPS). 
insert into PROGRESS(SUBJECT, IDSTUDENT, PDATE, NOTE)
values 
('ОАиП', 1005, '2023-12-29', 3),
('ОАиП', 1010, '2023-12-20', 3),
('СУБД', 1020, '2023-12-22', 1),
('ОАиП', 1013, '2023-12-12', 3),
('ОАиП', 1007, '2023-12-21', 2)

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

--в таблице PROGRESS для студента с конкретным номером IDSTUDENT корректируется оценка (увеличивает-ся на единицу).
insert into PROGRESS 
values 
('ОАиП', 1005, '2023-12-29', 6)

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

--8 отчёт на рисунке
declare ReportCursor cursor local static for
	select FACULTY.FACULTY as 'Факультет', PULPIT.PULPIT as 'Кафедра',
(select COUNT(*) from TEACHER where TEACHER.PULPIT = PULPIT.PULPIT) as 'Количество преподавателей',
(select STRING_AGG(LTRIM(RTRIM(SUBJECT.SUBJECT)), ', ') from SUBJECT where SUBJECT.PULPIT = PULPIT.PULPIT) AS 'Предметы'
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
		print 'Факультет: ' + @Faculty;
		set @PrevFaculty = @Faculty;
	end
	print '	Кафедра: ' + @Pulpit;
	print '	Количество преподавателей: ' + cast(@TeacherCount as nvarchar(5));
	print '	Дисциплины: ' + ISNULL(@Subjects, 'нет') + '.';
	fetch ReportCursor into @Faculty, @Pulpit, @TeacherCount, @Subjects;
end
go