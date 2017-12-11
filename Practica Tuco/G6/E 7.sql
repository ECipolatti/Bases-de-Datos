CREATE PROC sp_VerVenta (
			@stor_id	varchar(60),
			@ord_num	varchar(60),
			@qty		smallint )
	AS
		SELECT ord_Date
		FROM sales
		WHERE stor_id = @stor_id AND ord_num = @ord_num AND qty = @qty
RETURN

EXECUTE sp_VerVenta
		'7067', -- @stor_id
		'P2121', -- @ord_num
		 40 -- @qty

EXECUTE sp_VerVenta
		 @stor_id = '7067',
		 @ord_num = 'P2121',
		 @qty = 40