/*CREATE PROCEDURE sp_insertaEdit
	AS
		SELECT pub_id, pub_name 
		FROM publishers 
	RETURN
*/

INSERT Editoriales
	EXECUTE sp_insertaEdit

--OTRA FORMA
/*CREATE PROCEDURE sp_insertEditoriales
AS
	INSERT Editoriales
	SELECT *
	FROM publishers
*/
--EXECUTE sp_insertEditoriales
