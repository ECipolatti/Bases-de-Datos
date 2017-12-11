select * from cuentas

create table TIPO_DOMICILIO 
(
   CODIGO               smallint                       not null,
   DESCRIPCION          varchar(60)                    null,
   ID                   integer    IDENTITY(1,1)       not null,
   constraint PK_TIPO_DOMICILIO primary key clustered (ID),
   constraint AK_KEY_2_TIPO_DOM unique (CODIGO)
);

insert into TIPO_DOMICILIO values(1,'LEGAL')
