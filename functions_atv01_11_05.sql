-- ATIVIDADE 1.
DELIMITER $$

CREATE FUNCTION fn_total_pedido(p_order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10, 2);

    SELECT SUM(UnitPrice * Quantity * (1 - Discount))
    INTO v_total
    FROM OrderDetails
    WHERE OrderID = p_order_id;

    RETURN IFNULL(v_total, 0);
END$$

DELIMITER ;

-- ATIVIDADE 2.
DELIMITER $$

CREATE FUNCTION fn_verificar_estoque(p_product_id INT)

RETURNS VARCHAR(20)
DETERMINISTIC

BEGIN 
IF (SELECT UnitsInStock FROM Products WHERE ProductID = p_product_id) > 10 THEN
    RETURN "ESTOQUE OK";
ELSE
    RETURN "ESTOQUE BAIXO";
END IF;

END$$
DELIMITER ;
    
-- ATIVIDADE 3
    
DELIMITER $$
CREATE FUNCTION fn_categoria_produto(p_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE v_result VARCHAR(100);
    SELECT c.CategoryName INTO v_result
    FROM products p INNER JOIN categories c ON p.CategoryID = c.CategoryID
    WHERE p.ProductID = p_id;
    RETURN result;
END$$
DELIMITER ;

-- ATIVIDADE 4
DELIMITER $$

CREATE FUNCTION fn_frete_gratis(p_order_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10, 2);
    DECLARE v_resultado VARCHAR(20);

    SELECT fn_total_pedido(p_order_id) INTO v_total;

    IF v_total >= 500 THEN
        SET v_resultado = 'FRETE GRÁTIS';
    ELSE
        SET v_resultado = 'FRETE COBRADO';
    END IF;

    RETURN v_resultado;

END$$

DELIMITER ;

-- ATIVIDADE 5

DELIMITER $$

CREATE FUNCTION fn_nivel_cliente(p_customer_id VARCHAR(5))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_total DECIMAL(10, 2);
    DECLARE v_nivel VARCHAR(20);

    SELECT 
        SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
    INTO v_total
    FROM Customers c
    INNER JOIN Orders o ON c.CustomerID = o.CustomerID
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE c.CustomerID = p_customer_id;

    IF v_total > 10000 THEN
        SET v_nivel = 'PREMIUM';
    ELSEIF v_total > 5000 THEN
        SET v_nivel = 'GOLD';
    ELSEIF v_total > 1000 THEN
        SET v_nivel = 'SILVER';
    ELSE
        SET v_nivel = 'BRONZE';
    END IF;

    RETURN v_nivel;

END$$

DELIMITER ;

-- ATIVIDADE 6

DELIMITER $$
CREATE FUNCTION fn_tempo_entrega(p_order_id INT)
RETURNS INT
DETERMINISTIC
BEGIN
    DECLARE v_dias INT;
    
    SELECT DATEDIFF(ShippedDate, OrderDate) INTO v_dias
    FROM Orders
    WHERE OrderID = p_order_id;
    
    RETURN v_dias;
END$$
DELIMITER ;

-- ATIVIDADE 7

SELECT 
    o.OrderID AS Pedido, 
    c.CompanyName AS Cliente, 
    fn_total_pedido(o.OrderID) AS ValorTotal, 
    fn_frete_gratis(o.OrderID) AS Frete, 
    fn_tempo_entrega(o.OrderID) AS TempoEntrega, 
    fn_nivel_cliente(c.CustomerID) AS NivelCliente
FROM Orders o
INNER JOIN Customers c ON o.CustomerID = c.CustomerID;

-- ATIVIDADE 8 

DELIMITER $$

CREATE FUNCTION fn_comissao_funcionario(p_employee_id INT)
RETURNS VARCHAR(10)
DETERMINISTIC
BEGIN
    DECLARE v_total_vendido DECIMAL(10, 2);
    DECLARE v_comissao VARCHAR(10);

    SELECT SUM(od.UnitPrice * od.Quantity * (1 - od.Discount))
    INTO v_total_vendido
    FROM Orders o
    INNER JOIN OrderDetails od ON o.OrderID = od.OrderID
    WHERE o.EmployeeID = p_employee_id;

    IF v_total_vendido > 50000 THEN
        SET v_comissao = '10%';
    ELSEIF v_total_vendido > 20000 THEN
        SET v_comissao = '5%';
    ELSE
        SET v_comissao = '2%';
    END IF;

    RETURN v_comissao;
END$$

DELIMITER ;

-- ATIVIDADE 9

DELIMITER $$

CREATE FUNCTION fn_produtos_mais_vendidos(p_product_id INT)
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE v_quantidade_total INT;
    DECLARE v_status VARCHAR(20);

    SELECT SUM(Quantity) INTO v_quantidade_total
    FROM OrderDetails
    WHERE ProductID = p_product_id;

    IF v_quantidade_total > 1000 THEN
        SET v_status = 'MAIS VENDIDO';
    ELSE
        SET v_status = 'VENDA NORMAL';
    END IF;

    RETURN v_status;
END$$

DELIMITER ;
