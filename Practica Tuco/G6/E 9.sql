CREATE PROC sp_ObtenerPrecio4
			@title_id varchar(20) = NULL 
	AS
		IF @title_id IS  NULL
				PRINT ' El sp_ObtenerPrecio4 requeire del parametro title_id'
			ELSE 
				BEGIN
					SELECT price
					FROM titles
					WHERE title_id = @title_id
				END
RETURN
EXECUTE sp_ObtenerPrecio4 'PS1372'
EXECUTE sp_ObtenerPrecio4 

--PUEDO CAMBIAR EL PRINT POR UN SELECT, ENTONCES NO QUEDA COMO UN ERROR, SOLO MUESTRA EL MSJ
--SELECT ' El sp_ObtenerPrecio4 requeire del parametro title_id'