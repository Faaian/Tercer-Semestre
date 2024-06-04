DECLARE
    CURSOR cur_entrenador IS 
        SELECT id, name
        FROM trainers
        ;
        
    CURSOR cur_pokemon(id_entrenador trainers.id%TYPE) IS
        SELECT p.id, p.name
        FROM pokemon p
        JOIN pokemon_trainers pt ON p.id = pt.pokemon_id
        WHERE p.type_id = 2
        AND pt.trainer_id = id_entrenador;
BEGIN
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    DBMS_OUTPUT.PUT_LINE('        Pokemon de tipo Water');
    DBMS_OUTPUT.PUT_LINE('--------------------------------------');
    
    FOR entrenador IN cur_entrenador
    LOOP
        DBMS_OUTPUT.PUT_LINE('');
        DBMS_OUTPUT.PUT_LINE(entrenador.name||':');
        
        FOR pokemon IN cur_pokemon(entrenador.id)
        LOOP
            DBMS_OUTPUT.PUT_LINE(CHR(9)||pokemon.name);
        END LOOP;
        
    END LOOP;
END;