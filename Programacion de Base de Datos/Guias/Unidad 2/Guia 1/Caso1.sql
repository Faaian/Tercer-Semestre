DECLARE
    n INT;
    m INT;
    v_resultado INT := 0;
BEGIN
    n := FLOOR(DBMS_RANDOM.value(2,20));
    FOR i IN 1 .. n LOOP
        m := FLOOR(DBMS_RANDOM.value(20,200));
        v_resultado := i + n + v_resultado;
        dbms_output.put_line(v_resultado);
    END LOOP;
END;