-- Si us plau, descàrrega la base de dades del fitxer schema_universidad.sql, visualitza el diagrama E-R en un editor i efectua les següents consultes:

--     1-Retorna un llistat amb el primer cognom, segon cognom i el nom de tots els/les alumnes. El llistat haurà d'estar ordenat alfabèticament de menor a major pel primer cognom, segon cognom i nom.

SELECT apellido1,apellido2,nombre FROM persona WHERE tipo = 'alumno' ORDER BY apellido1 DESC;

--     2-Esbrina el nom i els dos cognoms dels alumnes que no han donat d'alta el seu número de telèfon en la base de dades.

SELECT nombre,apellido1,apellido2 FROM persona WHERE tipo = 'alumno' AND telefono IS NULL;

--     3-Retorna el llistat dels alumnes que van néixer en 1999.

SELECT * FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';

--     4-Retorna el llistat de professors/es que no han donat d'alta el seu número de telèfon en la base de dades i a més el seu NIF acaba en K.

SELECT * FROM persona WHERE tipo = 'profesor' AND telefono IS NULL AND nif LIKE '%K';

--     5-Retorna el llistat de les assignatures que s'imparteixen en el primer quadrimestre, en el tercer curs del grau que té l'identificador 7.

SELECT * FROM asignatura WHERE cuatrimestre = 1 AND curso = 3 AND id_grado = 7;

--     6-Retorna un llistat dels professors/es juntament amb el nom del departament al qual estan vinculats. El llistat ha de retornar quatre columnes, primer cognom, segon cognom, nom i nom del departament. El resultat estarà ordenat alfabèticament de menor a major pels cognoms i el nom.

SELECT persona.apellido1,persona.apellido2,persona.nombre,departamento.nombre FROM persona JOIN profesor ON profesor.id_profesor = persona.id JOIN departamento ON departamento.id = profesor.id_departamento ORDER BY persona.apellido1 ASC;

--     7-Retorna un llistat amb el nom de les assignatures, any d'inici i any de fi del curs escolar de l'alumne/a amb NIF 26902806M.

SELECT asignatura.nombre,curso_escolar.anyo_inicio,curso_escolar.anyo_fin,persona.nombre,persona.nif FROM asignatura JOIN alumno_se_matricula_asignatura ON asignatura.id = alumno_se_matricula_asignatura.id_asignatura JOIN curso_escolar ON curso_escolar.id = alumno_se_matricula_asignatura.id_curso_escolar JOIN persona ON persona.id = alumno_se_matricula_asignatura.id_alumno WHERE persona.nif = '26902806M';

--     8-Retorna un llistat amb el nom de tots els departaments que tenen professors/es que imparteixen alguna assignatura en el Grau en Enginyeria Informàtica (Pla 2015).

SELECT DISTINCT departamento.nombre,persona.nombre,grado.id FROM departamento JOIN profesor ON departamento.id = profesor.id_departamento JOIN persona ON profesor.id_profesor = persona.id JOIN asignatura ON asignatura.id_profesor = persona.id JOIN grado ON grado.id = asignatura.id_grado WHERE grado.id = 4;

--     9-Retorna un llistat amb tots els alumnes que s'han matriculat en alguna assignatura durant el curs escolar 2018/2019.
SELECT DISTINCT persona.nombre,curso_escolar.anyo_inicio FROM persona JOIN alumno_se_matricula_asignatura ON persona.id = alumno_se_matricula_asignatura.id_alumno JOIN curso_escolar ON alumno_se_matricula_asignatura.id_curso_escolar = curso_escolar.id WHERE curso_escolar.anyo_inicio = '2018';

-- Resol les 6 següents consultes utilitzant les clàusules LEFT JOIN i RIGHT JOIN.

--     10-Retorna un llistat amb els noms de tots els professors/es i els departaments que tenen vinculats. El llistat també ha de mostrar aquells professors/es que no tenen cap departament associat. El llistat ha de retornar quatre columnes, nom del departament, primer cognom, segon cognom i nom del professor/a. El resultat estarà ordenat alfabèticament de menor a major pel nom del departament, cognoms i el nom.

SELECT departamento.nombre,persona.apellido1,persona.apellido2,persona.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_profesor = persona.id ORDER BY departamento.nombre ASC;

--     11-Retorna un llistat amb els professors/es que no estan associats a un departament.

SELECT persona.nombre,departamento.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN departamento ON profesor.id_departamento = departamento.id WHERE departamento.nombre IS NULL;

