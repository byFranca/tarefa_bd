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
WHERE UnitPrice > 0;

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
  ProductName,
  categoryName,
  UnitPrice
FROM products
JOIN categories 
WHERE categories.CategoryID = products.CategoryID;

--ATIVIDADE 6
SELECT
	p.ProductName,
    s.CompanyName,
    s.City
FROM products p
JOIN suppliers s WHERE p.SupplierID = s.SupplierID;