/*CREATE VIEW vista_Titulos AS
	SELECT *
	FROM titles 
	WHERE pub_id = '0736'*/


SELECT A.au_lname + A.au_fname, VT.title
FROM authors A
INNER JOIN titleauthor TA
	ON A.au_id = TA.au_id
INNER JOIN vista_Titulos VT
	ON VT.title_id = TA.title_id

