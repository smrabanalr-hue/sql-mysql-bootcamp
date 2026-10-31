-- ==============================================================================
-- Ejercicios: Módulo 4
-- ==============================================================================
USE tienda_retail;

-- Reto 4.1:
-- Formatear los números telefónicos de la tabla clientes:
-- Extraer el código de país (primeros 3 caracteres sin signo '+') y los números restantes.
-- Si el cliente no tiene teléfono, mostrar 'SIN_TELEFONO_REGISTRADO' usando COALESCE.

-- Reto 4.2:
-- Generar un reporte de pedidos calculando el tiempo estimado de entrega:
-- Si el canal_venta es 'Tienda Física' -> fecha de entrega es el mismo día (`DATE(fecha_pedido)`).
-- Si es 'Web' -> sumar 48 horas (`DATE_ADD`).
-- Si es 'App Móvil' -> sumar 24 horas.
-- Proyectar: codigo_pedido, fecha_pedido, canal_venta y fecha_estimada_entrega.

-- Reto 4.3:
-- Calcular el margen de rentabilidad de cada producto de forma clasificada:
-- - Si el margen porcentual ((precio - costo) / precio) >= 40% -> 'Alta Rentabilidad'
-- - Si está entre 20% y 39.99% -> 'Rentabilidad Moderada'
-- - Menor a 20% -> 'Margen Crítico'
-- Incluir el cálculo numérico redondeado a 1 decimal.
