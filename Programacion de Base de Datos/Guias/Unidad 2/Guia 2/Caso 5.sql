DECLARE
    CURSOR cur_vendedores IS
    SELECT
        id_categoria
        ,id_vendedor
        ,nombres
        ,apellidos
        ,sueldo
    FROM
        vendedor
    WHERE
        sueldo <= 400000
    ORDER BY
        id_categoria
        ,nombres DESC
    ;
    
    v_categoria VARCHAR2(1) := NULL;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('INFORME DE EMPLEADOS POR DEPARTAMENTO');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    
    FOR vendedor IN cur_vendedores LOOP
        IF v_categoria IS NULL OR v_categoria != vendedor.id_categoria THEN
            v_categoria := vendedor.id_categoria;
            DBMS_OUTPUT.PUT_LINE(chr(10)||'Categoria '||v_categoria||':');
        END IF;
        
        DBMS_OUTPUT.PUT_LINE(
            RPAD(vendedor.id_vendedor, 10)||' '||
            RPAD(vendedor.nombres||' '||vendedor.apellidos, 25)||
            TO_CHAR(vendedor.sueldo, 'FML999g999')
        );
    END LOOP;
END;