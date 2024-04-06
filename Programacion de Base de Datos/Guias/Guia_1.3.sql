SELECT * FROM cliente_todosuma;

TRUNCATE TABLE cliente_todosuma;

DECLARE
    v_run cliente.numrun%TYPE := :x_run;
    v_dv VARCHAR(1) := :x_dv;
    v_nro_cliente cliente.nro_cliente%TYPE;
    v_run_completo VARCHAR(50);
    v_pesos INT := 1200;
    v_p_extra INT;
    v_nombre VARCHAR(50);
    v_tipo tipo_cliente.nombre_tipo_cliente%TYPE;
    v_monto INT;
    v_todo_suma INT;
BEGIN
    
    SELECT 
        c.nro_cliente
        ,TO_CHAR(v_run,'99g999g999')||'-'||v_dv
        ,c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno
        ,nombre_tipo_cliente
        ,(SELECT SUM(cr.monto_solicitado) FROM credito_cliente cr 
        WHERE cr.nro_cliente = c.nro_cliente 
        AND EXTRACT(YEAR FROM cr.fecha_solic_cred) = TO_CHAR(SYSDATE,'YYYY') - 1
        )
    INTO 
        v_nro_cliente, v_run_completo, v_nombre, v_tipo, v_monto
    FROM 
        cliente c
    JOIN 
        tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    WHERE
        v_run = numrun AND v_dv = dvrun;

    IF v_tipo = 'Trabajadores independientes'
        THEN
            IF v_monto < 1000000
                THEN v_p_extra := 100;
            ELSIF v_monto >= 1000001 AND v_monto < 3000000 
                THEN v_p_extra := 300;
            ELSE v_p_extra := 550;
            END IF;
        ELSE v_p_extra := 0;
    END IF;
    
    v_todo_suma := v_monto*(v_pesos + v_p_extra) / 100000;
    
    INSERT INTO cliente_todosuma
    VALUES(v_nro_cliente, v_run_completo, v_nombre, v_tipo, v_monto, v_todo_suma);
    
    dbms_output.put_line('Valores agregados');
END;