--     12-Retorna un llistat amb els departaments que no tenen professors/es associats.

SELECT departamento.nombre,persona.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON persona.id = profesor.id_profesor WHERE persona.nombre IS NULL;

--     13-Retorna un llistat amb els professors/es que no imparteixen cap assignatura.

SELECT persona.nombre,asignatura.nombre FROM persona LEFT JOIN profesor ON persona.id = profesor.id_profesor LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor WHERE asignatura.nombre IS NULL;

--     14-Retorna un llistat amb les assignatures que no tenen un professor/a assignat.

SELECT asignatura.nombre,persona.nombre FROM asignatura LEFT JOIN profesor ON asignatura.id_profesor = profesor.id_profesor LEFT JOIN persona ON persona.id = profesor.id_profesor WHERE persona.nombre IS NULL;

--     15-Retorna un llistat amb tots els departaments que no han impartit assignatures en cap curs escolar.

SELECT departamento.nombre,asignatura.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON asignatura.id = profesor.id_profesor WHERE asignatura.nombre IS NULL;

-- Consultes resum:

--     16-Retorna el nombre total d'alumnes que hi ha.
SELECT COUNT(*) FROM persona WHERE tipo = 'alumno';
--     17-Calcula quants alumnes van néixer en 1999.
SELECT COUNT(*) FROM persona WHERE YEAR(fecha_nacimiento) = 1999 AND tipo = 'alumno';
--     18-Calcula quants professors/es hi ha en cada departament. El resultat només ha de mostrar dues columnes, una amb el nom del departament i una altra amb el nombre de professors/es que hi ha en aquest departament. El resultat només ha d'incloure els departaments que tenen professors/es associats i haurà d'estar ordenat de major a menor pel nombre de professors/es.

SELECT departamento.nombre, profesor.id_profesor FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN persona ON profesor.id_departamento = persona.id;

--     19-Retorna un llistat amb tots els departaments i el nombre de professors/es que hi ha en cadascun d'ells. Tingui en compte que poden existir departaments que no tenen professors/es associats. Aquests departaments també han d'aparèixer en el llistat.

--     20-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun. Tingues en compte que poden existir graus que no tenen assignatures associades. Aquests graus també han d'aparèixer en el llistat. El resultat haurà d'estar ordenat de major a menor pel nombre d'assignatures.

--     21-Retorna un llistat amb el nom de tots els graus existents en la base de dades i el nombre d'assignatures que té cadascun, dels graus que tinguin més de 40 assignatures associades.

--     22-Retorna un llistat que mostri el nom dels graus i la suma del nombre total de crèdits que hi ha per a cada tipus d'assignatura. El resultat ha de tenir tres columnes: nom del grau, tipus d'assignatura i la suma dels crèdits de totes les assignatures que hi ha d'aquest tipus.

SELECT DISTINCT grado.nombre,asignatura.tipo,asignatura.creditos FROM grado JOIN asignatura ON grado.id = asignatura.id_grado;

--     23-Retorna un llistat que mostri quants alumnes s'han matriculat d'alguna assignatura en cadascun dels cursos escolars. El resultat haurà de mostrar dues columnes, una columna amb l'any d'inici del curs escolar i una altra amb el nombre d'alumnes matriculats.

--     24-Retorna un llistat amb el nombre d'assignatures que imparteix cada professor/a. El llistat ha de tenir en compte aquells professors/es que no imparteixen cap assignatura. El resultat mostrarà cinc columnes: id, nom, primer cognom, segon cognom i nombre d'assignatures. El resultat estarà ordenat de major a menor pel nombre d'assignatures.

SELECT persona.id,persona.nombre,persona.apellido1,persona.apellido2,asignatura.nombre FROM persona LEFT JOIN asignatura on persona.id = asignatura.id_profesor;

--     25-Retorna totes les dades de l'alumne/a més jove.

SELECT * FROM persona WHERE tipo = 'alumno' AND fecha_nacimiento = (SELECT MAX(fecha_nacimiento) FROM persona);

--     26-Retorna un llistat amb els professors/es que tenen un departament associat i que no imparteixen cap assignatura.

SELECT persona.nombre,departamento.nombre,asignatura.nombre FROM departamento LEFT JOIN profesor ON departamento.id = profesor.id_departamento LEFT JOIN asignatura ON profesor.id_profesor = asignatura.id_profesor LEFT JOIN persona ON persona.id = profesor.id_profesor WHERE asignatura.nombre IS NULL AND persona.nombre IS NOT NULL;