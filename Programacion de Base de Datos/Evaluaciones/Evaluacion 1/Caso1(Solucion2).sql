DECLARE
    v_id_min INT;
    v_id_max INT;
    contador INT;
    v_total INT;
BEGIN
    SELECT
        MIN(id_boleta)
        ,MAX(id_boleta)
    INTO
        v_id_min, v_id_max
    FROM
        boleta
    ;
    -----
    contador := v_id_min;
    
    WHILE contador <= v_id_max LOOP
        SELECT
            SUM(p.precio * d.cantidad)
        INTO v_total
        FROM
            boleta b JOIN detalle_boleta d 
                ON b.id_boleta = d.id_boleta
            JOIN producto p ON d.id_producto = p.id_producto
        WHERE
            b.id_boleta = contador
        ;
        -----
        UPDATE boleta
        SET boleta.total = v_total
        WHERE boleta.id_boleta = contador;
        -----
        contador := contador + 1;
    END LOOP;
    COMMIT;
END;
