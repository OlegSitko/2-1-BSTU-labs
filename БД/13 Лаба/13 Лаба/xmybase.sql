use A_MyBase
go
Create Procedure PrZkazy
as
begin
	declare @k int = (select count(*) from ������);
	select * from ������
	return @k
end;

declare @k int = 0;
exec PrZkazy


create procedure Zkz_REPORT  @p CHAR(50)
as  
declare @rc int = 0;                            
begin try    
declare @tv char(20), @t char(300) = ' ';  
declare ZkTov CURSOR  for 
select ������������_������ from ������ where �������� = @p;
if not exists (select ������������_������ 
from ������ where �������� = @p)
raiserror('������', 11, 1);
else 
open ZkTov;	  
fetch  ZkTov into @tv;   
print   '���������� ������';   
while @@fetch_status = 0                                     
begin 
set @t = rtrim(@tv) + ', ' + @t;  
set @rc = @rc + 1;       
fetch  ZkTov into @tv; 
end;   
print @t;        
close  ZkTov;
return @rc;
end try  
begin catch              
print '������ � ����������' 
if error_procedure() is not null   
print '��� ��������� : ' + error_procedure();
return @rc;
end catch; 


declare @rc int;  
exec @rc = Zkz_REPORT @p  = '���';  
print '���������� ������� = ' + cast(@rc as varchar(3)); 

