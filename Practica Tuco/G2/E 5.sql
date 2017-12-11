CREATE TABLE ventas
(
codVent		int			IDENTITY(1,1),
fechaVent	date	NOT NULL DEFAULT CURRENT_TIMESTAMP,
UsuarioDB	varchar(30) NOT NULL DEFAULT USER, /*SYSTEM_USER*/
cant		int			NULL
)