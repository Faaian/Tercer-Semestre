DECLARE
    TYPE r_informe IS RECORD(
        tipo VARCHAR2(25)
        ,id vendedor.id_vendedor%TYPE
        ,nombre_completo VARCHAR2(50)
        ,rut vendedor.rut_vendedor%TYPE
        ,equipo VARCHAR2(25)
        ,categoria VARCHAR2(25)
        ,sueldo VARCHAR2(25)
    );
    
    CURSOR cur_vendedor IS 
        SELECT
            'Vendedor' AS "tipo"
            ,id_vendedor
            ,nombres||' '||apellidos AS nombre_completo
            ,rut_vendedor
            ,' ' AS equipo
            ,'Categoria '||id_categoria AS categoria
            ,sueldo
        FROM
            vendedor
        ;
        
    CURSOR cur_cliente IS
        SELECT
            'Cliente' AS "tipo"
            ,id_cliente
            ,nombre_cliente
            ,' ' AS "rut"
            ,' ' AS "equipo"
            ,' ' AS "categoria"
            ,0 AS "sueldo"
        FROM
            cliente
        ;
        
        v_informe r_informe;
BEGIN
    OPEN cur_vendedor;
    OPEN cur_cliente;
    
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('                      INFORME DE EMPLEADOS, CLIENTES Y VENDEDORES');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------');
    DBMS_OUTPUT.PUT_LINE('TIPO        ID  NOMBRE COMPLETO         RUT         EQUIPO      CATEGORIA       SUELDO');
    DBMS_OUTPUT.PUT_LINE('----------------------------------------------------------------------------------------');
    LOOP 
        FETCH cur_vendedor INTO v_informe;
        FETCH cur_cliente INTO v_informe;
    EXIT WHEN cur_vendedor%NOTFOUND AND cur_cliente%NOTFOUND;
        DBMS_OUTPUT.PUT_LINE(
        RPAD(v_informe.tipo, 12)
        ||RPAD(v_informe.id, 4)
        ||RPAD(v_informe.nombre_completo,24)
        ||RPAD(v_informe.rut, 12)
        ||RPAD(v_informe.equipo,  12)
        ||RPAD(v_informe.categoria,16)
        ||TO_CHAR(RPAD(v_informe.sueldo, 6),'FML999g999g999'));

    END LOOP;
    
    CLOSE cur_cliente;
    CLOSE cur_vendedor;
END;