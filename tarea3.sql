--1.-Promedio de tiempo entre pagos en forma de vista 
create view promedios as 
with pagos as (
	select p.payment_id as id, p.payment_date as inicio from payment p where p.payment_id>1
), fechas as (
	select p.customer_id as id_c, count(p.payment_id) as num, sum(age(pagos.inicio,p.payment_date)) as intervalo from payment p
	join pagos on (p.payment_id =pagos.id-1) where age(pagos.inicio, p.payment_date)>'00:00'::interval group by p.customer_id
) select p2.customer_id, fechas.intervalo/fechas.num as tiempo, c.first_name || ' '|| c.last_name as "Nombre Completo"
from payment p2 join fechas on (p2.customer_id=fechas.id_c) join customer c using (customer_id) group by 
p2.customer_id, fechas.intervalo/fechas.num, "Nombre Completo" order by p2.customer_id;

create view promedios_segundos as (select p.customer_id, p."Nombre Completo", extract(epoch from tiempo) from promedios p);
--2.- no sigue una distribución normal los intervalos de tiempo ya que no es simétrica y además decrece hasta el "bucket" 8 y después vuleve a incrementa
select * from histogram('promedios_segundos', 'date_part');--visualización de la distribución de los tiempos entre pagos de los clientes
select sum(p2.tiempo)/count(*) from promedios p2; --promedio de tiempo entre pagos de los clientes (4 days 28:39:44.747798)
select extract(epoch from '4 days 28:39:44.747798'::interval);--cast de interval a bigint del promedio para verificar a que "bucket" pertence el promedio 
/* 448784.747798 es el promedio de segundos que tardan en promedio entre los pagos los clientes, notamos que 
 * corresponde a la "bucket" 5 por lo que nuestra distribución no es simétrica respecto a la media,
 * y por lo tanto, no es una distribución normal 
 */

--vista del tiempo entre rentas por cliente 
create view tiempo_entre_rentas as 
with dif as (
	select r.customer_id as id, sum(age(r.return_date,r.rental_date)) as tiempo from rental r group by r.customer_id order by r.customer_id 
), tot as (
	select r.customer_id as id_t, count(r.rental_id) as num from rental r group by r.customer_id order by r.customer_id 
) select r2.customer_id, dif.tiempo/tot.num as tiempoP from rental r2 join dif on (dif.id=r2.customer_id) 
join tot on (tot.id_t=r2.customer_id) group by r2.customer_id,tiempoP order by r2.customer_id;

--diferencia del tiempo entre rentas y el tiempo entre pagos por cliente 
select p.customer_id, p."Nombre Completo", p.tiempo as "tiempo entre pagos", te.tiempop as "tiempo entre rentas",  
te.tiempop-p.tiempo as "diferencia" from promedios p join tiempo_entre_rentas te on (te.customer_id=p.customer_id) order by p.customer_id;

--diferencia del tiempo entre rentas y el tiempo entre pagos promedio de todos los clientes
select sum(p.tiempo)/count(*) as "promedio entre pagos", sum(ter.tiempop)/count(*) as "promedio entre rentas", 
sum(p.tiempo)/count(*)-sum(ter.tiempop)/count(*) as "diferencia" from promedios p join tiempo_entre_rentas ter on 
(ter.customer_id=p.customer_id);--la gente en promedio hace un pago cada 4 días 28:39:44 (5 días 4 horas) mientras que hace una renta cada 3 días 47:05:40 (4 días 23 horas)
--difieren en 1 día -18:25:55.339534 (aproximadamente 6 horas) el promedio de pagos del promedio de rentas

drop view promedios;--eliminar vistas usadas 

drop view promedios_segundos; --eliminar vistas usadas 

drop view tiempo_entre_rentas;

