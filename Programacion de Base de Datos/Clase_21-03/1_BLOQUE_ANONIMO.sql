
/*
Imprimir el nombre completo de una
persona por el id.
*/

DECLARE
    -- VARIABLES
    v_id_persona int := :x_id_persona;
    v_nombre_completo VARCHAR2(100);
    v_porc_imp int;
BEGIN
    -- varible regular
    v_porc_imp := 10000 * 0.19;
    
    -- variable sql
    SELECT nombre || ' ' || apellido
    into v_nombre_completo
    FROM persona
    WHERE id_persona = v_id_persona;
    
    dbms_output.put_line('hola');
    dbms_output.put_line('El nombre del usuario ' || v_id_persona);
    dbms_output.put_line('Es: ' || v_nombre_completo);
    
    
END;