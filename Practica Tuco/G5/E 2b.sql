
SELECT *
FROM titles
GO

BEGIN TRANSACTION 

DECLARE curTitulos cursor
FOR 
	SELECT price, ytd_sales, type,title
	FROM titles
	for update

DECLARE @precio money, 
		@cantidad integer,
		@tipo char(12),
		@titulo varchar(60)

OPEN curTitulos

FETCH next
	FROM curTitulos
	INTO @precio, @cantidad, @tipo,@titulo

WHILE (@@FETCH_STATUS=0)
begin 
	IF @cantidad > 1000
	begin
		UPDATE titles 
		SET price = @precio*0.9
		WHERE current of curTitulos
	end
		ELSE
		begin
			IF  ( (@tipo = 'popular_comp') OR (@titulo LIKE '%computer%'))
			begin
				UPDATE titles 
				SET price = @precio*0.5
				WHERE current of curTitulos
			end
				ELSE
				begin
					UPDATE titles 
					SET price = @precio*0.75
					WHERE current of curTitulos
				end

		end

	FETCH next
	FROM curTitulos
	INTO @precio, @cantidad, @tipo,@titulo
		
end

CLOSE curTitulos
DEALLOCATE curTitulos


IF(@@ERROR = 0) COMMIT
ELSE ROLLBACK
GO

SELECT *
FROM titles
GO


	
