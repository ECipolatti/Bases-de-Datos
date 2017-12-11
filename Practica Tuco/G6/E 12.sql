DECLARE @error smallint

EXECUTE @error = sp_InsertaDetalle '1540','140','10'
SELECT @error