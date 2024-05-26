DECLARE
    CURSOR cur_entrenador(entrenador_id trainers.id%TYPE) IS 
        SELECT
            t.name
            ,p.name
        FROM trainers t
        JOIN pokemon_trainers pt ON pt.trainer_id = t.id
        JOIN pokemon p ON pt.pokemon_id = p.id
        WHERE t.id = entrenador_id;
    
    v_entrenador trainers.name%TYPE;
    v_pokemon pokemon.name%TYPE;
BEGIN
    OPEN cur_entrenador(FLOOR(DBMS_RANDOM.value(1,3)));
    FETCH cur_entrenador INTO v_entrenador, v_pokemon;
    CLOSE cur_entrenador;
    
    DBMS_OUTPUT.PUT_LINE('El entrenador '||v_entrenador||' es dueño del pokemon '||v_pokemon);
END;