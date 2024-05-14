DECLARE
    CURSOR cur_vendedores IS 
    (SELECT
        id_vendedor
        ,nombres
        ,apellidos
        ,fecnac
        ,sueldo
    FROM
        vendedor
    WHERE
        sueldo <= 354000);
    
    i NUMBER(2) := 0;
BEGIN
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('INFORME DE EMPLEADOS');
    DBMS_OUTPUT.PUT_LINE('-------------------------------------------');
    
    FOR vendedores IN cur_vendedores LOOP
        i := i + 1;
        DBMS_OUTPUT.PUT_LINE('['||i||'] '||
        'Empleado N° '||vendedores.id_vendedor||' - '||
        INITCAP(vendedores.nombres||' '||vendedores.apellidos)
        ||' tiene un sueldo de '||
        TO_CHAR(vendedores.sueldo,'FML999g999g999'));
    END LOOP;
END;