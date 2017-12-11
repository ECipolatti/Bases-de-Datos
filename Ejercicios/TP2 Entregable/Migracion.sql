
---------PROCEDIMIENTOS ALMACENADOS------------------

create proc sp_VerificarEstadoCivil @estacivil varchar(30), @estadocivil varchar(30) OUTPUT AS

	if(@estacivil like '%CA%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%SADO%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%SADA%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%ado%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%ASA%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%CAS%')
	begin
		select @estadocivil = 'CASADO'
		return
	end
	if(@estacivil like '%concu%')
	begin
		select @estadocivil = 'UNIDO_DE_HECHO'
		return
	end
	if(@estacivil like '%CONCU%')
	begin
		select @estadocivil = 'UNIDO_DE_HECHO'
		return
	end
	if(@estacivil like '%iad%')
	begin
		select @estadocivil = 'DIVORCIADO'
		return
	end
	if(@estacivil like '%IAD%')
	begin
		select @estadocivil = 'DIVORCIADO'
		return
	end
	if(@estacivil like '%DIV%')
	begin
		select @estadocivil = 'DIVORCIADO'
		return
	end
	if(@estacivil like '%ERA%')
	begin
		select @estadocivil = 'SOLTERO'
		return
	end
	if(@estacivil like '%OLT%')
	begin
		select @estadocivil = 'SOLTERO'
		return
	end
	if(@estacivil like 'olt')
	begin
		select @estadocivil = 'SOLTERO'
		return
	end
	if(@estacivil like 'VDA.')
	begin
		select @estadocivil = 'VIUDO'
		return
	end
	if(@estacivil like '%UD%')
	begin
		select @estadocivil = 'VIUDO'
		return
	end
	if(@estacivil like '%ud%')
	begin
		select @estadocivil = 'VIUDO'
		return
	end
	else
	begin
	select @estadocivil = 'NO_INFORMADO'
	end

	
	return
	go
create proc sp_VerificarTipoDoc @tipdoc varchar(9), @tipodoc varchar(9) OUTPUT as
	if(@tipdoc like '1')
	begin
		select @tipodoc = 'LE'
		return
	end
	if(@tipdoc like '2')
	begin
		select @tipodoc = 'LC'
		return
	end
	if(@tipdoc like '3')
	begin
		select @tipodoc = 'DNI'
		return
	end
	ELSE
		begin
			select @tipodoc='NO_INFORMADO'
			return
			end
