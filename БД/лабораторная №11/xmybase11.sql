use A_MyBase
go

declare @tv char(20), @t char(300) = '';
declare ZkTovar Cursor for select [������������_������] from ������

open ZkTovar
fetch ZkTovar into @tv --�������� FETCH ��������� ���� ������ �� ��������������� ������ � ���������� ��������� �� ��������� ������. 
print '���������� ������';
while @@FETCH_STATUS = 0 
begin 
set @t = RTRIM(@tv) + ', ' + @t;
fetch ZkTovar into @tv;
end;
print @t;
close ZkTovar;

-------------------------------------------------------------------------------
declare Tovary cursor local for select ������������_������, ���� from ������;
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
		 for select ������������_������, ����_�������, ���������� 
		       from dbo.������ where �������� = '����� 1';				   
	open Zakaz;
	print   '���������� ����� : '+ cast(@@CURSOR_ROWS as varchar(5)); 
    	UPDATE ������ set ���������� = 5 where ������������_������ = '������� 1';
	delete ������ where ������������_������ = '����';
	insert ������ (�����_������, ������������_������, ����_�������,    
                                ����������, ����_��������, ��������) 
	                 values (18, '����', 340, 1, '2014-08-02', '���'); 
	fetch  Zakaz into @tid, @tnm, @tgn;     
	while @@fetch_status = 0                                    
      begin 
          print @tid + ' '+ @tnm + ' '+ @tgn;      
          fetch Zakaz into @tid, @tnm, @tgn; 
       end;          
   close Zakaz;
