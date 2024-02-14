use A_MyBase
go

create table TR_Tov (
id int identity,
st varchar(20) check (st in ('ins', 'del', 'upd')),
trn varchar(50),
c varchar(300)
)

create trigger TRIG_Tov  on ������ after INSERT, DELETE, UPDATE  
as declare @a1 varchar(20), @a2 real, @a3 int, @in varchar(300);
declare @ins int = (select count(*) from inserted),
              @del int = (select count(*) from deleted); 
if  @ins > 0 and  @del = 0  
begin 
     print '�������: INSERT';
     set @a1 = (select ������������_������ from INSERTED);  
     set @a2 = (select [����] from INSERTED);
     set @a3 = (select [����������] from INSERTED);
     set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
     insert into TR_Tov(ST, TRN, C)  values('INS', 'TRIG_Tov', @in);
end; 
else		  	 
if @ins = 0 and  @del > 0  
begin 
    print '�������: DELETE';
    set @a1 = (select ������������_������ from deleted);
    set @a2 = (select [����] from deleted);
    set @a3 = (select [����������] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    insert into TR_Tov(ST, TRN, C)  values('DEL', 'TRIG_Tov', @in);
end; 
else	  
if @ins > 0 and  @del > 0  
begin 
    print '�������: UPDATE'; 
    set @a1 = (select ������������_������ from inserted);
    set @a2 = (select [����] from inserted);
    set @a3 = (select [����������] from inserted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20));
    set @a1 = (select ������������_������ from deleted);
    set @a2 = (select [����] from deleted);
    set @a3 = (select [����������] from deleted);
    set @in = @a1+' '+cast(@a2 as varchar(20))+' '+cast(@a3 as varchar(20))+' '+@in;
    insert into TR_Tov(ST, TRN, C)  values('UPD', 'TRIG_Tov', @in); 
end;  
return;  


    insert into  ������(������������_������, ����, ����������)
                                     values('����', 140, 20);                   
    delete from ������ where ������������_������ = '����';        
    update ������ set ���������� = 20  where ������������_������ = '����';      
	
select * from TR_Tov 


drop trigger TRIG_Tov