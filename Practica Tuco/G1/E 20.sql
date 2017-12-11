SELECT 'La cantidad vendida en junio es ' +CONVERT(varchar, SUM(qty)) + 'Articulos' "Cantidad"
FROM sales
WHERE MONTH(ord_date) = 6