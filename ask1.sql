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

