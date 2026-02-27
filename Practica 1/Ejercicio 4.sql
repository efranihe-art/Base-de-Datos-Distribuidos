USE AdventureWorks2022;
GO

-- Solución implementando la validación por conteo y las variantes solicitadas
SELECT 
    p.FirstName, 
    p.LastName,
    pc.Name AS Categoria,
    COUNT(DISTINCT pr.ProductID) AS ProductosDiferentesVendidos -- Variante 2: Conteo por vendedor
FROM Sales.SalesOrderHeader soh
JOIN Sales.SalesOrderDetail sod ON soh.SalesOrderID = sod.SalesOrderID
JOIN Production.Product pr ON sod.ProductID = pr.ProductID
JOIN Production.ProductSubcategory psc ON pr.ProductSubcategoryID = psc.ProductSubcategoryID
JOIN Production.ProductCategory pc ON psc.ProductCategoryID = pc.ProductCategoryID
JOIN Person.Person p ON soh.SalesPersonID = p.BusinessEntityID
WHERE pc.ProductCategoryID = 4 -- Variante 1: Filtrar por "Clothing" (ID=4) en lugar de Bikes (1)
GROUP BY p.FirstName, p.LastName, soh.SalesPersonID, pc.Name
-- División relacional: El empleado vendió la misma cantidad de productos únicos 
-- que el total de productos existentes en esa categoría.
HAVING COUNT(DISTINCT pr.ProductID) = (
    SELECT COUNT(ProductID) 
    FROM Production.Product pr_sub
    JOIN Production.ProductSubcategory psc_sub ON pr_sub.ProductSubcategoryID = psc_sub.ProductSubcategoryID
    WHERE psc_sub.ProductCategoryID = 4
);