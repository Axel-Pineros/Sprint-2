-- Si us plau, efectua les següents consultes:

--     1-Llista el nom de tots els productes que hi ha en la taula producto.

SELECT nombre FROM producto;

--     2-Llista els noms i els preus de tots els productes de la taula producto.

SELECT nombre,precio FROM producto;

--     3-Llista totes les columnes de la taula producto.

SELECT * FROM producto;

--     4-Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD).

SELECT nombre, precio, ROUND(precio * 1.10) as precio_dolares FROM producto;

--     5-Llista el nom dels productes, el preu en euros i el preu en dòlars estatunidencs (USD). Utilitza els següents àlies per a les columnes: nom de producto, euros, dòlars.

SELECT nombre as nom_de_producto, precio as euros, ROUND(precio * 1.10) as dòlars FROM producto;

--     6-Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a majúscula.

SELECT UPPER(nombre),precio FROM producto;

--     7-Llista els noms i els preus de tots els productes de la taula producto, convertint els noms a minúscula.

SELECT LOWER(nombre),precio FROM producto;

--     8-Llista el nom de tots els fabricants en una columna, i en una altra columna obtingui en majúscules els dos primers caràcters del nom del fabricant.

SELECT nombre FROM fabricante;
SELECT UPPER(LEFT(nombre, 2)) FROM fabricante;

--     9-Llista els noms i els preus de tots els productes de la taula producto, arrodonint el valor del preu.

SELECT nombre,ROUND(precio) FROM producto;

--     10-Llista els noms i els preus de tots els productes de la taula producto, truncant el valor del preu per a mostrar-lo sense cap xifra decimal.

SELECT nombre,TRUNCATE(precio, 0) FROM producto;

--     11-Llista el codi dels fabricants que tenen productes en la taula producto.

SELECT codigo_fabricante FROM producto;

--     12-Llista el codi dels fabricants que tenen productes en la taula producto, eliminant els codis que apareixen repetits.

SELECT DISTINCT codigo_fabricante FROM producto;

--     13-Llista els noms dels fabricants ordenats de manera ascendent.

SELECT nombre FROM fabricante ORDER BY nombre ASC;

--     14-Llista els noms dels fabricants ordenats de manera descendent.

SELECT nombre FROM fabricante ORDER BY nombre DESC;

--     15-Llista els noms dels productes ordenats, en primer lloc, pel nom de manera ascendent i, en segon lloc, pel preu de manera descendent.

SELECT nombre FROM producto ORDER BY nombre ASC;
SELECT nombre FROM producto ORDER BY precio DESC;

--     16-Retorna una llista amb les 5 primeres files de la taula fabricante.

SELECT * FROM fabricante LIMIT 5;

--     17-Retorna una llista amb 2 files a partir de la quarta fila de la taula fabricante. La quarta fila també s'ha d'incloure en la resposta.

SELECT * FROM fabricante LIMIT 2 OFFSET 3;

--     18-Llista el nom i el preu del producte més barat. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MIN(preu), necessitaria GROUP BY.

SELECT nombre,precio FROM producto ORDER BY precio ASC LIMIT 1;

--     19-Llista el nom i el preu del producte més car. (Utilitza solament les clàusules ORDER BY i LIMIT). NOTA: Aquí no podria usar MAX(preu), necessitaria GROUP BY.

SELECT nombre,precio FROM producto ORDER BY precio DESC LIMIT 1;

--     20-Llista el nom de tots els productes del fabricant el codi de fabricant del qual és igual a 2.

SELECT producto.nombre FROM producto LEFT JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.codigo_fabricante = 2;

--     21-Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades.

SELECT producto.nombre, fabricante.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

--     22-Retorna una llista amb el nom del producte, preu i nom de fabricant de tots els productes de la base de dades. Ordena el resultat pel nom del fabricant, per ordre alfabètic.

SELECT producto.nombre, fabricante.nombre, producto.precio FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo ORDER BY fabricante.nombre ASC;

--     23-Retorna una llista amb el codi del producte, nom del producte, codi del fabricador i nom del fabricador, de tots els productes de la base de dades.

SELECT producto.codigo, producto.nombre, fabricante.codigo, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo;

