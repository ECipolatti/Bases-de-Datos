DECLARE curPublicaciones Cursor
FOR
	SELECT title
	FROM Titles

DECLARE @title varchar(80)

OPEN curPublicaciones

FETCH Next
FROM curPublicaciones
INTO @title

WHILE @@fetch_status = 0
Begin
	IF @title = 'The Gourmet Microwave Parte II'
	UPDATE titles
	SET title = 'The Gourmet Microwave'
	WHERE CURRENT OF curPublicaciones
-- End If
FETCH Next
From curPublicaciones
Into @title
End
-- End While
Close curPublicaciones
Deallocate curPublicaciones