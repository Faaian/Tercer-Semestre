BEGIN

FOR i IN 1 .. 120 LOOP    
    UPDATE boleta
    SET total = 
        (SELECT
            SUM(p.precio * de.cantidad)
        FROM
            detalle_boleta de JOIN producto p
                ON de.id_producto = p.id_producto
        WHERE 
            de.id_boleta = i)
        WHERE id_boleta = i;
END LOOP;
COMMIT;
END;