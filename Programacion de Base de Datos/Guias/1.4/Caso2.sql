SELECT * FROM empleado;
select * from estado_civil;

DECLARE
    v_id_max NUMBER(3);
    v_id_min NUMBER(3);
    v_id empleado.id_emp%TYPE;
    contador INT;
    v_run empleado.numrun_emp%TYPE;
    v_dv empleado.dvrun_emp%TYPE;
    v_nombre VARCHAR2(70);
    v_usuario VARCHAR2(15);
BEGIN
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
            ,LOWER(SUBSTR(c.nombre_estado_civil,1,1))||SUBSTR(e.pnombre_emp,1,3)||
            LENGTH(e.pnombre_emp)||'*'||SUBSTR(e.sueldo_base,-1,1)||e.dvrun_emp
            ||TRUNC(MONTHS_BETWEEN(SYSDATE,e.fecha_contrato)/12)||
            CASE
               WHEN TRUNC(MONTHS_BETWEEN(SYSDATE,e.fecha_contrato)/12) < 10 THEN 'X'
            END
        INTO
            v_id, v_run, v_dv, v_nombre, v_usuario
        FROM
            empleado e JOIN estado_civil c
                ON e.id_estado_civil = c.id_estado_civil
        WHERE
            id_emp = contador   
        ;
        
        dbms_output.put_line(v_usuario);
        contador := contador + 10;
    END LOOP;
END;