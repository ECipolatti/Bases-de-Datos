DECLARE @precio money
SELECT @precio = price
FROM titles
WHERE title_id = 'BU1111'
	IF @precio < 10
		PRINT 'El precio es menor a 10'
		ELSE 
			IF @precio = 10
				PRINT 'EL precio es igual a 10'
			ELSE 
				PRINT 'EL precio es mayor a 10'

--usando el begin y end
IF(@precio< 10) 
		begin PRINT 'El precio es menor a 10' end
	    ELSE
			IF (@precio=10)
			begin PRINT 'El precio es igual a 10' end
				ELSE
				begin PRINT 'El precio es mayor a 10' end

				

