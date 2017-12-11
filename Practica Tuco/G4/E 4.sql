DECLARE @error varchar(10)
SET @error = @@ERROR
PRINT 'El ultimo codigo de error ejecutado por SQL fue '  + @error 

--Otra forma
/*DECLARE @error smallint
SET @error = @@ERROR
PRINT 'El ultimo codigo de error ejecutado por SQL fue '  + CONVERT(varchar,@error)*/

--O directamente
PRINT ' El ultimo codigo de error registrado fue: ' + convert(varchar,@@error)