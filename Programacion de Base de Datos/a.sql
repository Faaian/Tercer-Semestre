

DECLARE
    v_porc_bono int := :x_bono;
    v_rut_emp int := :x_rut_emp;
    v_dvrut_emp int := :x_dv_emp;
    v_nombrecompleto VARCHAR2(200);
    v_sueldo int;
    v_bonificacion int := 0;
BEGIN
    SELECT
        nombre_emp||' '||appaterno_emp||' '||apmaterno_emp AS nombre
        ,sueldo_emp
    INTO
        v_nombrecompleto
        ,v_sueldo
    FROM 
        empleado
    WHERE
        numrut_emp = v_rut_emp
        AND dvrut_emp = v_dvrut_emp
    ;
    
    v_bonificacion := v_sueldo * (v_porc_bono)/100;
    
    dbms_output.put_line('DATO CALCULO BONIFICACIÓN EXTRA DEL '||v_porc_bono||'% DEL SUELDO');
    dbms_output.put_line('Nombre Empleado: '||v_nombrecompleto);
    dbms_output.put_line('RUN: '||v_rut_emp||'-'||v_dvrut_emp);
    dbms_output.put_line('Sueldo: '||TO_CHAR(v_sueldo,'FM$999G999G999'));
    dbms_output.put_line('Bonificación extra: '||TO_CHAR(v_bonificacion,'FM$999g999g999'));
END;