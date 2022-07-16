-- Clientes que han comprado en total más de 100,000$ en los últimos 12 meses
SELECT CONCAT(A.nombre, ' ', A.apellido), SUM(D.precio) AS precio_actual, 
SUM(B.importe) AS precio_venta FROM clientes AS A
LEFT JOIN ventas AS B ON A.id = B.id_cliente
LEFT JOIN ventas_items AS C ON C.id_venta = B.id
LEFT JOIN productos AS D ON D.id = C.id_producto
GROUP BY 1 HAVING SUM(D.precio) > 100000

-- Productos más vendidos por sucursal en los últimos 12 meses
SELECT DISTINCT sucursal, producto FROM (
SELECT B.sucursal, C.nombre AS producto, COUNT(1) AS cantidad,
ROW_NUMBER() OVER(PARTITION BY B.sucursal, C.nombre) AS row FROM ventas AS A 
LEFT JOIN ventas_items AS B ON B.id_venta = A.id
LEFT JOIN productos AS C ON C.id = B.id_producto
ORDER BY 2 DESC) AS tabla 
WHERE row = 1

-- Productos que se hayan vendido por debajo del precio actual en los últimos 30 días (precio_venta < precio_actual).
SELECT DISTINCT D.nombre AS producto FROM ventas AS B
LEFT JOIN ventas_items AS C ON C.id_venta = B.id
LEFT JOIN productos AS D ON D.id = C.id_producto
WHERE CAST(D.fecha AS DATE) > DATE_SUB(CAST(NOW() AS DATE), INTERVAL 30 DAY) AND D.precio < C.importe

-- Promedio de ventas($) en los últimos 12 meses
SELECT 
CONCAT(MONTH(fecha), '/', YEAR(fecha)) AS mes,
AVG(importe) AS promedio
FROM ventas


