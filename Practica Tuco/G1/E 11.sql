SELECT lname "Apellidos", hire_date "Fecha"
FROM employee
WHERE hire_date  BETWEEN  '01/01/91' AND '01/01/92'
/*WHERE hire_date NOT BETWEEN  '01/01/91' AND '01/01/92'*/