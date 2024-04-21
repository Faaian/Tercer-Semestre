DROP TABLE detalle_boleta CASCADE CONSTRAINTS;
DROP TABLE boleta CASCADE CONSTRAINTS;
DROP TABLE producto CASCADE CONSTRAINTS;
DROP TABLE descuento CASCADE CONSTRAINTS;
DROP TABLE empleado CASCADE CONSTRAINTS;
DROP TABLE cliente CASCADE CONSTRAINTS;
DROP TABLE comision_empleado CASCADE CONSTRAINTS;
DROP TABLE equipo CASCADE CONSTRAINTS;
DROP TABLE categorizacion CASCADE CONSTRAINTS;
DROP TABLE cliente_beneficiado CASCADE CONSTRAINTS;


--------------------------------------------------------
--  DDL for Table equipo
--------------------------------------------------------
CREATE TABLE equipo (
  id_equipo VARCHAR2(1) NOT NULL, 
  nom_equipo VARCHAR2(10) NOT NULL,
  porc NUMBER(5,2) NOT NULL,
  CONSTRAINT pk_equipo PRIMARY KEY (id_equipo)
);

--------------------------------------------------------
--  DDL for Table categorizacion
--------------------------------------------------------
CREATE TABLE categorizacion (
  id_categorizacion CHAR(1) NOT NULL, 
  nom_categorizacion VARCHAR2(10) NOT NULL , 
  porcentaje NUMBER NOT NULL,
  CONSTRAINT pk_categorizacion PRIMARY KEY (id_categorizacion)
);

--------------------------------------------------------
--  DDL for Table CLIENTE
--------------------------------------------------------

  CREATE TABLE cliente (
    id_cliente NUMBER NOT NULL, 
    nombre_cliente VARCHAR2(35) NOT NULL, 
    direccion VARCHAR2(50) NOT NULL, 
    comuna VARCHAR2(25) NOT NULL, 
    telefono VARCHAR2(15) NOT NULL,
    CONSTRAINT pk_cliente PRIMARY KEY (id_cliente)
) ;
--------------------------------------------------------
--  DDL for Table producto
--------------------------------------------------------

  CREATE TABLE producto (
    id_producto NUMBER NOT NULL, 
    nom_producto VARCHAR2(25) NOT NULL, 
    fab_producto VARCHAR2(20) NOT NULL, 
    des_producto VARCHAR2(68) NOT NULL, 
    precio NUMBER NOT NULL, 
    stock NUMBER NOT NULL,
    CONSTRAINT pk_producto PRIMARY KEY (id_producto)
) ;
--------------------------------------------------------
--  DDL for Table empleado
--------------------------------------------------------

CREATE TABLE empleado (
  id_empleado NUMBER(6) NOT NULL, 
  rut_empleado VARCHAR2(10) NOT NULL, 
  nombres VARCHAR2(25) NOT NULL, 
  apellidos VARCHAR2(25) NOT NULL, 
  fecnac DATE NOT NULL, 
  feccontrato DATE NOT NULL, 
  id_equipo VARCHAR2(1), 
  id_categorizacion CHAR(1) NOT NULL, 
  sueldo NUMBER NOT NULL, 
  id_afp NUMBER NOT NULL,
  CONSTRAINT pk_empleado PRIMARY KEY (id_empleado),
  CONSTRAINT ak_empleado UNIQUE (rut_empleado)
);

--------------------------------------------------------
--  DDL for Table descuento
--------------------------------------------------------

CREATE TABLE descuento (
  id_empleado NUMBER(6) NOT NULL, 
  mes NUMBER(2),
  monto NUMBER(8),
  CONSTRAINT pk_descuento PRIMARY KEY (id_empleado, mes)
);  
  
--------------------------------------------------------
--  DDL for Table boleta
--------------------------------------------------------

  CREATE TABLE boleta (
    id_boleta NUMBER NOT NULL, 
    id_cliente NUMBER NOT NULL, 
    id_empleado NUMBER, 
    fecha_boleta DATE NOT NULL,
    total NUMBER(8),
    CONSTRAINT pk_boleta PRIMARY KEY (id_boleta)
) ;

--------------------------------------------------------
--  DDL for Table detalle_boleta
--------------------------------------------------------

  CREATE TABLE detalle_boleta (
    id_boleta NUMBER NOT NULL,
    id_producto NUMBER NOT NULL, 
    cantidad NUMBER NOT NULL,
    CONSTRAINT pk_detalle_boleta PRIMARY KEY (id_boleta, id_producto)
) ;

CREATE TABLE comision_empleado (
  ventaminima NUMBER,
  ventamaxima NUMBER,
  comision NUMBER,
  CONSTRAINT pk_comision_empleado PRIMARY KEY (ventaminima, ventamaxima)
);

CREATE TABLE detalle_venta_empleado (
  anno NUMBER(4) NOT NULL,
  mes NUMBER(2) NOT NULL,
  id_empleado NUMBER(6) NOT NULL, 
  nombre VARCHAR2(51)  NOT NULL,
  equipo_emp VARCHAR2(10) NOT NULL, 
  nro_ventas NUMBER(3) NOT NULL,
  ventas_netas_mes NUMBER(9) NOT NULL,
  bono_equipo NUMBER(8) NOT NULL,
  incentivo_categorizacion NUMBER(8) NOT NULL,
  asignacion_vtas NUMBER(8) NOT NULL,
  asignacion_antig number(8) NOT NULL,
  descuentos NUMBER(8) NOT NULL,
  totales_mes NUMBER(10) NOT NULL,
  CONSTRAINT pk_detalleventas PRIMARY KEY (anno, mes, id_empleado),
  CONSTRAINT fk_detalleventas_empleado FOREIGN KEY (id_empleado) REFERENCES empleado (id_empleado) 
);
DROP TABLE incentivo_empleado;
CREATE TABLE incentivo_empleado
(
    periodo VARCHAR2(7),
    rut_empleado VARCHAR2(10),
    nombre VARCHAR2(100),
    total_ventas NUMBER,
    total_incentivos NUMBER,
    CONSTRAINT pk_comision PRIMARY KEY (periodo, rut_empleado)
);


