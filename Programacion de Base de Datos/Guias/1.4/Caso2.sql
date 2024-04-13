SELECT * FROM empleado;
select * from estado_civil;
SELECT * FROM usuario_clave;
DECLARE
    v_id_max NUMBER(4);
    v_id_min NUMBER(4);
    v_id empleado.id_emp%TYPE;
    contador INT;
    v_run empleado.numrun_emp%TYPE;
    v_dv empleado.dvrun_emp%TYPE;
    v_nombre VARCHAR2(70);
    v_usuario VARCHAR2(15);
    v_clave VARCHAR2(20);
BEGIN
    EXECUTE IMMEDIATE 'TRUNCATE TABLE usuario_clave';

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
            ||e.id_emp||TO_CHAR(SYSDATE,'mmYYYY')
        INTO
            v_id, v_run, v_dv, v_nombre, v_usuario
        FROM
            empleado e JOIN estado_civil c
                ON e.id_estado_civil = c.id_estado_civil
        WHERE
            id_emp = contador   
        ;
        
        SELECT
            SUBSTR(e.numrun_emp,3,1)||TO_CHAR(e.fecha_nac,'yyyy') + 1
            ||SUBSTR(e.sueldo_base,-3,3) - 1||
            CASE
                WHEN c.id_estado_civil = 10 OR c.id_estado_civil = 60
                    THEN SUBSTR(c.nombre_estado_civil,1,2)
                WHEN c.id_estado_civil = 20 OR c.id_estado_civil = 30
                    THEN SUBSTR(c.nombre_estado_civil,1,1)||SUBSTR(c.nombre_estado_civil,-1,1)
                WHEN c.id_estado_civil = 40
                    THEN SUBSTR(c.nombre_estado_civil,-3,2)
                WHEN c.id_estado_civil = 50
                    THEN SUBSTR(c.nombre_estado_civil,-2,2)
            END
        INTO
            v_clave
        FROM
            empleado e JOIN estado_civil c
                ON e.id_estado_civil = c.id_estado_civil
        WHERE
            e.id_emp = contador 
        ;
        
        INSERT INTO usuario_clave
        VALUES(v_id, v_run, v_dv, v_nombre, v_usuario, v_clave);
        
        contador := contador + 10;
    END LOOP;
END;