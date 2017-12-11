--Ejercicio 1
create trigger informa_error
	on cliente
	for insert, delete
	as 
		Raiserror('%d Filas afectadas',10,1,@@rowcount)
sp_help cliente

insert into cliente values(1212,'Cipolatti','Edgardo','ameghi','9999')

--Ejercicio 2
sp_help sysobjects

--Ejercicio 3
select * from sysobjects where instrig <>0 or updtrig <>0 or deltrig<>0

--Ejercicio 4
sp_helptext employee_insupd

--Ejercicio 5
select * 	into Autores from authors

create trigger autores_t
	on Autores
	for insert, update,delete
	as Raiserror('%d Filas afectadas',10,1,@@rowcount)

delete from Autores where au_id='172-32-1176'
delete from Autores where au_id='213-46-9815'

--Ejercicio 6
CREATE TRIGGER tr_autores_iu
ON autores
FOR insert, update, delete
AS
	IF EXISTS (SELECT * FROM INSERTED) --si hay filas afectadas
		BEGIN
			PRINT ('Datos insertados en transaction log: ')
			SELECT * --muestro las filas de la tabla inserted
			FROM INSERTED
		END
	IF EXISTS (SELECT * FROM DELETED) 
		BEGIN
			PRINT ('Datos eliminados en transaction log: ')
			SELECT *
			FROM DELETED
		END



insert autores
values('111-11-1111', 'Lynne', 'Jeff', '415 658-9932',
'Galvez y Ochoa', 'Berkeley', 'CA', '94705', 1)

update autores
set au_fname = 'Nicanor' where au_id = '111-11-1111'

--Ejercicio 7
create trigger tr_productos_iu
	on productos
	for insert, update
	as
		if update(stock)
		begin
			if exists (select stock from inserted where stock <0)
			begin
				raiserror('Error el stock es negativo',16,1)
				rollback transaction
			end
			end

INSERT INTO productos VALUES (100,'Articulo 1',11,-2)			