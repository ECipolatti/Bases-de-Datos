--use practico2
/*use Integrador2
drop table localidad

create table LOCALIDAD 
(
   DESCRIPCION          varchar(60)                    not null,
   CODIGO_POSTAL        int		                       null,
   CODIGO               smallint                       null,
   ID                   integer    IDENTITY(1,1)       not null,
   ID_PROVINCIA         integer                        null,
   constraint PK_LOCALIDAD primary key clustered (ID)
   --constraint AK_KEY_3_LOCALIDA unique (CODIGO, ID_PROVINCIA)
);*/
create proc llenar_localidades
as

declare curloc cursor
	for select localidad,provincia,cp from codpost

declare @nombreloc varchar(60)
declare @nombreprov varchar(50)
declare @codp varchar(50)

open curloc
fetch next
	from curloc
	into @nombreloc, @nombreprov, @codp

begin transaction
while @@fetch_status=0
begin
	if exists(select descripcion from Integrador2.dbo.localidad where descripcion = @nombreloc)
		begin
			fetch next
			from curloc
			into @nombreloc, @nombreprov, @codp
		continue
		end
	else
	 
--select * from localidad
	insert into Integrador2.dbo.localidad values(@nombreloc,@codp,null,null)
	if(@@error=0)
		commit
	else rollback
	fetch next
			from curloc
			into @nombreloc, @nombreprov, @codp
	
end

close curloc
deallocate curloc
---------------------------------------
declare curloccod cursor
	for select id from Integrador2.dbo.localidad
	for update
declare @cod int

begin transaction
open curloccod
fetch next
	from curloccod
	into @cod

while (@@FETCH_STATUS=0)
begin
	update Integrador2.dbo.localidad
		set codigo = @cod
		where current of curloccod
	if (@@error=0)
		commit
	else rollback
	fetch next
		from curloccod
		into @cod
end
close curloccod
deallocate curloccod
------------------------------------------------------------------------------------
declare curid cursor
	for select CODIGO_POSTAL,DESCRIPCION from Integrador2.dbo.localidad
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
	select @nombrelocalidad2=provincia from codpost where localidad = @nombrelocalidad and cp= @codposloc
	select @codpro=id from Integrador2.dbo.provincia where DESCRIPCION = @nombrelocalidad2
	update Integrador2.dbo.localidad
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
---------------------------------------
return
---------------------------------------
--exec llenar_localidades
use practico2
select * from Integrador2.dbo.LOCALIDAD order by Descripcion
select * from Integrador2.dbo.PROVINCIA 
select * from codpost order by localidad
----------------------------------------



alter table Localidad
	alter column CODIGO smallint not null
alter table Localidad
	alter column CODIGO_POSTAL int not null
alter table Localidad
	alter column ID_PROVINCIA integer not null

alter table Localidad
	add constraint AK_KEY_3_LOCALIDA unique (CODIGO, ID_PROVINCIA)
