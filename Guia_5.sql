CREATE TABLE Provincia(
Id_provincia smallint NOT NULL,
nom_provincia char(30) NOT NULL,
CONSTRAINT pk_Provincia PRIMARY KEY(Id_provincia)
)

CREATE TABLE Localidad(
Id_localidad smallint NOT NULL,
id_provincia smallint NOT NULL,
nom_localidad char(40) NOT NULL,
CONSTRAINT pk_localidad PRIMARY KEY (id_localidad, id_provincia),
CONSTRAINT fk_localidad_provincia FOREIGN KEY(id_provincia) REFERENCES Provincia(id_provincia)
)

CREATE TABLE Seccion(
id_seccion smallint NOT NULL,
nom_seccion char(30) NOT NULL,
CONSTRAINT pk_seccion PRIMARY KEY (id_seccion)
)

CREATE TABLE Sector(
id_seccion smallint NOT NULL,
id_sector smallint NOT NULL,
nom_sector char(30) NOT NULL,
CONSTRAINT pk_sector PRIMARY KEY (id_sector, id_seccion),
CONSTRAINT fk_sector_seccion FOREIGN KEY(id_seccion) REFERENCES Seccion(id_seccion)
)

CREATE TABLE Empleado(
id_empleado int NOT NULL,
tipodoc char(1) NOT NULL,
nrodoc int NOT NULL,
sexo char(1) NOT NULL,
feingreso date NOT NULL,
CONSTRAINT pk_empleado PRIMARY KEY (id_empleado),
CONSTRAINT fk2_empleado_persona FOREIGN KEY(tipodoc, nrodoc, sexo) REFERENCES Persona(tipodoc, nrodoc, sexo)
)

CREATE TABLE Persona(
tipodoc char(1) NOT NULL,
nrodoc int NOT NULL,
sexo char(1) NOT NULL,
id_provincia_v smallint NOT NULL,
id_provincia_n smallint NULL,
id_localidad_v smallint NULL,
id_localidad_n smallint NULL,
tipodoc_p char(1) NULL,
nrodoc_p int NULL,
sexo_p char(1) NULL,
tipodoc_m char(1) NULL,
nrodoc_m int NULL,
sexo_m char(1) NULL,
apenom char(40) NOT NULL,
domicilio char(50) NULL,
denaci date NULL,

CONSTRAINT pk_persona PRIMARY KEY (tipodoc,nrodoc,sexo),
CONSTRAINT fk2_persona FOREIGN KEY(tipodoc_m, nrodoc_m, sexo_m) REFERENCES Persona(tipodoc, nrodoc, sexo),
CONSTRAINT fk3_persona FOREIGN KEY(tipodoc_p, nrodoc_p, sexo_p) REFERENCES Persona(tipodoc, nrodoc, sexo),
CONSTRAINT fk1_persona_localidad_v FOREIGN KEY(id_provincia_v, id_localidad_v) REFERENCES Localidad(id_localidad, id_provincia),
CONSTRAINT fk4_persona_localidad_n FOREIGN KEY(id_provincia_n, id_localidad_n) REFERENCES Localidad(id_localidad, id_provincia)
)




CREATE TABLE medico(
matricula smallint NOT NULL,
id_especialidad smallint NOT NULL,
tipodoc char(1) NOT NULL,
nrodoc smallint NOT NULL,
sexo char(1) NOT NULL,

CONSTRAINT pk_medico PRIMARY KEY (matricula),
CONSTRAINT fk1_medico_especialidad FOREIGN KEY(id_especialidad) REFERENCES especialidad(id_especialidad),
CONSTRAINT fk2_medico_Persona FOREIGN KEY(tipodoc, nrodoc, sexo) REFERENCES Persona(tipodoc, nrodoc, sexo)
)


CREATE TABLE especialidad(
id_especialidad smallint NOT NULL,
nom_especialidad char(30) NOT NULL,

CONSTRAINT pk_especialidad PRIMARY KEY(id_especialidad)
)


CREATE TABLE sala(
id_seccion smallint NOT NULL,
id_sector smallint NOT NULL,
nro_sala smallint NOT NULL,
id_especialidad smallint NOT NULL,
id_empleado smallint NOT NULL, 
nom_sala char(30) NULL,
capacidad smallint NULL,

CONSTRAINT pk_sala PRIMARY KEY (id_seccion, id_sector, nro_sala),
CONSTRAINT fk1_sala_sector FOREIGN KEY(id_seccion, id_sector) REFERENCES Sector(id_seccion, id_sector),
CONSTRAINT fk2_sala_empleado FOREIGN KEY(id_empleado) REFERENCES Empleado(id_empleado),
CONSTRAINT fk3_sala_especialidad FOREIGN KEY (id_especialidad) REFERENCES especialidad(id_especialidad)

)


CREATE TABLE cargo(
id_cargo smallint NOT NULL,
nom_cargo char(30) NOT NULL,

CONSTRAINT pk_cargo PRIMARY KEY(id_cargo)
)

