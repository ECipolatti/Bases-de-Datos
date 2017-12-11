create trigger tr_up_estados from Estado_Afiliado
 for insert, update 
 as

 declare @viejo_estado int,@nuevo_estado int
begin
	if  exists (select * from deleted)
		begin 
			--si esta aca es por que ya estaba creado
			select @viejo_estado=estado from deleted
			select @nuevo_estado=estado from inserted
			if (@viejo_estado=3 or  @nuevo_estado)
				begin
					
				end
		end 
end







 