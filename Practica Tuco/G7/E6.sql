/*CREATE TRIGGER tr_autores_iu
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
*/


/*insert autores
values('111-11-1111', 'Lynne', 'Jeff', '415 658-9932',
'Galvez y Ochoa', 'Berkeley', 'CA', '94705', 1)*/

update autores
set au_fname = 'Nicanor' where au_id = '111-11-1111'