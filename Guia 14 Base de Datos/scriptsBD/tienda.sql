/*DROP DATABASE IF EXISTS tienda;*/
CREATE DATABASE tienda CHARACTER SET utf8mb4;
USE tienda;
/*SET SQL_SAFE_UPDATES=0; para poder guardar un set*/
CREATE TABLE fabricante (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL
);

CREATE TABLE producto (
  codigo INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
  nombre VARCHAR(100) NOT NULL,
  precio DOUBLE NOT NULL,
  codigo_fabricante INT UNSIGNED NOT NULL,
  FOREIGN KEY (codigo_fabricante) REFERENCES fabricante(codigo)
);

INSERT INTO fabricante VALUES(1, 'Asus');
INSERT INTO fabricante VALUES(2, 'Lenovo');
INSERT INTO fabricante VALUES(3, 'Hewlett-Packard');
INSERT INTO fabricante VALUES(4, 'Samsung');
INSERT INTO fabricante VALUES(5, 'Seagate');
INSERT INTO fabricante VALUES(6, 'Crucial');
INSERT INTO fabricante VALUES(7, 'Gigabyte');
INSERT INTO fabricante VALUES(8, 'Huawei');
INSERT INTO fabricante VALUES(9, 'Xiaomi');

INSERT INTO producto VALUES(1, 'Disco duro SATA3 1TB', 86.99, 5);
INSERT INTO producto VALUES(2, 'Memoria RAM DDR4 8GB', 120, 6);
INSERT INTO producto VALUES(3, 'Disco SSD 1 TB', 150.99, 4);
INSERT INTO producto VALUES(4, 'GeForce GTX 1050Ti', 185, 7);
INSERT INTO producto VALUES(5, 'GeForce GTX 1080 Xtreme', 755, 6);
INSERT INTO producto VALUES(6, 'Monitor 24 LED Full HD', 202, 1);
INSERT INTO producto VALUES(7, 'Monitor 27 LED Full HD', 245.99, 1);
INSERT INTO producto VALUES(8, 'Portátil Yoga 520', 559, 2);
INSERT INTO producto VALUES(9, 'Portátil Ideapd 320', 444, 2);
INSERT INTO producto VALUES(10, 'Impresora HP Deskjet 3720', 59.99, 3);
INSERT INTO producto VALUES(11, 'Impresora HP Laserjet Pro M26nw', 180, 3);

SELECT * FROM fabricante;
SELECT * FROM producto;
/*1. Lista el nombre de todos los productos que hay en la tabla producto.*/
SELECT nombre FROM producto;
/*2. Lista los nombres y los precios de todos los productos de la tabla producto.*/
SELECT nombre,precio FROM producto;
/*3. Lista todas las columnas de la tabla producto.*/
SELECT * from producto;
/*4. Lista los nombres y los precios de todos los productos de la tabla producto, redondeando el valor del precio.*/
SELECT nombre,ROUND(precio) AS 'Precio' FROM PRODUCTO;
/*5. Lista el código de los fabricantes que tienen productos en la tabla producto.*/
SELECT codigo_fabricante, nombre
FROM producto
WHERE codigo_fabricante;

/*6. Lista el código de los fabricantes que tienen productos en la tabla producto, sin mostrar los repetidos.*/
SELECT DISTINCT codigo_fabricante/*uso DISTINCT para eliminar los valores duplicados del resultado*/
FROM producto;

/*7. Lista los nombres de los fabricantes ordenados de forma ascendente.*/
SELECT nombre FROM fabricante ORDER BY nombre ASC;

/*8. Lista los nombres de los productos ordenados en primer lugar por el nombre de forma ascendente y en segundo lugar por el precio de forma descendente.*/
SELECT nombre, precio FROM producto ORDER BY nombre ASC, precio DESC; /*Si quiero usar el Round debo hacerlo en el Select*/

/*9. Devuelve una lista con las 5 primeras filas de la tabla fabricante.*/
SELECT * FROM fabricante LIMIT 5;

/*10. Lista el nombre y el precio del producto más barato. (Utilice solamente las cláusulas
ORDER BY y LIMIT)*/
SELECT nombre, precio FROM producto ORDER BY precio ASC LIMIT 1;

/*11. Lista el nombre y el precio del producto más caro. (Utilice solamente las cláusulas ORDER
BY y LIMIT)*/
SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;

/*12. Lista el nombre de los productos que tienen un precio menor o igual a $120.*/
SELECT nombre,precio FROM producto WHERE precio <=120;

/*13. Lista todos los productos que tengan un precio entre $60 y $200. Utilizando el operador
BETWEEN.*/
SELECT nombre,precio FROM producto WHERE precio BETWEEN 60 AND 200;

/*14. Lista todos los productos donde el código de fabricante sea 1, 3 o 5. Utilizando el operador
IN.*/
SELECT nombre,codigo_fabricante FROM producto WHERE codigo_fabricante IN(1,3,5);

