CREATE TABLE persona(
    id_persona INT,
    nombre VARCHAR2(50),
    apellido VARCHAR2(50),
    id_comuna INT   
);

INSERT INTO persona(id_persona, nombre, apellido, id_comuna)
VALUES(1, 'Fabian', 'Loyola', 1);
INSERT INTO persona(id_persona, nombre, apellido, id_comuna)
VALUES(2, 'a', 'a', 2);


DECLARE
    -- Crear Variables
    v_id_persona INT := 2;  -- := Inicializar Variable
    v_nombreCompleto VARCHAR2(100);
    
BEGIN
    -- Ejecutar Codigo
    SELECT nombre || ' '|| apellido
    INTO v_nombreCompleto
    FROM persona
    WHERE id_persona = v_id_persona;
    
    dbms_output.put_line('ID seleccionado: '|| v_id_persona);    
    dbms_output.put_line('Nombre: ' || v_nombreCompleto);
END;
