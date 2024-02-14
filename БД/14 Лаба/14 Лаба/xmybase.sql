use A_MyBase
go

create function Count_zakazy (@f varchar(20)) returns int 
as begin declare @rc int = 0;
set @rc = (select count(Количество) from Заказы z join Заказчики zk 
on z.Заказчик = zk.Наименование_фирмы 
where Наименование_фирмы = @f );
return @rc;
end;

declare @f int = dbo.Count_zakazy('Стул');
print 'Количество заказов: ' + cast(@f as varchar(4));
drop function Count_zakazy

------------------------------------------------------------

create FUNCTION FZakazy(@tz char(20)) returns char(300) 
as
begin  
declare @tv char(20);  
declare @t varchar(300) = 'Заказанные товары: ';  
declare ZkTovar CURSOR LOCAL 
for select Наименование_товара from Заказы 
    where Заказчик = @tz;
open ZkTovar;	  
fetch  ZkTovar into @tv;   	 
while @@fetch_status = 0                                     
begin 
set @t = @t + ', ' + rtrim(@tv);         
FETCH  ZkTovar into @tv; 
end;    
return @t;
end;  

select Наименование_фирмы,  dbo.FZakazy (Наименование_фирмы)  from Заказчики;

 drop function FZakazy


