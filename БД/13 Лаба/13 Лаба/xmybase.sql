use A_MyBase
go
Create Procedure PrZkazy
as
begin
	declare @k int = (select count(*) from Заказы);
	select * from Заказы
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
select Наименование_товара from Заказы where Заказчик = @p;
if not exists (select Наименование_товара 
from Заказы where Заказчик = @p)
raiserror('ошибка', 11, 1);
else 
open ZkTov;	  
fetch  ZkTov into @tv;   
print   'Заказанные товары';   
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
print 'ошибка в параметрах' 
if error_procedure() is not null   
print 'имя процедуры : ' + error_procedure();
return @rc;
end catch; 


declare @rc int;  
exec @rc = Zkz_REPORT @p  = 'Луч';  
print 'количество товаров = ' + cast(@rc as varchar(3)); 

