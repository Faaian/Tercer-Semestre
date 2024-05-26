DECLARE
    CURSOR cur_pokemon(id_pokemon pokemon.id%TYPE) IS
        SELECT speed, type_id
        FROM pokemon
        WHERE id = id_pokemon;
        
    v_speed pokemon.speed%TYPE;
    v_type pokemon.type_id%TYPE;
    v_id pokemon.id%TYPE := :x_id;
BEGIN
    OPEN cur_pokemon(v_id);
    FETCH cur_pokemon INTO v_speed, v_type;
    
    v_speed := 
        CASE v_type
            WHEN 1 THEN v_speed + 15
            WHEN 2 THEN v_speed + 10
            ELSE v_speed + 5
        END;
        
    UPDATE pokemon
    SET speed = v_speed
    WHERE id = v_id;
END;