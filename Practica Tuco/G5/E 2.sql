SELECT *
FROM titles
GO

DECLARE curPrecio CURSOR
	FOR 
		SELECT title, type, ytd_sales, price
		FROM titles
GO

DECLARE @titulo		 varchar(60),
		@tipo	   	 varchar(20),
		@cantidad	 int,
		@precio		 money

OPEN curPrecio

FETCH NEXT
	FROM curPrecio
	INTO @titulo, @tipo, @cantidad, @precio

WHILE @@FETCH_STATUS = 0
	BEGIN 
		IF @cantidad > 1000
			BEGIN 
				UPDATE titles
					SET price = price * 0.9
					WHERE CURRENT OF curPrecio
			END
		ELSE
			BEGIN 
				IF @tipo = 'popular_comp' OR @titulo LIKE '%computer%'
					BEGIN 
						UPDATE titles
							SET price = price * 0.59
							WHERE CURRENT OF curPrecio
					END
				ELSE
					BEGIN 
						UPDATE titles
							SET price = price * 0.75
							WHERE CURRENT OF curPrecio
					END
			END
	END
CLOSE curPrecio
DEALLOCATE curPrecio
GO

SELECT *
FROM titles
GO

