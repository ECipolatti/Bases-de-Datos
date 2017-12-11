select * from ventas
exec sp_help ventas
select user_name()

--Ejercicio 9
update cliente set dir= 'the crystal mathod 168' where not patindex('%1%', dir) = 0
select * from cliente

--Ejercicio 10
Update cliente set codPost = default
select * from cliente

--Ejercicio 11
select * from clistafe
delete clistafe where codPost is null

--Ejercicio 12
create table #Tempi(
	codcli int not null,
	ape varchar(30) not null
)
select * from #Tempi

--Ejercicio 13
select au_lname, au_fname, address, city 
into #Temptable 
from authors
where state in ('CA')

select * from #Temptable
select * from authors where state in ('CA')