drop SEQUENCE ciudad_id_ciudad_seq;
drop SEQUENCE cliente_id_cliente_seq;
drop SEQUENCE direccion_id_direccion_seq;
drop SEQUENCE usuario_empleado_id_usuario;
drop SEQUENCE actor_id_actor_seq;
drop SEQUENCE clasificacion_id_clasificacion;
drop SEQUENCE categoria_id_categoria_seq;
drop SEQUENCE tienda_id_tienda_seq;
drop SEQUENCE  empleado_id_empleado_seq;
drop SEQUENCE entrega_id_entrega_seq;
drop SEQUENCE actor_entrega_id_actor_entrega;
drop SEQUENCE categoria_entrega_id_categoria;
drop SEQUENCE lenguaje_id_lenguaje_seq;
drop SEQUENCE pelicula_id_pelicula_seq;
drop SEQUENCE renta_id_renta_seq;
drop SEQUENCE pais_id_pais_seq;

drop table pais;
drop table renta;
DROP TABLE EMPLEADO;
drop table cliente;
drop table direccion;
drop table ciudad;
drop table categoria_entrega;
drop table actor_entrega;
drop table pelicula;
DROP TABLE ENTREGA;
drop table CLASIFICACION;
drop table actor;
drop table usuario_empleado;
drop table categoria;
drop table tienda;
drop table lenguaje;

-- Generado por Oracle SQL Developer Data Modeler 20.4.0.374.0801
--   en:        2021-09-19 19:32:19 CST
--   sitio:      Oracle Database 11g
--   tipo:      Oracle Database 11g



-- predefined type, no DDL - MDSYS.SDO_GEOMETRY

-- predefined type, no DDL - XMLTYPE

CREATE TABLE actor (
    id_actor  INTEGER NOT NULL,
    nombre    VARCHAR2(20),
    apellido  VARCHAR2(20)
);

ALTER TABLE actor ADD CONSTRAINT actor_pk PRIMARY KEY ( id_actor );

CREATE TABLE actor_entrega (
    id_actor_entrega    INTEGER NOT NULL,
    actor_id_actor      INTEGER NOT NULL,
    entrega_id_entrega  INTEGER NOT NULL
);

ALTER TABLE actor_entrega ADD CONSTRAINT actor_entrega_pk PRIMARY KEY ( id_actor_entrega );

CREATE TABLE categoria (
    id_categoria  INTEGER NOT NULL,
    descripcion   VARCHAR2(15)
);

ALTER TABLE categoria ADD CONSTRAINT categoria_pk PRIMARY KEY ( id_categoria );

CREATE TABLE categoria_entrega (
    id_categoria_entrega    INTEGER NOT NULL,
    categoria_id_categoria  INTEGER NOT NULL,
    entrega_id_entrega      INTEGER NOT NULL
);

ALTER TABLE categoria_entrega ADD CONSTRAINT categoria_entrega_pk PRIMARY KEY ( id_categoria_entrega );

CREATE TABLE ciudad (
    id_ciudad     INTEGER NOT NULL,
    ciudad        VARCHAR2(30),
    pais_id_pais  INTEGER NOT NULL
);

ALTER TABLE ciudad ADD CONSTRAINT ciudad_pk PRIMARY KEY ( id_ciudad );

CREATE TABLE clasificacion (
    id_clasificacion  INTEGER NOT NULL,
    nombre            VARCHAR2(10)
);

ALTER TABLE clasificacion ADD CONSTRAINT clasificacion_pk PRIMARY KEY ( id_clasificacion );

CREATE TABLE cliente (
    id_cliente              INTEGER NOT NULL,
    nombre                  VARCHAR2(20) NOT NULL,
    apellido                VARCHAR2(20),
    correo                  VARCHAR2(35),
    fecha_registro          DATE NOT NULL,
    estado                  VARCHAR2(5) NOT NULL,
    direccion_id_direccion  INTEGER NOT NULL,
    tienda_id_tienda        INTEGER NOT NULL
);

