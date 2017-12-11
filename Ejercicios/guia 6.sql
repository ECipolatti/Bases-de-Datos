alter proc sp_obtener_precio
(@id varchar(6))
AS
select price from titles where title_id like @id--like 'ps2091'
--return

exec sp_obtener_precio 'ps2091'

exec sp_help sp_obtener_precio

select s.id, s.type from sysobjects s where name like 'sp_obtener_precio'

select name from sysobjects s where s.type like 'p' 