CREATE TABLE historial(
id_empleado smallint NOT NULL,
fechainicio date NOT NULL,
id_cargo smallint NOT NULL,
fechafin date NULL,

CONSTRAINT pk_historial PRIMARY KEY (id_empleado, fechainicio),
CONSTRAINT fk1_historial_cargo FOREIGN KEY (id_cargo) REFERENCES cargo (id_cargo),
CONSTRAINT fk2_historial_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado)

)

CREATE TABLE trabajaen(
id_empleado smallint NOT NULL,
id_seccion smallint NOT NULL,
id_sector smallint NOT NULL,
nro_sala smallint NOT NULL,

CONSTRAINT pk_trabajaen PRIMARY KEY (id_empleado, id_seccion, id_sector, nro_sala),
CONSTRAINT fk1_trabajaen_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado),
CONSTRAINT fk2_trabajaen_sala FOREIGN KEY (id_seccion, id_sector, nro_sala) REFERENCES sala(id_seccion, id_sector, nro_sala)
)


CREATE TABLE asignacion(
id_asignacion int NOT NULL,
matricula smallint NOT NULL,
tipodoc Char(1) NOT NULL,
nrodoc int NOT NULL,
sexo Char(1) NOT NULL,
id_seccion smallint NOT NULL,
id_sector smallint NOT NULL,
nro_sala smallint NOT NULL,
id_empleado int NOT NULL,
feasigna Date NOT NULL,
fesalida Date NULL,
CONSTRAINT pk_asignacion PRIMARY KEY (id_asignacion),
CONSTRAINT fk1_asignacion_persona FOREIGN KEY (tipodoc,nrodoc,sexo) REFERENCES Persona(tipodoc,nrodoc,sexo),
CONSTRAINT fk2_asignacion_sala FOREIGN KEY (id_seccion, id_sector, nro_sala) REFERENCES sala(id_seccion,id_sector,nro_sala),
CONSTRAINT fk3_asignacion_empleado FOREIGN KEY (id_empleado) REFERENCES Empleado(id_empleado),
CONSTRAINT fk4_asignacion_medico FOREIGN KEY (matricula) REFERENCES medico(matricula)
)

--prueba
declare curPublicaciones cursor
	for
		select title, type, price
		from titles 
		order by type, title
		for read only

open curPublicaciones

Set NoCount On

Declare @type char (12),
		@price money,
		@title varchar(80),
		@cad varchar(40)

print 'Titulo					Precio'
print '-------------------------------'

fetch next
	from curPublicaciones
	into @title, @type, @price

while @@fetch_status =0
begin
	IF @type = 'businees'
	begin
		SELECT @PRICE = @PRICE*1.25
	END
	if @price is null
	begin
		select @cad = convert(char(22),@title) + ' No posee precio '
		end
	else 
		begin
		select @cad = convert(char(22), @title) + convert(char(7), @price)
	 end

	PRINT @cad

	fetch next
		from curPublicaciones
		into @title, @type, @price
end

Close curPublicaciones
deallocate curPublicaciones


--Prueba 2
declare curPub cursor
for select title from titles

declare @title varchar(80)

open curPub
fetch next
	from curPub
	into @title

while @@FETCH_STATUS =0
begin
	if @title = 'The gourmet Microwave'
	begin
		update titles
			set title = title + ' parte II'
			where current of curPub
	end
	fetch next
		from curPub
		into @title
end

close curPub
deallocate curPub


--Ejercicio 1
select title, price, pub_id from titles where pub_id = '0736' order by price

declare cursorPub cursor
for 
	select price 
		from titles
		where pub_id = '0736'
declare @precio money

open cursorPub
fetch next
	from cursorPub
	into @precio

while @@FETCH_STATUS =0
begin
	if @precio <= 10
	begin
		update titles
			set price = price*1.25
			where current of cursorPub
	end
	else begin
		update titles
		set price = price*0.75
		where current of cursorPub		
	end

	fetch next
		from cursorPub
		into @precio

end

close cursorPub
deallocate cursorPub

--Ejercicio 2
select title, ytd_sales, type, price from titles

declare curPub cursor
for 
	select ytd_sales, type, price ,title
	from titles

declare @cantidad_ventas int, @tipo varchar(40), @costo money, @titulo varchar(80)
open curPub

fetch next
	from curPub
	into @cantidad_ventas, @tipo, @costo, @titulo

while @@FETCH_STATUS=0
begin
	if @cantidad_ventas > 1000
	begin
		update titles
			set price = price * 0.9
			where current of curPub	
	end
	else
	begin
		if (@tipo = 'popular_comp' or @titulo like '%computer%')
		begin
			update titles
			set price = price*0.5
			where current of curPub	
		end
		else
		begin
			update titles
			set price = price*0.75
			where current of curPub	
		end
	end
	fetch next
		from curPub
		into @cantidad_ventas, @tipo, @costo, @titulo
end
close curPub
deallocate curPub


select title, ytd_sales, type, price from titles
