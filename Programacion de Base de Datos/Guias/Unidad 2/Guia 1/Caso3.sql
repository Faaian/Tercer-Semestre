DECLARE
    v_resultado INT;
BEGIN
    FOR i IN 1 .. 10 LOOP
        FOR u IN 1 .. 10 LOOP
            v_resultado := i * u;
            dbms_output.put_line(i||'x'||u||' = '||v_resultado );
        END LOOP;
    END LOOP;
END;