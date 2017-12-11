SELECT au_lname, au_fname, address, city
	INTO #tempoauthors
	FROM authors
	WHERE state = 'CA'