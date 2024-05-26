DECLARE
    CURSOR cur_pokemon(id_pokemon pokemon.id%TYPE) IS (
        SELECT hp
        FROM pokemon
        WHERE id = id_pokemon
    );
    
    v_hp pokemon.hp%TYPE; 
    v_pokemon pokemon.id%TYPE := :x_pokemon;
BEGIN
    OPEN cur_pokemon(v_pokemon);
    FETCH cur_pokemon INTO v_hp;
    CLOSE cur_pokemon;
    
    IF(v_hp < 50) THEN v_hp := v_hp + 50;
    ELSE v_hp := v_hp + 10;
    END IF;
    
    UPDATE pokemon
    SET pokemon.hp = v_hp
    WHERE pokemon.id = v_pokemon;
    
    DBMS_OUTPUT.PUT_LINE('Actualizado correctamente.');
END;