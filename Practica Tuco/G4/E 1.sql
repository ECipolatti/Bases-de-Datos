SELECT db_name() /*Consulto el contexto actual*/
/*sp_helpdb   /*Averiguo los contextos*/
USE tempdb  /*Cambio el contexto a la base tmpdb*/
SELECT *    /*Hago la consulta sobre authors de pubs*/
FROM pubs.dbo.authors 
USE pubs    /*Vuelvo a pubs*/
*/

/*Otra Forma*/
SELECT db_name()	/*Consulto el contexto actual*/
SELECT name			/*Averiguo los contextos*/
FROM sysdatabases
USE tempdb			/*Cambio el contexto a la base tmpdb*/
SELECT *			/*Hago la consulta sobre authors de pubs*/
FROM pubs.dbo.authors
USE pubs			/*Vuelvo a pubs*/