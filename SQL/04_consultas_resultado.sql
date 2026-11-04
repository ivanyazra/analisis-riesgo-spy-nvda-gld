-- 04. Resultados
USE FinanzasDB;
GO

-- Resumen por activo
SELECT * FROM vw_resumen;

-- Primeras filas del análisis diario
SELECT TOP 5 * FROM vw_analisis ORDER BY ticker, fecha;