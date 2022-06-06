#1. a. Películas Ordenadas por duración de mayor a menor.[Tittle,release_year].Rows=1000
SELECT f.title, f.release_year
FROM film f 
ORDER BY f.length DESC;

#b. Toda la información de los clientes ordenada por Nombre y apellidoalfabéticamente. [ solo de la tabla customer]Rows=599
SELECT c.first_name, c.last_name
FROM customer c
ORDER BY c.first_name AND c.last_name;

#c. Apellidos de los actores ordenados por ID de actor de menor a mayor.[Actor_id,last_name] Rows=200
SELECT last_name, actor_id
FROM actor 
ORDER BY actor_id;

#2. a. Actores Cuyos nombres Empiezan con la letra “w” [first_name].Rows=8
SELECT first_name 
FROM actor
WHERE first_name LIKE 'w%';

#b. Actores cuyos nombres empiecen con la letra “A” y contengan en alguna parte la cadena “EL”. [first_name]Rows=3
SELECT first_name
FROM actor
WHERE first_name LIKE 'A%EL%';

#c. Actores cuyos Nombres contengan solo 5 letras. [first_name]Rows=43
SELECT first_name
FROM actor
WHERE length(first_name)=5;

SELECT first_name
FROM actor
WHERE first_name LIKE '_____';

#3. a. Nombres de las categorías existentes, ordenadas alfabéticamente al revés. 
#solo debe aparecer una vez el nombre de la categoría, es decir si hay 3 categorías el
#resultset debe contener 3 filas solamente. [name,category_id].Rows=16
SELECT c.name, c.category_id
FROM category c
GROUP BY c.category_id
ORDER BY c.name DESC;

#b. Cantidad de Categorías que hay. [Cantidad]Rows= 1
SELECT count(category_id) AS cantidad FROM category; 

#4. a. Nombre del cliente, teléfono y dirección en la que vive [First_name,address,phone]Rows=599
SELECT c.first_name, a.address,a.phone
FROM customer c INNER JOIN address a ON c.address_id=a.address_id;

#b. Ciudades en las que viven los clientes cuyos países son Afghanistan y Argentina [Country,City]Rows=14
SELECT co.country, ci.city
FROM customer c INNER JOIN address a ON c.address_id=a.address_id
				INNER JOIN city ci ON a.city_id=ci.city_id
                INNER JOIN country co ON ci.country_id=co.country_id
WHERE co.country='Argentina' OR co.country='Afghanistan';

#alternativa mas piola
SELECT co.country, ci.city
FROM customer c INNER JOIN address a ON c.address_id=a.address_id
				INNER JOIN city ci ON a.city_id=ci.city_id
                INNER JOIN country co ON ci.country_id=co.country_id
WHERE co.country IN('Afghanistan','Argentina');

#5. a. Nombre del Actor y películas en las que se encuentra, Ordenadas por actor Alfabéticamente [first_name,tittle]Rows=1000
SELECT a.first_name, f.title
FROM actor a INNER JOIN film_actor fa ON a.actor_id=fa.actor_id
			INNER JOIN film f ON fa.film_id=f.film_id
ORDER BY a.first_name ASC;

#b. Miembros del staff que son manager, en alguna tienda.[first_name,active,store,address,address2]Rows=2
SELECT s.first_name,s.active,s.store_id,a.address,a.address2
FROM staff s INNER JOIN store st ON s.staff_id=st.manager_staff_id
			INNER JOIN address a ON st.address_id=a.address_id

#6. Cantidad de Dinero recaudado por las ventas en el tercer trimestre del año 2005
#(formato de fecha yyyy/mm/dd hh/mm/ss) [Monto]Rows=1



#7. Películas que han sido alquiladas alguna vez [Title]Rows=958
#8. Clientes No Activos ordenados por Ciudad alfabéticamente [First_name,City]Rows= 15
#9. Las 4 películas más alquiladas en orden Descendente. [Cantidad_de_alquileres,Title]Rows=4
#10. Película que nunca ha sido alquilada [Film_id,Title]Rows=42
#11. Cantidad de copias de cada película Por película Ordenadas en orden de cantidad de 
#películas de mayor a menor. [Film_id,Cantidad]Rows=958
#12. Películas que fueron devueltas Fuera de fecha.(Películas que han pagadorecargo) 
#.[Title, Rental_date, rental_duration, 
#payment_date ,Return_date, amount,replacement_cost, inventori_id]Rows=48
#13. Cantidad de películas por categoría indicando su precio promedio. [Name,Promedio]Rows=16
#14. Lista de precios conteniendo 4 columnas: 1) precio del alquiler 2) precio del alquiler
#+ 10% del mismo por retraso de 1 DIA 2) precio del alquiler + 20% del mismo por
#retraso de mas de 1 días . La lista debe estar ordenada por titulo y categoríaRows=1000
#15. Países los cuales poseen clientes los cuales nunca han alquilado una película[country]Rows=0
#16. Paises en los cuales nunca se ha alquilado una película. [country]Rows=1
#17. Descripción de las películas con todos sus actores [First_name,Title,description]Rows=546218. Películas cuyo precio de alquiler supere el promedio del costo de las películas para
#mayores de 13 años. [Title,Rental_Rate]Rows=336
#19. a. Cree una tabla que se llame películas_divertidas e inserte en ella todas las
#películas que como special_features (Características especiales) contengan Deleted Scenes (escenas borradas)
#b. Cree una tabla que se llame películas _ nuevas con los siguientes campos:nombre: varchar(45)
#precio: int Tiempo_de_alquiler:int
#20. Sume al film_id 1000 ,aumente el precio de alquiler de las mismas un 25% y agregue
#una día mas a la duración de alquiler
#21. Elimine las películas cuyo rating sea ‘G’¿Se puede?, ¿Por qué?
#22. a. Inserte todas las películas de la tabla películas _ divertidas En la tabla film
#b. Inserte en la tabla películas _ nuevas los siguientes valores:nombre: Furia de titanes precio: 8 Tiempo de alquiler : 6
#c. Inserte la película de la tabla películas _ nuevas en la tabla film, ¿Se puede?, ¿Por qué?
#23. Elimine la tabla películas divertidas
#24. Modifique el nombre de las películas de la tabla film, cuyo id sea mayor que 1000 de
#manera que al final del nombre de la película se le agregue la cadena -new , de la siguiente manera: Nombre –new
#25. Cree una tabla, staff_inactivo, con todos los miembros del staff inactivos del sistema
#26. Elimine del sistema todos los Miembros del staff inactivos
#27. Elimine del sistema las 10 películas menos alquiladas
#28. Agregue una columna a la tabla film, llamada Calificación, la cual poseerá la
#calificación de la película (Buena,Regular,Mala), puede ser varchar(30).Esto puede
#hacerlo a través del asistente. Agregue la calificación BUENA a las películas cuyo
#film_id sea impar(puede hacerlo con varias consultas)




