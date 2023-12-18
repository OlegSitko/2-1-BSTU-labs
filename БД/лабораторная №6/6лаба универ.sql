use UNIVER;
go
--������� 1
select 
    AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  [������������ ���� ���������],
    MAX(AUDITORIUM.AUDITORIUM_CAPACITY)  [������������ �����������],
    MIN(AUDITORIUM.AUDITORIUM_CAPACITY)  [����������� �����������],
    AVG(AUDITORIUM.AUDITORIUM_CAPACITY)  [������� �����������],
    SUM(AUDITORIUM.AUDITORIUM_CAPACITY)  [��������� �����������],
	count(*) [���������� ���������]
from AUDITORIUM INNER JOIN AUDITORIUM_TYPE
    on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME;

--������� 3

select *
from (
	select
		case
			when NOTE < 4 then '�� 4'
			when NOTE between 4 and 6 then '�� 4 �� 6'
			when NOTE between 7 and 8 then '�� 7 �� 8'
			when NOTE between 9 and 10 then '�� 9 �� 10'
			else '???'
		end  '�������',
		count(*) AS '����������',
		string_agg(NOTE, ', ')  '��� ������'
	from PROGRESS
	group by 
		case
			when NOTE < 4 THEN '�� 4'
			when NOTE between 4 and 6 then '�� 4 �� 6'
			when NOTE between 7 and 8 then '�� 7 �� 8'
			when NOTE between 9 and 10 then '�� 9 �� 10'
			else '???'
		end
) AS T
order by
	case [�������]
		when '�� 4' then 4
		when '�� 4 �� 6' then 3
		when '�� 7 �� 8' then 2
		when '�� 9 �� 10' then 1
		else 0
	end
;

--������ 4

select FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST, PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as ' ��������'
	from FACULTY 
	inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
	inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
group by 
	GROUPS.YEAR_FIRST,
	FACULTY.FACULTY_NAME,
	PROFESSION.PROFESSION_NAME,
	PROGRESS.SUBJECT
order by ' ��������' desc

--������� 5

select FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST, PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as ' ��������'
	from FACULTY 
	inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
	inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	where PROGRESS.SUBJECT in ('��', '����')
group by 
	GROUPS.YEAR_FIRST,
	FACULTY.FACULTY_NAME,
	PROFESSION.PROFESSION_NAME,
	PROGRESS.SUBJECT
order by ' ��������' desc;

--������� 6

select 
	 PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as  �������_������
from 
	FACULTY
	inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
	inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where 
	FACULTY.FACULTY = '���'
group by
	PROFESSION.PROFESSION_NAME,
	PROGRESS.SUBJECT
order by  �������_������ desc
;

--������� 7

select count(*) '���-�� ���������', PROGRESS.NOTE
from 
	PROGRESS
where 
	PROGRESS.NOTE in (9,8)
group by 
	PROGRESS.NOTE
having 
	count(*) > 0
order by PROGRESS.NOTE desc;
