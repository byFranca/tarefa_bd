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

--ATIVIDADE 2.
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
