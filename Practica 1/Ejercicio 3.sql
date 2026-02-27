USE AdventureWorks2022;
GO
-- Solución inicial y variante integradas
SELECT 
    st.Name AS Territorio,
    YEAR(soh.OrderDate) AS Anio,
    COUNT(soh.SalesOrderID) AS TotalOrdenes,
    SUM(soh.SubTotal) AS VentasTotales,
    STDEV(soh.SubTotal) AS DesviacionEstandarVentas -- Variante 1 agregada
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesTerritory st ON soh.TerritoryID = st.TerritoryID
GROUP BY st.Name, YEAR(soh.OrderDate)
HAVING COUNT(soh.SalesOrderID) > 5 
   AND SUM(soh.SubTotal) > 1000000
ORDER BY VentasTotales DESC;