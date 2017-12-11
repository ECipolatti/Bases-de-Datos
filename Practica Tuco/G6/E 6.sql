CREATE PROC sp_ObtenerPrecio2
			@title_id varchar(20)
	AS
		SELECT price
		FROM titles
		WHERE title_id = @title_id
	RETURN
	
EXECUTE sp_ObtenerPrecio2 'PS1372'