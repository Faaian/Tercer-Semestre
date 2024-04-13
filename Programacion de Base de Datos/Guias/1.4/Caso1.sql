SELECT * FROM proy_movilizacion;

DECLARE
    v_id_min NUMBER(3);
    v_id_max NUMBER(3);
    contador NUMBER(3);
    v_id empleado.id_emp%TYPE;
    v_numrun empleado.numrun_emp%TYPE;
    v_dvrun empleado.dvrun_emp%TYPE;
    v_nombre VARCHAR2(70);
    v_comuna comuna.nombre_comuna%TYPE;
    v_sueldo empleado.sueldo_base%TYPE;
    v_id_comuna comuna.id_comuna%TYPE;
    v_porc_movil_normal NUMBER(2);
    v_valor_movil INT;
    v_valor_movil_extra int;
    v_valor_total INT;
BEGIN
    
    EXECUTE IMMEDIATE 'TRUNCATE TABLE proy_movilizacion';
    
    SELECT MAX(id_emp), MIN(id_emp)
    INTO v_id_max, v_id_min
    FROM empleado;
    
    contador := v_id_min;

    WHILE contador <= v_id_max LOOP
        SELECT
            e.id_emp
            ,e.numrun_emp
            ,e.dvrun_emp
            ,e.pnombre_emp||' '||e.snombre_emp||' '||e.appaterno_emp||' '||e.apmaterno_emp
            ,c.nombre_comuna
            ,e.id_comuna
            ,e.sueldo_base
        INTO
            v_id, v_numrun, v_dvrun, v_nombre, v_comuna, v_id_comuna, v_sueldo
        FROM
            empleado e JOIN comuna c
                ON e.id_comuna = c.id_comuna
        WHERE
            id_emp = contador
        ;
        
        v_porc_movil_normal := TRUNC(v_sueldo / 100000);
        v_valor_movil := (v_sueldo * v_porc_movil_normal)/100;
        
        CASE
        WHEN v_id_comuna = 117
            THEN v_valor_movil_extra := 20000;
        WHEN v_id_comuna = 118
            THEN v_valor_movil_extra := 25000;
        WHEN v_id_comuna = 119
            THEN v_valor_movil_extra := 30000;
        WHEN v_id_comuna = 120
            THEN v_valor_movil_extra := 35000;
        WHEN v_id_comuna = 121
            THEN v_valor_movil_extra := 40000;
        ELSE v_valor_movil_extra := 0;
        END CASE;
        
        v_valor_total := v_valor_movil + v_valor_movil_extra;
        
        INSERT INTO proy_movilizacion
        VALUES(TO_CHAR(SYSDATE,'yyyy'),v_id,v_numrun,v_dvrun,v_nombre,v_comuna,v_sueldo,v_porc_movil_normal,v_valor_movil,v_valor_movil_extra,v_valor_total);
        
        contador := contador + 10;
    END LOOP;
    EXECUTE IMMEDIATE 'SELECT * FROM proy_movilizacion';
END;