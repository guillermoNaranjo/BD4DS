with pagos as (
	select o.customer_id as id_c ,sum(od.quantity*od.unit_price) as total, o.order_id, o.order_date as fecha from order_details od join orders o using (order_id) group by o.order_id, o.customer_id order by o.order_id, fecha 
), pagos_cliente as (
	select p.total as tot, p.id_c as id, extract('month' from p.fecha) as mes, p.fecha as f from pagos p order by p.id_c
) select pc.id, pc.tot as precio_a, lead(pc.tot) over w as precio_Amas1, 
((lead(pc.tot) over w - pc.tot)/pc.tot)*100 as porcentaje from pagos_cliente pc window w as 
(partition by pc.id order by pc.f);