ALTER TABLE cliente ADD CONSTRAINT cliente_pk PRIMARY KEY ( id_cliente );

CREATE TABLE direccion (
    id_direccion      INTEGER NOT NULL,
    direccion         VARCHAR2(40),
    codigo_postal     INTEGER,
    ciudad_id_ciudad  INTEGER NOT NULL
);

ALTER TABLE direccion ADD CONSTRAINT direccion_pk PRIMARY KEY ( id_direccion );

CREATE TABLE empleado (
    id_empleado                  INTEGER NOT NULL,
    nombre                       VARCHAR2(15),
    apellido                     VARCHAR2(15),
    activo                       VARCHAR2(5),
    tipo_empleado                VARCHAR2(15),
    correo                       VARCHAR2(30),
    direccion_id_direccion       INTEGER NOT NULL,
    tienda_id_tienda             INTEGER NOT NULL,
    usuario_empleado_id_usuario  INTEGER NOT NULL
);

ALTER TABLE empleado ADD CONSTRAINT empleado_pk PRIMARY KEY ( id_empleado );

CREATE TABLE entrega (
    id_entrega                      INTEGER NOT NULL,
    titulo                          VARCHAR2(30),
    descripcion                     VARCHAR2(130),
    lanzamiento                     INTEGER,
    duracion                        INTEGER,
    clasificacion_id_clasificacion  INTEGER NOT NULL
);

ALTER TABLE entrega ADD CONSTRAINT entrega_pk PRIMARY KEY ( id_entrega );

CREATE TABLE lenguaje (
    id_lenguaje  INTEGER NOT NULL,
    lenguaje     VARCHAR2(25)
);

ALTER TABLE lenguaje ADD CONSTRAINT lenguaje_pk PRIMARY KEY ( id_lenguaje );

CREATE TABLE pais (
    id_pais  INTEGER NOT NULL,
    nombre   VARCHAR2(40)
);

ALTER TABLE pais ADD CONSTRAINT pais_pk PRIMARY KEY ( id_pais );

CREATE TABLE pelicula (
    id_pelicula           INTEGER NOT NULL,
    dias_renta            INTEGER,
    costo_renta           REAL,
    dano_renta            REAL,
    lenguaje_id_lenguaje  INTEGER NOT NULL,
    tienda_id_tienda      INTEGER NOT NULL,
    entrega_id_entrega    INTEGER NOT NULL
);

ALTER TABLE pelicula ADD CONSTRAINT pelicula_pk PRIMARY KEY ( id_pelicula );

CREATE TABLE renta (
    id_renta              INTEGER NOT NULL,
    fecha_renta           DATE NOT NULL,
    fecha_retorno         DATE,
    monto_pagar           REAL NOT NULL,
    fecha_pago            DATE,
    cliente_id_cliente    INTEGER NOT NULL,
    empleado_id_empleado  INTEGER NOT NULL,
    tienda_id_tienda      INTEGER NOT NULL,
    pelicula_id_pelicula  INTEGER NOT NULL
);

ALTER TABLE renta ADD CONSTRAINT renta_pk PRIMARY KEY ( id_renta );

CREATE TABLE tienda (
    id_tienda  INTEGER NOT NULL,
    nombre     VARCHAR2(15),
    direccion  VARCHAR2(40)
);

ALTER TABLE tienda ADD CONSTRAINT tienda_pk PRIMARY KEY ( id_tienda );

CREATE TABLE usuario_empleado (
    id_usuario  INTEGER NOT NULL,
    usuario     VARCHAR2(20),
    contrasena  VARCHAR2(50)
);

ALTER TABLE usuario_empleado ADD CONSTRAINT usuario_empleado_pk PRIMARY KEY ( id_usuario );

ALTER TABLE actor_entrega
    ADD CONSTRAINT actor_entrega_actor_fk FOREIGN KEY ( actor_id_actor )
        REFERENCES actor ( id_actor );

