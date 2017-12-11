SELECT T.title "Titulo", P.pub_name, T.price "Precio"
FROM titles T
	INNER JOIN publishers P
	ON P.pub_id = T.pub_id
WHERE T.price < (
		SELECT AVG(price)
		FROM titles
		)
ORDER BY T.Title DESC