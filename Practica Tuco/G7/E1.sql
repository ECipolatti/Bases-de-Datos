CREATE TRIGGER TriggerCliente
ON cliente
FOR INSERT,UPDATE
AS
	RAISERROR ('Se modificaron %d filas',16,1,@@rowcount)

INSERT INTO cliente (codCli,ape,nom,dir,codPost)
VALUES (120,'Tome','Jorge','blabla',3142)
