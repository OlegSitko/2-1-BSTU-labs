use A_MyBase
go

declare @tv char(20), @t char(300) = '';
declare ZkTovar Cursor for select [Наименование_товара] from Заказы

open ZkTovar
fetch ZkTovar into @tv --Оператор FETCH считывает одну строку из результирующего набора и продвигает указатель на следующую строку. 
print 'Заказанные Товары';
while @@FETCH_STATUS = 0 
begin 
set @t = RTRIM(@tv) + ', ' + @t;
fetch ZkTovar into @tv;
end;
print @t;
close ZkTovar;

-------------------------------------------------------------------------------
declare Tovary cursor local for select Наименование_товара, Цена from Товары;
declare @tv char(20), @cena real;      
	open Tovary;	  
	fetch  Tovary into @tv, @cena; 	
      print '1. '+@tv+cast(@cena as varchar(6));   
      go
 declare @tv char(20), @cena real;     	
	fetch  Tovary into @tv, @cena; 	
      print '2. '+@tv+cast(@cena as varchar(6));  
  go   

  -------------------------------------------------------
      declare @tid char(10), @tnm char(40), @tgn char(1);  
	declare Zakaz cursor local static                              
		 for select Наименование_товара, Цена_продажи, Количество 
		       from dbo.Заказы where Заказчик = 'Фирма 1';				   
	open Zakaz;
	print   'Количество строк : '+ cast(@@CURSOR_ROWS as varchar(5)); 
    	UPDATE Заказы set Количество = 5 where Наименование_товара = 'Продукт 1';
	delete Заказы where Наименование_товара = 'Шкаф';
	insert Заказы (Номер_заказа, Наименование_товара, Цена_продажи,    
                                Количество, Дата_поставки, Заказчик) 
	                 values (18, 'Шкаф', 340, 1, '2014-08-02', 'Луч'); 
	fetch  Zakaz into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn;      
          fetch Zakaz into @tid, @tnm, @tgn; 
       end;          
   close Zakaz;
