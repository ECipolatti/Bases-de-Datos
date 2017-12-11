SELECT A.au_lname "Apellido", A.au_fname "Nom", SUM (T.price*S.qty) "Ingresos"
	FROM authors A
	INNER JOIN titleauthor TA
		ON A.au_id = TA.au_id
	INNER JOIN titles T
		ON TA.title_id = T.title_id
	INNER JOIN sales S
		ON T.title_id = S.title_id
	GROUP BY A.au_lname, A.au_fname
	ORDER BY "Ingresos" DESC