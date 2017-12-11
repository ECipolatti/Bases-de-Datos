--Nivel 2
create table Articulo(
	id int not null,
	codigo_de_articulo smallint not null,
	id_tipo_articulo int not null,
	nombre_de_articulo char(20) not null,
	precio int not null,
constraint pk_articulo_id primary key (id),
constraint u_articulo_codigo_de_articulo unique(codigo_de_articulo,id_tipo_articulo),
constraint fk_articulo_tipo_de_articulo foreign key (id_tipo_articulo) references Tipo_de_articulo(id)
);
create table Provedor(
	id int not null,
	codigo_provedor smallint not null,
	observaciones_de_provedor varchar(255) null,
	id_persona int not null,
constraint pk_provedor_id primary key (id),
constraint u_provedor_codigo_provedor unique(codigo_provedor,id_persona),
constraint fk_provedor_persona foreign key (id_persona) references Persona(id)
);
create table Localidad(
	id int not null,
	codigo_postal smallint not null,
	nombre_localidad char(30) not null,
	id_provincia int not null,
constraint pk_localidad_id primary key (id),
constraint u_localidad_codigo_postal unique(codigo_postal),
constraint fk_localidad_provincia foreign key (id_provincia) references Provincia(id)
);
create table Cliente(
	id int not null,
	codigo_cliente smallint not null,
	fecha_de_alta date not null,
	observaciones_de_cliente varchar(255) null,	
	id_persona int not null,
constraint pk_cliente_id primary key (id),
constraint u_cliente_codigo_cliente unique(codigo_cliente, id_persona),
constraint fk_cliente_persona foreign key (id_persona) references Persona(id)
);
create table Persona_Juridica(
	id int not null,
	cuit char(13) not null,
	fecha_inicio date not null,
	razon_social char(40) not null,	
	id_persona int not null,
constraint pk_persona_juridica_id primary key (id),
constraint u_persona_juridica_cuit unique(cuit,id_persona),
constraint fk_persona_juridica_persona foreign key (id_persona) references Persona(id)
);
