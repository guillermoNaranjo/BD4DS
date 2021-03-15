--Qué películas son las más rentadas en todas nuestras stores?
select c.customer_id, concat(c.first_name,' ',c.last_name) as "Name", count(f.film_id) from film f 
join inventory i using (film_id) join rental r using 
(inventory_id) join customer c using (customer_id) where 
f.rating ='NC-17' group by c.customer_id, "Name" order by count(f.film_id)
desc limit 2;
--Cómo obtenemos todos los nombres y correos de nuestros clientes canadienses para una campaña?
select concat(c2.first_name, ' ', c2.last_name), c2.email from country c join city using (country_id) join 
address a using (city_id) join store s using (address_id) join customer c2 using (store_id) where c.country='Canada'; 
--Cuál es nuestro revenue por store?
select store_id,  sum(p.amount) from payment p join staff s using (staff_id) join store using (store_id) group by store_id; 
--Qué películas son las más rentadas en todas nuestras stores? (top 10 más rentadas en todas las tiendas)
select count(i.film_id) as "Numero de rentas", f.title as "Pelicula" from rental r 
join inventory i using (inventory_id) join store s using 
(store_id) join film f using (film_id) 
group by f.title order by count(i.film_id) desc limit 10;