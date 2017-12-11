
/*SELECT *
	INTO autores
	FROM authors
	*/

/*CREATE TRIGGER triAutores
ON autores
FOR insert, update, delete
AS
RAISERROR ('Se modificaron %d filas',16,1,@@rowcount)

DELETE autores 
	WHERE au_id IN ('172-32-1176', '213-46-8915')
*/

SELECT *
FROM autores
where au_id IN ('172-32-1176', '213-46-8915') --tiene que devolver vacio