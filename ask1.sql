-- SQLite

-- 1.
SELECT c.CategoryName, c.CategoryID, COUNT(*) AS NrProducts
FROM Categories c, Products p WHERE c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName HAVING COUNT(*) < 10;

-- 2.
SELECT 
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS MoneySpent
FROM Customers c, Orders o, "Order Details" od 
  WHERE c.CustomerID = o.CustomerID  AND o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY MoneySpent DESC
LIMIT 10;

-- 3.
SELECT
    o.OrderID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS OrderCost
FROM  Orders o, Customers c, "Order Details" od 
WHERE c.CustomerID = o.CustomerID  AND o.OrderID = od.OrderID
GROUP BY o.OrderID, c.CompanyName
ORDER BY OrderCost DESC
LIMIT 15;

-- 4.
SELECT 
    c.CustomerID,
    c.CompanyName,
    c.Address,
    e.EmployeeID,
    e.LastName,
    e.Address
FROM Customers c
INNER JOIN Employees e ON c.City = e.City 
    AND SUBSTR(c.Address, 1, 1) = SUBSTR(e.Address, 1, 1);

-- 5.
SELECT 
    c.City,
    strftime('%m', o.OrderDate) AS MHNAS,
    SUM(od.UnitPrice * od.Quantity) AS CityCost,
    COUNT(DISTINCT o.OrderID) AS Paraggelies
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN "Order Details" od ON o.OrderID = od.OrderID
GROUP BY c.City, MHNAS
ORDER BY c.City ASC, MHNAS ASC;

-- 6.
SELECT 
    temp.MHNAS,
    MAX(temp.Cost) AS OrderCost
FROM (
    SELECT 
        o.OrderID,
        STRFTIME('%m', o.OrderDate) AS MHNAS,
        SUM(od.UnitPrice * od.Quantity) AS Cost
    FROM Orders o, "Order Details" od
    WHERE o.OrderID = od.OrderID
      AND STRFTIME('%Y', o.OrderDate) = '1997'
    GROUP BY o.OrderID, MHNAS
) AS temp
GROUP BY temp.MHNAS
ORDER BY SUM(temp.Cost) DESC
LIMIT 3;

-- SQL Server (T-SQL)

-- 1.
SELECT 
    c.CategoryName, 
    c.CategoryID, 
    COUNT(*) AS NrProducts
FROM Categories c, Products p 
WHERE c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName 
HAVING COUNT(*) < 10;

-- 2.
SELECT TOP 10
    c.CustomerID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS MoneySpent
FROM Customers c, Orders o, [Order Details] od 
WHERE c.CustomerID = o.CustomerID 
  AND o.OrderID = od.OrderID
GROUP BY c.CustomerID, c.CompanyName
ORDER BY MoneySpent DESC;

-- 3.
SELECT TOP 15
    o.OrderID,
    c.CompanyName,
    SUM(od.UnitPrice * od.Quantity) AS OrderCost
FROM Orders o, Customers c, [Order Details] od 
WHERE c.CustomerID = o.CustomerID 
  AND o.OrderID = od.OrderID
GROUP BY o.OrderID, c.CompanyName
ORDER BY OrderCost DESC;

-- 4.
SELECT 
    c.CustomerID,
    c.CompanyName,
    c.Address,
    e.EmployeeID,
    e.LastName,
    e.Address
FROM Customers c
INNER JOIN Employees e 
    ON c.City = e.City 
   AND LEFT(c.Address, 1) = LEFT(e.Address, 1);

-- 5.
SELECT 
    c.City,
    MONTH(o.OrderDate) AS MHNAS,
    SUM(od.UnitPrice * od.Quantity) AS CityCost,
    COUNT(DISTINCT o.OrderID) AS Paraggelies
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID
INNER JOIN [Order Details] od ON o.OrderID = od.OrderID
GROUP BY c.City, MONTH(o.OrderDate)
ORDER BY c.City ASC, MHNAS ASC;

-- 6.
SELECT TOP 3
    temp.MHNAS,
    MAX(temp.Cost) AS OrderCost
FROM (
    SELECT 
        o.OrderID,
        MONTH(o.OrderDate) AS MHNAS,
        SUM(od.UnitPrice * od.Quantity) AS Cost
    FROM Orders o, [Order Details] od
    WHERE o.OrderID = od.OrderID
      AND YEAR(o.OrderDate) = 1997
    GROUP BY o.OrderID, MONTH(o.OrderDate)
) AS temp
GROUP BY temp.MHNAS
ORDER BY SUM(temp.Cost) DESC;
