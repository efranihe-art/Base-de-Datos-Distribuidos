-- 0. Nos cambiamos a la base de datos correcta
USE AdventureWorks2022;
GO

-- 1. Solución Inicial: Top 10 productos más vendidos en 2014 por cliente
SELECT TOP 10
    p.Name AS NombreProducto,
    SUM(sod.OrderQty) AS CantidadTotalVendida,
    CONCAT(per.FirstName, ' ', per.LastName) AS NombreCliente
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person per ON c.PersonID = per.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2014
GROUP BY 
    p.Name, 
    per.FirstName, 
    per.LastName
ORDER BY 
    CantidadTotalVendida DESC;

    -- Variante 1.1: Agregando Precio Promedio y Filtro de ListPrice > 1000
SELECT TOP 10
    p.Name AS NombreProducto,
    SUM(sod.OrderQty) AS CantidadTotalVendida,
    CONCAT(per.FirstName, ' ', per.LastName) AS NombreCliente,
    AVG(sod.UnitPrice) AS PrecioUnitarioPromedio
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product p ON sod.ProductID = p.ProductID
JOIN Sales.Customer c ON soh.CustomerID = c.CustomerID
JOIN Person.Person per ON c.PersonID = per.BusinessEntityID
WHERE YEAR(soh.OrderDate) = 2014
  AND p.ListPrice > 1000 -- Nuevo filtro agregado
GROUP BY 
    p.Name, 
    per.FirstName, 
    per.LastName
ORDER BY 
    CantidadTotalVendida DESC;