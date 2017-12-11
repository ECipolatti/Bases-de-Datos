SELECT au_lname "Apellido", au_fname "Nombre", T.title "Titulo"
	FROM authors A 
	INNER JOIN titleauthor TA
			ON A.au_id = TA.au_id
	INNER JOIN titles T
			ON T.title_id = TA.title_id
	ORDER BY A.au_lname 