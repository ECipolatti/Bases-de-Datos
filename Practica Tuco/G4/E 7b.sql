/*DE ESTA MANERA ME ASEGURO DE MODIFICAR LAS DOS O NINGUNA
	ES DECIR QUE SI NO HAY PROD CON COD 100 NO HAGO NADA*/
BEGIN TRANSACTION
DECLARE @codigo integer, @cantidad integer

SELECT @codigo = codProd
FROM productos
WHERE codProd = 100

if (@codigo !=NULL)
BEGIN
	UPDATE productos 
		SET stock = stock -5
		WHERE codProd = '100'

	INSERT INTO detalle (codDetalle, numPed, codProd, cant, precioTot)
	VALUES (1200, 1108,100,5,10)

END
IF( @@ERROR = 0) COMMIT --si no hay errores guardo los cambios en "detalle"
	ELSE ROLLBACK
GO