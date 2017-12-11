--Nivel 3
create table Articulo_de_provedor(
	id int not null,
	codigo_articulo_provedor char(15) not null,
	id_articulo int null,
	id_provedor int null,

constraint pk_articulo_de_provedor_id primary key(id),
constraint u_articulo_de_provedor_codigo_de_provedor_id_provedor unique(codigo_articulo_provedor,id_provedor),
constraint fk_articulo_de_provedor_articulo foreign key (id_articulo) references Articulo(id),
constraint fk_articulo_de_provedor_provedor foreign key (id_provedor) references Provedor(id)

);
create table Factura_de_compra(
	id int not null,
	id_provedor int not null,
	tipo_factura_de_compra char(1) not null,
	numero_factura_de_compra int not null,
	fecha_factura_de_compra date not null,
	



constraint pk_factura_de_compra_id primary key(id),
constraint u_factura_de_compra_tipo_numero_id_provedor unique(tipo_factura_de_compra,numero_factura_de_compra,id_provedor),
constraint fk_factura_de_compra_provedor foreign key (id_provedor) references Provedor(id)


);
create table Factura_de_venta(
	id int not null,
	id_cliente int not null,
	numero_factura_de_venta int not null,
	fecha_factura_de_venta date not null,	
	tipo_factura_de_venta char(1) not null,


constraint pk_factura_de_venta_id primary key(id),
constraint u_factura_de_venta_numero_tipo unique(numero_factura_de_venta,tipo_factura_de_venta),
constraint fk_factura_de_venta_cliente foreign key (id_cliente) references Cliente(id)

);
create table Pago_a_provedor(
	id int not null,
	id_provedor int not null,
	numero_recibo int not null,
	fecha_de_pago_provedor date not null,
	importe_pagado_al_provedor float not null,
	


constraint pk_pago_a_provedor_id primary key(id),
constraint u_pago_a_provedor_numero_recibo_id_provedor unique(numero_recibo,id_provedor),
constraint fk_pago_a_provedor_provedor foreign key (id_provedor) references Provedor(id)


);
create table Domicilio_de_persona(
	id int not null,
	id_tipo_de_domicilio int not null,
	domicilio char(40) null,
	id_persona int not null,




constraint pk_domicilio_de_persona_id primary key(id),
constraint u_domicilio_de_persona_id_tipo_domicilio_id_persona unique(id_tipo_de_domicilio,id_persona),
constraint fk_domicilio_de_persona_tipo_de_domicilio foreign key (id_tipo_de_domicilio) references Tipo_de_domicilio(id),
constraint fk_domicilio_de_persona_persona foreign key (id_persona) references Persona(id)

);
create table Persona_fisica(
	id int not null,
	id_localidad int not null,
	id_persona int not null,
	tipo_documento char(1) not null,
	num_documento int not null,
	sexo char(1) not null,
	


constraint pk_persona_fisica_id primary key(id),
constraint u_persona_fisica_ unique(tipo_documento,num_documento,id_persona,sexo),
constraint fk_persona_fisica_localidad foreign key (id_localidad) references Localidad(id),
constraint fk_persona_fisica_persona foreign key (id_persona) references Persona(id)



);
create table Integrantes(
	id int not null,
	id_persona_juridica int not null,
	id_persona int not null,
	
	item_integrante smallint not null,
	fecha_incio date not null,
	fecha_fin date null,
	observaciones varchar(255) null,		
	



constraint pk_integrantes_id primary key(id),
constraint u_integrantes_item_inte_id_persona_juridica unique(item_integrante,id_persona_juridica),
constraint fk_integrantes_persona_juridica foreign key (id_persona_juridica) references Persona_juridica(id),
constraint fk_integrantes_persona foreign key (id_persona) references Persona(id)


);
create table Recibo_a_cliente(
	id int not null,
	id_cliente int not null,
	nro_recibo_cliente int not null,
	importe_recibo_cliente float not null default (15.2) ,
	fecha_de_pago_cliente date not null,	




constraint pk_recibo_a_cliente_id primary key(id),
constraint u_recibo_a_cliente__nro_recibo_cliente unique(nro_recibo_cliente),
constraint fk_recibo_a_cliente_cliente foreign key (id_cliente) references Cliente(id)


);