/*CREATE TRIGGER tr_productos_iu
ON productos
FOR insert, update
AS
	IF UPDATE (stock)
	begin
		if EXISTS ( SELECT stock
					FROM INSERTED 
					WHERE stock<0
					)
			begin
				RAISERROR('Stock negativo',1,16,1)
				 ROLLBACK TRANSACTION
			end
	end
	*/

INSERT INTO productos (codProd,descr,precUnit,stock)
VALUES (100,'Articulo 1',11,-2)