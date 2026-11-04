-- 02. Carga de los CSV
-- Por cada activo: se vacía stg, se carga el CSV y se copia a precios con su ticker.
-- Cambiar las rutas por las de tu computadora.
USE FinanzasDB;
GO

SET DATEFORMAT mdy;   -- las fechas vienen como mes/día/año
GO

-- SPY
TRUNCATE TABLE stg;
BULK INSERT stg
FROM 'C:\Users\ivan\Desktop\DATOS PROYECTO SQL\spy.csv'
WITH (FIELDTERMINATOR = ';', ROWTERMINATOR = '\n', FIRSTROW = 2);
INSERT INTO precios (ticker, fecha, abierto, maximo, minimo, cierre, volumen)
SELECT 'SPY', fecha, abierto, maximo, minimo, cierre, volumen FROM stg;

-- NVDA
TRUNCATE TABLE stg;
BULK INSERT stg
FROM 'C:\Users\ivan\Desktop\DATOS PROYECTO SQL\nvda.csv'
WITH (FIELDTERMINATOR = ';', ROWTERMINATOR = '\n', FIRSTROW = 2);
INSERT INTO precios (ticker, fecha, abierto, maximo, minimo, cierre, volumen)
SELECT 'NVDA', fecha, abierto, maximo, minimo, cierre, volumen FROM stg;

-- GLD
TRUNCATE TABLE stg;
BULK INSERT stg
FROM 'C:\Users\ivan\Desktop\DATOS PROYECTO SQL\gld.csv'
WITH (FIELDTERMINATOR = ';', ROWTERMINATOR = '\n', FIRSTROW = 2);
INSERT INTO precios (ticker, fecha, abierto, maximo, minimo, cierre, volumen)
SELECT 'GLD', fecha, abierto, maximo, minimo, cierre, volumen FROM stg;
GO

-- Verificación: filas y período por activo
SELECT ticker, COUNT(*) AS filas, MIN(fecha) AS desde, MAX(fecha) AS hasta
FROM precios
GROUP BY ticker;