--Ejercicio 1
select db_name()
exec sp_helpdb
use tempdb
select au_lname from Pubs.dbo.authors
use pubs

--Ejercicio 2
declare @mens varchar(40)
set @mens = 'Just testing..'
select @mens
go --Se muestra lo que contiene @mens

select @mens
GO --arroja error ya que la variable @mens no esta declara, son solo locales

------------------------
declare @price int
select @price = price from titles where title_id = 'BU1111'
select @price 'prueba'
go

--Ejercicio 3
select * from ventas--para saber que tiene
declare @cant smallint
update ventas
	set cant = cant -100,
	@cant = cant
	where codVent = 1
	select @cant --para ver que guarda @cant
	go

--Ejerciocio 4
print 'el ultimo codigo de error fue: ' + convert(varchar, @@error)
go

--Ejercicio 5
declare @precio money
select @precio = price from titles
where title_id = 'BU1111'

if (@precio < 10 )
	begin
		print 'El precio es MENOR a 10'
	end
	else
		if @precio > 10 
			begin
				print 'El precio es MAYOR a 10'
			end
		else
			begin
				print 'El precio es IGUAL a 10'
			end

--Ejercicio 6
create table t1 (
	ID int identity, 
	FechaHora datetime not null default Current_timestamp)

declare @contador int
set @contador = 100
while @contador <> 0
begin
	insert into t1 values(CURRENT_TIMESTAMP)
	waitfor delay '00:00:00:010'--un minimo retraso para ver que cambió el tiempo
	set @contador = @contador -1
end
select * from T1

--Ejercicio 7
begin transaction
declare @stock int,@error smallint

select @stock=stock from productos where codProd = 100
update productos
	set stock = stock -5,
	 @stock = stock
	where codProd = 100
	set @error = @@error
	if @error =0
	begin
		insert into detalle values(1200,1108,100,5,10)
		if @error <> 0
			begin 
				ROLLBACK TRANSACTION 
			END
		ELSE 
			BEGIN 
				COMMIT TRANSACTION 
			END
		end
	else
	begin 
		rollback transaction
	end

GO
--PARA VER SI FUNCIONO
SELECT * FROM detalle
select * from productos
insert into productos VALUES(100,'jabon',3,50)

--Prueba
declare @cad1 varchar(100)
declare @cad2 varchar(100)
set @cad1 = 'Select title from '
set @cad2 = 'titles'
exec (@cad1 + @cad2)




				