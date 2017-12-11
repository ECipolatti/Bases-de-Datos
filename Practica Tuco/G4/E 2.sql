DECLARE @Mens varchar(40)		--crea la variable 
SET @Mens = 'Just testing...'	--le asigna un valor
SELECT @Mens					--muestra la variable
GO								--ejecuta el batch 

SELECT @Mens					--intenta mostrar la variable pero no puede
GO								--porque es local y finalizo el entorno con el GO anterior