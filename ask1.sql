-- 1.
SELECT c.CategoryName, c.CategoryID, COUNT(*) AS NrProducts
FROM Categories c, Products p WHERE c.CategoryID = p.CategoryID
GROUP BY c.CategoryID, c.CategoryName HAVING COUNT(*) < 10;

-- 2.
