-- views
use ecomoda2;
-- esta view sirve para la gente que trabaja en la bodega ya que no le interesa el valor de los materiales para realizar su trabajo, solo la cantidad.
Create view view_material as 
Select id_material, cantidad, descripcion
From materiales;
-- esta view sirve para la gente que trabaja en la bodega ya que no le interesa el valor de los productos para realizar su trabajo, solo la cantidad.
Create view view_producto  as 
Select id_producto, cantidad, descripcion
From productos;

-- funciones
-- Esta funcion sirve para conocer el saldo total de las cuentas por pagar pendientes(no saldadas)

DELIMITER $$

CREATE FUNCTION fn_cuentas_pagar(
    param_estado VARCHAR(20)
) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_valor DECIMAL(10,2);
    IF param_estado = 'por pagar' THEN
        SELECT SUM(valor) INTO total_valor 
        FROM cuentas_cobrar
        WHERE estado = 'por pagar';
    ELSEIF param_estado = 'saldada' THEN
        SELECT SUM(valor) INTO total_valor
        FROM cuentas_cobrar
        WHERE estado = 'saldada';
    ELSE
        SET total_valor = 0;  
    END IF;
    
    RETURN total_valor;
END$$

DELIMITER ;


-- esta funcion sirve para conocer el saldo total de las cuentas por cobrar pendientes(no saldadas)

DELIMITER $$
DROP FUNCTION IF EXISTS fn_cuentas_cobrar;
CREATE FUNCTION fn_cuentas_cobrar(
    param_estado VARCHAR(20)
) RETURNS DECIMAL(10,2)
READS SQL DATA
BEGIN
    DECLARE total_valor DECIMAL(10,2);
    IF param_estado = 'por cobrar' THEN
        SELECT SUM(valor) INTO total_valor
        FROM cuentas_cobrar
        WHERE estado = 'por cobrar';
    ELSEIF param_estado = 'saldada' THEN
        SELECT SUM(valor) INTO total_valor
        FROM cuentas_cobrar
        WHERE estado = 'saldada';
    ELSE
        SET total_valor = 0;  
    END IF;
    
    RETURN total_valor;
END$$

DELIMITER ;

SELECT fn_cuentas_cobrar('por cobrar') AS total_por_cobrar;
SELECT fn_cuentas_cobrar('saldada') AS total_saldada;


-- STORED PROCEDURE
DELIMITER // 

CREATE PROCEDURE insertmaterial (
    IN p_descripcion VARCHAR(45),
    IN p_tipo ENUM('hilo', 'tela'),
    IN p_cantidad INT,
    IN p_precio DECIMAL(10,2)
)
BEGIN
    
        INSERT INTO materiales (descripcion, tipo, cantidad, precio)
        VALUES (p_descripcion, p_tipo, p_cantidad, p_precio);
   
END //

DELIMITER ;

call insertmaterial('tela fucsia seda', 'tela', 500, 1500);
select * from materiales;


-- TRIGGERS
CREATE TABLE audit_por_cobrar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cuenta_cobrar INT NOT NULL,
    estado ENUM('por cobrar', 'saldada') NOT NULL,
    valor DOUBLE NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    paz_y_salvo ENUM('si', 'no') NOT NULL,
    FOREIGN KEY (id_cuenta_cobrar) REFERENCES cuentas_cobrar(id_cuenta_cobrar)
);

DELIMITER //

CREATE TRIGGER update_cuentas_cobrar
AFTER UPDATE ON cuentas_cobrar
FOR EACH ROW
BEGIN
    INSERT INTO audit_por_cobrar (id_cuenta_cobrar, estado, valor, paz_y_salvo)
    VALUES (NEW.id_cuenta_cobrar, NEW.estado, NEW.valor, 
            CASE WHEN NEW.estado = 'saldada' and NEW.VALOR = 0  THEN 'si' ELSE 'no' END);
END //

DELIMITER ;

UPDATE cuentas_cobrar
SET estado = 'saldada', valor = 0 
WHERE id_cuenta_cobrar = 9960;

select * from cuentas_cobrar;

CREATE TABLE audit_por_pagar (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_cuentas_pagar INT NOT NULL,
    estado ENUM('por pagar', 'saldada') NOT NULL,
    valor DOUBLE NOT NULL,
    fecha TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    paz_y_salvo ENUM('si', 'no') NOT NULL,
    FOREIGN KEY (id_cuentas_pagar) REFERENCES cuentas_pagar(id_cuentas_pagar)
);

DELIMITER //

CREATE TRIGGER update_cuentas_pagar
AFTER UPDATE ON cuentas_pagar
FOR EACH ROW
BEGIN
    INSERT INTO audit_por_pagar(id_cuentas_pagar, estado, valor, paz_y_salvo)
    VALUES (NEW.id_cuentas_pagar, NEW.estado, NEW.valor, 
            CASE WHEN NEW.estado = 'saldada' and NEW.VALOR = 0  THEN 'si' ELSE 'no' END);
END //

DELIMITER ;

update cuentas_pagar 
SET estado = 'saldada', valor = 0 
where id_cuentas_pagar = 8850;

select * from cuentas_pagar;

-- 