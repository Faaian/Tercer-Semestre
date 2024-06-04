DECLARE
    CURSOR cur_batalla(id_pokemon pokemon.id%TYPE, id_pokemon2 pokemon.id%TYPE) IS
        SELECT id, hp, name
        FROM
            pokemon
        WHERE id = id_pokemon
        OR id = id_pokemon2;
        
    v_id_pokemon pokemon.id%TYPE;
    v_id_pokemon2 pokemon.id%TYPE;
    v_hp pokemon.hp%TYPE;
    v_hp2 pokemon.hp%TYPE;
    v_name pokemon.name%TYPE;
    v_name2 pokemon.name%TYPE;
    v_ganador battles.winner_id%TYPE;
BEGIN
    EXECUTE IMMEDIATE('TRUNCATE TABLE battles'); -- Le puse un truncate porque el *id* en la tabla de *battles* no incrementa automaticamente y manda error.
    OPEN cur_batalla(FLOOR(DBMS_RANDOM.value(1,150)), FLOOR(DBMS_RANDOM.value(1,150)));
    FETCH cur_batalla INTO v_id_pokemon, v_hp, v_name;
    FETCH cur_batalla INTO v_id_pokemon2, v_hp2, v_name2;
    CLOSE cur_batalla;
    
    IF (v_hp > v_hp2)
        THEN v_ganador := v_id_pokemon;
    ELSE v_ganador := v_id_pokemon2;
    END IF;
    
    INSERT INTO battles(id, pokemon1_id, pokemon2_id, winner_id, battle_date)
    VALUES(1, v_id_pokemon, v_id_pokemon2, v_ganador, SYSDATE);
    
    DBMS_OUTPUT.PUT_LINE('El Pokemon con id '||v_ganador||' ha ganado la batalla');
    DBMS_OUTPUT.PUT_LINE('Datos insertados en la tabla, Exitosamente.');
    
    COMMIT;
END;