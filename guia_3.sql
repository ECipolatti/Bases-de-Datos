select title, pub_name
	from titles inner join publishers
		on titles.pub_id = publishers.pub_id 


select title, T.pub_id, pub_name  
from titles T inner join publishers P
ON T.pub_id = P.pub_id

--Ejercicio 1
select au_lname 'apellido', au_fname 'nombre', title 'título'
from authors 	
	inner join titleauthor 
	ON authors.au_id = titleauthor.au_id
	inner join titles 
	on titles.title_id = titleauthor.title_id
order by au_lname desc

--Ejercicio 2
select pub_name 'nombre editorial', lname 'apellido', fname 'nombre'
from employee E
inner join	publishers P
ON E.pub_id = P.pub_id
where job_lvl >= 200

--Ejercicio 3
select au_lname, au_fname, sum(qty*price) 'Ingresos'
from authors A
inner join titleauthor TA
on TA.au_id = A.au_id
inner join	titles T
on T.title_id = TA.title_id
inner join sales S
ON S.title_id = T.title_id
group by au_lname,au_fname
order by 'ingresos' desc

--Ejercicio 4
select type 'Tipo'
from titles
group by type
having AVG(price) > 12

--Ejercicio 5
select lname 'Apellido' , fname 'Nombre'
from employee
where hire_date = (select max(hire_date) from employee)

--Ejercicio 6
select pub_name 'nombre editorial' from publishers
inner join titles
on publishers.pub_id = titles.pub_id
where titles.type in ('business')
group by pub_name

--Otra opción
select pub_name 'nombre editorial'
from publishers
where pub_id in (select pub_id from titles
						where type in ('business'))

--Ejercicio 7
select title from titles
where title_id not in(select title_id 
						from sales	
						where year(ord_date) in ('1993','1994'))

--Ejercicio 8
select title, pub_name, price from titles T
	inner join publishers P
	ON P.pub_id = T.pub_id
where T.price < (
					select AVG(price) from titles					
					)
order by pub_name desc
--
select title, pub_id, price from titles T
	where price< (select avg(price) from titles D
					where T.pub_id  = D.pub_id)


--Ejercicio 9
select title, titles.title_id	from titles
	where exists (select * from sales
						where sales.title_id = titles.title_id AND Year(ord_date) NOT IN (1993, 1994)
						) OR NOT exists (select * from sales where sales.title_id = titles.title_id)
--Ejercicio 10
select au_fname 'Nombre', au_lname 'Apellido',
	case contract
		when 1 then 'SI'
		else 'NO'
	end 'Posee Contrato?'
	from authors
where state = 'CA'

--Ejercicio 11
select lname 'Apellido', case  
							when  (job_lvl> 100 and job_lvl <200) then 'Puntaje entre 100 y 200'
							when (job_lvl < 100) then 'puntaje menor a 100'
							else 'puntaje mayor a 200' 
					end 'Nivel'
from employee 
order by 'Nivel', lname

--Ejercicio 12
create view Titulos_con_autor as
select au_lname 'Apellido', au_fname 'Nombre', phone 'Telefono', title 'Titulo', type 'Tipo', price 'Precio'
from authors A
inner join titleauthor TA
ON A.au_id = TA.au_id
inner join titles T
ON TA.title_id = T.title_id
where state = 'CA'

--Ejercicio 13
create view Pub_new_moon as
select * from titles T
Where T.pub_id = 0736

select au_fname + ', '+ au_lname 'Nombre y Apellido', P.title 'Titulos' from authors A
inner join titleauthor T
ON A.au_id = T.au_id
inner join Pub_new_moon P
ON T.title_id = P.title_id