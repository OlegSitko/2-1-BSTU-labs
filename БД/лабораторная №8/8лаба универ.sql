use UNIVER;
go

--1ое задание 
drop view Преподаватель
go
CREATE VIEW Преподаватель
as 
select 
TEACHER [код],
GENDER [пол],
TEACHER_NAME[имя],
PULPIT[кафедра]
from TEACHER ;


go

--2ое задание
drop view Количество_кафедр
go
create view Количество_кафедр (факультет, количество_кафедр)
as 
select FACULTY.FACULTY_NAME [факультет] , count(*) [кафедра]
from FACULTY 
inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

go
--3ее задание
drop view [Аудитории]
go
create view [Аудитории]
as 
select AUDITORIUM [	код ],
AUDITORIUM_TYPE [наименование аудитории]
from AUDITORIUM
go

insert [Аудитории] values('200-3a', 'ЛК-К');
GO

delete [Аудитории] where [	код ] = '200-3a';
go

select * from [Аудитории];
go

select * from AUDITORIUM;
go
 
--4ое задание 
drop view Лекционные_аудитории
go
Create View Лекционные_аудитории ( код, наименование_аудитории)
as
select AUDITORIUM_TYPE, AUDITORIUM
from AUDITORIUM
where AUDITORIUM_TYPE like  'ЛК%'
go
select * from AUDITORIUM
where AUDITORIUM_TYPE like  'ЛК%'
go

--5ое заадние
drop view Дисциплины
go
create view Дисциплины (код, наименование_дисциплины, код_кафедры)
as
select top(150) [SUBJECT], [SUBJECT_NAME], [PULPIT]
from SUBJECT
order by SUBJECT_NAME
go
select * from SUBJECT
go

--6ое заадние

alter view  dbo.Количество_кафедр
with SCHEMABINDING
as
select 
    f.FACULTY_NAME [факультет],
    count(*) [кол-во кафедр]
FROM 
    dbo.FACULTY f
join
    dbo.PULPIT p on f.FACULTY = p.FACULTY
group by 
    f.FACULTY_NAME;
