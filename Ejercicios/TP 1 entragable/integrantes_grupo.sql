create table Integrantes_Grupo(
	apellidos char(40) not null,
	nombres char(20) not null,

	constraint pk_integrantes_grupo primary key(apellidos,nombres)
);

insert into Integrantes_grupo values ('Cipolatti','Edgardo');
insert into Integrantes_grupo values ('Catena','Ignacio');
insert into Integrantes_grupo values ('Schlimovich','Damian');