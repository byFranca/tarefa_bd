-- MIGUEL FRANÇA - 2° DS

--ATIVIDADE 1
SELECT
	companyName,
    city,
    country
FROM customers
ORDER BY companyName ASC;

-- ATIVIDADE 2

SELECT
	productName,
    UnitPrice,
    UnitsInStock
FROM products
WHERE UnitsInStock > 0;

-- ATIVIDADE 3

SELECT
	CONCAT(FirstName, " ", LastName) as nome_completo,
    City,
    Country
FROM employees;

-- ATIVIDADE 4

SELECT
    OrderID,
    OrderDate,
    ShipCity,
    ShipCountry
FROM Orders
ORDER BY OrderDate DESC; 

-- ATIVIDADE 5
SELECT
  p.ProductName,
  c.categoryName,
  p.UnitPrice
FROM products p
JOIN categories c 
ON c.CategoryID = p.CategoryID;

--ATIVIDADE 6
SELECT
	p.ProductName,
    s.CompanyName,
    s.City
FROM products p
JOIN suppliers s 
ON p.SupplierID = s.SupplierID;

--ATIVIDADE 7

SELECT
	c.CompanyName,
    o.OrderID,
    o.OrderDate
FROM customers c
JOIN orders o
ON c.CustomerID = o.CustomerID;

-- ATIVIDADE 8

SELECT
	o.OrderID,
    e.FirstName,
    o.OrderDate
FROM orders o
JOIN employees e
ON o.EmployeeID = e.EmployeeID;

-- ATIVIDADE 9

 SELECT
	o.ProductID,
    p.ProductName,
    o.Quantity,
    p.UnitPrice
 FROM orderDetails o
 JOIN products p
 ON ProductID = p.ProductID;

-- ATIVIDADE 10

SELECT count(*) AS total_produtos 
FROM products;