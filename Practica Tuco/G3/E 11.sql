SELECT lname "Apellido", 
CASE
	WHEN job_lvl>100 AND job_lvl < 200 THEN 'Puntaje entre 100 y 200'
	WHEN job_lvl>200 THEN 'Puntaje mayor que 200'
	WHEN job_lvl < 100 THEN 'Puntaje menor que 100'
END "Nivel"
FROM employee
ORDER BY lname, job_lvl ASC