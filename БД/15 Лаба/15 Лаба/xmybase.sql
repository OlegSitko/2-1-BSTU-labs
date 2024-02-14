use A_MyBase
go

create table TR_Tov (
id int identity,
st varchar(20) check (st in ('ins', 'del', 'upd')),
trn varchar(50),
c varchar(300)
)

create trigger TRIG_Tov  on Товары after INSERT, DELETE, UPDATE  
as declare @a1 varchar(20), @a2 real, @a3 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print 'Событие: INSERT';
     set @a1 = (select Наименование_товара from INSERTED);  
     set @a2 = (select [Цена] from INSERTED);
     set @a3 = (select [Количество] from INSERTED);
     set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
     insert into TR_Tov(ST, TRN, C)  values('INS', 'TRIG_Tov', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print 'Событие: DELETE';
    set @a1 = (select Наименование_товара from deleted);
    set @a2 = (select [Цена] from deleted);
    set @a3 = (select [Количество] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Tov', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print 'Событие: UPDATE'; 
    set @a1 = (select Наименование_товара from inserted);
    set @a2 = (select [Цена] from inserted);
    set @a3 = (select [Количество] from inserted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    set @a1 = (select Наименование_товара from deleted);
    set @a2 = (select [Цена] from deleted);
    set @a3 = (select [Количество] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Tov', @in); 
end;  
return;  


    insert into  Товары(Наименование_товара, Цена, Количество)
                                     values('Стол', 140, 20);                   
    delete from Товары where Наименование_товара = 'Стол';        
    update Товары set Количество = 20  where Наименование_товара = 'Стул';      
	
select * from TR_Tov 


drop trigger TRIG_Tov