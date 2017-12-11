create table pais(
codigo char(3) not null,
nombre char(30),
constraint pk_pais primary key(codigo));

create table tipo_persona_juridica(
id int8 not null,
codigo int2 not null,
nombre char(80) not null,
constraint pk_tipo_persona_juridica primary key(id));

create table localidad(
codigo int2 not null,
nombre char(60) not null,
codigo_postal int2 null,
constraint pk_localidad primary key(codigo));

create table tipo_domicilio(
id int8 not null,
tipo int2 not null,
nombre char(60) not null,
constraint pk_tipo_domicilio primary key(id));
create table persona(
id int8 not null,
codigo int8 not null,
telefono char(20) null,
telefono_movil char(20) null,
correo_electronico char(120) null,
cuit_cuil int8 null,
codigo_pais char(3) null,
constraint pk_persona primary key (id),
constraint fk_persona_pais foreign key (codigo_pais) references pais (codigo)
);

alter table tipo_persona_juridica add constraint tipo_persona_juridica_unique unique (codigo);
alter table tipo_domicilio add constraint tipo_domicilio_unique unique (tipo);
create table persona_juridica(
id int8 not null,
razon_social char (40) not null,
nombre_fantasia char(40) not null,
id_persona int8 not null,
cuit char(30) not null,
constraint pk_persona_juridica primary key (id),
constraint fk_persona_juridica_persona foreign key (id_persona) references persona (id)
);

create table persona_fisica(
id int8 not null,
tipo_documento char(1) not null,
numero_documento int4 not null,
apellido char(40) not null,
nombre char(40) not null,
sexo char(1) not null,
fecha_nacimiento date null,
observaciones varchar(10) null,
id_persona int8 not null,
constraint pk_persona_fisica primary key (id),
constraint fk_persona_fisica_persona foreign key (id_persona) references persona (id),
constraint persona_fisica_unique unique (tipo_documento, numero_documento)
);


create table domicilio(
id int8 not null,
id_persona int8 null,
item int2 null,
detalle_domicilio char(100) not null,
codigo_localidad int2 null,
id_tipo_domicilio int8 null,
constraint pk_domicilio primary key (id),
constraint fk_domicilio_localidad foreign key (codigo_localidad) references localidad (codigo),
constraint fk_domicilio_persona foreign key (id_persona) references persona (id),
constraint fk_domicilio_tipo_domicilio foreign key (id_tipo_domicilio) references tipo_domicilio (id),
constraint fk_domicilio_unique unique (id_persona, item)
);


create table integra_persona_juridica(
id int8 not null,
id_persona_juridica int8 not null,
item int2 null,
id_persona_fisica int8 null,
id_funcion int2 null,
observaciones char(100) not null,
constraint pk_integra_persona_juridica primary key (id),
constraint fk_integra_persona_juridica_persona_juridica foreign key (id_persona_juridica) references persona_juridica (id),
constraint fk_integra_persona_juridica_persona_fisica foreign key (id_persona_fisica) references persona_fisica (id),
constraint fk_integra_persona_juridica_unique unique(id_persona_juridica,item),
constraint fk_integra_persona_juridica_funcion foreign key (id_funcion) references funcion (id)
);

create table funcion(
id int8 not null,
codigo int2 not null,
nombre char(60) not null,
constraint pk_funcion primary key (id)
);


insert into pais(codigo, nombre)
values(24,'Brasil');

select * from pais;

insert into localidad(codigo, nombre, codigo_postal)
values(4345, 'sunchales', 2322);
insert into localidad(codigo, nombre, codigo_postal)
values(123, 'rafaela', 2223);

select * from localidad;

insert into persona(id, codigo,telefono,telefono_movil,correo_electronico,cuit_cuil,codigo_pais)
values(12,123,null,null,null,null,null);

insert into persona(id, codigo,telefono,telefono_movil,correo_electronico,cuit_cuil,codigo_pais)
values(112,1223,null,null,null,1234,null);

insert into persona(id, codigo,telefono,telefono_movil,correo_electronico,cuit_cuil,codigo_pais)
values(132,13323,null,null,null,null,54);

insert into tipo_domicilio(id, tipo, nombre)
values(43,455,'casa');

insert into domicilio(id,id_persona,item,detalle_domicilio,codigo_localidad,id_tipo_domicilio)
values(123,12,34,'algo',123,43);

--Ejercicio 1
create proc sp_ObtenerPrecio
	as
		select price from titles where title_id = 'PS2091'
return
exec sp_ObtenerPrecio

--Ejercicio 2
sp_help sp_ObtenerPrecio

--Ejercicio 3
select name, ID, type from sysobjects where name = 'sp_ObtenerPrecio'

--Ejercicio 4
select name from sysobjects where type = 'P'

--Ejercicio 5
sp_helptext sp_help
sp_helptext sp_obtenerPrecio

--Ejercicio 6
use pubs
sp_help titles

