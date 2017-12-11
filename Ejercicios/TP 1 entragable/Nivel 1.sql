


--nivel 1
create table Provincia (
	id int not null,
	codigo_provincia smallint not null,
	nombre_provincia char(30) not null,
constraint pk_provincia primary key(id),
constraint u_provincia_codigo_provincia unique (codigo_provincia)

);

create table Persona (
	id int not null,
	identificativo_de_persona int not null,
	telefonos char(40) null,
	email char(70) null,

constraint pk_persona primary key(id),
constraint u_persona_identificativo_de_persona unique (identificativo_de_persona)
);


create table Tipo_de_domicilio (
	id int not null,
	codigo_de_tipo_de_domicilio char(1) not null,
	nombre_del_tipo_de_domicilio char(15) not null,
constraint pk_tipo_de_domicilio primary key(id),
constraint u_tipo_de_domicilio_cogido_de_tipo_de_domicilio unique (codigo_de_tipo_de_domicilio)
);

create table Tipo_de_articulo (
	id int not null,
	codigo_de_tipo smallint not null ,
	nombre_de_tipo char(20) not null,
	observaciones varchar(255) null,

constraint pk_Tipo_de_articulo primary key(id),
constraint u_tipo_de_acrticulo_codigo_de_tipo unique (codigo_de_tipo)

);
