BEGIN
    FOR movimiento IN (SELECT * FROM moves WHERE type_id = 3)
    LOOP
        UPDATE moves
        SET moves.power = moves.power + 10
        WHERE moves.id = movimiento.id;
        DBMS_OUTPUT.PUT_LINE(movimiento.name||' Aumentó poder en 10.');
    END LOOP;   
END;