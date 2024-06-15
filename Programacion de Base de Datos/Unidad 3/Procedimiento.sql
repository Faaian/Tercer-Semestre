create or replace PROCEDURE sp_contar
(x_numero1 NUMBER)
AS
    v_resultado NUMBER;
BEGIN
    IF(x_numero1 = 0)
    THEN
        RAISE ZERO_DIVIDE;
    END IF;
        
    FOR contador IN 1..100
    LOOP
        v_resultado := contador / x_numero1;
        DBMS_OUTPUT.PUT_LINE('numero: '||contador);
        DBMS_OUTPUT.PUT_LINE('calculo: '||v_resultado);
    END LOOP;
EXCEPTION
    WHEN ZERO_DIVIDE THEN
        DBMS_OUTPUT.PUT_LINE('No se puede divir por 0');
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Cagó');
END sp_contar;