GO
create proc sp_VerificarNacionalidad @nacionalidad varchar(20),@nacionalidadO int OUTPUT as
if(@nacionalidad like '%FRAN%')
	begin
		SElECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'FRA')
		return
	end
	if(@nacionalidad like '%ISRA%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'ISR')
		return
	end
	if(@nacionalidad like '%ITALI%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'ITA')
		return
	end
	if(@nacionalidad like '%MEX%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'MEX')
		return
	end
	if(@nacionalidad like '%NORTEA%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'USA')
		return
	end
	if(@nacionalidad like '%PANAM%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'PAN')
		return
	end
	if(@nacionalidad like '%PARAG%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'PRY')
		return
	end
	if(@nacionalidad like '%PERUA%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'PER')
		return
	end
	if(@nacionalidad like '%SUIZ%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'CHE')
		return
	end
	if(@nacionalidad like '%URUG%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'URY')
		return
	end
	if(@nacionalidad like '%BRAS%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'BRA')
		return
	end
	if(@nacionalidad like '%CHI%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'CHL')
		return
	end
	if(@nacionalidad like '%COLOM%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'COL')
		return
	end
	if(@nacionalidad like '%ESPA%')
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'ESP')
		return
	end
	if(@nacionalidad like '%EXTRAN%') --ACÁ SE CONTEMPLA UNA SITUACION ESPECIAL, SE TOMO COMO REGLA DE NEGOCIOS Q TODAS LAS INSERCIONES "RARAS" CORRESPONDIAN A ARGENTINOS. ESTA SITUACION SE DA VARIAS VECES, NO ES ARGENTINO PARA PONERLO COMO DEFAULT PERO ES EXTRANJERO SIN IDENTIFIACION, SE CREO UN PAIS ESPECIAL EN EL NOMENCLADOR PARA ATENDER ESTA NECESIDAD
	begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'XXX')
		return
	end
	else
		begin
		SELECT @nacionalidadO = (SELECT ID FROM PAIS WHERE PAIS_CODIGO LIKE 'ARG')
		return
		end
			
GO


create proc sp_InsertarCuentasAfiliado @documento int , @idafiliado int as

declare cur_cuentas cursor for select fecafiaa, fecafiba, nrocta from #cuentas_validas where nrodoc = @documento  order by fecafiaa asc

open cur_cuentas

declare @fecalta date, @fecbaja date, @contador int,@error int,@codigocuenta int
SET @contador = 1

begin transaction
fetch next from cur_cuentas into @fecalta, @fecbaja,@codigocuenta 

while (@@FETCH_STATUS = 0)
begin
	if(@fecalta is null)
		set @fecalta = CURRENT_TIMESTAMP

	insert into CUENTAS_AFILIADO(FECHA_ALTA,FECHA_BAJA,CODIGO_SISTEMA_ANTERIOR,ITEM,ID_AFILIADO)VALUES
	 (@fecalta,@fecbaja,@codigocuenta,@contador,@idafiliado)
	
	---Verifico errores en inserciones----
	set @error = @@ERROR
	if(@error != 0)
	begin
		rollback transaction
		break
	end
	--------------------------------------

	fetch next from cur_cuentas into @fecalta, @fecbaja,@codigocuenta
	set @contador=@contador+1
end
	
	if(@error = 0)
		commit transaction

close cur_cuentas
deallocate cur_cuentas
return
GO


-----------------------------------------------INSERTA ACTORES--------------------------------------------
select * into #cuentas_null from cuentas C where C.nyap is null
select * into #cuentas_validas from cuentas C where C.nyap is not null
select * into TABLA_LOG from #cuentas_null 
update #cuentas_validas set fecafiaa=CURRENT_TIMESTAMP where fecafiaa is null
update #cuentas_validas set fechanac=CURRENT_TIMESTAMP where fechanac is null
declare @nombre varchar(20), @apellido varchar(30),
		@domicilio varchar(50),@cp int,@telefono varchar(20),
		@celular varchar(20),@nacionalidad varchar(20),
		@estacivil varchar(30),@fechanac date,
		@sexo varchar(15),@fecafiba date, @error int,
		@estadocivil varchar(30), @tipdoc varchar(9),
		@nacionalidadO varchar(20),@aux int,
		@np varchar(50),@tel varchar(30), @cel varchar(30),
		@fenac date, @error_datos int, @fecalta date, @nrodoc int,
		@fecafiaa date,@nrocta int,@c int



declare cursor_a cursor  for select C.nrodoc,min(C.fecafiaa),min(C.nrocta),max(C.fecafiba) from #cuentas_validas C group by C.nrodoc,C.tipdoc
open cursor_a

fetch next from cursor_a into @nrodoc,@fecafiaa,@nrocta,@fecafiba
set @c=0
while(@@FETCH_STATUS=0)
begin
	--select nrocta, count(*) from #cuentas_validas group by nrocta having COUNT(*)>1
		select @tipdoc = tipdoc, @domicilio = domicilio ,@cp = cp,
		@nacionalidad = nacionalidad,@estacivil = estacivil,
		@sexo = sexo, @nrocta = nrocta FROM #cuentas_validas where nrocta=@nrocta and fecafiaa = @fecafiaa--nrodoc=@nrodoc and fecafiaa = @fecafiaa and 
		
		
		--Obtener telefonos
		
		select @aux =  len(telefono) from cuentas where (nrodoc = @nrodoc) and len(telefono)>=7  group by telefono
		select @telefono = telefono from cuentas where len(telefono)=@aux and nrodoc = @nrodoc
			
		select @aux =  len(celular) from cuentas where (nrodoc = @nrodoc) and len(celular)>=9  group by celular
		select @celular = celular from cuentas where len(celular)=@aux and nrodoc = @nrodoc


						
		--codigo para obtener el id de nacionalidad
		exec sp_VerificarNacionalidad @nacionalidad ,@nacionalidadO OUTPUT	

		--select @fecafiba = max(fecafiba) from #cuentas_validas where @nrodoc= nrodoc 
		insert into ACTOR (ALTA,BAJA,TELEFONO_PRINCIPAL,MOVIL_PRINCIPAL,CODIGO,ID_PAIS) 
			VALUES(@fecafiaa,@fecafiba,@telefono,@celular,@nrocta,@nacionalidadO)
		if(@@ERROR != 0)
			begin
				SELECT * FROM ACTOR
				RAISERROR ('fallo insercion en actor',16,1,@@error)
				break
		end
		
		fetch next from cursor_a into @nrodoc,@fecafiaa,@nrocta,@fecafiba
		set @c=@c+1
end --- fin whilee

if(@@ERROR =0)
	print 'exito'
else
	print 'ocurrio un error'

close cursor_a
deallocate cursor_a
go

--------------------------------------------- INSERTA PERSONA FISICA-------------------------------------------------
declare @nombre varchar(20), @apellido varchar(30),
		@domicilio varchar(50),@cp int,@telefono varchar(30),
		@celular varchar(30),@nacionalidad varchar(20),
		@estacivil varchar(30),@fechanac date,
		@sexo varchar(15),@fecafiba date, @error int,
		@estadocivil varchar(30), @tipdoc varchar(9),
		@nacionalidadO varchar(20),@aux int,
		@np varchar(50),@tel varchar(30), @cel varchar(30),
		@fenac date, @error_datos int, @fecalta date, @nrodoc int,
		@fecafiaa date,@nrocta int,@c int,@id_actor int,@nyap varchar(100),
		@tipodoc varchar(30)
		
declare cursor_a cursor for select codigo,ALTA,id from Actor
open cursor_a
begin transaction
fetch next from cursor_a into @nrocta,@fecafiaa,@id_actor
while @@FETCH_STATUS=0 
begin
	select @tipdoc = tipdoc,@nrodoc=nrodoc,@nyap=nyap,
			@nacionalidad = nacionalidad,@estacivil = estacivil,
			@sexo = sexo, @nrocta = nrocta,@fechanac=fechanac FROM #cuentas_validas 
			where nrocta=@nrocta--nrodoc=@nrodoc and fecafiaa = @fecafiaa and 
	if(@sexo NOT IN ('MASCULINO', 'FEMENINO'))
		begin
			set @sexo = 'NO_INFORMADO'
		end
	--falta checkear que el numero doc y el tipo
    ------------SEPARACION nyap EN APELLIDO Y NOMBRE--------------------
	set @nombre = SUBSTRING(@nyap, 1, charindex(' ', @nyap) - 1)
	set @apellido = SUBSTRING(@nyap, charindex(' ', @nyap), len(@nyap))
	--------------------------------------------------------------------
	if @fechanac is null
		print @fechanac
	
	
	execute sp_VerificarTipoDoc @tipdoc, @tipodoc OUTPUT
	set @tipdoc=@tipodoc
		
	--si  existe esa persona ya no la vuelvo a cargar
	if(exists (select * from PERSONA_FISICA P where P.NRO_DOCUMENTO=@nrodoc and P.TIPO_DOCUMENTO=@tipdoc))
	begin
		fetch next from cursor_a into @nrocta,@fecafiaa,@id_actor
		continue
	end	
	insert into PERSONA_FISICA(SEXO,APELLIDO,NOMBRE,FECHA_NACIMIENTO,FECHA_FALLECIMIENTO,ESCOLARIDAD_ACTUAL,
	TIENE_DISCAPACIDAD,NRO_DOCUMENTO,TIPO_DOCUMENTO,ID_ACTOR,ID_ESTADO_CIVIL_PERSONA)
	 values (@sexo,@apellido,@nombre,@fechanac,null,'NO_INFORMADO',0,@nrodoc,@tipdoc,@id_actor,null)

	---Verifico errores en inserciones----
	if(@@ERROR != 0)
	begin
		RAISERROR ('fallo insercion en persona_fisica',16,1,@@error)
		break
	end

	fetch next from cursor_a into @nrocta,@fecafiaa,@id_actor
end

if(@@ERROR =0)
	begin
		commit transaction
		print 'exito cargar Persona Fisica'
	end
else
	begin
		rollback transaction
		print 'ocurrio un error en Persona Fisica'
	end
close cursor_a
deallocate cursor_a

go


----------------------------------------------- INSERTA ESTADO CIVIL--------------------------------------------
declare @estacivil varchar(15),@estadocivil varchar(15),@id_persona_fisica int,
		@fecafiaa date

declare cursor_a cursor for (select P.id, C.estacivil,C.fecafiaa from PERSONA_FISICA P inner join Actor A on P.id_actor=A.id
																inner join  #cuentas_validas C on A.codigo=C.nrocta)
open cursor_a
fetch next from cursor_a into @id_persona_fisica,@estacivil,@fecafiaa
while( @@FETCH_STATUS=0)
begin


	print 'holaaa'				

	------VERIFICO ESTADOCIVIL-----------
	exec sp_VerificarEstadoCivil @estacivil, @estadocivil OUTPUT
		------------------------------------
	------INSERTO ESTADO CIVIL---------
	insert into ESTADO_CIVIL_PERSONA(FECHA_DESDE,FECHA_HASTA,ESTADO,ITEM,ID_PERSONA_FISICA) values 
	(@fecafiaa,null,@estadocivil,1,@id_persona_fisica)
	-----------------------------------

		---Verifico errores en inserciones----
	if(@@ERROR != 0)
	begin
		RAISERROR ('fallo insercion en estado_civil_persona',16,1,@@error)
		break
	end
    ---------------------------------------
	
	UPDATE PERSONA_FISICA  SET
	ID_ESTADO_CIVIL_PERSONA  = (select ID from ESTADO_CIVIL_PERSONA P where P.ID_PERSONA_FISICA=@id_persona_fisica)
						where id= @id_persona_fisica
	

	fetch next from cursor_a into @id_persona_fisica,@estacivil,@fecafiaa
end
if(@@ERROR =0)
	begin
		print 'exito cargar Estado Civil'
	end
else
	begin
		print 'ocurrio un error en Estado Civil'
	end
close cursor_a
deallocate cursor_a

go	


------------------------------------------INSERTAR AFILIADOS SIN ESTADOS-----------------------------------------------
declare cur_PersFisica cursor for select PF.ID, NRO_DOCUMENTO, CODIGO, ALTA, BAJA FROM PERSONA_FISICA PF INNER JOIN ACTOR A ON PF.ID_ACTOR = A.ID

OPEN cur_PersFisica

declare @PFID int, @nrodoc int, @nrocta int, @fecafiaa date, @fecafiba date, @error int
set @error = 0

begin transaction --EL BEGIN SIEMPRE VA SOBRE EL PRIMER FETCH
fetch next from cur_PersFisica into @PFID , @nrodoc, @nrocta , @fecafiaa , @fecafiba

while (@@FETCH_STATUS = 0)
begin
	insert into AFILIADO(TIPO_AFILIADO,FECHA_ALTA,FECHA_BAJA,OBSERVACIONES,CODIGO,ID_PERSONA_FISICA,ID_ESTADO_AFILIADO) 
		values('EFECTIVO',@fecafiaa,@fecafiba,null,@nrocta,@PFID,null)
		---Verifico errores en inserciones----
			set @error = @@ERROR
			if(@error != 0)
			begin
				rollback transaction
				break
			end
	fetch next from cur_PersFisica into @PFID , @nrodoc, @nrocta , @fecafiaa , @fecafiba
end

if(@error = 0)
	commit transaction

close cur_PersFisica
deallocate cur_PersFisica




go

--------------------------------------------------- CARGA FAMILIARES--------------------------------------------------------
update Actor set CODIGO=ID
--select * from ACTOR
select *  into #datosfam_null from datosfam D where D.nombre_fam is null or 
					not exists (select * from PERSONA_FISICA P where P.NRO_DOCUMENTO=D.nrodoc ) 
select * into #datosfam_validas from datosfam D where D.nombre_fam is not null and
				exists (select * from PERSONA_FISICA P where P.NRO_DOCUMENTO=D.nrodoc )



update #datosfam_validas set fecnac=CURRENT_TIMESTAMP where fecnac is null

declare @nrodocfam int,@nombre_fam varchar(50),@nrodoc int,@nrodatos int,
		@nombre varchar(30),@apellido varchar(30),@sexo varchar(20),@contador int,
		@fecnac date,@id_actor int
		
set @contador=-1
declare cursor_fam cursor for select nrodocfam,nombre_fam,nrodoc,min(nrodatos) from #datosfam_validas 
										group by nrodocfam,nombre_fam,nrodoc
open cursor_fam
begin transaction
fetch next from cursor_fam into @nrodocfam,@nombre_fam,@nrodoc,@nrodatos
while(@@FETCH_STATUS=0)
begin

	--			select * from ACTOR A inner join PERSONA_FISICA P on A.ID=P.ID_ACTOR where P.NRO_DOCUMENTO=	12565456

	if(exists (select * from ACTOR A inner join PERSONA_FISICA P on A.ID=P.ID_ACTOR where P.NRO_DOCUMENTO=@nrodocfam ))
	begin
		print('ya existia el familiar en actor y por lo tanto en persona')
		
		fetch next from cursor_fam into @nrodocfam,@nombre_fam,@nrodoc,@nrodatos
		continue
	end
	else
		begin
			 
			
		declare @fecha_alta date
		select @fecha_alta=A.FECHA_ALTA from AFILIADO A inner join PERSONA_FISICA P on A.ID_PERSONA_FISICA=P.ID
				where P.NRO_DOCUMENTO=@nrodoc
				
		/*if(@fecha_alta is null)
			begin
				--select @nrodoc
			end
		*/
		insert into ACTOR (ALTA,BAJA,TELEFONO_PRINCIPAL,MOVIL_PRINCIPAL,CODIGO,ID_PAIS) 
			VALUES(@fecha_alta,null,null,null,-1,69)
		if(@@ERROR!=0)
				begin
					Raiserror ('error en la carga de actor',16,1)
					break
				end
		
		------------SEPARACION nyap EN APELLIDO Y NOMBRE--------------------
		set @nombre = SUBSTRING(@nombre_fam, 1, charindex(' ', @nombre_fam) - 1)
		set @apellido = SUBSTRING(@nombre_fam, charindex(' ', @nombre_fam), len(@nombre_fam))
	--------------------------------------------------------------------
		select @id_actor=ID from ACTOR where CODIGO=-1
		update Actor set CODIGO=ID where CODIGO=-1
		select @sexo=sexo,@fecnac=fecnac from #datosfam_validas where nrodatos=@nrodatos
		if(@sexo NOT IN ('MASCULINO', 'FEMENINO'))
		begin
			set @sexo = 'NO_INFORMADO'
		end
		
		if(@nrodocfam is null)
		begin
			set @nrodocfam=(-1)*@contador
			set @contador=@contador-1
		end
		
		
	--	select * from PERSONA_FISICA where NRO_DOCUMENTO=12565456
		
		if(exists (select * from PERSONA_FISICA where NRO_DOCUMENTO=@nrodocfam and TIPO_DOCUMENTO like 'DNI'))
			begin 
				select @nrodocfam
			end
		insert into PERSONA_FISICA(SEXO,APELLIDO,NOMBRE,FECHA_NACIMIENTO,FECHA_FALLECIMIENTO,ESCOLARIDAD_ACTUAL,
			TIENE_DISCAPACIDAD,NRO_DOCUMENTO,TIPO_DOCUMENTO,ID_ACTOR,ID_ESTADO_CIVIL_PERSONA)
			values (@sexo,@apellido,@nombre,@fecnac,null,'NO_INFORMADO',0,@nrodocfam,'DNI',@id_actor,null)
		if(@@ERROR!=0)
			begin
				Raiserror ('error en la carga de Persona_Fisica',16,1)
				
				break
			end
		end
		
		
	-- SI LLEGO HASTA ACA ES POR QUE EXISTIO  EL FAMILIAR O  SE CARGO
	
	
	declare @fecha_a date, @fecha_m date,@fecha_n date,@vinculo VARCHAR(30),@id_p1 int,@id_p2 int
	
	select @fecha_n=fecha_nacimiento from PERSONA_FISICA where NRO_DOCUMENTO=@nrodocfam
	select @fecha_a=Alta from ACTOR A inner join  PERSONA_FISICA P on P.ID_ACTOR=A.ID 
										where Nro_Documento=@nrodoc
	if(@fecha_n<@fecha_a)
	BEGIN
		set @fecha_m=@fecha_n
	end	
	ELSE
	BEGIN
		set @fecha_m=@fecha_a
	END
	
	
	--select * from #datosfam_validas
	select @vinculo=parentesco from #datosfam_validas where nrodatos=@nrodatos 
	
	select @id_p1=ID from PERSONA_FISICA where NRO_DOcumento=@nrodocfam
	select @id_p2=ID from PERSONA_FISICA where NRO_DOcumento=@nrodoc
	INSERT INTO FAMILIARES VALUES(@fecha_m,null,@vinculo,null,-1,
										@id_p1 ,
										@id_p2)
	update FAMILIARES set ITEM=id where ITEM=-1
		
	if(@@ERROR!=0)
				begin
				
					Raiserror ('error en la carga de FAMILIAR',16,1)
					break
				end
		
			
		
	fetch next from cursor_fam into @nrodocfam,@nombre_fam,@nrodoc,@nrodatos
end

if(@@ERROR=0)
	begin
		
		commit transaction
		print('todo bien')
		
	end
else
	begin
		rollback transaction
		print('todo mal')
	end

close cursor_fam
deallocate cursor_fam

go

-------------------------------------------CARGA FAMILIAR AFILIADO------------------------------------------------
declare cursor_fa cursor for select id,ID_PERSONA_FISICA_PERSONA,ID_PERSONA_FISICA_PARIENTE from FAMILIARES

declare @id_persona int, @id_pariente int,@id int,@fecha_alta date,@fecha_baja date
open cursor_fa
begin transaction
fetch next from cursor_fa into @id,@id_persona, @id_pariente
while @@FETCH_STATUS=0
begin 
	
	select @fecha_alta=fecha_alta,@fecha_baja=FECHA_BAJA from AFILIADO A where A.id_Persona_fisica=@id_pariente
	--select fecha_alta from AFILIADO A where A.id_Persona_fisica=17416
	
	
	
	insert into FAMILIAR_AFILIADO values(@fecha_alta,@fecha_baja,null,-1,@id,@id_pariente)
	--select * from FAMILIAR_AFILIADO
	
	if(@@error!=0)
		begin 
			raiserror('ocurrio un error en cargar un Familiar_afiliado',16,1)
			break
		end
	update FAMILIAR_AFILIADO set item=id where ITEM=-1

	fetch next from cursor_fa into @id,@id_persona, @id_pariente 
end

close cursor_fa
deallocate cursor_fa


if(@@ERROR=0)
	begin
		
		commit transaction
		print('todo bien')
		
	end
else
	begin
		rollback transaction
		print('todo mal')
	end


go


-----------------------------------------CARGA CUENTAS DE AFILIADOS------------------------------------------------------

DECLARE CUR_AFILIADOS CURSOR FOR SELECT A.ID, NRO_DOCUMENTO FROM AFILIADO A INNER JOIN PERSONA_FISICA PA ON PA.ID = A.ID_PERSONA_FISICA
OPEN CUR_AFILIADOS

DECLARE @nrodoc int, @idafiliado int

FETCH NEXT FROM CUR_AFILIADOS into @idafiliado, @nrodoc
while (@@FETCH_STATUS = 0)
begin
	exec sp_InsertarCuentasAfiliado @nrodoc , @idafiliado
	
	FETCH NEXT FROM CUR_AFILIADOS into @idafiliado, @nrodoc
end

close CUR_AFILIADOS
DEALLOCATE CUR_AFILIADOS

GO


-------------------------------------INSERCION DE ESTADOS DE AFILIADOS-----------------------------------------

DECLARE CUR_AFILIADOS cursor FOR SELECT ID, FECHA_ALTA, FECHA_BAJA FROM AFILIADO 

OPEN CUR_AFILIADOS

DECLARE @idafiliado int, @fecafiaa date, @fecafiba date, @error int
set @error = 0

BEGIN TRANSACTION
FETCH NEXT FROM CUR_AFILIADOS INTO  @idafiliado, @fecafiaa, @fecafiba

while (@@FETCH_STATUS = 0)
begin

	IF(@fecafiba is null)
	BEGIN
	insert into ESTADO_AFILIADO(FECHA,OBSERVACIONES,SECUENCIA,ESTADO_AFILIADO,ID_AFILIADO) VALUES(@fecafiaa,null,2,'ACTIVO',@idafiliado)
	---Verifico errores en inserciones----
	set @error = @@ERROR
	if(@error != 0)
	begin
		rollback transaction
		break
	end
    ---------------------------------------
	END
	ELSE
		begin
			insert into ESTADO_AFILIADO(FECHA,OBSERVACIONES,SECUENCIA,ESTADO_AFILIADO,ID_AFILIADO) VALUES(@fecafiba,null,5,'BAJA',@idafiliado)
			---Verifico errores en inserciones----
			set @error = @@ERROR
			if(@error != 0)
			begin
				rollback transaction
				break
			end
			---------------------------------------
		end

	FETCH NEXT FROM CUR_AFILIADOS INTO  @idafiliado, @fecafiaa, @fecafiba
end

IF(@error = 0)
	commit transaction

close CUR_AFILIADOS
DEALLOCATE CUR_AFILIADOS

GO

------------------------------------ACTUALIZA LOS AFILIADOS CON SU ESTADO------------------------------------
DECLARE CUR_ESTADO_AFILIADO CURSOR FOR SELECT ID, ID_AFILIADO FROM ESTADO_AFILIADO

OPEN CUR_ESTADO_AFILIADO

declare @id_estado int, @id_afiliado int, @error int
set @error = 0

BEGIN TRANSACTION
fetch next from CUR_ESTADO_AFILIADO into @id_estado, @id_afiliado

while (@@FETCH_STATUS = 0)
begin
	UPDATE AFILIADO SET ID_ESTADO_AFILIADO = @id_estado WHERE ID = @id_afiliado
	---Verifico errores en inserciones----
	set @error = @@ERROR
	if(@error != 0)
	begin
		rollback transaction
		break
	end
    ---------------------------------------
	fetch next from CUR_ESTADO_AFILIADO into @id_estado, @id_afiliado
end

if(@error = 0)
	commit transaction

close CUR_ESTADO_AFILIADO
DEALLOCATE CUR_ESTADO_AFILIADO

GO



------------------------INSERTO PROVINCIAS Y LOCALIDADES--------------------------------------
DROP TABLE PROVINCIA
DROP TABLE LOCALIDAD


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



insert into TIPO_DOMICILIO values(1,'LEGAL')


GO


------INSERCION DE DIRECCION AUTOR 
DECLARE CUR_ACTORES CURSOR FOR SELECT A.ID, NRO_DOCUMENTO FROM ACTOR A INNER JOIN PERSONA_FISICA PF ON  PF.ID_ACTOR = A.ID

OPEN CUR_ACTORES

DECLARE @id_actor int, @documento int, @error int, @aux varchar(120), @domicilio varchar(120), @id_tipo int, @localidad varchar(40), @idlocalidad int

select @id_tipo = ID from TIPO_DOMICILIO

BEGIN TRANSACTION
FETCH NEXT FROM CUR_ACTORES INTO @id_actor, @documento

while (@@FETCH_STATUS = 0)
begin

	select @aux =  max(len(domicilio)) from cuentas where (nrodoc = @documento) and len(domicilio)>=12 group by domicilio
	select @domicilio = domicilio from cuentas where len(domicilio)=@aux and nrodoc = @documento

	select @localidad = localidad from codpost CP inner join cuentas C on C.cp=CP.cp WHERE C.nrodoc=@documento
	select @idlocalidad = ID from LOCALIDAD where DESCRIPCION like @localidad 


	insert into DIRECCION_ACTOR (ITEM,NOMBRE_CALLE_SIN_NOMENCLAR,ID_PAIS,ID_ACTOR,ID_TIPO_DOMICILIO,ID_LOCALIDAD) VALUES(1,@domicilio,(select ID from PAIS WHERE PAIS_CODIGO like 'ARG'),@id_actor,@id_tipo,@idlocalidad)
	---Verifico errores en inserciones----
	set @error = @@ERROR
	if(@error != 0)
	begin
		rollback transaction
		break
	end
    ---------------------------------------
	FETCH NEXT FROM CUR_ACTORES INTO @id_actor, @documento
end

IF(@error = 0)
	COMMIT TRANSACTION

CLOSE CUR_ACTORES
DEALLOCATE CUR_ACTORES

GO


/*----------------------------------------------------------
/ACA ARRANCAN LAS FOREIGN KEY!!!
------------------------------------------------------------*/



alter table ACTOR
   add constraint FK_PAIS2 foreign key (ID_PAIS)
      references PAIS (ID);

alter table AFILIADO
   add constraint FK_PF2 foreign key (ID_PERSONA_FISICA)
      references PERSONA_FISICA (ID);

alter table AFILIADO
   add constraint FK_ESTADO_AFILIADO2 foreign key (ID_ESTADO_AFILIADO)
      references ESTADO_AFILIADO (ID);

alter table CUENTAS_AFILIADO
   add constraint FK_AFILIADO2 foreign key (ID_AFILIADO)
      references AFILIADO (ID);

alter table DIRECCION_ACTOR
   add constraint FK_PAIS3 foreign key (ID_PAIS)
      references PAIS (ID);

alter table DIRECCION_ACTOR
   add constraint FK_LOCALIDAD2 foreign key (ID_LOCALIDAD)
      references LOCALIDAD (ID);

alter table DIRECCION_ACTOR
   add constraint FK_DOMICILIO2 foreign key (ID_TIPO_DOMICILIO)
      references TIPO_DOMICILIO (ID);

alter table DIRECCION_ACTOR
   add constraint FK_actor2 foreign key (ID_ACTOR)
      references ACTOR (ID);

alter table ESTADO_AFILIADO
   add constraint FK_AFILIADO2 foreign key (ID_AFILIADO)
      references AFILIADO (ID);

alter table ESTADO_CIVIL_PERSONA
   add constraint FK_PF2 foreign key (ID_PERSONA_FISICA)
      references PERSONA_FISICA1 (ID);

alter table FAMILIARES
   add constraint FK_PF_persona foreign key (ID_PERSONA_FISICA_PERSONA)
      references PERSONA_FISICA2 (ID);

alter table FAMILIARES
   add constraint FK_PF_pariente foreign key (ID_PERSONA_FISICA_PARIENTE)
      references PERSONA_FISICA3 (ID);

alter table FAMILIAR_AFILIADO
   add constraint FK_FAMILIARES2 foreign key (ID_FAMILIARES)
      references FAMILIARES (ID);

alter table FAMILIAR_AFILIADO
   add constraint FK_AFILIADO4 foreign key (ID_AFILIADO)
      references AFILIADO (ID);

alter table LOCALIDAD
   add constraint FK_PROVINCIA4 foreign key (ID_PROVINCIA)
      references PROVINCIA (ID);

alter table PERSONA_FISICA
   add constraint FK_actor7 foreign key (ID_ACTOR)
      references ACTOR (ID);

alter table PERSONA_FISICA
   add constraint FK_ECP99 foreign key (ID_ESTADO_CIVIL_PERSONA)
      references ESTADO_CIVIL_PERSONA (ID);

ALTER TABLE PERSONA_FISICA ADD CONSTRAINT CK_TipoDoc
    CHECK (NRO_DOCUMENTO in ('DNI','LE','LC','CEDULA','PASAPORTE','NO_INFORMADO'));

ALTER TABLE ESTADO_CIVIL_PERSONA ADD CONSTRAINT CK_EstadoCivil
    CHECK (ESTADO in ('SOLTERO','CASADO','UNIDO_DE_HECHO','SEPARADO','DIVORCIADO','VIUDO','FALLECIDO','NO_INFORMADO'));

ALTER TABLE AFILIADO ADD CONSTRAINT CK_TipoAfiliado
    CHECK (TIPO_AFILIADO in ('VOLUNTARIO','EFECTIVO'));

ALTER TABLE PERSONA_FISICA ADD CONSTRAINT CK_PF_NIVEL_ESCOLARIDAD
    CHECK (ESCOLARIDAD_ACTUAL in ('PRIMARIA','SECUNDARIA','TERCIARIA','UNIVERSITARIA','NO_POSEE','NO_INFORMADO'));

ALTER TABLE PERSONA_FISICA ADD CONSTRAINT CK_Sexo
    CHECK (CreditRating in ('MASCULINO','FEMENINO','NO_INFORMADO'));

ALTER TABLE FAMILIARES ADD CONSTRAINT CK_Parentesco
    CHECK (VINCULO in ('CONYUGE','HIJO','HIJASTRO','A_CARGO','PADRE','NIETO','CONCUBINO','NO_INFORMADO','ABUELO','PADRASTRO','FAMILIAR TUTOR'));



GO




















/*


*/
