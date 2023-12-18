--1
declare @a char = 'q', @b varchar(9) = 'ФИТР_БНТУ',
@с datetime = '2222-02-22T20:02:22', @t time = '20:02:22', 
@i int = 1, @s smallint = 222, @ty tinyint = 22, @n numeric(12, 5) 
select @a 
set @a = 'w'
print @t

--2 . 
-- Разработать скрипт, в котором определяется общая вместимость аудито-рий.
-- Если общая вместимость превышает 200, то вывести количество аудиторий, среднюю вместимость аудиторий, ко-личество аудиторий, вместимость которых меньше средней, и процент таких аудиторий. 
-- Если общая вместимость аудиторий меньше 200, то вывести сообщение о размере общей вместимости.

use UNIVER;
go
declare 
@allCapacity int = (select sum(AUDITORIUM_CAPACITY)  from AUDITORIUM ), -- общая вместимость аудиторий
-- общая вместимость > 200
@countCapacity int, -- количество аудиторий
@avgCapacity int, -- средняя вместимость аудиторий
@CapacityMensheAvg int, -- количество аудиторий, вместимость которых меньше средней
@ProcentCapacity int -- процент таких аудиторий
print @allCapacity

if @allCapacity > 200 
begin
set @countCapacity = (select count(*) from AUDITORIUM );
set @avgCapacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
set @CapacityMensheAvg = (select count(*) from AUDITORIUM where @countCapacity < @avgCapacity);
set @ProcentCapacity = (@CapacityMensheAvg * 100 / @countCapacity);
select 
@allCapacity [общая вместимость],
@countCapacity [количество аудиторий],
@avgCapacity [средняя вместимость аудиторий],
@CapacityMensheAvg [количество аудиторий, вместимость которых меньше средней],
@ProcentCapacity [процент аудиторий в которых вместимость < 200]
end
else print 'общая вместимолсть меньше 200'

--3

print 'число обработанных строк' + cast(@@ROWCOUNT as varchar) 
print 'версия SQL Server' + cast(@@VERSION as varchar)
print 'возвращает системный идентифика-тор процесса, назначенный серве-ром текущему подключению' + cast (@@SPID as varchar) 
print 'код последней ошибки' + cast(@@ERROR as varchar)  
print 'имя сервера' + cast (@@SERVERNAME as varchar)
print 'возвращает уровень вложенности транзакции' + cast (@@TRANCOUNT as varchar) 
print 'проверка результата считывания строк результирующего набора' + cast(@@FETCH_STATUS as varchar) 
print 'уровень вложенности текущей про-цедуры' + cast(@@NESTLEVEL as varchar) 

--4

declare 
@z float,
@t int = 21,
@x int = 5

if @t > @x 
set @z = Power(sin(@t), 2)
else if @t < @x
set @z = 4 * (@t+@x)
else  
set @z = 1 - exp(@x-2)
 
select @z
--
declare 
@fullName nvarchar(100),
@surName nvarchar(10) = 'Авдей',
@Name nvarchar(10) = 'Алексей',
@Father nvarchar(10) = 'Юрьевич'

set @fullName = @surName + ' ' + @Name + ' ' + @Father
print @fullName
--select @fullName

set @fullName  = @surName + ' ' + SUBSTRING(@Name, 1,1) + '.' + SUBSTRING(@Father, 1,1) + '.'
print @fullName

--

select STUDENT.NAME,STUDENT.BDAY,(datediff(YY,STUDENT.BDAY,sysdatetime())) as 'Возраст'
	from STUDENT
	where MONTH(STUDENT.BDAY)=month(sysdatetime());

--

declare @grNum int=2;
select distinct PROGRESS.PDATE[день сдачи], case
	when DATEPART(dw,PROGRESS.PDATE)=1 then 'пн'
	when DATEPART(dw,PROGRESS.PDATE)=2 then 'вт'
	when DATEPART(dw,PROGRESS.PDATE)=3 then 'ср'
	when DATEPART(dw,PROGRESS.PDATE)=4 then 'чт'
	when DATEPART(dw,PROGRESS.PDATE)=5 then 'пт'
	when DATEPART(dw,PROGRESS.PDATE)=6 then 'сб'
	when DATEPART(dw,PROGRESS.PDATE)=7 then 'вс'
end [дн]
from GROUPS inner join STUDENT on STUDENT.IDGROUP=GROUPS.IDGROUP
	inner join PROGRESS on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
	where GROUPS.IDGROUP=@grNum

--6

select case 
	when NOTE between 0 and 4 then 'хорошо'
	when NOTE between 4 and 8 then 'афигеть как хорошо'
	when NOTE between 8 and 10 then 'чел ты просто гений!!!'
	else 'ты не сдал'
	end имя, count(*) [кол-во челов]
from PROGRESS
group by case 
	when NOTE between 0 and 4 then 'хорошо'
	when NOTE between 4 and 8 then 'афигеть как хорошо'
	when NOTE between 8 and 10 then 'чел ты просто гений!!!'
	else 'ты не сдал'
	end

--7
create table #ex
(fitst_column int, second_column nvarchar(10));
set nocount on;
declare @i int = 0;
while @i < 1000 
begin 
insert #ex(fitst_column, second_column)
values (FLOOR(300*RAND()), REPLICATE('строка', 10));
if (@i % 100 = 0 ) 
print @i
set @i = @i + 1 
end;

 --8

 declare @b int = 1
 print @b+1
 print @b+4
 return print @b

--9
use UNIVER;
go
begin try 
update AUDITORIUM set AUDITORIUM = 'adsad' where AUDITORIUM = '206-1'
end try 
begin catch 
print ERROR_NUMBER()
print ERROR_MESSAGE()
print ERROR_LINE()
print ERROR_PROCEDURE()
print ERROR_SEVERITY()
print ERROR_STATE()
end catch