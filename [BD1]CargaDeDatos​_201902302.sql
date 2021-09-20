-- PAIS
insert into pais(nombre)
SELECT DISTINCT PAIS_CLIENTE from temporal where PAIS_CLIENTE!='-';
-- TIENDA
insert into tienda (direccion,nombre)
select DISTINCT DIRECCION_TIENDA ,NOMBRE_TIENDA from temporal 
where direccion_tienda !='-' and nombre_tienda != '-';
-- CATEGORIA
insert into CATEGORIA (DESCRIPCION)
select distinct CATEGORIA_PELICULA from temporal where CATEGORIA_PELICULA!='-';
-- USUARIO EMPLEADO
INSERT INTO usuario_empleado (usuario,contrasena)
select DISTINCT T.USUARIO_EMPLEADO,T.CONTRASENA_EMPLEADO FROM TEMPORAL T where t.usuario_empleado !='-';
-- CLASIFICACION
insert into CLASIFICACION (nombre)
select DISTINCT T.CLASIFICACION from TEMPORAL T where t.clasificacion!='-';
-- ENTREGA
insert into entrega
(titulo,descripcion,duracion,lanzamiento,clasificacion_id_clasificacion)
SELECT DISTINCT T.NOMBRE_PELICULA,T.DESCRIPCION_PELICULA,(cast (t.DURACION as iNTEGER)) as duracion,
(cast (t.ANO_LANZAMIENTO as iNTEGER)) as lanzamiento,
(select id_clasificacion from clasificacion where nombre=t.CLASIFICACION) as cla
from temporal T where t.duracion!='-' and t.ANO_LANZAMIENTO!='-';
-- ACTOR
INSERT INTO actor (nombre,apellido)
SELECT DISTINCT SUBSTR(T.ACTOR_PELICULA, 1, INSTR(T.ACTOR_PELICULA, ' ')-1) AS nombre,
       SUBSTR(T.ACTOR_PELICULA, INSTR(T.ACTOR_PELICULA, ' ')+1) AS apellido
FROM temporal T where SUBSTR(T.ACTOR_PELICULA, 1, INSTR(T.ACTOR_PELICULA, ' ')-1) is not null;
-- CIUDAD
INSERT INTO CIUDAD (CIUDAD,pais_id_pais)
SELECT DISTINCT T.CIUDAD_CLIENTE,
(select id_pais from pais where nombre=t.PAIS_CLIENTE)FROM TEMPORAL T where t.CIUDAD_CLIENTE!='-' and t.pais_cliente!='-'
UNION
SELECT DISTINCT t.CIUDAD_TIENDA,(select id_pais from pais where nombre=t.PAIS_TIENDA)
FROM TEMPORAL T where t.ciudad_tienda!='-';
-- DIRECCION
INSERT INTO DIRECCION(DIRECCION,CIUDAD_ID_CIUDAD,CODIGO_POSTAL)
SELECT DISTINCT T.DIRECCION_CLIENTE,
(SELECT C.ID_CIUDAD FROM CIUDAD C WHERE c.pais_id_pais=(select id_pais from pais where nombre=T.PAIS_CLIENTE)
AND C.CIUDAD=T.CIUDAD_CLIENTE) AS IDE,T.CODIGO_POSTAL_CLIENTE
FROM TEMPORAL T where t.direccion_cliente!='-';
-- CLIENTE
insert into cliente (correo,estado,nombre,apellido,fecha_registro,direccion_id_direccion,tienda_id_tienda)
select  DISTINCT t.correo_cliente,t.cliente_activo,SUBSTR(T.nombre_cliente, 1, INSTR(T.nombre_cliente, ' ')-1) AS nombre,
       SUBSTR(T.nombre_cliente, INSTR(T.nombre_cliente, ' ')+1) AS apellido,TO_DATE(t.fecha_creacion,'DD-MM-YY') as fecha,
       (SELECT C.ID_CIUDAD FROM CIUDAD C WHERE c.pais_id_pais=(SELECT ID_PAIS FROM PAIS WHERE NOMBRE=T.PAIS_CLIENTE) AND C.CIUDAD=T.CIUDAD_CLIENTE) AS IDE_ciudad,
       (select id_tienda from tienda where nombre = t.TIENDA_PREFERIDA) as tienda
