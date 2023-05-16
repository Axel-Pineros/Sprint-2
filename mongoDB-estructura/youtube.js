// De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.


// Un usuari/ària publica vídeos. De cada vídeo guardem un identificador únic: Un títol, una descripció, una grandària, el nom de l'arxiu de vídeo, durada del vídeo, un thumbnail, el nombre de reproduccions, el número de likes, el número de dislikes.


// Un vídeo pot tenir tres estats diferents: públic, ocult i privat. Un vídeo pot tenir moltes etiquetes. Una etiqueta s'identifica per un identificador únic i un nom d'etiqueta. Interessa guardar qui és l'usuari/ària que publica el vídeo i en quina data/hora el fa.


// Un usuari/ària pot crear un canal. Un canal té un identificador únic: Un nom, una descripció, una data de creació.


// Un usuari/ària es pot subscriure als canals d'altres usuaris/es. Un usuari/ària pot donar-li un like o un dislike a un vídeo una única vegada. Caldrà portar un registre dels usuaris/es que li han donat like i dislike a un determinat vídeo i en quina data/hora ho van fer.


// Un usuari/ària pot crear playlists amb els vídeos que li agraden. Cada playlist té un identificador únic: Un nom, una data de creació, un estat que indica que pot ser pública o privada.


// Un usuari/ària pot escriure comentaris en un vídeo determinat. Cada comentari està identificat per un identificador únic: El text del comentari, la data/hora en la qual es va realitzar.


// Un usuari/ària pot marcar un comentari com m'agrada o no m'agrada. Caldrà portar un registre dels usuaris/es que han marcat un comentari com m'agrada/no m'agrada, i en quina data/hora ho van fer.

use('youtube');

db.createCollection('usuaris');
db.createCollection('videos');
db.createCollection('canals');
db.createCollection('playlists');

db.usuaris.insertMany([
    {
        correu: 'pepitogrillo@gmail.com',
        contrasenya: '123pruebaotravez',
        nom: 'Pepe',
        data_naixement: '1998-02-21',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '09632'
    },
    {
        correu: 'armadillo@gmail.com',
        contrasenya: 'HolaAMIGOS',
        nom: 'Luis',
        data_naixement: '1987-06-10',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '04587'
    },
    {
        correu: 'colorderosa@gmail.com',
        contrasenya: 'estoesuninsulto',
        nom: 'Pepa',
        data_naixement: '1999-03-30',
        sexe: 'dona',
        pais: 'Espanya',
        codi_postal: '52170'
    },
    {
        correu: 'elpepopepote@gmail.com',
        contrasenya: 'ret53t36t3t3',
        nom: 'Pepo',
        data_naixement: '1995-06-12',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '57357'
    }
]);

db.videos.insertMany([
    {
        titol: 'Saltant per la finestra',
        descripcio: 'Un tipus molt estúpid surt corrents per la finestra fugint del seu gat',
        tamany_mb: 700,
        nom_arxiu: 'paio-estupid',
        durada: '00:10:30',
        miniatura: 'pobre-tonto.jpg',
        reproduccions: 2579,
        likes: 260,
        dislikes: 68,
        estat: 'public',
        data_hora_publicacio: '2006-05-02 11:42:49',
        usuari: 'Pepa',
        etiquetes: ["Humor", "Bromes pesades"],
        valoracions: {
            usuari: "Luis",
            valoracio: "Like",
            data_valoracio: "2012-06-24 11:09:41"
        },
        comentaris: {
            contingut: 'Ostres com mola',
            data_creacio: '2009-12-28 09:15:13',
            usuari: 'Luis',
            valoracions_comentari: {
                usuari: 'Pepa',
                valoracio: "Like",
                data: "2010-04-23 10:21:24"
            }
        }
    },
    {
        titol: 'La història de la Terra',
        descripcio: "Des dels inicis fins a l'actualitat",
        tamany_mb: 1200,
        nom_arxiu: 'historia-terra',
        durada: '00:37:25',
        miniatura: 'planeta-terra.jpg',
        reproduccions: 5824,
        likes: 145,
        dislikes: 13,
        estat: 'public',
        data_hora_publicacio: '2005-02-19 18:29:03',
        usuari: 'Luis',
        etiquetes: "Documental",
        comentaris: {
            contingut: 'No és per a tant...',
            data_creacio: '2008-04-12 23:01:34',
            usuari: 'Pepa',
            valoracions_comentari: {
                usuari: 'Pepe',
                valoracio: "Dislike",
                data: "2008-12-01 13:46:59"
            }
        }
    },
    {
        titol: 'Internet, el gran espia',
        descripcio: "Descubreix tota la informació que Internet sap de tu",
        tamany_mb: 450,
        nom_arxiu: 'la-veritat',
        durada: '00:23:57',
        miniatura: 'internet.jpg',
        reproduccions: 2341,
        likes: 573,
        dislikes: 147,
        estat: 'public',
        data_hora_publicacio: '2005-01-14 23:58:11',
        usuari: 'Pepo',
        etiquetes: "Teories conspiració",
        valoracions: {
            usuari: "Pepa",
            valoracio: "Like",
            data_valoracio: "2012-08-03 03:46:12"
        },
        comentaris: {
            contingut: 'Jajjajajaja que bo xdddddd',
            data_creacio: '2008-10-13 19:23:41',
            usuari: 'Pepe',
            valoracions_comentari: {
                usuari: 'Luis',
                valoracio: "Like",
                data: "2008-10-13 19:23:41"
            }
        }
    },
    {
        titol: 'Despertant al vei',
        descripcio: "El nostre vei sofrirà una broma pesada",
        tamany_mb: 900,
        nom_arxiu: 'vei-espantat',
        durada: '00:16:38',
        miniatura: 'persona-espantada.jpg',
        reproduccions: 4064,
        likes: 274,
        dislikes: 745,
        estat: 'public',
        data_hora_publicacio: '2005-01-14 23:58:11',
        usuari: 'Pepa',
        etiquetes: ["Humor", "Bromes pesades"],
        comentaris: {
            dades: {
                contingut: 'Que interessant',
                data_creacio: '2008-10-13 12:57:27',
                usuari: 'Pepe',
            }
        }
    }
]);

db.canals.insertMany([
    {
        nom: 'El rei del mambo',
        descripcio: 'En aquest canal veureu les idiotades més idiotes que un idiota podia inventar',
        data_creacio: '2010-04-02',
        usuari: 'Pepe',
        suscriptors: ["Luis", "Pepo"]
    },
    {
        nom: 'Yoloman',
        descripcio: 'El millor canal del món',
        data_creacio: '2011-06-19',
        usuari: 'Pepa',
        suscriptors: "Luis"
    },
    {
        nom: 'Superman',
        descripcio: 'El canal dels canals',
        data_creacio: '2011-06-19',
        usuari: 'Pepo',
        suscriptors: "Pepa"
    }
]);

db.playlists.insertMany([
    {
        nom: 'Caigudes tontes',
        data_creacio: '2008-09-02',
        estat: 'privada',
        usuari: 'Pepe',
        videos: ["Saltant per la finestra", "Despertant al vei"]
    },
    {
        nom: 'Burros',
        data_creacio: '2009-11-28',
        estat: 'publica',
        usuari: 'Pepa',
        videos: ["Saltant per la finestra", "Despertant al vei"]
    },
    {
        nom: 'Ovnis',
        data_creacio: '2010-02-13',
        estat: 'publica',
        usuari: 'Pepo',
        videos: ["La història de la Terra", "Internet, el gran espia"]
    }
]);