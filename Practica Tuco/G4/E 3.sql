DECLARE @Cant smallint
UPDATE ventas
SET cant = Cant + 100,
@cant = cant
WHERE codvent = 1

Select @cant
GO