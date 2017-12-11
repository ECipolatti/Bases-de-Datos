SELECT TOP 1 lname + ',' + fname "Ape. y Nom", hire_date "Fecha"
FROM employee
GROUP BY lname, fname, hire_date
ORDER BY hire_date DESC

/*TOP 1 = muestra el primero
GROUP BY = lo necesito para la comparacion de las fechas
ORDER BY = ordeno por fecha*/


--OTRA FORMA---
select lname+ ','+ fname  'Ape. y Nom.', hire_date 'Fecha'
from employee
where hire_date = (select  max(hire_date)
				   from employee)