--Ejercicio 1
select title_id, title, type, price*1.08 from titles order by type,title

--Ejercicio 2
select title_id, title, type, price*1.08 'Precio actualizado' from titles order by type,title

--Ejercicio 3
select title_id, title, type, price*1.08 'Precio actualizado' from titles order by price desc
--Los null son tratados como ceros o los más pequeños en terminos de orden

--Ejercicio 4
select title_id, title, type, price*1.08 'Precio actualizado' from titles order by 4 desc

--Ejercicio 5
select au_lname + ', '+au_fname 'Listado de Autores' from authors order by au_lname

--Ejercicio 7
select title_id + ' posee un valor de $' + convert(varchar(9), price) from titles

--Ejercicio 8
exec sp_tables

--Ejercicio 9
Exec sp_columns authors

--Ejercicio 10
select title,price from titles where not price >13 order by price

--Ejercicio 11
select lname, hire_date from employee where hire_date between '01/01/91' and '01/01/92'

--Ejercicio 12
select au_id 'Codigo', address 'Direccion', city 'Ciudad' from authors where au_id in  ('172-32-1176', '238-95-7766')

--Ejercicio 13
select title_id, title from titles where title like '%computer%'

--Ejercicio 14
select pub_name, city, state from publishers where state is null

--Ejercicio 15
exec sp_columns publishers
		--cualquiera de las dos
exec sp_help publishers

--Ejercicio 16
select count (price) 'Precio sin nulos', count(*) 'Precio con nulos' from titles

--Ejercicio 17
select count (distinct price) 'cantidad de precios diferentes' from titles

--Ejercicio 18
select max (hire_date) from employee
select lname + ', ' + fname 'nombre y apellido' from employee where hire_date >= '01/05/94'
--forma anidada
select lname + ', ' + fname 'nombre y apellido' from employee where hire_date = (
																				select max (hire_date) from employee)
--Otra forma
SELECT TOP 1 lname + ',' + fname "Ape. y Nom", hire_date "Fecha"
FROM employee ORDER BY hire_date DESC

--Ejercicio 19
select sum (ytd_sales*price) from titles

--Ejercicio 20
select sum(qty) 'publicaciones vendidas en junio' from sales where MONTH(ord_date) = 6

--VARIOS
select convert(varchar,ord_date,3) from sales
select title from titles
select patindex('%is%',title) from titles
select substring(title, 1 ,5) from titles

select * from sysobjects
select name from sysobjects where type = 'FK'
select col_length('titles', 'title')
