
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


Insert into Estado_Afiliado values('1/3/2013',null,3,'Baja',50)
Insert into Estado_Afiliado values('3/2/2013',null,5,'activo',78)
Insert into Estado_Afiliado values('7/4/2013',null,1,'Baja',455)
Insert into Estado_Afiliado values('5/7/2013',null,3,'activo',90)
Insert into Estado_Afiliado values('3/8/2013',null,4,'activo',222)
Insert into Estado_Afiliado values('7/9/2013',null,5,'activo',111)
Insert into Estado_Afiliado values('7/3/2013',null,2,'Baja',56)
Insert into Estado_Afiliado values('9/1/2013',null,2,'activo',50)
Insert into Estado_Afiliado values('5/1/2013',null,1,'Baja',599)
Insert into Estado_Afiliado values('1/6/2013',null,1,'activo',88)

UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=50
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=455
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=90
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=222
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=111
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=56
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=50
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=599
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=78
UPDATE Estado_Afiliado SET secuencia = 2 WHERE id_afiliado=88

DELETE FROM Estado_Afiliado WHERE secuencia=1
DELETE FROM Estado_Afiliado WHERE secuencia=5
DELETE FROM Estado_Afiliado WHERE id_afiliado=1
DELETE FROM Estado_Afiliado WHERE id_afiliado=88
DELETE FROM Estado_Afiliado WHERE id_afiliado=111
DELETE FROM Estado_Afiliado WHERE id_afiliado=222
DELETE FROM Estado_Afiliado WHERE id_afiliado=88
DELETE FROM Estado_Afiliado WHERE id_afiliado=599
DELETE FROM Estado_Afiliado WHERE id_afiliado=50
DELETE FROM Estado_Afiliado WHERE id_afiliado=1