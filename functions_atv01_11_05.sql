--ATIVIDADE 1.
DELIMITER $$

CREATE FUNCTION calcular_total_pedido(p_order_id INT)
RETURNS DECIMAL(10, 2)
DETERMINISTIC
BEGIN
    DECLARE fn_total_pedido DECIMAL(10, 2);

    SELECT SUM(UnitPrice * Quantity * (1 - Discount))
    INTO fn_total_pedido
    FROM OrderDetails
    WHERE OrderID = p_order_id;

    RETURN IFNULL(fn_total_pedido, 0);
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
