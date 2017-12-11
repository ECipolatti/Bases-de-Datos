/*CREATE TABLE t1 
(
ID			int		identity(1,1), 
FechaHora	datetime	NOT NULL DEFAULT CURRENT_TIMESTAMP
)
GO */

DECLARE @c int
SET @c = 0
WHILE @c<100
	BEGIN
	INSERT INTO t1 (FechaHora)
	VALUES (DEFAULT)
	SET @c = @c + 1
	END
GO

SELECT ID, FechaHora
FROM t1
ORDER BY ID ASC
