---------------------PROVINCIA---------------------------
create table PROVINCIA 
(
   DESCRIPCION          varchar(60)                    not null,
   CODIGO               tinyint                        null,
   ID                   integer   IDENTITY(1,1)        not null,
   constraint PK_PROVINCIA primary key clustered (ID)
);

---------------------------------------------------------
--AHORA LLENO LA TABLA PROVINCIA
declare curprov cursor
	for select provincia from codpost group by provincia order by provincia

declare @nombreprov varchar(50)
begin transaction
open curprov
fetch next
	from curprov
	into @nombreprov


while @@fetch_status=0
begin
	begin transaction
	Insert into PROVINCIA values(@nombreprov,NULL)
	
	fetch next
		from curprov
		into @nombreprov
	if (@@ERROR=0)
		commit
	else rollback
end

close curprov
deallocate curprov
commit


declare curprovcod cursor
	for select id from PROVINCIA
	for update
declare @cod tinyint

begin transaction
open curprovcod
fetch next
	from curprovcod
	into @cod


while (@@FETCH_STATUS=0)
begin
	begin transaction
	update PROVINCIA
		set codigo = @cod
		where current of curprovcod
	
	fetch next
		from curprovcod
		into @cod
	if (@@error=0)
		commit
	else rollback
end
close curprovcod
deallocate curprovcod
commit
----LA DEJO COMO ESTÄ EN EL ESQUEMA

alter table PROVINCIA
	alter column codigo tinyint not null
alter table PROVINCIA
	add constraint AK_KEY_2_PROVIENC unique (CODIGO)

--select * from PROVINCIA
--drop table PROVINCIA

-----------------LOCALIDAD-------------------------------------------

--drop table localidad

create table LOCALIDAD 
(
   DESCRIPCION          varchar(60)                    not null,
   CODIGO_POSTAL        int		                       null,
   CODIGO               int		                       null,
   ID                   integer    IDENTITY(1,1)       not null,
   ID_PROVINCIA         integer                        null,
   constraint PK_LOCALIDAD primary key clustered (ID)
   --constraint AK_KEY_3_LOCALIDA unique (CODIGO, ID_PROVINCIA)
);


declare curloc cursor
	for select localidad,provincia,cp from codpost

declare @nombreloc varchar(60)
declare @nombreprovi varchar(50) ---- esta definida arriba
declare @codp varchar(50)

begin transaction
open curloc
fetch next
	from curloc
	into @nombreloc, @nombreprovi, @codp


while @@fetch_status=0
begin
	begin transaction
	if exists(select descripcion from LOCALIDAD where descripcion = @nombreloc)
		begin
			fetch next
			from curloc
			into @nombreloc, @nombreprovi, @codp
		continue
		end
	else
	 
--select * from localidad
	insert into LOCALIDAD values(@nombreloc,@codp,null,null)
	if(@@error=0)
		commit
	else rollback
	fetch next
			from curloc
			into @nombreloc, @nombreprovi, @codp
	
end

close curloc
deallocate curloc
commit
---------------------------------------
declare curloccod cursor
	for select id from LOCALIDAD
	for update
declare @codi int ----- esta definida arriba

begin transaction
open curloccod
fetch next
	from curloccod
	into @codi

while (@@FETCH_STATUS=0)
begin
	begin transaction
	update LOCALIDAD
		set codigo = @codi
		where current of curloccod
	if (@@error=0)
		commit
	else rollback
	fetch next
		from curloccod
		into @codi
end
close curloccod
deallocate curloccod
commit
------------------------------------------------------------------------------------
declare curid cursor
	for select CODIGO_POSTAL,DESCRIPCION from LOCALIDAD
	for update

declare @codpro int
declare @codposloc int
declare @nombrelocalidad varchar(80)
declare @nombrelocalidad2 varchar(80)

begin transaction
open curid
fetch next
	from curid
	into @codposloc,@nombrelocalidad

while (@@FETCH_STATUS=0)
begin
	begin transaction
	select @nombrelocalidad2=provincia from codpost where localidad = @nombrelocalidad and cp= @codposloc
	select @codpro=id from PROVINCIA where DESCRIPCION = @nombrelocalidad2
	update LOCALIDAD
		set id_provincia = @codpro
		where current of curid
	if (@@error=0)
		commit
	else rollback
	fetch next
		from curid
		into @codposloc,@nombrelocalidad
end
close curid
deallocate curid
commit
/*
---------------------------------------
--exec llenar_localidades
use practico2
select * from Integrador2.dbo.LOCALIDAD order by Descripcion
select * from Integrador2.dbo.PROVINCIA 
select * from codpost order by localidad
----------------------------------------
*/


alter table Localidad
	alter column CODIGO int not null
--alter table Localidad
	--alter column CODIGO_POSTAL int not null
alter table Localidad
	alter column ID_PROVINCIA integer not null

alter table Localidad
	add constraint AK_KEY_3_LOCALIDA unique (CODIGO, ID_PROVINCIA)

---------------------------TIPO_DOMICILIO-----------------------------

create table TIPO_DOMICILIO 
(
   CODIGO               smallint                       not null,
   DESCRIPCION          varchar(60)                    null,
   ID                   integer    IDENTITY(1,1)       not null,
   constraint PK_TIPO_DOMICILIO primary key clustered (ID),
   constraint AK_KEY_2_TIPO_DOM unique (CODIGO)
);

insert into TIPO_DOMICILIO values(1,'LEGAL')