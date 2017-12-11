SELECT P.pub_name "Nom Editorial", E.fname "Nom. Emp", E.lname "Ape. Emp"
	FROM publishers P
	INNER JOIN employee E
		ON P.pub_id = E.pub_id
WHERE E.job_lvl >= 200

/*En la primer linea no es necesario aclarar la columna con el alias
P.pub_name o E.fname...porque no hay ambiguedad*/