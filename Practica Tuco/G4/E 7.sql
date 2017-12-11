DECLARE @error smallint, @precio money

BEGIN TRANSACTION 

UPDATE productos
	SET stock = stock - 5
	WHERE codProd = '100'

SET @error = @@ERROR

IF @error = 0
	BEGIN 
		INSERT INTO detalle (codDetalle, numPed, codProd, cant, precioTot)
			VALUES (1200, 1108,100,5,10)
		SET @error = @@ERROR
		if @error = 0
			BEGIN 
				COMMIT TRANSACTION
			END
		ELSE
			ROLLBACK TRANSACTION 
	END
ELSE
	ROLLBACK TRANSACTION 
GO