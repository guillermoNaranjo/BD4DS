select count(*) from inventory i; --tenemos 4581 películas en total 

select i2.store_id, count(*) from inventory i2 group by 
i2.store_id;--tenemos 2270 películas en la store 1 y 2311 en la 2

select (2270*0.5)/50;--Numero de contenedores para store 1 (22.7->23)

select (2311*0.5)/50;--Número de contenedores para store 2 (23.11->24)

select (50/0.5);--Número de pelícculas por cada cilindro (100)

select (5040*100);--Volumen que deben almacenar los cilindros sin desperdiciar espacio 

--Asumiendo que almacenamos 4 películas por cada nivel del cilindro 
--y que entre cada nivel de películas hay 0.25 cm de separacion (para
--estructura del cilindro) tenemos que la altura del cilindro es de: 
select (25*8)+(25*0.25);-- 85 cm de altura

select (pi()*(40*40)*206.25)--V=1,036,725 cm^3  

select (pi()*(40^2)*206.25)-(5040*100)--Volúmen desperdiciado= 532,725 cm^3

/*Las medidas del cilindro serán de 40 cm de radio y 206.25 cm de altura
la tienda 1 necesitará de 23 contenedores para almacenar sus películas mientras que 
la tienda 2 necesitará de 24 contenedores para almacenar sus películas 
Nota: la decisión de usar un contenedor cilíndrico para almacenar las películas 
no es óptimo ya que se desperdicia mucho volumen del cilindro (532,725 cm^3) por la forma rectangular
del arnés en el que se guardan las películas */



