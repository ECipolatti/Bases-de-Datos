
DECLARE curPublicaciones CURSOR
FOR
SELECT title, type, price
	FROM titles
	ORDER BY type, title
	FOR READ ONLY

OPEN curPublicaciones 

Set NoCount On

DECLARE @type Char(12),
@price money,
@title varchar(80),
@Cad varchar(40)

PRINT 'Titulo Precio'
PRINT '---------------------------------------------------'

FETCH next
FROM curPublicaciones
INTO @title, @type, @price


WHILE @@fetch_status = 0
Begin
-- Si el tipo es business, incremento el precio en un 25% (pero solo para mostrarlo)
	IF @type = 'business'
		Select @price = @price * 1.25
-- End If
-- Si el precio es nulo, muestro un mensaje, sino muestro el titulo junto a su precio
	IF @price is Null
		SELECT @Cad = Convert(Char(22), @title) + ' No posee precio '
	ELSE
	SELECT @Cad = Convert(Char(22), @title) + Convert(Char(7), @price)
-- End If
PRINT @Cad

FETCH next
FROM curPublicaciones
INTO @title, @type, @price
END
-- End While
Close curPublicaciones
DEALLOCATE curPublicaciones