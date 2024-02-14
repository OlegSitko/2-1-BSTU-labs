USE UNIVER;
GO


-- ������� �1
--����� ������� ����������
declare @c int , @t char(5) = 'n'
SET IMPLICIT_TRANSACTIONS ON
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('test-1',20,'��','��'),
       ('test-2',20,'��','��'),
	   ('test-3',20,'��','��')
set @c = (select count(*) from AUDITORIUM)
if @t = 'y' 
begin
	commit;
	select @c as [����������� ���������] , string_agg(rtrim(AUDITORIUM.AUDITORIUM), ',')  from AUDITORIUM
end
else
begin
	rollback;
	print '��������� rollback'
end
SET IMPLICIT_TRANSACTIONS OFF
delete from AUDITORIUM where AUDITORIUM like 'test%'


-- ������� �2
--�������� ����������� ����� ���������� 
begin try 
	begin tran 
	update AUDITORIUM set AUDITORIUM_CAPACITY = 'iAmNotAValue';
	delete from AUDITORIUM where AUDITORIUM like 'test%' 
	insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
	values('new-1',20,'��','��'),
		('new-1',20,'��','��'),
		('new-3',20,'��','��')
	commit tran
end try 
begin catch 
	print '������: ' + case 
		when error_number() = 245 
			then '���������� ������ � �����'
		when error_number() = 2627 and patindex('%PK_AUDITORIUM%',error_message())>0
			then '��������� ������������ ����� (������� �������� ������������� ��������)'
		else '�������������� ������ � �����: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) + ', ��������� �� ������: ' + ERROR_MESSAGE()
	end;
	if @@TRANCOUNT > 0 rollback tran;
end catch;


-- ������� �3
--���������� ��������� SAVE TRAN 
declare @point varchar(32)
begin try 
	begin tran 
	delete from AUDITORIUM where AUDITORIUM like 'test%' 
	set @point = 'p1' ; save tran @point
	delete from AUDITORIUM where AUDITORIUM like 'new%' 
	set @point = 'p2' ; save tran @point
	insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
	values('new-1',20,'��','��'),
		  ('new-1',20,'��','��'),
	      ('new-3',20,'��','��')
	set @point = 'p3' ; save tran @point
	update AUDITORIUM set AUDITORIUM_CAPACITY =  21 where AUDITORIUM = 'new-2';
	set @point = 'p4' ; save tran @point
	commit tran
end try 
begin catch 
	print '������ � �������'
	if error_number() = 245 
	begin
		print '������: ���������� ������ � �����'
	end
	else if error_number() = 2627
	begin
		print '������: ��������� ������������ ����� (������� �������� ������������� ��������)'
	end
	else
	begin
		print '�������������� ������ � �����: ' + CAST(ERROR_NUMBER() AS NVARCHAR(10)) + ', ��������� �� ������: ' + ERROR_MESSAGE()
	end
	if @@TRANCOUNT > 0 
	begin
		print '����������� ����� ' + @point;
		rollback tran @point; -- �����
		commit tran;
	end
end catch;


-- ������� �4
-- A:  
use UNIVER
set transaction isolation level READ UNCOMMITTED 
begin tran 
-------------------------- t1 ------------------
select @@SPID [connection id], 'insert AUDITORIUM' 'result' , * 
from AUDITORIUM
where AUDITORIUM = '4task-2';
select 'update AUDITORIUM' 'result', AUDITORIUM.AUDITORIUM_CAPACITY, AUDITORIUM.AUDITORIUM 
from AUDITORIUM 
where AUDITORIUM.AUDITORIUM like '4task%';
commit 

-------------------------- t2 ------------------
-- B: 
begin tran 
delete AUDITORIUM where AUDITORIUM like '4task%';
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('4task-1',20,'��','��'),
      ('4task-2',20,'��','��'),
	  ('4task-3',20,'��','��')
;
update AUDITORIUM set AUDITORIUM_CAPACITY =  21 where AUDITORIUM = '4task-2';

-------------------------- t1 ------------------
-------------------------- t2 ------------------
rollback


-- ������� �5
--�� ��������� ����������������� ������,
insert AUDITORIUM (AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY, AUDITORIUM_NAME)
values ('111-1', '��', 30, '111-1');
-- A:
set transaction isolation level READ COMMITTED 
begin tran
select * from AUDITORIUM where AUDITORIUM_CAPACITY < 30
-------------------------- t1 ------------------
-------------------------- t2 ------------------
select 'update AUDITORIUM' 'result', count(*) from AUDITORIUM where AUDITORIUM.AUDITORIUM like 'task5%';
commit

-- B:
begin tran
-------------------------- t1 ------------------
update AUDITORIUM set AUDITORIUM = 'task5-1' where AUDITORIUM = '111-1';
commit
-------------------------- t2 ------------------

update AUDITORIUM set AUDITORIUM = '111-1' where AUDITORIUM = 'task5-1';
delete from AUDITORIUM where AUDITORIUM_NAME = '111-1'

-- ������� �6
--A: �� ��������� ����������������� ������ � ���������������� ������, �� ��� ���� ���-����� ��������� ������. 
set transaction isolation level  REPEATABLE READ  
begin tran 
select * from AUDITORIUM 
-------------------------- t1 ------------------
-------------------------- t2 ------------------
select case 
when AUDITORIUM.AUDITORIUM = 'task6-1'  then 'insert AUDITORIUM' else ''
end 'result', * from AUDITORIUM where AUDITORIUM = 'task6-1';
commit;

-- B: 
begin tran 
-------------------------- t1 ------------------
delete AUDITORIUM where AUDITORIUM like 'task6%'
 insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
 values('task6-1',20,'��','��')
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task6-1'
delete AUDITORIUM where AUDITORIUM = 'task6-1'
commit;
-------------------------- t2 ------------------
rollback;


-- ������� �7
-- A:
set transaction isolation level SERIALIZABLE 
begin tran 
delete AUDITORIUM where AUDITORIUM = 'task7-1'
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('task7-1',20,'��','��')
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task7-1'
select * from AUDITORIUM where AUDITORIUM = 'task7-1'
-------------------------- t1 ------------------
select * from AUDITORIUM where AUDITORIUM = 'task7-1'
-------------------------- t2 ------------------
commit

 -- B: 
set transaction isolation level READ COMMITTED 
begin tran 
delete AUDITORIUM where AUDITORIUM = 'task7-1'
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('task7-1',20,'��','��')
update AUDITORIUM set AUDITORIUM_CAPACITY = 25 where AUDITORIUM = 'task7-1'
select * from AUDITORIUM where AUDITORIUM = 'task7-1'
 -------------------------- t1 ------------------
commit
select * from AUDITORIUM where AUDITORIUM = 'task7-1'
-------------------------- t2 ------------------
delete AUDITORIUM where AUDITORIUM = 'task7-1'


-- ������� �8
begin tran 
delete AUDITORIUM where AUDITORIUM = 'task8-1'
insert AUDITORIUM (AUDITORIUM,AUDITORIUM_CAPACITY,AUDITORIUM_NAME,AUDITORIUM_TYPE)
values('task8-1',20,'��','��')
begin tran 
update AUDITORIUM set AUDITORIUM_CAPACITY = 66 where AUDITORIUM = 'task8-1'
commit
select * from AUDITORIUM
rollback
select * from AUDITORIUM
