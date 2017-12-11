
create trigger tr_EstadoAfiliado on EstadoAfiliado 
for insert, update
as
begin
	declare @nuevo int,@viejo int;
	select @nuevo=estado from inserted
	select @viejo=estado from deleted
	
	if(@nuevo=1 and @viejo <>0)
		begin
			rollback
		end 

	 if(@nuevo=2 and @viejo not in (1,3,4,5))
		begin
			rollback
		end 
		
	if(@nuevo=3 and @viejo <>2)
		begin
			rollback
		end 
	if(@nuevo=4 and @viejo not in(5,2,3))
		begin
			rollback
		end 
	if(@nuevo=5 and @viejo <>2)
		begin
			rollback
		end 
	-- si no se filtro por alguna de las anteriores es por que es valido
	--deberia ir algun insert en principio si se modifica el estado
	
end	
	
go