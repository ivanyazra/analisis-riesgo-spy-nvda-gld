-- 01. Tablas del proyecto
-- stg: tabla borrador con la forma del CSV (el CSV no trae ticker)
-- precios: tabla definitiva, una fila por ticker y día
USE FinanzasDB;
GO

CREATE TABLE stg (
    fecha   DATE,
    abierto DECIMAL(18,4),
    maximo  DECIMAL(18,4),
    minimo  DECIMAL(18,4),
    cierre  DECIMAL(18,4),
    volumen BIGINT
);

CREATE TABLE precios (
    ticker  VARCHAR(10),
    fecha   DATE,
    abierto DECIMAL(18,4),
    maximo  DECIMAL(18,4),
    minimo  DECIMAL(18,4),
    cierre  DECIMAL(18,4),
    volumen BIGINT,
    PRIMARY KEY (ticker, fecha)   -- evita duplicados (mismo ticker y fecha)
);
GO