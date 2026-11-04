Análisis de Rendimiento y Riesgo Financiero: SPY, NVDA y GLD

Proyecto personal de análisis financiero con SQL Server (T-SQL) para cargar los datos y calcular las métricas, y Power BI para visualizarlas.

Compara la relación entre riesgo y rendimiento de tres activos entre octubre de 2021 y octubre de 2026.

  -Activos analizados
SPY: ETF que replica el índice S&P 500 (referencia del mercado general).
NVDA: Nvidia Corporation (acción de crecimiento, alta volatilidad).
GLD: SPDR Gold Shares (ETF de oro, activo refugio).
  -Métricas calculadas
Rendimiento diario y total: variación porcentual del precio de cierre respecto del día anterior y respecto del primer día del período.
Índice base 100: lleva el valor inicial de cada activo a 100 para compararlos en la misma escala.
Volatilidad anualizada: desvío estándar de los rendimientos diarios × √252 (días de operación del año).
Drawdown diario y máximo: caída porcentual desde el máximo previo alcanzado en el período.
  -Resultados
Activo	Rendimiento total	Volatilidad anual	Drawdown máximo
GLD	124,1%	19,0%	−26,4%
NVDA	742,3%	51,9%	−66,4%
SPY	68,2%	17,2%	−25,4%

Conclusión: NVDA tuvo el mayor rendimiento, pero con una volatilidad de unas tres veces la de SPY y una caída máxima del 66,4%. GLD rindió más que SPY con un nivel de riesgo similar.

Dashboard de Power BI
  -Herramientas y cómo está armado
SQL Server (T-SQL):
Carga de los CSV con BULK INSERT a una tabla de paso (stg) y de ahí a la tabla precios, agregando el ticker.
Funciones de ventana (LAG, FIRST_VALUE, MAX() OVER), CTE, agregaciones y JOINs para calcular las métricas.
Dos vistas: vw_analisis (métricas por día) y vw_resumen (métricas por activo), que alimentan Power BI.
Power BI: dashboard conectado a las vistas, con gráficos de serie temporal y una tabla de resumen.
  -Estructura del repositorio
text
├── data/       # CSV con los precios diarios (2021-2026)
├── sql/        # Scripts numerados, en el orden en que se ejecutan (01 al 04)
└── dashboard/  # Captura del dashboard y archivo de Power BI (.pbix)
  - Cómo reproducirlo
Instalar SQL Server (alcanza con Express) y un editor para conectarse, como VS Code con la extensión MSSQL o SSMS. Crear la base `FinanzasDB`.
Ejecutar en orden los scripts de la carpeta sql/.
En 02_cargar_datos.sql, reemplazar la ruta de los CSV por la de tu computadora.
Abrir el archivo de Power BI de dashboard/ y actualizar la conexión al servidor.
  -Notas y limitaciones
Fuente de los datos: Nasdaq (precios históricos diarios).
Los rendimientos se calculan sobre el precio de cierre, sin dividendos.
Se usan 252 días de operación por año para anualizar la volatilidad.
Se excluyó el 20/04/2026 de SPY y GLD porque la fuente traía el volumen como “N/A”.
El período es de 5 años: incluye la caída de 2022, pero no otros ciclos de mercado.
 Próximos pasos
Calcular la beta de cada activo respecto de SPY.
Agregar volatilidad móvil.
