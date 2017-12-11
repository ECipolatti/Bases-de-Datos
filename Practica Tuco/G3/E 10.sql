SELECT au_fname "Nombre", au_lname "Apellido", 
			CASE contract 
				WHEN 1 THEN 'SI'
				ELSE	    'NO'
			END "Posee contrato?"
			
FROM authors
WHERE state = 'CA'