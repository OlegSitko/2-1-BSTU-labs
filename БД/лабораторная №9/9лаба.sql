--1
declare @a char = 'q', @b varchar(9) = '����_����',
@� datetime = '2222-02-22T20:02:22', @t time = '20:02:22', 
@i int = 1, @s smallint = 222, @ty tinyint = 22, @n numeric(12, 5) 
select @a 
set @a = 'w'
print @t

--2 . 
-- ����������� ������, � ������� ������������ ����� ����������� ������-���.
-- ���� ����� ����������� ��������� 200, �� ������� ���������� ���������, ������� ����������� ���������, ��-�������� ���������, ����������� ������� ������ �������, � ������� ����� ���������. 
-- ���� ����� ����������� ��������� ������ 200, �� ������� ��������� � ������� ����� �����������.

use UNIVER;
go
declare 
@allCapacity int = (select sum(AUDITORIUM_CAPACITY)  from AUDITORIUM ), -- ����� ����������� ���������
-- ����� ����������� > 200
@countCapacity int, -- ���������� ���������
@avgCapacity int, -- ������� ����������� ���������
@CapacityMensheAvg int, -- ���������� ���������, ����������� ������� ������ �������
@ProcentCapacity int -- ������� ����� ���������
print @allCapacity

if @allCapacity > 200 
begin
set @countCapacity = (select count(*) from AUDITORIUM );
set @avgCapacity = (select avg(AUDITORIUM_CAPACITY) from AUDITORIUM);
set @CapacityMensheAvg = (select count(*) from AUDITORIUM where @countCapacity < @avgCapacity);
set @ProcentCapacity = (@CapacityMensheAvg * 100 / @countCapacity);
select 
@allCapacity [����� �����������],
@countCapacity [���������� ���������],
@avgCapacity [������� ����������� ���������],
@CapacityMensheAvg [���������� ���������, ����������� ������� ������ �������],
@ProcentCapacity [������� ��������� � ������� ����������� < 200]
end
else print '����� ������������ ������ 200'

--3

print '����� ������������ �����' + cast(@@ROWCOUNT as varchar) 
print '������ SQL Server' + cast(@@VERSION as varchar)
print '���������� ��������� ����������-��� ��������, ����������� �����-��� �������� �����������' + cast (@@SPID as varchar) 
print '��� ��������� ������' + cast(@@ERROR as varchar)  
print '��� �������' + cast (@@SERVERNAME as varchar)
print '���������� ������� ����������� ����������' + cast (@@TRANCOUNT as varchar) 
print '�������� ���������� ���������� ����� ��������������� ������' + cast(@@FETCH_STATUS as varchar) 
print '������� ����������� ������� ���-������' + cast(@@NESTLEVEL as varchar) 

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
@surName nvarchar(10) = '�����',
@Name nvarchar(10) = '�������',
@Father nvarchar(10) = '�������'

set @fullName = @surName + ' ' + @Name + ' ' + @Father
print @fullName
--select @fullName

set @fullName  = @surName + ' ' + SUBSTRING(@Name, 1,1) + '.' + SUBSTRING(@Father, 1,1) + '.'
print @fullName

--

select STUDENT.NAME,STUDENT.BDAY,(datediff(YY,STUDENT.BDAY,sysdatetime())) as '�������'
	from STUDENT
	where MONTH(STUDENT.BDAY)=month(sysdatetime());

--

declare @grNum int=2;
select distinct PROGRESS.PDATE[���� �����], case
	when DATEPART(dw,PROGRESS.PDATE)=1 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=2 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=3 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=4 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=5 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=6 then '��'
	when DATEPART(dw,PROGRESS.PDATE)=7 then '��'
end [��]
from GROUPS inner join STUDENT on STUDENT.IDGROUP=GROUPS.IDGROUP
	inner join PROGRESS on STUDENT.IDSTUDENT=PROGRESS.IDSTUDENT
	where GROUPS.IDGROUP=@grNum

--6

select case 
	when NOTE between 0 and 4 then '������'
	when NOTE between 4 and 8 then '������� ��� ������'
	when NOTE between 8 and 10 then '��� �� ������ �����!!!'
	else '�� �� ����'
	end ���, count(*) [���-�� �����]
from PROGRESS
group by case 
	when NOTE between 0 and 4 then '������'
	when NOTE between 4 and 8 then '������� ��� ������'
	when NOTE between 8 and 10 then '��� �� ������ �����!!!'
	else '�� �� ����'
	end

--7
create table #ex
(fitst_column int, second_column nvarchar(10));
set nocount on;
declare @i int = 0;
while @i < 1000 
begin 
insert #ex(fitst_column, second_column)
values (FLOOR(300*RAND()), REPLICATE('������', 10));
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