create proc sp_ObtenerPrecio2
	@codigo varchar(6)
	as
		select price from titles where title_id = @codigo
return

exec sp_ObtenerPrecio2 bu7832--Funciona sin comillas TMB

--Ejercicio 7
sp_help sales
create proc sp_VerVenta
	@id char(4),
	@numero_orden varchar(20),
	@cantidad smallint
	as
		select ord_date from sales where stor_id = @id and ord_num = @numero_orden and qty = @cantidad
return

exec sp_VerVenta '7067',p2121,40

--Ejercicio 8
create proc sp_ObtenerPrecio3
	@codigo varchar(6) = null
	as
		print @codigo
		if @codigo is not null
		begin
			select price from titles where title_id = @codigo
		end
		else
		begin
			select price from titles
		end
return
drop proc sp_ObtenerPrecio3
exec sp_ObtenerPrecio3 bu7832

--Ejercicio 9
create proc sp_ObtenerPrecio4
	@codigo varchar(6) = null
	as
		print @codigo
		if @codigo is not null
		begin
			select price from titles where title_id = @codigo
		end
		else
		begin
			print 'El procedimiento sp_ObtenerPrecio4 necesita del parámetro title_id' 
		end
return
exec sp_ObtenerPrecio4 bu7832
exec sp_ObtenerPrecio4

--Ejercicio 10
(10, “Articulo 1”, $50, 20)
(20, “Articulo 2”, $70, 40)
insert into productos values(20, 'Articulo 2', $70, 40)
select * from productos

create proc sp_BuscaPrecio
	(@codProd int,
	@PrecUnit money output)
	as
		select @PrecUnit= precUnit
			from productos
			where @codProd = codProd
		return

create proc sp_InsertaDetalle
	(@codigo int, @numero int, @codProd int, @cantidad int)
	as		
		declare @precio_total money
		exec sp_BuscaPrecio @codProd, @precio_total output
		insert into detalle 
		values(@codigo, @numero,@codProd,@cantidad,@cantidad*@precio_total)
		if @@ROWCOUNT = 1
			print ' Se Inserto una file'
		return

exec sp_InsertaDetalle 15,13,10,3

select * from detalle

--Ejercicoi 11

exec sp_InsertaDetalle 1540,120,10,2
select * from detalle

--Ejercicio 12
declare @eror int
exec @eror = sp_InsertaDetalle 1540,120
select @eror

--Ejercicio 13
CREATE PROCEDURE sp_BuscarPrecio2
	(@CodProd int, -- Parametro de entrada
	@PrecUnit money OUTPUT) -- Parametro de salida
	AS
		SELECT @PrecUnit = PrecUnit
			FROM Productos
			WHERE CodProd = @Codprod
		IF @@RowCount = 0
			RETURN 70 -- No se encontro el producto
		IF @PrecUnit IS NULL
			RETURN 71 -- El producto existe pero su precio es NULL
		RETURN 0 -- El producto existe y su precio no es NULL

CREATE PROCEDURE sp_InsertaDetalle2
	(@CodDetalle Int, -- Parametro de entrada a sp_InsertaDetalle2
	@NumPed Int, -- Parametro de entrada a sp_InsertaDetalle2
	@CodProd int, -- Parametro de entrada a sp_InsertaDetalle2 y al inner proc
	@Cant Int) -- Parametro de entrada a sp_InsertaDetalle2
	AS
	DECLARE @PrecioObtenido MONEY --Parametro de salida del inner procedure
	DECLARE @StatusRetorno Int
	EXECUTE @StatusRetorno = sp_BuscarPrecio2 @CodProd, @PrecioObtenido OUTPUT
	IF @StatusRetorno != 0
	BEGIN
		IF @StatusRetorno = 70
			RAISERROR ('Codigo de producto inexistente', 16, 1)
		ELSE
			IF @StatusRetorno = 71
				RAISERROR ('El producto %d no posee precio', 16, 1, @CodProd)
			ELSE
				RAISERROR ('Error en el SP sp_BuscarPrecio2', 16, 1)
			RETURN 99
	END
	INSERT Detalle Values(@CodDetalle, @NumPed, @CodProd, @Cant,
		@Cant * @PrecioObtenido)
	IF @@Error != 0
		RETURN 77
	If @@RowCount = 1
		PRINT 'Se inserto una fila'
	RETURN 0

exec sp_InsertaDetalle2 1540,120,99,2
--Nos devuelve :
--Mens 50000, Nivel 16, Estado 1, Procedimiento sp_InsertaDetalle2, Línea 14
--Codigo de producto inexistente

--Ejercicio 14
sp_help publishers
select * from publishers
create table Editoriales(
	pub_id char(4) not null,
	pub_name varchar(40) not null
	)

select pub_id, pub_name 
	into Editoriales
	from publishers
	where country is null

--Ejercicio 15
create proc sp_editorial
	as
		select pub_id, pub_name from publishers
	return

insert Editoriales
	exec sp_editorial
select * from editoriales
select * from publishers