use UNIVER;
go

--1�� ������� 
drop view �������������
go
CREATE VIEW �������������
as 
select 
TEACHER [���],
GENDER [���],
TEACHER_NAME[���],
PULPIT[�������]
from TEACHER ;


go

--2�� �������
drop view ����������_������
go
create view ����������_������ (���������, ����������_������)
as 
select FACULTY.FACULTY_NAME [���������] , count(*) [�������]
from FACULTY 
inner join PULPIT on FACULTY.FACULTY = PULPIT.FACULTY
group by FACULTY.FACULTY_NAME;

go
--3�� �������
drop view [���������]
go
create view [���������]
as 
select AUDITORIUM [	��� ],
AUDITORIUM_TYPE [������������ ���������]
from AUDITORIUM
go

insert [���������] values('200-3a', '��-�');
GO

delete [���������] where [	��� ] = '200-3a';
go

select * from [���������];
go

select * from AUDITORIUM;
go
 
--4�� ������� 
drop view ����������_���������
go
Create View ����������_��������� ( ���, ������������_���������)
as
select AUDITORIUM_TYPE, AUDITORIUM
from AUDITORIUM
where AUDITORIUM_TYPE like  '��%'
go
select * from AUDITORIUM
where AUDITORIUM_TYPE like  '��%'
go

--5�� �������
drop view ����������
go
create view ���������� (���, ������������_����������, ���_�������)
as
select top(150) [SUBJECT], [SUBJECT_NAME], [PULPIT]
from SUBJECT
order by SUBJECT_NAME
go
select * from SUBJECT
go

--6�� �������

alter view  dbo.����������_������
with SCHEMABINDING
as
select 
    f.FACULTY_NAME [���������],
    count(*) [���-�� ������]
FROM 
    dbo.FACULTY f
join
    dbo.PULPIT p on f.FACULTY = p.FACULTY
group by 
    f.FACULTY_NAME;
