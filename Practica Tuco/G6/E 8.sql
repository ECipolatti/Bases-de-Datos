/*CREATE PROC sp_ObtenerPrecio3
			@title_id varchar(20) = NULL 
	AS
		SELECT price
		FROM titles
		WHERE title_id = @title_id
	RETURN
	*/
EXECUTE sp_ObtenerPrecio3 'PS1372'
EXECUTE sp_ObtenerPrecio3 