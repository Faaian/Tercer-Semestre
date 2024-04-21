select * from cliente_beneficiado;
DECLARE
    v_mes_anio VARCHAR2(7) := :x_mes_anio;
    v_id_min INT;
    v_id_max INT;
    v_id_cli INT;
    v_nombre VARCHAR2(50);
    v_comuna cliente.comuna%TYPE;
    v_total INT;
    v_gift INT;
    v_porc INT;
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE cliente_beneficiado';
    
    SELECT
        MIN(id_cliente)
        ,MAX(id_cliente)
    INTO
        v_id_min, v_id_max
    FROM
        cliente
    ;
    ------
    
    FOR i in v_id_min .. v_id_max LOOP
        SELECT nombre_cliente, comuna
        INTO v_nombre, v_comuna
        FROM cliente
        WHERE id_cliente = i
        ;
       ------
        SELECT
        SUM(p.precio * d.cantidad)
        INTO v_total
        FROM
            boleta b JOIN detalle_boleta d 
                ON b.id_boleta = d.id_boleta
            JOIN producto p ON d.id_producto = p.id_producto
        WHERE
            b.id_cliente = i
            AND TO_CHAR(b.fecha_boleta,'mm-yyyy') = v_mes_anio 
        ;
        
        -----
        
        v_gift := 
            ROUND(CASE
                WHEN v_total BETWEEN 100000 AND 250000
                    THEN (v_total * 15)/100
                WHEN v_total BETWEEN 250001 AND 750000
                    THEN ((v_total * 25)/100)+ 10000
                WHEN v_total BETWEEN 750001 AND 1000000
                    THEN ((v_total * 28)/100)+ 20000
                WHEN v_total > 1000000
                    THEN ((v_total * 30)/100)+ 30000
                ELSE 0
            END);
        ------
        v_porc := 
            CASE v_comuna
                WHEN 'VITACURA' THEN 30
                WHEN 'LA REINA' THEN 20
                WHEN 'LO BARNECHEA' THEN 15
                WHEN 'LAS CONDES' THEN 5
                WHEN 'PROVIDENCIA' THEN 25
                WHEN 'SANTIAGO' THEN 10
            END;
        
        ------
        
        INSERT INTO cliente_beneficiado
        VALUES(TO_CHAR(SYSDATE,'dd-mm-yyyy'), v_mes_anio, i, v_nombre, v_total, v_gift, v_porc,
        'Ha obtenido una gif card de '
        ||TO_CHAR(v_gift,'FMl999g999g999')||' y '||v_porc||'% de descuento en su proxima compra online');
    END LOOP;
    COMMIT;
END;