CREATE TABLE cliente_beneficiado (
    fecha VARCHAR2(25) NOT NULL,
    mes_anio VARCHAR2(10) NOT NULL,
    id_cliente NUMBER NOT NULL, 
    nombre_cliente VARCHAR2(90) NOT NULL, 
    total_compras NUMBER(10) NOT NULL,
    total_gif_card NUMBER(10) NOT NULL,
    porc_descuento NUMBER(10) NOT NULL,
    comentario VARCHAR2(200) NOT NULL,
    CONSTRAINT pk_cliente_beneficiado PRIMARY KEY(mes_anio,id_cliente)
) ;


ALTER TABLE boleta 
	 ADD CONSTRAINT fk_cliente FOREIGN KEY (id_cliente)
	  REFERENCES cliente (id_cliente);

ALTER TABLE boleta 
	 ADD CONSTRAINT fk_empleado FOREIGN KEY (id_empleado)
	  REFERENCES empleado(id_empleado);

ALTER TABLE empleado 
  ADD CONSTRAINT fk_equipo_empleado FOREIGN KEY (id_equipo) 
   REFERENCES equipo (id_equipo);
  
ALTER TABLE empleado 
  ADD CONSTRAINT fk_empleado_categorizacion FOREIGN KEY (id_categorizacion) 
   REFERENCES categorizacion (id_categorizacion);

ALTER TABLE detalle_boleta 
	ADD CONSTRAINT fk_detboleta_boleta FOREIGN KEY (id_boleta)
	  REFERENCES boleta (id_boleta);

ALTER TABLE detalle_boleta 
	ADD CONSTRAINT fk_detboleta_producto FOREIGN KEY (id_producto)
	  REFERENCES producto (id_producto);

ALTER TABLE descuento 
  ADD CONSTRAINT fk_descuento_empleado FOREIGN KEY (id_empleado)
  REFERENCES empleado (id_empleado);


INSERT INTO equipo VALUES ('A','Equipo A',8.56);
INSERT INTO equipo VALUES ('B','Equipo B',10.48);
INSERT INTO equipo VALUES ('C','Equipo C',11.27);
INSERT INTO equipo VALUES ('D','Equipo D',7.24);

INSERT INTO categorizacion VALUES ('A','LISTA A', 17.5);
INSERT INTO categorizacion VALUES ('B','LISTA B', 12.6);
INSERT INTO categorizacion VALUES ('C','LISTA C', 9.4);
INSERT INTO categorizacion VALUES ('D','LISTA D', 7.2);
INSERT INTO categorizacion VALUES ('E','LISTA E', 5.4);

INSERT INTO cliente VALUES (1,'ALCARAZ NOVOA MONTSERRAT','RUBEN BARRALES 1630','LO BARNECHEA','564522114');
INSERT INTO cliente VALUES (2,'JIMÉNEZ LORCA ELENA','AV. BUSTAMANTE 529 DPTO K','PROVIDENCIA','566665443');
INSERT INTO cliente VALUES (3,'TORRES ROCA MARÍA','DONATELLO 7421','LAS CONDES','565626134');
INSERT INTO cliente VALUES (4,'LOPEZ ROJAS THOMAS','JOSE MANUEL INFANTE 2007','PROVIDENCIA','562989233');
INSERT INTO cliente VALUES (5,'ZAMORA MOLINA TOMÁS','HUERFANOS 1294 OF.45','SANTIAGO','564343456');
INSERT INTO cliente VALUES (6,'GALLO LÓPEZ GONZALO','ESCRIBA DE BALAGUER 5584','VITACURA','562334533');
INSERT INTO cliente VALUES (7,'VIVEROS MIRANDA ELIZABETH','MATEO TORO Y ZAMBRANO 1395 D12','LA REINA','567019232');
INSERT INTO cliente VALUES (8,'LAMONT ORTEGA OLIVIA','LAS MALVAS 517','LAS CONDES','564197043');
INSERT INTO cliente VALUES (9,'SEVILLANO MORENO LUISA','EL NOGAL 11','LO BARNECHEA','566675321');

INSERT INTO producto VALUES (1,'BARRITAS','COSTA','BARRITAS DE CARAMELO CUBIERTAS DE CHOCOLATE',250,150);
INSERT INTO producto VALUES (2,'LECHEROS','COSTA','BOLITAS DE CHOCOLATE CUBIERTAS DE CARAMELO',325,50);
INSERT INTO producto VALUES (3,'ROSENDOS','DOS EN UNO','BARRITAS DE FRUTA CUBIERTAS DE PASAS',100,200);
INSERT INTO producto VALUES (4,'ZIG ZAGS','DOS EN UNO','ARROPE CUBIERTO DE CHOCOLATE',375,50);
INSERT INTO producto VALUES (5,'PECADOS','COSTA','MANÍ CUBIERTO DE TURRÓN',400,80);
INSERT INTO producto VALUES (6,'LINGOTE DE ORO','NESTLÉ','CRUJIENTES GRANOS DE ARROZ TOSTADO CUBIERTOS DE CARAMELO Y CHOCOLATE',410,200);
INSERT INTO producto VALUES (7,'productoS PLACERES','ARCOR','MANTEQUILLA DE CACAHUETE CUBIERTA DE CHOCOLATE',450,60);
INSERT INTO producto VALUES (8,'ARTESANOS','COSTA','CHICLÉS CUBIERTOS DE CARAMELO',310,35);
INSERT INTO producto VALUES (9,'TARTALETAS','COSTA','BOMBONES CUBIERTOS DE CHOCOLATE Y MANTEQUILLA DE MANI',750,300);
INSERT INTO producto VALUES (10,'BANANAS','ARCOR','PLÁTANOS CUBIERTOS DE CARAMELO',340,80);
INSERT INTO producto VALUES (11,'ROLLOS NABISCO','ARCOR','ROLLITOS CUBIERTOS DE CHOCOLATE CREMOSO',850,200);
INSERT INTO producto VALUES (12,'PALITOS NABISCO','DOS EN UNO','PALITOS AZUCARADOS CUBIERTOS DE CHOCOLATE CREMOSO',610,200);
INSERT INTO producto VALUES (13,'MANÍ SALADO','DOS EN UNO','MANÍ TOSTADO CON SAL',850,250);
INSERT INTO producto VALUES (14,'MOMENTOS','DOS EN UNO','productoS DE LECHE AZUCARADOS',493,240);
INSERT INTO producto VALUES (15,'OSITOS DE GOMA','DOS EN UNO','GOMITAS DE FRUTA Y YOGHURT',500,10);

