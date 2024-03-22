
CREATE TABLE persona(
    id_persona INT PRIMARY KEY
    ,nombre VARCHAR2(50)
    ,apellido VARCHAR2(50)
);

INSERT INTO persona VALUES(1, 'David', 'Bisbal');
INSERT INTO persona VALUES(2, 'Harrinson', 'Ford');

SELECT * FROM persona;