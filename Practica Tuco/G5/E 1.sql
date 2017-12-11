DECLARE curPubl CURSOR
	FOR
		SELECT price
		FROM publishers P 
		INNER JOIN titles T
			ON P.pub_id = T.pub_id
			WHERE P.pub_id = '0736'

OPEN curPubl

DECLARE @precio money

FETCH NEXT
	FROM curPubl
	INTO @precio

WHILE @@FETCH_STATUS = 0
	BEGIN 
		IF @precio <= 10
			BEGIN 
				UPDATE titles
					SET price = price *1.25
					WHERE CURRENT OF curPubl
			END
		ELSE
			BEGIN 
				UPDATE titles
					SET price = price * 0.75
					WHERE CURRENT OF curPubl
			END
		FETCH NEXT
			FROM curPubl
			INTO @precio
	END

CLOSE curPubl
DEALLOCATE curPubl
GO
