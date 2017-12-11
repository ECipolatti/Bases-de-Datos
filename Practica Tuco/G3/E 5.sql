/*SELECT fname, lname, hire_date
FROM employee 
WHERE hire_date = (
	SELECT MAX(hire_date)
	FROM employee)*/
 

/*SELECT fname, lname, hire_Date
FROM employee 
WHERE hire_date = (
	SELECT TOP 1 hire_date
	FROM employee
ORDER BY hire_date DESC)*/

/*LO PUEDO HACER DIRECTAMENTE USANDO UN SOLO SELECT*/
/*SELECT TOP 1 fname, lname, hire_date
FROM employee
ORDER BY hire_date  DESC*/