INSERT INTO empleado VALUES (2,'11111112','MARY','CULVERT ','22051963','16041985','A','C',350000,1);
INSERT INTO empleado VALUES (4,'22222223','JEROME','WOODS','07081978','02072000','A','B',345000,2);
INSERT INTO empleado VALUES (6,'33333334','NORA','BROMSLER','09101979','03092001','A','A',367400,3);
INSERT INTO empleado VALUES (8,'44444445','FREDERICK','MALLON','08121977','03111999','B','C',373620,4);
INSERT INTO empleado VALUES (10,'55555556','ADRIENNE','SNYDER','08051990','02042008','B','D',359000,4);
INSERT INTO empleado VALUES (12,'66666667','URSULA','HALLIDAY','07121985','02112007','B','C',346372,5);
INSERT INTO empleado VALUES (14,'77777778','HANS','ORLON','05101975','30081997','B','A',354000,1);
INSERT INTO empleado VALUES (16,'88888889','CHARLES','BEATTY','12031980','05022002','C','A',353504,6);
INSERT INTO empleado VALUES (18,'99999991','DALE','WILSON','04031976','28011998','C','C',338934,2);
INSERT INTO empleado VALUES (20,'101111112','DONNA','PETRI','11101977','06091999','C','A',338432,4);
INSERT INTO empleado VALUES (22,'111111113','ELIZABETH','YARROW','12021974','08011996','B','A',348232,3);
INSERT INTO empleado VALUES (24,'121111114','ROWEN','GILBERT','22011978','18121999','D','B',356734,2);
INSERT INTO empleado VALUES (26,'131111115','HENRY','CZYNSKI','18111981','14102003','D','B',364832,5);
INSERT INTO empleado VALUES (28,'141111116','ROBIN','SAITO','21081984','17072006','D','D',378484,1);
INSERT INTO empleado VALUES (30,'151111117','PAZ','GUERRA','21071983','17062005','A','C',478584,2);

INSERT INTO descuento VALUES(2,4,12987);
INSERT INTO descuento VALUES(4,4,18144);
INSERT INTO descuento VALUES(2,5,26487);
INSERT INTO descuento VALUES(4,5,29120);
INSERT INTO descuento VALUES(6,5,10144);
INSERT INTO descuento VALUES(8,5,10218);
INSERT INTO descuento VALUES(10,5,22652);
INSERT INTO descuento VALUES(12,5,12763);
INSERT INTO descuento VALUES(14,5,21889);
INSERT INTO descuento VALUES(16,5,20840);
INSERT INTO descuento VALUES(18,5,14188);
INSERT INTO descuento VALUES(20,5,13293);
INSERT INTO descuento VALUES(22,5,15675);
INSERT INTO descuento VALUES(24,5,17024);
INSERT INTO descuento VALUES(26,5,24602);
INSERT INTO descuento VALUES(28,5,25751);
INSERT INTO descuento VALUES(30,5,22452);
INSERT INTO descuento VALUES(14,6,17357);
INSERT INTO descuento VALUES(16,6,28057);
INSERT INTO descuento VALUES(20,7,14080);
INSERT INTO descuento VALUES(20,8,28295);
INSERT INTO descuento VALUES(22,6,17301);
INSERT INTO descuento VALUES(22,7,18434);
INSERT INTO descuento VALUES(22,8,15867);
INSERT INTO descuento VALUES(24,6,28169);
INSERT INTO descuento VALUES(24,7,15308);
INSERT INTO descuento VALUES(24,4,29625);
INSERT INTO descuento VALUES(26,2,16431);
INSERT INTO descuento VALUES(26,3,25139);
INSERT INTO descuento VALUES(26,4,16291);
INSERT INTO descuento VALUES(26,7,11611);
INSERT INTO descuento VALUES(30,2,27999);
INSERT INTO descuento VALUES(30,3,29132);
INSERT INTO descuento VALUES(30,4,27191);

INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (1,3,14,'26/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (2,7,26,'27/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (3,8,6,'27/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (4,2,22,'27/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (5,2,26,'27/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (6,9,14,'28/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (7,9,22,'28/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (8,5,2,'28/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (9,4,14,'28/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (10,4,14,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (11,5,6,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (12,4,22,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (13,5,6,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (14,3,6,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (15,2,6,'29/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (16,3,8,'30/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (17,6,16,'30/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (18,6,4,'30/04/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (19,9,12,'01/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (20,2,14,'01/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (21,6,12,'01/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (22,3,6,'02/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (23,8,6,'02/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (24,1,6,'02/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (25,4,2,'03/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (26,9,2,'03/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (27,8,22,'04/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (28,9,22,'04/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (29,1,12,'05/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (30,7,12,'05/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (31,6,20,'06/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (32,5,20,'06/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (33,2,20,'06/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (34,5,22,'07/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (35,8,22,'07/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (36,1,22,'07/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (37,3,16,'08/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (38,6,16,'08/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (39,2,16,'08/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (40,4,4,'08/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (41,6,26,'09/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (42,1,NULL,'09/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (43,3,8,'09/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (44,1,26,'10/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (45,4,22,'10/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (46,6,22,'12/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (47,2,12,'13/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (48,7,12,'13/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (49,9,12,'13/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (50,6,12,'14/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (51,7,20,'14/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (52,8,2,'15/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (53,1,26,'16/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (54,4,6,'16/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (55,3,20,'16/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (56,6,4,'17/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (57,9,4,'17/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (58,6,4,'17/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (59,4,10,'18/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (60,9,10,'18/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (61,9,10,'18/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (62,9,10,'18/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (63,8,2,'19/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (64,6,26,'19/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (65,5,26,'19/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (66,7,26,'19/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (67,4,16,'19/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (68,2,4,'20/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (69,8,4,'20/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (70,4,4,'20/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (71,8,4,'20/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (72,9,16,'20/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (73,8,2,'21/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (74,1,18,'22/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (75,7,16,'22/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (76,6,16,'22/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (77,8,16,'22/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (78,6,14,'23/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (79,3,18,'23/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (80,2,4,'23/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (81,9,16,'24/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (82,8,18,'24/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (83,6,10,'24/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (84,8,8,'25/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (85,3,2,'25/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (86,1,16,'25/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (87,1,22,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (88,2,20,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (89,1,10,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (90,1,4,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (91,1,18,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (92,1,14,'26/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (93,7,22,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (94,2,24,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (95,6,22,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (96,2,8,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (97,4,18,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (98,7,10,'27/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (99,9,8,'28/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (100,7,10,'28/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (101,3,24,'28/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (102,4,18,'28/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (103,2,26,'29/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (104,7,28,'29/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (105,3,30,'30/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (106,1,28,'30/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (107,9,6,'31/05/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (108,7,4,'01/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (109,4,16,'01/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (110,9,14,'01/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (111,9,26,'01/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (112,6,6,'01/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (113,5,6,'02/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (114,9,22,'02/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (115,3,24,'02/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (116,9,20,'02/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (117,9,8,'04/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (118,3,18,'05/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (119,5,12,'05/06/2022');
INSERT INTO boleta (id_boleta, id_cliente, id_empleado, fecha_boleta) VALUES (120,5,12,'06/06/2022');

INSERT INTO detalle_boleta VALUES (1,1,10);
INSERT INTO detalle_boleta VALUES (1,5,33);
INSERT INTO detalle_boleta VALUES (1,13,88);
INSERT INTO detalle_boleta VALUES (2,3,33);
INSERT INTO detalle_boleta VALUES (2,10,90);
INSERT INTO detalle_boleta VALUES (3,4,200);
INSERT INTO detalle_boleta VALUES (3,11,500);
INSERT INTO detalle_boleta VALUES (4,5,500);
INSERT INTO detalle_boleta VALUES (4,6,250);
INSERT INTO detalle_boleta VALUES (4,7,300);
INSERT INTO detalle_boleta VALUES (5,1,196);
INSERT INTO detalle_boleta VALUES (5,6,128);
INSERT INTO detalle_boleta VALUES (5,12,181);
INSERT INTO detalle_boleta VALUES (6,10,283);
INSERT INTO detalle_boleta VALUES (6,11,41);
INSERT INTO detalle_boleta VALUES (7,12,84);
INSERT INTO detalle_boleta VALUES (8,2,198);
INSERT INTO detalle_boleta VALUES (9,9,79);
INSERT INTO detalle_boleta VALUES (10,13,200);
INSERT INTO detalle_boleta VALUES (11,8,183);
INSERT INTO detalle_boleta VALUES (12,10,239);
INSERT INTO detalle_boleta VALUES (12,15,52);
INSERT INTO detalle_boleta VALUES (12,4,248);
INSERT INTO detalle_boleta VALUES (13,9,152);
INSERT INTO detalle_boleta VALUES (14,14,283);
INSERT INTO detalle_boleta VALUES (14,13,285);
INSERT INTO detalle_boleta VALUES (15,1,170);
INSERT INTO detalle_boleta VALUES (15,9,63);
INSERT INTO detalle_boleta VALUES (15,2,137);
INSERT INTO detalle_boleta VALUES (15,3,151);
INSERT INTO detalle_boleta VALUES (17,6,117);
INSERT INTO detalle_boleta VALUES (17,4,203);
INSERT INTO detalle_boleta VALUES (18,8,283);
INSERT INTO detalle_boleta VALUES (19,7,255);
INSERT INTO detalle_boleta VALUES (20,15,272);
INSERT INTO detalle_boleta VALUES (20,9,242);
INSERT INTO detalle_boleta VALUES (20,12,67);
INSERT INTO detalle_boleta VALUES (20,8,157);
INSERT INTO detalle_boleta VALUES (20,13,37);
INSERT INTO detalle_boleta VALUES (20,14,29);
INSERT INTO detalle_boleta VALUES (20,2,26);
INSERT INTO detalle_boleta VALUES (21,7,94);
INSERT INTO detalle_boleta VALUES (21,4,24);
INSERT INTO detalle_boleta VALUES (21,1,247);
INSERT INTO detalle_boleta VALUES (21,8,226);
INSERT INTO detalle_boleta VALUES (22,8,116);
INSERT INTO detalle_boleta VALUES (22,11,250);
INSERT INTO detalle_boleta VALUES (22,13,98);
INSERT INTO detalle_boleta VALUES (22,7,194);
INSERT INTO detalle_boleta VALUES (23,10,205);
INSERT INTO detalle_boleta VALUES (23,8,101);
INSERT INTO detalle_boleta VALUES (24,3,40);
INSERT INTO detalle_boleta VALUES (24,15,282);
INSERT INTO detalle_boleta VALUES (24,7,206);
INSERT INTO detalle_boleta VALUES (24,2,95);
INSERT INTO detalle_boleta VALUES (25,2,271);
INSERT INTO detalle_boleta VALUES (25,5,34);
INSERT INTO detalle_boleta VALUES (25,6,47);
INSERT INTO detalle_boleta VALUES (25,7,206);
INSERT INTO detalle_boleta VALUES (25,8,184);
INSERT INTO detalle_boleta VALUES (25,3,92);
INSERT INTO detalle_boleta VALUES (25,15,122);
INSERT INTO detalle_boleta VALUES (26,3,32);
INSERT INTO detalle_boleta VALUES (26,5,20);
INSERT INTO detalle_boleta VALUES (27,7,105);
INSERT INTO detalle_boleta VALUES (27,9,105);
INSERT INTO detalle_boleta VALUES (27,8,115);
INSERT INTO detalle_boleta VALUES (27,15,128);
INSERT INTO detalle_boleta VALUES (27,12,134);
INSERT INTO detalle_boleta VALUES (28,1,284);
INSERT INTO detalle_boleta VALUES (29,9,29);
INSERT INTO detalle_boleta VALUES (29,10,27);
INSERT INTO detalle_boleta VALUES (29,15,139);
INSERT INTO detalle_boleta VALUES (29,8,109);
INSERT INTO detalle_boleta VALUES (30,2,228);
INSERT INTO detalle_boleta VALUES (30,7,133);
INSERT INTO detalle_boleta VALUES (30,9,289);
INSERT INTO detalle_boleta VALUES (30,14,75);
INSERT INTO detalle_boleta VALUES (31,4,221);
INSERT INTO detalle_boleta VALUES (31,11,189);
INSERT INTO detalle_boleta VALUES (32,8,231);
INSERT INTO detalle_boleta VALUES (32,6,120);
INSERT INTO detalle_boleta VALUES (33,1,78);
INSERT INTO detalle_boleta VALUES (33,15,160);
INSERT INTO detalle_boleta VALUES (34,13,230);
INSERT INTO detalle_boleta VALUES (35,7,253);
INSERT INTO detalle_boleta VALUES (35,8,192);
INSERT INTO detalle_boleta VALUES (36,7,32);
INSERT INTO detalle_boleta VALUES (36,10,138);
INSERT INTO detalle_boleta VALUES (36,1,97);
INSERT INTO detalle_boleta VALUES (37,1,73);
INSERT INTO detalle_boleta VALUES (38,1,279);
INSERT INTO detalle_boleta VALUES (38,5,198);
INSERT INTO detalle_boleta VALUES (38,9,173);
INSERT INTO detalle_boleta VALUES (38,10,86);
INSERT INTO detalle_boleta VALUES (39,12,165);
INSERT INTO detalle_boleta VALUES (40,12,100);
INSERT INTO detalle_boleta VALUES (40,6,265);
INSERT INTO detalle_boleta VALUES (40,7,257);
INSERT INTO detalle_boleta VALUES (41,2,100);
INSERT INTO detalle_boleta VALUES (41,8,154);
INSERT INTO detalle_boleta VALUES (41,14,250);
INSERT INTO detalle_boleta VALUES (41,1,77);
INSERT INTO detalle_boleta VALUES (42,1,51);
INSERT INTO detalle_boleta VALUES (42,14,75);
INSERT INTO detalle_boleta VALUES (42,10,81);
INSERT INTO detalle_boleta VALUES (42,13,64);
INSERT INTO detalle_boleta VALUES (43,15,52);
INSERT INTO detalle_boleta VALUES (43,9,27);
INSERT INTO detalle_boleta VALUES (43,12,298);
INSERT INTO detalle_boleta VALUES (43,1,198);
INSERT INTO detalle_boleta VALUES (43,11,45);
INSERT INTO detalle_boleta VALUES (44,6,126);
INSERT INTO detalle_boleta VALUES (44,7,206);
INSERT INTO detalle_boleta VALUES (44,8,117);
INSERT INTO detalle_boleta VALUES (44,15,146);
INSERT INTO detalle_boleta VALUES (44,13,260);
INSERT INTO detalle_boleta VALUES (44,14,244);
INSERT INTO detalle_boleta VALUES (45,1,242);
INSERT INTO detalle_boleta VALUES (45,7,258);
INSERT INTO detalle_boleta VALUES (45,4,274);
INSERT INTO detalle_boleta VALUES (45,9,105);
INSERT INTO detalle_boleta VALUES (45,10,188);
INSERT INTO detalle_boleta VALUES (46,9,138);
INSERT INTO detalle_boleta VALUES (46,3,64);
INSERT INTO detalle_boleta VALUES (47,12,28);
INSERT INTO detalle_boleta VALUES (47,5,146);
INSERT INTO detalle_boleta VALUES (47,13,245);
INSERT INTO detalle_boleta VALUES (48,6,236);
INSERT INTO detalle_boleta VALUES (49,14,206);
INSERT INTO detalle_boleta VALUES (49,7,167);
INSERT INTO detalle_boleta VALUES (49,6,154);
INSERT INTO detalle_boleta VALUES (49,8,282);
INSERT INTO detalle_boleta VALUES (50,1,210);
INSERT INTO detalle_boleta VALUES (50,2,223);
INSERT INTO detalle_boleta VALUES (50,3,147);
INSERT INTO detalle_boleta VALUES (50,5,25);
INSERT INTO detalle_boleta VALUES (50,8,53);
INSERT INTO detalle_boleta VALUES (50,10,157);
INSERT INTO detalle_boleta VALUES (51,12,170);
INSERT INTO detalle_boleta VALUES (51,13,52);
INSERT INTO detalle_boleta VALUES (51,1,164);
INSERT INTO detalle_boleta VALUES (52,10,130);
INSERT INTO detalle_boleta VALUES (52,1,95);
INSERT INTO detalle_boleta VALUES (52,2,264);
INSERT INTO detalle_boleta VALUES (52,8,115);
INSERT INTO detalle_boleta VALUES (53,11,46);
INSERT INTO detalle_boleta VALUES (53,4,281);
INSERT INTO detalle_boleta VALUES (54,1,167);
INSERT INTO detalle_boleta VALUES (54,2,263);
INSERT INTO detalle_boleta VALUES (54,3,62);
INSERT INTO detalle_boleta VALUES (54,4,267);
INSERT INTO detalle_boleta VALUES (54,12,78);
INSERT INTO detalle_boleta VALUES (55,8,256);
INSERT INTO detalle_boleta VALUES (56,12,191);
INSERT INTO detalle_boleta VALUES (56,6,230);
INSERT INTO detalle_boleta VALUES (56,1,89);
INSERT INTO detalle_boleta VALUES (56,8,140);
INSERT INTO detalle_boleta VALUES (57,12,164);
INSERT INTO detalle_boleta VALUES (57,10,70);
INSERT INTO detalle_boleta VALUES (57,8,20);
INSERT INTO detalle_boleta VALUES (58,11,144);
INSERT INTO detalle_boleta VALUES (58,3,157);
INSERT INTO detalle_boleta VALUES (58,7,226);
INSERT INTO detalle_boleta VALUES (58,4,228);
INSERT INTO detalle_boleta VALUES (58,5,148);
INSERT INTO detalle_boleta VALUES (58,1,284);
INSERT INTO detalle_boleta VALUES (59,10,256);
INSERT INTO detalle_boleta VALUES (59,11,255);
INSERT INTO detalle_boleta VALUES (59,15,59);
INSERT INTO detalle_boleta VALUES (59,8,260);
INSERT INTO detalle_boleta VALUES (59,4,126);
INSERT INTO detalle_boleta VALUES (59,5,173);
INSERT INTO detalle_boleta VALUES (59,2,90);
INSERT INTO detalle_boleta VALUES (59,1,170);
INSERT INTO detalle_boleta VALUES (60,4,214);
INSERT INTO detalle_boleta VALUES (60,10,104);
INSERT INTO detalle_boleta VALUES (60,6,163);
INSERT INTO detalle_boleta VALUES (60,2,172);
INSERT INTO detalle_boleta VALUES (61,2,51);
INSERT INTO detalle_boleta VALUES (61,4,274);
INSERT INTO detalle_boleta VALUES (61,12,174);
INSERT INTO detalle_boleta VALUES (61,7,145);
INSERT INTO detalle_boleta VALUES (61,10,278);
INSERT INTO detalle_boleta VALUES (61,5,126);
INSERT INTO detalle_boleta VALUES (61,8,57);
INSERT INTO detalle_boleta VALUES (62,7,46);
INSERT INTO detalle_boleta VALUES (62,5,175);
INSERT INTO detalle_boleta VALUES (62,13,203);
INSERT INTO detalle_boleta VALUES (63,11,275);
INSERT INTO detalle_boleta VALUES (63,15,212);
INSERT INTO detalle_boleta VALUES (64,6,83);
INSERT INTO detalle_boleta VALUES (64,2,29);
INSERT INTO detalle_boleta VALUES (64,8,252);
INSERT INTO detalle_boleta VALUES (64,1,253);
INSERT INTO detalle_boleta VALUES (65,6,206);
INSERT INTO detalle_boleta VALUES (65,3,102);
INSERT INTO detalle_boleta VALUES (65,15,201);
INSERT INTO detalle_boleta VALUES (66,7,59);
INSERT INTO detalle_boleta VALUES (66,15,294);
INSERT INTO detalle_boleta VALUES (66,3,267);
INSERT INTO detalle_boleta VALUES (66,9,295);
INSERT INTO detalle_boleta VALUES (66,4,173);
INSERT INTO detalle_boleta VALUES (67,7,217);
INSERT INTO detalle_boleta VALUES (67,1,29);
INSERT INTO detalle_boleta VALUES (67,14,124);
INSERT INTO detalle_boleta VALUES (67,2,278);
INSERT INTO detalle_boleta VALUES (67,3,272);
INSERT INTO detalle_boleta VALUES (68,11,159);
INSERT INTO detalle_boleta VALUES (68,9,286);
INSERT INTO detalle_boleta VALUES (68,15,135);
INSERT INTO detalle_boleta VALUES (69,4,173);
INSERT INTO detalle_boleta VALUES (69,15,128);
INSERT INTO detalle_boleta VALUES (69,9,63);
INSERT INTO detalle_boleta VALUES (69,7,243);
INSERT INTO detalle_boleta VALUES (70,6,108);
INSERT INTO detalle_boleta VALUES (70,5,291);
INSERT INTO detalle_boleta VALUES (71,14,110);
INSERT INTO detalle_boleta VALUES (71,10,180);
INSERT INTO detalle_boleta VALUES (72,14,104);
INSERT INTO detalle_boleta VALUES (72,3,59);
INSERT INTO detalle_boleta VALUES (72,13,106);
INSERT INTO detalle_boleta VALUES (73,4,174);
INSERT INTO detalle_boleta VALUES (73,10,20);
INSERT INTO detalle_boleta VALUES (74,13,229);
INSERT INTO detalle_boleta VALUES (74,11,233);
INSERT INTO detalle_boleta VALUES (75,10,211);
INSERT INTO detalle_boleta VALUES (75,7,202);
INSERT INTO detalle_boleta VALUES (75,1,202);
INSERT INTO detalle_boleta VALUES (75,12,72);
INSERT INTO detalle_boleta VALUES (75,8,287);
INSERT INTO detalle_boleta VALUES (76,1,185);
INSERT INTO detalle_boleta VALUES (77,2,272);
INSERT INTO detalle_boleta VALUES (77,6,111);
INSERT INTO detalle_boleta VALUES (77,12,81);
INSERT INTO detalle_boleta VALUES (77,13,183);
INSERT INTO detalle_boleta VALUES (77,10,168);
INSERT INTO detalle_boleta VALUES (78,1,244);
INSERT INTO detalle_boleta VALUES (78,8,108);
INSERT INTO detalle_boleta VALUES (78,11,252);
INSERT INTO detalle_boleta VALUES (79,1,167);
INSERT INTO detalle_boleta VALUES (79,13,124);
INSERT INTO detalle_boleta VALUES (79,12,149);
INSERT INTO detalle_boleta VALUES (79,15,280);
INSERT INTO detalle_boleta VALUES (79,8,209);
INSERT INTO detalle_boleta VALUES (80,10,203);
INSERT INTO detalle_boleta VALUES (80,6,20);
INSERT INTO detalle_boleta VALUES (80,4,120);
INSERT INTO detalle_boleta VALUES (80,7,62);
INSERT INTO detalle_boleta VALUES (80,9,214);
INSERT INTO detalle_boleta VALUES (81,12,78);
INSERT INTO detalle_boleta VALUES (81,5,48);
INSERT INTO detalle_boleta VALUES (81,6,268);
INSERT INTO detalle_boleta VALUES (81,1,287);
INSERT INTO detalle_boleta VALUES (81,9,36);
INSERT INTO detalle_boleta VALUES (82,10,202);
INSERT INTO detalle_boleta VALUES (82,12,231);
INSERT INTO detalle_boleta VALUES (82,9,161);
INSERT INTO detalle_boleta VALUES (82,13,38);
INSERT INTO detalle_boleta VALUES (83,12,21);
INSERT INTO detalle_boleta VALUES (83,10,69);
INSERT INTO detalle_boleta VALUES (84,14,65);
INSERT INTO detalle_boleta VALUES (84,3,272);
INSERT INTO detalle_boleta VALUES (84,12,148);
INSERT INTO detalle_boleta VALUES (84,13,160);
INSERT INTO detalle_boleta VALUES (84,11,250);
INSERT INTO detalle_boleta VALUES (84,1,260);
INSERT INTO detalle_boleta VALUES (85,8,107);
INSERT INTO detalle_boleta VALUES (85,1,192);
INSERT INTO detalle_boleta VALUES (86,6,293);
INSERT INTO detalle_boleta VALUES (86,10,215);
INSERT INTO detalle_boleta VALUES (87,14,297);
INSERT INTO detalle_boleta VALUES (87,13,62);
INSERT INTO detalle_boleta VALUES (88,10,147);
INSERT INTO detalle_boleta VALUES (88,11,187);
INSERT INTO detalle_boleta VALUES (88,12,215);
INSERT INTO detalle_boleta VALUES (88,13,280);
INSERT INTO detalle_boleta VALUES (89,2,51);
INSERT INTO detalle_boleta VALUES (90,10,61);
INSERT INTO detalle_boleta VALUES (90,1,178);
INSERT INTO detalle_boleta VALUES (90,2,239);
INSERT INTO detalle_boleta VALUES (91,9,30);
INSERT INTO detalle_boleta VALUES (92,8,205);
INSERT INTO detalle_boleta VALUES (92,12,256);
INSERT INTO detalle_boleta VALUES (93,4,42);
INSERT INTO detalle_boleta VALUES (94,1,26);
INSERT INTO detalle_boleta VALUES (94,3,264);
INSERT INTO detalle_boleta VALUES (94,10,295);
INSERT INTO detalle_boleta VALUES (94,4,102);
INSERT INTO detalle_boleta VALUES (95,1,70);
INSERT INTO detalle_boleta VALUES (95,9,106);
INSERT INTO detalle_boleta VALUES (95,6,99);
INSERT INTO detalle_boleta VALUES (95,14,263);
INSERT INTO detalle_boleta VALUES (96,15,127);
INSERT INTO detalle_boleta VALUES (96,10,243);
INSERT INTO detalle_boleta VALUES (96,7,197);
INSERT INTO detalle_boleta VALUES (96,11,215);
INSERT INTO detalle_boleta VALUES (97,15,298);
INSERT INTO detalle_boleta VALUES (97,9,25);
INSERT INTO detalle_boleta VALUES (97,4,89);
INSERT INTO detalle_boleta VALUES (97,7,101);
INSERT INTO detalle_boleta VALUES (97,11,107);
INSERT INTO detalle_boleta VALUES (97,3,253);
INSERT INTO detalle_boleta VALUES (98,2,283);
INSERT INTO detalle_boleta VALUES (98,8,225);
INSERT INTO detalle_boleta VALUES (98,13,260);
INSERT INTO detalle_boleta VALUES (98,14,130);
INSERT INTO detalle_boleta VALUES (99,9,77);
INSERT INTO detalle_boleta VALUES (99,10,297);
INSERT INTO detalle_boleta VALUES (99,1,255);
INSERT INTO detalle_boleta VALUES (100,15,49);
INSERT INTO detalle_boleta VALUES (101,12,99);
INSERT INTO detalle_boleta VALUES (101,7,43);
INSERT INTO detalle_boleta VALUES (102,3,56);
INSERT INTO detalle_boleta VALUES (102,11,166);
INSERT INTO detalle_boleta VALUES (102,5,190);
INSERT INTO detalle_boleta VALUES (102,7,296);
INSERT INTO detalle_boleta VALUES (102,13,233);
INSERT INTO detalle_boleta VALUES (102,2,115);
INSERT INTO detalle_boleta VALUES (102,14,279);
INSERT INTO detalle_boleta VALUES (102,6,85);
INSERT INTO detalle_boleta VALUES (103,15,176);
INSERT INTO detalle_boleta VALUES (103,11,250);
INSERT INTO detalle_boleta VALUES (103,12,131);
INSERT INTO detalle_boleta VALUES (103,8,151);
INSERT INTO detalle_boleta VALUES (103,5,111);
INSERT INTO detalle_boleta VALUES (104,12,114);
INSERT INTO detalle_boleta VALUES (104,14,102);
INSERT INTO detalle_boleta VALUES (104,3,122);
INSERT INTO detalle_boleta VALUES (105,11,258);
INSERT INTO detalle_boleta VALUES (105,15,237);
INSERT INTO detalle_boleta VALUES (105,6,173);
INSERT INTO detalle_boleta VALUES (105,9,155);
INSERT INTO detalle_boleta VALUES (105,12,261);
INSERT INTO detalle_boleta VALUES (105,2,217);
INSERT INTO detalle_boleta VALUES (105,10,206);
INSERT INTO detalle_boleta VALUES (105,3,60);
INSERT INTO detalle_boleta VALUES (106,4,223);
INSERT INTO detalle_boleta VALUES (106,14,154);
INSERT INTO detalle_boleta VALUES (107,12,136);
INSERT INTO detalle_boleta VALUES (107,1,186);
INSERT INTO detalle_boleta VALUES (107,4,278);
INSERT INTO detalle_boleta VALUES (107,5,143);
INSERT INTO detalle_boleta VALUES (107,6,253);
INSERT INTO detalle_boleta VALUES (107,2,147);
INSERT INTO detalle_boleta VALUES (108,15,245);
INSERT INTO detalle_boleta VALUES (108,3,56);
INSERT INTO detalle_boleta VALUES (108,2,280);
INSERT INTO detalle_boleta VALUES (109,2,298);
INSERT INTO detalle_boleta VALUES (109,1,286);
INSERT INTO detalle_boleta VALUES (109,5,65);
INSERT INTO detalle_boleta VALUES (109,10,227);
INSERT INTO detalle_boleta VALUES (109,13,213);
INSERT INTO detalle_boleta VALUES (109,4,186);
INSERT INTO detalle_boleta VALUES (110,9,84);
INSERT INTO detalle_boleta VALUES (110,12,120);
INSERT INTO detalle_boleta VALUES (110,10,231);
INSERT INTO detalle_boleta VALUES (111,2,253);
INSERT INTO detalle_boleta VALUES (111,12,208);
INSERT INTO detalle_boleta VALUES (111,1,100);
INSERT INTO detalle_boleta VALUES (111,14,133);
INSERT INTO detalle_boleta VALUES (111,10,28);
INSERT INTO detalle_boleta VALUES (112,15,294);
INSERT INTO detalle_boleta VALUES (112,3,227);
INSERT INTO detalle_boleta VALUES (113,4,148);
INSERT INTO detalle_boleta VALUES (113,2,256);
INSERT INTO detalle_boleta VALUES (113,6,177);
INSERT INTO detalle_boleta VALUES (114,3,209);
INSERT INTO detalle_boleta VALUES (114,5,154);
INSERT INTO detalle_boleta VALUES (114,12,250);
INSERT INTO detalle_boleta VALUES (114,1,27);
INSERT INTO detalle_boleta VALUES (114,14,192);
INSERT INTO detalle_boleta VALUES (115,9,30);
INSERT INTO detalle_boleta VALUES (115,4,60);
INSERT INTO detalle_boleta VALUES (115,11,277);
INSERT INTO detalle_boleta VALUES (115,3,259);
INSERT INTO detalle_boleta VALUES (115,2,189);
INSERT INTO detalle_boleta VALUES (115,1,249);
INSERT INTO detalle_boleta VALUES (115,6,199);
INSERT INTO detalle_boleta VALUES (115,7,255);
INSERT INTO detalle_boleta VALUES (116,8,79);
INSERT INTO detalle_boleta VALUES (116,10,138);
INSERT INTO detalle_boleta VALUES (116,14,151);
INSERT INTO detalle_boleta VALUES (116,2,95);
INSERT INTO detalle_boleta VALUES (117,10,256);
INSERT INTO detalle_boleta VALUES (118,3,298);
INSERT INTO detalle_boleta VALUES (118,12,149);
INSERT INTO detalle_boleta VALUES (118,4,195);
INSERT INTO detalle_boleta VALUES (118,5,276);
INSERT INTO detalle_boleta VALUES (118,6,260);
INSERT INTO detalle_boleta VALUES (118,8,169);
INSERT INTO detalle_boleta VALUES (118,7,106);
INSERT INTO detalle_boleta VALUES (118,15,267);
INSERT INTO detalle_boleta VALUES (118,1,214);
INSERT INTO detalle_boleta VALUES (118,11,187);
INSERT INTO detalle_boleta VALUES (119,7,30);
INSERT INTO detalle_boleta VALUES (119,1,122);
INSERT INTO detalle_boleta VALUES (119,14,199);
INSERT INTO detalle_boleta VALUES (119,6,81);
INSERT INTO detalle_boleta VALUES (119,8,241);
INSERT INTO detalle_boleta VALUES (119,13,216);
INSERT INTO detalle_boleta VALUES (119,15,223);
INSERT INTO detalle_boleta VALUES (120,7,147);
INSERT INTO detalle_boleta VALUES (120,5,104);
INSERT INTO detalle_boleta VALUES (120,12,225);
INSERT INTO detalle_boleta VALUES (120,13,228);
INSERT INTO detalle_boleta VALUES (120,15,239);

INSERT INTO comision_empleado VALUES (0, 100000, 0);
INSERT INTO comision_empleado VALUES (100001, 200000, 2.4);
INSERT INTO comision_empleado VALUES (200001, 300000, 3.6);
INSERT INTO comision_empleado VALUES (300001, 400000, 4.4);
INSERT INTO comision_empleado VALUES (400001, 900000, 5.6);
INSERT INTO comision_empleado VALUES (900001, 1400000, 5.3);
INSERT INTO comision_empleado VALUES (1400001, 2500000, 4.4);
INSERT INTO comision_empleado VALUES (2500001, 6000000, 3.8);
COMMIT;