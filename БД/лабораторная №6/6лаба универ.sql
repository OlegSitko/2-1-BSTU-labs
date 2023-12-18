use UNIVER;
go
--задание 1
select 
    AUDITORIUM_TYPE.AUDITORIUM_TYPENAME  [Наименование типа аудитории],
    MAX(AUDITORIUM.AUDITORIUM_CAPACITY)  [Максимальная вместимость],
    MIN(AUDITORIUM.AUDITORIUM_CAPACITY)  [Минимальная вместимость],
    AVG(AUDITORIUM.AUDITORIUM_CAPACITY)  [Средняя вместимость],
    SUM(AUDITORIUM.AUDITORIUM_CAPACITY)  [Суммарная вместимость],
	count(*) [Количество аудиторий]
from AUDITORIUM INNER JOIN AUDITORIUM_TYPE
    on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE
group by AUDITORIUM_TYPE.AUDITORIUM_TYPENAME;

--задание 3

select *
from (
	select
		case
			when NOTE < 4 then 'до 4'
			when NOTE between 4 and 6 then 'от 4 до 6'
			when NOTE between 7 and 8 then 'от 7 до 8'
			when NOTE between 9 and 10 then 'от 9 до 10'
			else '???'
		end  'пределы',
		count(*) AS 'количество',
		string_agg(NOTE, ', ')  'все оценки'
	from PROGRESS
	group by 
		case
			when NOTE < 4 THEN 'до 4'
			when NOTE between 4 and 6 then 'от 4 до 6'
			when NOTE between 7 and 8 then 'от 7 до 8'
			when NOTE between 9 and 10 then 'от 9 до 10'
			else '???'
		end
) AS T
order by
	case [пределы]
		when 'до 4' then 4
		when 'от 4 до 6' then 3
		when 'от 7 до 8' then 2
		when 'от 9 до 10' then 1
		else 0
	end
;

--задние 4

select FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST, PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as ' убывание'
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
order by ' убывание' desc

--задание 5

select FACULTY.FACULTY_NAME, GROUPS.YEAR_FIRST, PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as ' убывание'
	from FACULTY 
	inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
	inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
	where PROGRESS.SUBJECT in ('БД', 'ОАиП')
group by 
	GROUPS.YEAR_FIRST,
	FACULTY.FACULTY_NAME,
	PROFESSION.PROFESSION_NAME,
	PROGRESS.SUBJECT
order by ' убывание' desc;

--зааднме 6

select 
	 PROFESSION.PROFESSION_NAME, PROGRESS.SUBJECT,
	round(avg(cast(PROGRESS.NOTE as float(4))),2) as  Средняя_оценка
from 
	FACULTY
	inner join GROUPS on GROUPS.FACULTY = FACULTY.FACULTY
	inner join PROFESSION on PROFESSION.PROFESSION = GROUPS.PROFESSION
	inner join STUDENT on STUDENT.IDGROUP = GROUPS.IDGROUP
	inner join PROGRESS on PROGRESS.IDSTUDENT = STUDENT.IDSTUDENT
where 
	FACULTY.FACULTY = 'ТОВ'
group by
	PROFESSION.PROFESSION_NAME,
	PROGRESS.SUBJECT
order by  Средняя_оценка desc
;

--заадние 7

select count(*) 'кол-во студентов', PROGRESS.NOTE
from 
	PROGRESS
where 
	PROGRESS.NOTE in (9,8)
group by 
	PROGRESS.NOTE
having 
	count(*) > 0
order by PROGRESS.NOTE desc;
