--Insercion de Persona Jurídica
insert into Persona values(1,34123239,'0343-4311561','holamundo@esteesmiemail.com');
insert into Persona_Juridica values(1,'20-10232546','2001-10-05','ONG',1);

--Insercion de 3 facturas de compra
insert into Persona values(2,34623856,'0342-4221023','holamundo2@esteesmiemail.com');
insert into Provedor (id, codigo_provedor,id_persona) values (1,0102,2);
insert into Persona values(3,34625656,'0342-4225269','holamundo3@esteesmiemail.com');
insert into Provedor (id, codigo_provedor,id_persona) values (2,0155,3);
insert into Factura_de_compra values(1,1,'A',2223654,'2014-12-07');
insert into Factura_de_compra values(2,2,'B',2211234,'2013-11-22');
insert into Factura_de_compra values(3,1,'C',9999666,'2014-05-31');

--Insercion de 3 facturas de venta
insert into Persona values(4,34546856,'0342-4221023','holamundo3@esteesmiemail.com');
insert into Persona values(5,33456856,'0342-4555555','holamundo4@esteesmiemail.com');
insert into Persona values(6,22222456,'0342-4666999','holamundo5@esteesmiemail.com');
insert into Cliente values(1,2325,'2011-09-25','Le gustan las gomas caras',4);
insert into Cliente values(2,2222,'2000-09-22','Conductor de carreras',5);
insert into Cliente values(3,6666,'2002-08-19','gato por liebre',6);
insert into Factura_de_venta values(1,2,666758756,'2012-05-22','A');
insert into Factura_de_venta values(2,3,668916528,'2010-04-23','B');
insert into Factura_de_venta values(3,1,734340568,'2001-03-10','C');

--insercion de 3 recibos de pago a clientes
insert into Recibo_a_cliente values(1,2,22223456,222.55,'2012-05-22');
insert into Recibo_a_cliente values(2,3,12123433,123213.94,'2010-04-23');
insert into Recibo_a_cliente values(3,1,12256459,500.00,'2001-03-10');

--insercion de 3 recibos de pago a Proveedores
insert into Pago_a_provedor values(1,1,2223344,'2001-03-10',1000000);
insert into Pago_a_provedor values(2,2,1111343,'2012-09-10',99999.5);
insert into Pago_a_provedor values(3,1,1222203,'2010-06-25',666622);