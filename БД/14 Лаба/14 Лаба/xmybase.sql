use A_MyBase
go

create function Count_zakazy (@f varchar(20)) returns int 
as begin declare @rc int = 0;
set @rc = (select count(����������) from ������ z join ��������� zk 
on z.�������� = zk.������������_����� 
where ������������_����� = @f );
return @rc;
end;

declare @f int = dbo.Count_zakazy('����');
print '���������� �������: ' + cast(@f as varchar(4));
drop function Count_zakazy

------------------------------------------------------------

create FUNCTION FZakazy(@tz char(20)) returns char(300) 
as
begin  
declare @tv char(20);  
declare @t varchar(300) = '���������� ������: ';  
declare ZkTovar CURSOR LOCAL 
for select ������������_������ from ������ 
    where �������� = @tz;
open ZkTovar;	  
fetch  ZkTovar into @tv;   	 
while @@fetch_status = 0                                     
begin 
set @t = @t + ', ' + rtrim(@tv);         
FETCH  ZkTovar into @tv; 
end;    
return @t;
end;  

select ������������_�����,  dbo.FZakazy (������������_�����)  from ���������;

 drop function FZakazy


