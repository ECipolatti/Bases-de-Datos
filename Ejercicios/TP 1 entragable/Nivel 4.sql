--Nivel 4
create table Detalle_factura_de_compra(
	id int not null,
	id_articulo_de_provedor int not null,
	id_factura_de_compra int not null,
	cantidad_comprada smallint not null,
	precio_de_compra float not null default (15.2),




constraint pk_detalle_factura_de_compra_id primary key(id),
constraint u_detalle_factura_de_compra_id_articulo_de_provedor_id_factura_de_compra unique(id_articulo_de_provedor,id_factura_de_compra),
constraint fk_detalle_factura_de_compra_articulo_de_provedor foreign key (id_articulo_de_provedor) references Articulo_de_provedor(id),
constraint fk_detalle_factura_de_compra_factura_de_compra foreign key (id_factura_de_compra) references Factura_de_compra(id)
);
create table Detalle_de_fv(
	id int not null,
	id_factura_de_venta int not null,
	id_articulo int not null,
	cantidad_vendida smallint not null,



constraint pk_detalle_de_fv_id primary key(id),
constraint u_detalle_de_fv_id_factura_de_venta_id_articulo unique(id_factura_de_venta,id_articulo),
constraint fk_detalle_de_fv_factura_de_venta foreign key (id_factura_de_venta) references Factura_de_venta(id),
constraint fk_detalle_de_fv_articulo foreign key (id_articulo) references Articulo(id)
);
