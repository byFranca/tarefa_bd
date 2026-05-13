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
    RETURN "Estoque Ok";
ELSE
    RETURN "Estoque Baixo";
END IF;

END$$
DELIMITER ;
    
-- ATIVIDADE 3
    
DELIMITER $$
CREATE FUNCTION fn_categoria_produto(p_id INT)
RETURNS VARCHAR(100)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(100);
    SELECT c.CategoryName INTO result
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