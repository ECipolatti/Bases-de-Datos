/*CREATE PROCEDURE sp_BuscarPrecio2 (
		@CodProd int, -- Parametro de entrada
		@PrecUnit money OUTPUT) -- Parametro de salida
AS
		SELECT @PrecUnit = PrecUnit
		FROM Productos
		WHERE CodProd = @Codprod
IF @@RowCount = 0
	RETURN 70 -- No se encontro el producto
	IF @PrecUnit IS NULL
	RETURN 71 -- El producto existe pero su precio es NULL
RETURN 0 -- El producto existe y su precio no es NULL


CREATE PROCEDURE sp_InsertaDetalle2 (
		@CodDetalle Int, -- Parametro de entrada a sp_InsertaDetalle2
		@NumPed Int, -- Parametro de entrada a sp_InsertaDetalle2
		@CodProd int, -- Parametro de entrada a sp_InsertaDetalle2 y al inner proc
		@Cant Int) -- Parametro de entrada a sp_InsertaDetalle2
AS
		DECLARE @PrecioObtenido MONEY --Parametro de salida del inner procedure
		DECLARE @StatusRetorno Int
		EXECUTE @StatusRetorno = sp_BuscarPrecio2 @CodProd, @PrecioObtenido OUTPUT
	IF @StatusRetorno != 0
		BEGIN
			IF @StatusRetorno = 70
			RAISERROR ('Codigo de producto inexistente', 16, 1)
		ELSE
			IF @StatusRetorno = 71
				RAISERROR ('El producto %d no posee precio', 16, 1, @CodProd)
			ELSE
				RAISERROR ('Error en el SP sp_BuscarPrecio2', 16, 1)
			RETURN 99
	END
INSERT Detalle Values(@CodDetalle, @NumPed, @CodProd, @Cant,
		@Cant * @PrecioObtenido)
IF @@Error != 0
	RETURN 77
If @@RowCount = 1
	PRINT 'Se inserto una fila'
RETURN 0

*/

EXECUTE sp_InsertaDetalle2 1540, 120, 99, 2