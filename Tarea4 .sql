select count(*) from inventory i; --tenemos 4581 pel�culas en total 

select i2.store_id, count(*) from inventory i2 group by 
i2.store_id;--tenemos 2270 pel�culas en la store 1 y 2311 en la 2

select (2270*0.5)/50;--Numero de contenedores para store 1 (22.7->23)

select (2311*0.5)/50;--N�mero de contenedores para store 2 (23.11->24)

select (50/0.5);--N�mero de pel�cculas por cada cilindro (100)

select (5040*100);--Volumen que deben almacenar los cilindros sin desperdiciar espacio 

--Asumiendo que almacenamos 4 pel�culas por cada nivel del cilindro 
--y que entre cada nivel de pel�culas hay 0.25 cm de separacion (para
--estructura del cilindro) tenemos que la altura del cilindro es de: 
select (25*8)+(25*0.25);-- 85 cm de altura

select (pi()*(40*40)*206.25)--V=1,036,725 cm^3  

select (pi()*(40^2)*206.25)-(5040*100)--Vol�men desperdiciado= 532,725 cm^3

/*Las medidas del cilindro ser�n de 40 cm de radio y 206.25 cm de altura
la tienda 1 necesitar� de 23 contenedores para almacenar sus pel�culas mientras que 
la tienda 2 necesitar� de 24 contenedores para almacenar sus pel�culas 
Nota: la decisi�n de usar un contenedor cil�ndrico para almacenar las pel�culas 
no es �ptimo ya que se desperdicia mucho volumen del cilindro (532,725 cm^3) por la forma rectangular
del arn�s en el que se guardan las pel�culas */



