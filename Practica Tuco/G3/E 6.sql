/*SELECT pub_name "Editorial"
FROM publishers P 
	INNER JOIN titles T
		ON P.pub_id = T.pub_id
	WHERE T.type = 'business'
GROUP BY pub_name /*ASI NO REPITE LOS NOMBRES*/*/

SELECT pub_name "Editorial"
FROM publishers P 
	WHERE P.pub_id IN 
				(SELECT T.pub_id
				 FROM titles T
				 WHERE T.type = 'business')
