/*SELECT 'El total de ventas es de $' + CONVERT (varchar, SUM(ytd_sales*price))*/
SELECT SUM(ytd_sales*price)
FROM titles

/*Si le pongo el string 'El total de ...' 
tengo que convertir el precio en varchar*/