--     24-Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més barat.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MIN(precio) FROM producto);

--     25-Retorna el nom del producte, el seu preu i el nom del seu fabricant, del producte més car.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio = (SELECT MAX(precio) FROM producto);

--     26-Retorna una llista de tots els productes del fabricant Lenovo.

SELECT producto.nombre, producto.precio, fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE 'Lenovo';

--     27-Retorna una llista de tots els productes del fabricant Crucial que tinguin un preu major que 200 €.

SELECT producto.* FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre = 'Crucial' AND producto.precio > 200;

--     28-Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Sense utilitzar l'operador IN.

SELECT * FROM producto WHERE codigo_fabricante = 1 OR codigo_fabricante = 3 OR codigo_fabricante = 5;

--     29-Retorna un llistat amb tots els productes dels fabricants Asus, Hewlett-Packard y Seagate. Fent servir l'operador IN.

SELECT * FROM producto WHERE codigo_fabricante IN (1,3,5);

--     30-Retorna un llistat amb el nom i el preu de tots els productes dels fabricants el nom dels quals acabi per la vocal e.

SELECT producto.nombre,producto.precio,fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%e';

--     31-Retorna un llistat amb el nom i el preu de tots els productes el nom de fabricant dels quals contingui el caràcter w en el seu nom.

SELECT producto.nombre,producto.precio,fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE fabricante.nombre LIKE '%w%';

--     32-Retorna un llistat amb el nom de producte, preu i nom de fabricant, de tots els productes que tinguin un preu major o igual a 180 €. Ordena el resultat, en primer lloc, pel preu (en ordre descendent) i, en segon lloc, pel nom (en ordre ascendent).

SELECT producto.nombre,producto.precio,fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.precio DESC;
SELECT producto.nombre,producto.precio,fabricante.nombre FROM producto JOIN fabricante ON producto.codigo_fabricante = fabricante.codigo WHERE producto.precio >= 180 ORDER BY producto.nombre ASC;

--     33-Retorna un llistat amb el codi i el nom de fabricant, solament d'aquells fabricants que tenen productes associats en la base de dades.

SELECT DISTINCT fabricante.codigo, fabricante.nombre FROM fabricante JOIN producto ON producto.codigo_fabricante = fabricante.codigo;

--     34-Retorna un llistat de tots els fabricants que existeixen en la base de dades, juntament amb els productes que té cadascun d'ells. El llistat haurà de mostrar també aquells fabricants que no tenen productes associats.

SELECT fabricante.nombre, producto.nombre FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante;

--     35-Retorna un llistat on només apareguin aquells fabricants que no tenen cap producte associat.

SELECT fabricante.* FROM fabricante LEFT JOIN producto ON fabricante.codigo = producto.codigo_fabricante WHERE producto.codigo_fabricante IS NULL;

--     36-Retorna tots els productes del fabricador Lenovo. (Sense utilitzar INNER JOIN).

SELECT * FROM producto LEFT JOIN fabricante ON fabricante.codigo = producto.codigo_fabricante WHERE fabricante.nombre = 'Lenovo';

--     37-Retorna totes les dades dels productes que tenen el mateix preu que el producte més car del fabricant Lenovo. (Sense usar INNER JOIN).

SELECT * FROM producto WHERE precio = (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = 2);

--     38-Llista el nom del producte més car del fabricant Lenovo.

SELECT nombre, MAX(precio) FROM producto WHERE codigo_fabricante = 2;

--     39-Llista el nom del producte més barat del fabricant Hewlett-Packard.

SELECT nombre, MIN(precio) FROM producto WHERE codigo_fabricante = 3;

--     40-Retorna tots els productes de la base de dades que tenen un preu major o igual al producte més car del fabricant Lenovo.

SELECT * FROM producto WHERE precio >= (SELECT MAX(precio) FROM producto WHERE codigo_fabricante = 2);

--     41-Llista tots els productes del fabricant Asus que tenen un preu superior al preu mitjà de tots els seus productes.

SELECT * FROM producto WHERE codigo_fabricante = 1 AND precio > (SELECT AVG(precio) FROM producto WHERE codigo_fabricante = 1);