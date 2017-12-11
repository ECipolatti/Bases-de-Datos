/*INSERT productos (codProd, descr, precUnit, stock) VALUES (10, 'Articulo 1', $50, 20)
INSERT productos (codProd, descr, precUnit, stock) VALUES (10, 'Articulo 2', $70, 40)

CREATE PROCEDURE sp_BuscarPrecio (
	@CodProd int, -- Parametro de entrada
	@PrecUnit money OUTPUT) -- Parametro de salida
 AS
	SELECT @PrecUnit = PrecUnit
	FROM Productos
	WHERE CodProd = @Codprod
 RETURN

 DECLARE @PrecioObtenido MONEY
 EXECUTE sp_BuscarPrecio 10, @PrecioObtenido OUTPUT
 SELECT @PrecioObtenido "Par. de salida"

 CREATE PROCEDURE sp_InsertaDetalle(
		@CodDetalle int,	-- Parametro de entrada a sp_InsertaDetalle
		@NumPed int,		-- Parametro de entrada a sp_InsertaDetalle
		@CodProd int,		-- Parametro de entrada a sp_InsertaDetalle y al inner proc
		@Cant int)			-- Parametro de entrada a sp_InsertaDetalle
 AS
	DECLARE @PrecioObtenido MONEY --Parametro de salida del inner procedure
	EXECUTE sp_BuscarPrecio @CodProd, @PrecioObtenido OUTPUT
	INSERT Detalle Values(@CodDetalle, @NumPed, @CodProd, @Cant, @Cant * @PrecioObtenido)

	If @@RowCount = 1
		PRINT 'Se inserto una fila'
 RETURN
 */

 EXECUTE sp_InsertaDetalle '1540','140','10',2