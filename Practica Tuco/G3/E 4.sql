SELECT type "Tipo"
FROM titles
GROUP BY type
HAVING AVG(price) > 12
