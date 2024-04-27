DECLARE
    v_cantidad INT := 0;
BEGIN
    FOR i IN 1 .. 200 LOOP
        IF MOD(i,3) = 0
            THEN v_cantidad:= v_cantidad + 1;
        END IF;
    END LOOP;
    dbms_output.put_line('La cantidad de multiplos de 3 es de: '||v_cantidad||' números');
END;