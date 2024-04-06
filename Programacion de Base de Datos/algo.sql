select * from producto_inversion_cliente;

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
BEGIN
    
    SELECT 
        c.nro_cliente
        ,TO_CHAR(v_run,'99g999g999')||'-'||v_dv
        ,c.pnombre||' '||c.snombre||' '||c.appaterno||' '||c.apmaterno
        ,nombre_tipo_cliente
        ,p.monto_total_ahorrado
    INTO v_nro_cliente, v_run_completo, v_nombre, v_tipo, v_monto
    FROM cliente c
    JOIN tipo_cliente t ON c.cod_tipo_cliente = t.cod_tipo_cliente
    JOIN producto_inversion_cliente p ON c.nro_cliente = p.nro_cliente
    WHERE
        v_run = numrun AND v_dv = dvrun;
    
    dbms_output.put_line(v_run_completo);
    dbms_output.put_line(v_nombre);
    dbms_output.put_line(v_tipo);
    dbms_output.put_line(v_monto);
END;