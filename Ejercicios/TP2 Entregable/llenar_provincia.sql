create proc llenar_provincia
as

declare curprov cursor
	for select provincia from codpost group by provincia order by provincia

declare @nombreprov varchar(50)

open curprov
fetch next
	from curprov
	into @nombreprov

begin transaction
while @@fetch_status=0
begin
	Insert into Integrador2.dbo.PROVINCIA values(@nombreprov,NULL)
	if (@@ERROR=0)
		commit
	else rollback
	fetch next
		from curprov
		into @nombreprov
end

close curprov
deallocate curprov

declare curprovcod cursor
	for select id from Integrador2.dbo.provincia
	for update
declare @cod tinyint

begin transaction
open curprovcod
fetch next
	from curprovcod
	into @cod

while (@@FETCH_STATUS=0)
begin
	update Integrador2.dbo.provincia
		set codigo = @cod
		where current of curprovcod
	if (@@error=0)
		commit
	else rollback
	fetch next
		from curprovcod
		into @cod
end
close curprovcod
deallocate curprovcod

return

exec llenar_provincia

