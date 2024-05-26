DECLARE
    CURSOR cur_electricos IS
        SELECT
            name
        FROM
            pokemon
        WHERE
            type_id = 1;
BEGIN
    FOR pokemon IN cur_electricos LOOP
        DBMS_OUTPUT.PUT_LINE(pokemon.name);
    END LOOP;
END;