SELECT pub_id, pub_name
	INTO Editoriales
	FROM publishers
	WHERE city = 'Enzo Francescoli'
	--WHERE pub_id IS NULL 