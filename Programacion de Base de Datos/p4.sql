SELECT * FROM empleado;

TRUNCATE TABLE proy_movilizacion;

DECLARE
    v_id_min NUMBER(3);
    v_id_max NUMBER(3);
    contador NUMBER(3);
    v_id empleado.id_emp%TYPE;
    v_numrun_emp empleado.numrun_emp%TYPE;
    v_dvrun_emp empleado.dvrun_emp
BEGIN    
    SELECT MAX(id_emp), MIN(id_emp)
    INTO v_id_max, v_id_min
    FROM empleado;
    
    contador := v_id_min;
    
    SELECT
        id_emp
        ,numrun_emp
        ,dvrun_emp
        ,pnombre_emp||' '||snombre_emp||' '||appaterno_emp||' '||apmaterno_emp
        
    FROM
        empleado
    ;
    
    WHILE contador <= v_id_max LOOP
        dbms_output.put_line(contador);
        contador := contador + 10;
    END LOOP;
END;