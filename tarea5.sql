with pagos as (
	select o.customer_id as id_c ,sum(od.quantity*od.unit_price) as total, o.order_id, o.order_date as fecha from order_details od join orders o using (order_id) group by o.order_id, o.customer_id order by o.order_id, fecha 
), pagos_cliente as (
	select p.total as tot, p.id_c as id, extract('month' from p.fecha) as mes, p.fecha as f from pagos p order by p.id_c
), delta as ( 
	select pc.id as cliente, pc.tot as precio_a, lag(pc.tot) over w as precio_Amas1, 
	(pc.tot-lag(pc.tot) over w) as diferencia from pagos_cliente pc window w as 
	(partition by pc.id order by pc.f)
), diferencias as ( 
	select d.cliente as cliente, sum(d.diferencia)/(count(*)-1) as crecimiento from delta d group by d.cliente
) select d.cliente, d.crecimiento, case 
	when d.crecimiento<=0 then 'Malo'
	when d.crecimiento>=0 and d.crecimiento<=100 then 'regular'
	when d.crecimiento>100 then 'Bueno' 
	else 'Bueno'
	end as "Categoría cliente" from diferencias d 