ALTER TABLE actor_entrega
    ADD CONSTRAINT actor_entrega_entrega_fk FOREIGN KEY ( entrega_id_entrega )
        REFERENCES entrega ( id_entrega );

ALTER TABLE categoria_entrega
    ADD CONSTRAINT categoria_entrega_categoria_fk FOREIGN KEY ( categoria_id_categoria )
        REFERENCES categoria ( id_categoria );

ALTER TABLE categoria_entrega
    ADD CONSTRAINT categoria_entrega_entrega_fk FOREIGN KEY ( entrega_id_entrega )
        REFERENCES entrega ( id_entrega );

ALTER TABLE ciudad
    ADD CONSTRAINT ciudad_pais_fk FOREIGN KEY ( pais_id_pais )
        REFERENCES pais ( id_pais );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE cliente
    ADD CONSTRAINT cliente_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE direccion
    ADD CONSTRAINT direccion_ciudad_fk FOREIGN KEY ( ciudad_id_ciudad )
        REFERENCES ciudad ( id_ciudad );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_direccion_fk FOREIGN KEY ( direccion_id_direccion )
        REFERENCES direccion ( id_direccion );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE empleado
    ADD CONSTRAINT empleado_usuario_empleado_fk FOREIGN KEY ( usuario_empleado_id_usuario )
        REFERENCES usuario_empleado ( id_usuario );

ALTER TABLE entrega
    ADD CONSTRAINT entrega_clasificacion_fk FOREIGN KEY ( clasificacion_id_clasificacion )
        REFERENCES clasificacion ( id_clasificacion );

ALTER TABLE pelicula
    ADD CONSTRAINT pelicula_entrega_fk FOREIGN KEY ( entrega_id_entrega )
        REFERENCES entrega ( id_entrega );

ALTER TABLE pelicula
    ADD CONSTRAINT pelicula_lenguaje_fk FOREIGN KEY ( lenguaje_id_lenguaje )
        REFERENCES lenguaje ( id_lenguaje );

ALTER TABLE pelicula
    ADD CONSTRAINT pelicula_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

ALTER TABLE renta
    ADD CONSTRAINT renta_cliente_fk FOREIGN KEY ( cliente_id_cliente )
        REFERENCES cliente ( id_cliente );

ALTER TABLE renta
    ADD CONSTRAINT renta_empleado_fk FOREIGN KEY ( empleado_id_empleado )
        REFERENCES empleado ( id_empleado );

ALTER TABLE renta
    ADD CONSTRAINT renta_pelicula_fk FOREIGN KEY ( pelicula_id_pelicula )
        REFERENCES pelicula ( id_pelicula );

ALTER TABLE renta
    ADD CONSTRAINT renta_tienda_fk FOREIGN KEY ( tienda_id_tienda )
        REFERENCES tienda ( id_tienda );

CREATE SEQUENCE actor_id_actor_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER actor_id_actor_trg BEFORE
    INSERT ON actor
    FOR EACH ROW
BEGIN
    :new.id_actor := actor_id_actor_seq.nextval;
END;
/

CREATE SEQUENCE actor_entrega_id_actor_entrega START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER actor_entrega_id_actor_entrega BEFORE
    INSERT ON actor_entrega
    FOR EACH ROW
BEGIN
    :new.id_actor_entrega := actor_entrega_id_actor_entrega.nextval;
END;
/

CREATE SEQUENCE categoria_id_categoria_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER categoria_id_categoria_trg BEFORE
    INSERT ON categoria
    FOR EACH ROW
BEGIN
    :new.id_categoria := categoria_id_categoria_seq.nextval;
END;
/

CREATE SEQUENCE categoria_entrega_id_categoria START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER categoria_entrega_id_categoria BEFORE
    INSERT ON categoria_entrega
    FOR EACH ROW
BEGIN
    :new.id_categoria_entrega := categoria_entrega_id_categoria.nextval;
END;
/

CREATE SEQUENCE ciudad_id_ciudad_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER ciudad_id_ciudad_trg BEFORE
    INSERT ON ciudad
    FOR EACH ROW
