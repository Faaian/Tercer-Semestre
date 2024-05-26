DECLARE
    TYPE r_pokemon IS RECORD(
        nombre pokemon.name%TYPE
        ,tipo types.type_name%TYPE
        ,hp pokemon.hp%TYPE
    );
    
    CURSOR cur_pokemon(id_pokemon pokemon.id%TYPE) IS (
        SELECT
            p.name
            ,t.type_name
            ,p.hp
        FROM pokemon p
        JOIN types t ON p.type_id = t.id
        WHERE p.id = id_pokemon
    );
    
    v_pokemon r_pokemon;
BEGIN
    OPEN cur_pokemon(FLOOR(DBMS_RANDOM.VALUE(1,150)));
    FETCH cur_pokemon INTO v_pokemon;
    CLOSE cur_pokemon;
    
    DBMS_OUTPUT.PUT_LINE(
    'Nombre: '||v_pokemon.nombre
    ||CHR(10)||'Tipo: '||v_pokemon.tipo
    ||CHR(10)||'HP: '||v_pokemon.hp);
END;