/*15. Devuelve una lista con el nombre de todos los productos que contienen la cadena Portátil
en el nombre.*/

SELECT nombre FROM producto WHERE nombre like '%Portátil%'; /*Ponerlo con ascento o sin ascento es lo mismo*/

/*Consultas Multitabla*/
/*1. Devuelve una lista con el código del producto, nombre del producto, código del fabricante
y nombre del fabricante, de todos los productos de la base de datos.*/
SELECT producto.codigo,producto.nombre,producto.codigo_fabricante,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

/*2. Devuelve una lista con el nombre del producto, precio y nombre de fabricante de todos
los productos de la base de datos. Ordene el resultado por el nombre del fabricante, por
orden alfabético.*/
SELECT producto.nombre,producto.precio,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
ORDER BY fabricante.nombre ASC;

/*3. Devuelve el nombre del producto, su precio y el nombre de su fabricante, del producto
más barato.*/
SELECT producto.nombre,producto.precio,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio = (SELECT MIN(precio) FROM producto); /*En este ejercicio no puedo usar HAVING producto.precio = MIN(producto.precio); porque */
														/*no se puede utilizar directamente una función de agregación (como MIN()) en la cláusula HAVING para comparar valores*/
                                                        
/*4. Devuelve una lista de todos los productos del fabricante Lenovo.*/                                                        
SELECT producto.nombre,fabricante.nombre
 FROM producto
 JOIN fabricante
 ON producto.codigo_fabricante = fabricante.codigo
 WHERE fabricante.nombre LIKE 'Lenovo';
 
 /*5. Devuelve una lista de todos los productos del fabricante Crucial que tengan un precio
mayor que $200.*/
SELECT producto.nombre,producto.precio,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >=200 AND fabricante.nombre LIKE 'Crucial%';

/*6. Devuelve un listado con todos los productos de los fabricantes Asus, Hewlett-Packard.
Utilizando el operador IN.*/
SELECT producto.nombre,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE fabricante.nombre IN('Asus','Hewlett-Packard');     

/*7. Devuelve un listado con el nombre de producto, precio y nombre de fabricante, de todos
los productos que tengan un precio mayor o igual a $180. Ordene el resultado en primer
lugar por el precio (en orden descendente) y en segundo lugar por el nombre (en orden
ascendente)*/
SELECT producto.nombre,producto.precio,fabricante.nombre
FROM producto
JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo
WHERE producto.precio >= 180 ORDER BY producto.precio DESC,producto.nombre ASC;

/*Consultas Multitabla*/
/*Resuelva todas las consultas utilizando las cláusulas LEFT JOIN y RIGHT JOIN.
1. Devuelve un listado de todos los fabricantes que existen en la base de datos, junto con los
productos que tiene cada uno de ellos. El listado deberá mostrar también aquellos
fabricantes que no tienen productos asociados.*/
SELECT producto.nombre,fabricante.nombre
FROM producto
RIGHT JOIN fabricante
ON producto.codigo_fabricante = fabricante.codigo;

/*2. Devuelve un listado donde sólo aparezcan aquellos fabricantes que no tienen ningún
producto asociado.*/
SELECT producto.codigo_fabricante AS 'Codigo',fabricante.nombre
FROM fabricante
lEFT JOIN producto
ON fabricante.codigo = producto.codigo_fabricante
WHERE producto.codigo_fabricante IS NULL;

/*Subconsultas (En la cláusula WHERE)
Con operadores básicos de comparación*/
/*1. Devuelve todos los productos del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT producto.nombre,fabricante.nombre
FROM producto, fabricante
WHERE producto.codigo_fabricante = (SELECT fabricante.nombre LIKE '%Lenovo%');

/*2. Devuelve todos los datos de los productos que tienen el mismo precio que el producto
más caro del fabricante Lenovo. (Sin utilizar INNER JOIN).*/
SELECT producto.*,fabricante.*
FROM producto,fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre LIKE '%Lenovo%'
AND producto.precio =(
SELECT MAX(precio)
FROM producto
WHERE codigo_fabricante = fabricante.codigo);

/*3. Lista el nombre del producto más caro del fabricante Lenovo.*/
SELECT producto.nombre,producto.precio
FROM producto, fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre LIKE 'Lenovo%'
AND producto.precio = (
SELECT MAX(precio)
FROM producto
WHERE codigo_fabricante = fabricante.codigo);

/*4. Lista todos los productos del fabricante Asus que tienen un precio superior al precio
medio de todos sus productos.*/
SELECT producto.*,fabricante.*
FROM producto,fabricante
WHERE producto.codigo_fabricante = fabricante.codigo
AND fabricante.nombre LIKE 'Asus'
AND producto.precio > (
SELECT AVG(precio)
FROM producto
WHERE codigo_fabricante = fabricante.codigo);

						