BEGIN
    :new.id_ciudad := ciudad_id_ciudad_seq.nextval;
END;
/

CREATE SEQUENCE clasificacion_id_clasificacion START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER clasificacion_id_clasificacion BEFORE
    INSERT ON clasificacion
    FOR EACH ROW
BEGIN
    :new.id_clasificacion := clasificacion_id_clasificacion.nextval;
END;
/

CREATE SEQUENCE cliente_id_cliente_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER cliente_id_cliente_trg BEFORE
    INSERT ON cliente
    FOR EACH ROW
BEGIN
    :new.id_cliente := cliente_id_cliente_seq.nextval;
END;
/

CREATE SEQUENCE direccion_id_direccion_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER direccion_id_direccion_trg BEFORE
    INSERT ON direccion
    FOR EACH ROW
BEGIN
    :new.id_direccion := direccion_id_direccion_seq.nextval;
END;
/

CREATE SEQUENCE empleado_id_empleado_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER empleado_id_empleado_trg BEFORE
    INSERT ON empleado
    FOR EACH ROW
BEGIN
    :new.id_empleado := empleado_id_empleado_seq.nextval;
END;
/

CREATE SEQUENCE entrega_id_entrega_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER entrega_id_entrega_trg BEFORE
    INSERT ON entrega
    FOR EACH ROW
BEGIN
    :new.id_entrega := entrega_id_entrega_seq.nextval;
END;
/

CREATE SEQUENCE lenguaje_id_lenguaje_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER lenguaje_id_lenguaje_trg BEFORE
    INSERT ON lenguaje
    FOR EACH ROW
BEGIN
    :new.id_lenguaje := lenguaje_id_lenguaje_seq.nextval;
END;
/

CREATE SEQUENCE pais_id_pais_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pais_id_pais_trg BEFORE
    INSERT ON pais
    FOR EACH ROW
BEGIN
    :new.id_pais := pais_id_pais_seq.nextval;
END;
/

CREATE SEQUENCE pelicula_id_pelicula_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER pelicula_id_pelicula_trg BEFORE
    INSERT ON pelicula
    FOR EACH ROW
BEGIN
    :new.id_pelicula := pelicula_id_pelicula_seq.nextval;
END;
/

CREATE SEQUENCE renta_id_renta_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER renta_id_renta_trg BEFORE
    INSERT ON renta
    FOR EACH ROW
BEGIN
    :new.id_renta := renta_id_renta_seq.nextval;
END;
/

CREATE SEQUENCE tienda_id_tienda_seq START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER tienda_id_tienda_trg BEFORE
    INSERT ON tienda
    FOR EACH ROW
BEGIN
    :new.id_tienda := tienda_id_tienda_seq.nextval;
END;
/

CREATE SEQUENCE usuario_empleado_id_usuario START WITH 1 NOCACHE ORDER;

CREATE OR REPLACE TRIGGER usuario_empleado_id_usuario BEFORE
    INSERT ON usuario_empleado
    FOR EACH ROW
BEGIN
    :new.id_usuario := usuario_empleado_id_usuario.nextval;
END;
/



-- Informe de Resumen de Oracle SQL Developer Data Modeler: 
-- 
-- CREATE TABLE                            16
-- CREATE INDEX                             0
-- ALTER TABLE                             35
-- CREATE VIEW                              0
-- ALTER VIEW                               0
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                          16
-- ALTER TRIGGER                            0
-- CREATE COLLECTION TYPE                   0
-- CREATE STRUCTURED TYPE                   0
-- CREATE STRUCTURED TYPE BODY              0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                         16
-- CREATE MATERIALIZED VIEW                 0
-- CREATE MATERIALIZED VIEW LOG             0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- REDACTION POLICY                         0
-- 
-- ORDS DROP SCHEMA                         0
-- ORDS ENABLE SCHEMA                       0
-- ORDS ENABLE OBJECT                       0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
