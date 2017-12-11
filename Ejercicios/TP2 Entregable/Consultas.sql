
----------------------CONSULTA 1----------------------------------------------------
select top 1 count(C.ID_AFILIADO) 'ID del afiliado' from Cuentas_Afiliado C
	inner join Afiliado A
	on A.id=C.id_afiliado
	where not exists(select C.fecha_baja from Cuentas_Afiliado where fecha_baja is not null)									
	order by 'ID del afiliado' desc



----------------------CONSULTA 2----------------------------------------------------
--Listado de afiliados que tienen como familiar a otro afiliado.


SELECT FA.ID_AFILIADO FROM FAMILIAR_AFILIADO FA 
		inner JOIN FAMILIARES F 
			ON FA.ID_FAMILIARES=F.ID 
		INNER JOIN PERSONA_FISICA PF 
			ON F.ID_PERSONA_FISICA_PERSONA=PF.ID 
		WHERE PF.ID = (SELECT PF2.ID FROM AFILIADO A2 
								INNER JOIN PERSONA_FISICA PF2 
								ON A2.ID=A2.ID 
								where PF.ID=PF2.ID)


----------------------CONSULTAS DEL EJERCICIO 3----------------------------------------------------
/*-------ACLARACIONES:
Utilizo Procesos almacenados porque necesito mandarle un valor específico.
La consigna no expresa claramente como se para este parametro y no sabía si declarar una variable o no
Por este motivo abajo de cada SP hay un exec y un valor el cuales es el de la localidad en la cual buscar
*/
----------------------CONSULTA 3a----------------------------------------------------
create proc sp_consulta_3a
	@idloc int
	as
	if exists (select id from LOCALIDAD where id=@idloc)
	begin
		select A.id,PF.tipo_documento,PF.nro_documento
		from persona_fisica PF
		inner join 	actor AC
		on AC.id = PF.id_actor
		inner join Direccion_Actor DA
		on DA.id_actor= AC.id
		inner join localidad L
		on DA.id_localidad=L.id
		inner join Afiliado A
		on A.id_persona_fisica=PF.id
		where L.id=@idloc
	end
	else
	begin
		print('No existe nadie cargado en esa localidad')
	end
return

--exec sp_consulta_3a 2
----------------------CONSULTA 3b----------------------------------------------------
create proc sp_consulta_3b
	@idloc int
	as
if exists (select id from LOCALIDAD where id=@idloc)
	begin
		select A.id,PF.apellido, PF.nombre from persona_fisica PF
		inner join 	actor AC
		on AC.id = PF.id_actor
		inner join Direccion_Actor DA
		on DA.id_actor= AC.id
		inner join localidad L
		on DA.id_localidad=L.id
		inner join Afiliado A
		on A.id_persona_fisica=PF.id

		where L.id=@idloc
	end
	else
	begin
		print('No existe nadie cargado en esa localidad')
	end
return
--exec sp_consulta_3b 3
----------------------CONSULTA 3c----------------------------------------------------
create proc sp_consulta_3c
	@idloc int
	as
if exists (select id from LOCALIDAD where id=@idloc)
	begin
		select A.id,ECP.estado from Estado_Civil_Persona ECP
		inner join Persona_Fisica PF
		on ECP.id_persona_fisica= PF.id
		inner join 	actor AC
		on AC.id = PF.id_actor
		inner join Direccion_Actor DA
		on DA.id_actor= AC.id
		inner join localidad L
		on DA.id_localidad=L.id
		inner join Afiliado A
		on A.id_persona_fisica=PF.id

		where L.id=@idloc
	end
	else
	begin
		print('No existe nadie cargado en esa localidad')
	end
return
--exec sp_consulta_3c 3
----------------------CONSULTA 3d----------------------------------------------------
create proc sp_consulta_3d
	@idloc int
	as
if exists (select id from LOCALIDAD where id=@idloc)
	begin
		select A.id, count(FA.id) from Familiar_Afiliado FA
		inner join Afiliado A
		on FA.id_afiliado= A.id
		inner join Persona_Fisica PF
		on A.id_persona_fisica=PF.id
		inner join 	actor AC
		on AC.id = PF.id_actor
		inner join Direccion_Actor DA
		on DA.id_actor= AC.id
		inner join localidad L
		on DA.id_localidad=L.id
		
		where L.id=@idloc
	end
	else
	begin
		print('No existe nadie cargado en esa localidad')
	end
return
--exec sp_consulta_3d 3
----------------------CONSULTA 3e----------------------------------------------------
create proc sp_consulta_3e
	@idloc int
	as
if exists (select id from LOCALIDAD where id=@idloc)
	begin
		select A.id, count(FA.id) from Cuentas_Afiliado CA
		inner join Afiliado A
		on CA.id_afiliado= A.id
		inner join Persona_Fisica PF
		on A.id_persona_fisica=PF.id
		inner join 	actor AC
		on AC.id = PF.id_actor
		inner join Direccion_Actor DA
		on DA.id_actor= AC.id
		inner join localidad L
		on DA.id_localidad=L.id
		
		where L.id=@idloc
	end
	else
	begin
		print('No existe nadie cargado en esa localidad')
	end
return

--exec sp_consulta_3e 3