-- CONSULTA 1
select count(p.id_pelicula) as cantidad_pelicula from pelicula p where
p.entrega_id_entrega = (select id_entrega from entrega where titulo='Sugar Wonka');
-- CONSULTA 2
select nombre,apellido,sum(r.monto_pagar) pago
from renta r,cliente c
where  r.cliente_id_cliente=c.id_cliente and
(select count(id_renta) from renta where cliente_id_cliente=c.id_cliente) >= 40
group by c.nombre,c.apellido;
-- consulta 3
select c.nombre,c.apellido,fecha_renta,
(select titulo from entrega where id_entrega=(select entrega_id_entrega from pelicula where id_pelicula=r.pelicula_id_pelicula)) as titulo,
sysdate-r.fecha_renta as diferencia
from cliente c, renta r
where r.cliente_id_cliente=c.id_cliente and r.fecha_retorno is null 
and (sysdate-r.fecha_renta)>(select dias_renta from pelicula where id_pelicula=r.pelicula_id_pelicula);
-- consulta 4
select a.nombre||' '||a.apellido nombre_completo from actor a 
where lower(a.apellido) like '%son%'
order by a.nombre;
-- CONSULTA 5
select a.apellido,
(select count(id_actor) from actor where apellido=a.apellido) num
from actor a  where(select count(id_actor) from actor  where nombre=a.nombre)>=2
group by a.apellido;
-- CONSULTA 6
select distinct a.nombre,a.apellido,e.lanzamiento
from actor a, entrega e,actor_entrega ae
where ae.entrega_id_entrega=e.id_entrega and ae.actor_id_actor=a.id_actor and
(e.descripcion like ('%Crocodile%') and e.descripcion like '%Shark%')
order by a.apellido asc;
-- consulta 7
select c.descripcion,
count(c.id_categoria) no_peliculas
from categoria c, categoria_entrega cae
where c.id_categoria=cae.categoria_id_categoria
and  (select count(id_categoria_entrega) from categoria_entrega where categoria_id_categoria=c.id_categoria) BETWEEN 55 and 65
group by c.descripcion order by no_peliculas desc;
-- consulta 8
select c.descripcion,
(select avg((select avg(dano_renta-costo_renta) from pelicula  
where entrega_id_entrega=cae.entrega_id_entrega) )
from categoria_entrega cae where cae.categoria_id_categoria=c.id_categoria) as promedio
from categoria c where
(select avg((select avg(dano_renta-costo_renta) from pelicula  where entrega_id_entrega=cae.entrega_id_entrega) )
from categoria_entrega cae where cae.categoria_id_categoria=c.id_categoria)>17;
-- consulta 9
select e.titulo,a.nombre,a.apellido,
(select count(id_actor_entrega) from actor_entrega where actor_id_actor=a.id_actor) no_pelis
from entrega e, actor a , actor_entrega ac 
where e.id_entrega=ac.entrega_id_entrega and a.id_actor=ac.actor_id_actor
and (select count(id_actor_entrega) from actor_entrega where actor_id_actor=a.id_actor)>=2;
-- consulta 10
select a.nombre||' '||a.apellido actor,c.nombre||' '||c.apellido cliente
from actor a, cliente c
where a.nombre=c.nombre and c.nombre=(select nombre from actor where id_actor=8) and a.id_actor!=8;
-- CONSULTA 11
SELECT P.NOMBRE,C.NOMBRE,
((select count(cliente_id_cliente) from renta where cliente_id_cliente=c.id_cliente)/
(select count(id_renta) from renta where cliente_id_cliente in  (select id_cliente from cliente where direccion_id_direccion 
in (select id_direccion from direccion where ciudad_id_ciudad in 
(select id_ciudad from ciudad where pais_id_pais=1)))  )* 100) porcentaje
from pais p, cliente c where 
c.direccion_id_direccion in (select id_direccion from direccion where ciudad_id_ciudad in 
(select id_ciudad from ciudad where pais_id_pais=p.id_pais)) order by porcentaje desc;
-- CONSULTA 12
-- CONSULTA 13
SELECT P.NOMBRE,C.NOMBRE,
(select count(cliente_id_cliente) from renta where cliente_id_cliente=c.id_cliente) rentadas
from pais p, cliente c where 
c.direccion_id_direccion in (select id_direccion from direccion where ciudad_id_ciudad in 
(select id_ciudad from ciudad where pais_id_pais=p.id_pais)) order by rentadas desc;
-- CONSULTA 15
select p.nombre,ciu.ciudad,trunc(
(select count(id_renta) from renta where cliente_id_cliente in (select id_cliente from cliente where direccion_id_direccion 
in (select id_direccion from direccion where ciudad_id_ciudad in(select id_ciudad from ciudad where pais_id_pais=p.id_pais))))/
(select count(id_ciudad) from ciudad where pais_id_pais=p.id_pais),4) promedio
from pais p, ciudad ciu 
where p.id_pais=ciu.pais_id_pais order by p.nombre;
-- CONSULTA 16
select p.nombre,((
select count(id_renta) from renta where 
-- cliente del pais
cliente_id_cliente in (select id_cliente from cliente where direccion_id_direccion 
in (select id_direccion from direccion where ciudad_id_ciudad in(select id_ciudad from ciudad where pais_id_pais=p.id_pais)))
-- pelicula con categoria
and pelicula_id_pelicula in (select id_pelicula from pelicula where entrega_id_entrega
in (select entrega_id_entrega from categoria_entrega where categoria_id_categoria=(select id_categoria from categoria where descripcion='Sports')))
)/(select count(id_renta) from renta where cliente_id_cliente in (select id_cliente from cliente where direccion_id_direccion 
in (select id_direccion from direccion where ciudad_id_ciudad in(select id_ciudad from ciudad where pais_id_pais=p.id_pais))))*100 ) porcentaje from pais p;
-- CONSULTA 20
select c.ciudad,l.lenguaje,100
from pelicula p, lenguaje l,ciudad c
where p.lenguaje_id_lenguaje=l.id_lenguaje and
(select max(extract(year from fecha_renta)) from renta where pelicula_id_pelicula=p.id_pelicula)=2005 
and 7 in (select extract(month from fecha_renta) from renta where pelicula_id_pelicula=p.id_pelicula) 
group by c.ciudad,l.lenguaje;


