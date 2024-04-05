/*
CREATE TABLE cliente(
    id_cliente INT
    ,razonsocial VARCHAR2(50)
    ,rut VARCHAR2(10)
);
*/

DECLARE
    --v_rut cliente.rut%TYPE;
    v_razonsocial cliente.razonsocial%TYPE := :x_nombre;
BEGIN
    /*
    SELECT *
    INTO v_razonsocial
    FROM cliente 
    WHERE rut = v_rut;
    */
    
    IF LENGTH(v_razonsocial) > 10 THEN
        dbms_output.put_line('El largo es mayor a 4');
    ELSE IF LENGTH(v_razonsocial) < 4 AND LENGTH(v_razonsocial) < 10
    THEN
        dbms_output.put_line('');
    ELSE
        dbms_output.put_line('Es menor o igual a 4 de largo');
    END IF;
END;