DECLARE @precio money,
		@codigo char(4)

DECLARE curTitulos CURSOR
	FOR
		SELECT price, pub_id
		FROM titles 
		
			

OPEN curTitulos

FETCH next
	FROM curTitulos
	INTO  @precio, @codigo

WHILE @@FETCH_STATUS = 0
begin
	IF @codigo = '0736'
	begin
	IF @precio <= 10
	begin 
		UPDATE titles
		SET price = @precio*1.25
		WHERE CURRENT OF curTitulos
	end
	ELSE
	begin
		UPDATE titles
		SET price = @precio/1.25
		WHERE CURRENT OF curTitulos
	end
	end
	FETCH next
	FROM curTitulos
	INTO  @precio,@codigo
end

close curTitulos
Deallocate curTitulos