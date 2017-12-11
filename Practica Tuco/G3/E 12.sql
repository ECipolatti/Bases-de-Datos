CREATE VIEW vista_california AS
	SELECT A.au_lname "Ape", A.au_fname "Nom", A.phone "Tel", T.title Titulo, T.price "Precio"
	FROM authors A
		INNER JOIN titleauthor TA
			ON A.au_id = TA.au_id
		INNER JOIN titles T
			ON TA.title_id = T.title_id
WHERE A.state = 'CA'