from temporal T
where t.nombre_cliente !='-';
-- EMPLEADO
INSERT INTO EMPLEADO
(nombre,apellido,correo,direccion_id_direccion,activo,usuario_empleado_id_usuario,tienda_id_tienda,tipo_empleado)
SELECT DISTINCT SUBSTR(T.NOMBRE_EMPLEADO, 1, INSTR(T.NOMBRE_EMPLEADO, ' ')-1) AS nombre,
       SUBSTR(T.NOMBRE_EMPLEADO, INSTR(T.NOMBRE_EMPLEADO, ' ')+1) AS apellido,t.CORREO_EMPLEADO,
       (select id_direccion from direccion where direccion=t.direccion_empleado) as direc,
       t.EMPLEADO_ACTIVO,(select id_usuario from usuario_empleado where usuario=t.USUARIO_EMPLEADO) as ussr,
       (select id_tienda from tienda where nombre=t.NOMBRE_TIENDA) idti,
       case t.ENCARGADO_TIENDA 
       when t.NOMBRE_EMPLEADO then 'encargado'
       else 'empleado' end as tipo
from temporal t where t.nombre_empleado!='-';
-- categoria entrega
INSERT INTO CATEGORIA_ENTREGA
(Entrega_id_entrega,categoria_id_categoria)
select distinct 
(SELECT id_entrega from entrega where titulo=T.NOMBRE_PELICULA) AS IDEPELI,
(select id_categoria from categoria where descripcion=t.categoria_pelicula) as IDECATE 
from temporal T
where nombre_pelicula!='-';
-- actor entrega
INSERT INTO actor_entrega
(entrega_id_entrega,actor_id_actor)
SELECT DISTINCT 
(select id_entrega from entrega where titulo=T.NOMBRE_PELICULA) AS IDPELI,
(select id_actor from actor where (nombre||' '||apellido)=t.actor_pelicula) as ideacto
from temporal T 
where t.nombre_pelicula!='-' and SUBSTR(T.ACTOR_PELICULA, 1, INSTR(T.ACTOR_PELICULA, ' ')-1) is not null;
-- LENGUAJE 
INSERT INTO LENGUAJE
(LENGUAJE)
SELECT DISTINCT LENGUAJE_PELICULA FROM TEMPORAL where lenguaje_pelicula!='-';
-- PELICULA O INVENTARIO
insert into pelicula(entrega_id_entrega,tienda_id_tienda,lenguaje_id_lenguaje,dias_renta,costo_renta,dano_renta)
select distinct (select id_entrega from entrega where titulo=nombre_pelicula)idepeli,
(select id_tienda from tienda where nombre=tienda_pelicula)idetien,
(SELECT id_lenguaje from LENGUAJE where lenguaje=LENGUAJE_PELICULA)idlen,
(cast (DIAS_RENTA as iNTEGER)) as dias,cast(REPLACE(COSTO_RENTA, '.', ',') as real) costo ,cast(REPLACE(COSTO_POR_DANO, '.', ',') as real) dano
from temporal 
where nombre_pelicula!='-' and tienda_pelicula!='-';
-- RENTA
insert into renta
(pelicula_id_pelicula,cliente_id_cliente,empleado_id_empleado,tienda_id_tienda,fecha_renta,fecha_retorno,monto_pagar,fecha_pago)
SELECT DISTINCT 
(select P.id_pelicula from pelicula P
where P.entrega_id_entrega=(select id_entrega from entrega where titulo=t.nombre_pelicula) 
and P.tienda_id_tienda=(select id_tienda from tienda where nombre=T.TIENDA_PELICULA)) idepeli,

(select id_cliente from cliente where (nombre||' '||apellido)=t.nombre_cliente) idecli,

(select id_empleado from empleado where (nombre||' '||apellido)=t.nombre_empleado) ideemple,

(select id_tienda from tienda where nombre=T.TIENDA_PELICULA) ideti,

TO_TIMESTAMP (t.FECHA_RENTA, 'DD/MM/YYYY HH24:MI')FECHA_RENTA,

case FECHA_RETORNO when 
'-' then null
else TO_TIMESTAMP (t.FECHA_RETORNO, 'DD/MM/YYYY HH24:MI') end fecharet,

cast(REPLACE(t.monto_a_pagar, '.', ',') as real) montopago,

TO_TIMESTAMP (t.FECHA_PAGO, 'DD/MM/YYYY HH24:MI')FECHA_PAGO
FROM TEMPORAL T where NOMBRE_CLIENTE!='-' and nombre_pelicula!='-' and fecha_renta!='-' and tienda_pelicula!='-' and nombre_empleado!='-'
and COSTO_RENTA!='-';