CREATE PROC sp_ObtenerPrecio
	AS
		SELECT price
		FROM titles
		WHERE title_id = 'PS2091'
	RETURN

EXEC sp_ObtenerPrecio