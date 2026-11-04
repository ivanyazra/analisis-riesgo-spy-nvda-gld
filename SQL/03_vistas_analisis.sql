-- 03. Vistas de análisis
USE FinanzasDB;
GO

-- Vista diaria: rendimiento, índice base 100 y drawdown
CREATE VIEW vw_analisis AS
WITH base AS (
    SELECT ticker, fecha, cierre,
           LAG(cierre) OVER (PARTITION BY ticker ORDER BY fecha) AS cierre_anterior,
           FIRST_VALUE(cierre) OVER (PARTITION BY ticker ORDER BY fecha) AS cierre_inicial,
           MAX(cierre) OVER (PARTITION BY ticker ORDER BY fecha
                             ROWS UNBOUNDED PRECEDING) AS maximo_acumulado
    FROM precios
)
SELECT ticker, fecha, cierre,
       cierre / cierre_anterior - 1   AS rendimiento_diario,
       cierre / cierre_inicial * 100  AS indice_base_100,
       maximo_acumulado,
       cierre / maximo_acumulado - 1  AS drawdown
FROM base;
GO

-- Vista resumen: métricas por activo
CREATE VIEW vw_resumen AS
WITH ext AS (
    SELECT ticker, MIN(fecha) AS desde, MAX(fecha) AS hasta
    FROM precios
    GROUP BY ticker
),
met AS (
    SELECT ticker,
           STDEV(rendimiento_diario) * SQRT(252) AS volatilidad_anual,
           MIN(drawdown)                         AS drawdown_maximo
    FROM vw_analisis
    GROUP BY ticker
)
SELECT e.ticker, e.desde, e.hasta,
       p_fin.cierre / p_ini.cierre - 1 AS rendimiento_total,
       m.volatilidad_anual,
       m.drawdown_maximo
FROM ext AS e
JOIN precios AS p_ini ON p_ini.ticker = e.ticker AND p_ini.fecha = e.desde
JOIN precios AS p_fin ON p_fin.ticker = e.ticker AND p_fin.fecha = e.hasta
JOIN met AS m         ON m.ticker = e.ticker;
GO