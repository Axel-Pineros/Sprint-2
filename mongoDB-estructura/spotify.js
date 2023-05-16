// Tractarem de fer un model senzill de com seria la base de dades necessària per a Spotify.

//     Existeixen dos tipus d'usuaris/es: free i  prèmium. De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.


//     Els usuaris/es prèmium fan subscripcions. Les dades necessàries que caldrà guardar per a cada subscripció són: Data d'inici de la subscripció, data de renovació del servei, una forma de pagament, que pot ser mitjançant targeta de crèdit o PayPal.


//     De les targetes de crèdit guardem el número de targeta, mes i any de caducitat i el codi de seguretat. Dels usuaris/es que paguen amb PayPal guardem el nom d'usuari/ària de PayPal. Ens interessa portar un registre de tots els pagaments que un usuari/ària prèmium ha anat realitzant durant el període que està subscrit. De cada pagament es guarda: La data, un número d'ordre (que és únic), un total.


//     Un usuari/ària pot crear moltes playlists. De cada playlist guardem: Un títol, el nombre de cançons que conté, un identificador únic, una data de creació.


//     Quan un usuari/ària esborra una playlist no s'esborra del sistema, sinó que es marca com que ha estat eliminada. D'aquesta manera l'usuari/ària pot tornar a recuperar les seves playlists en cas que les hagi eliminat per error. És necessari emmagatzemar la data en la qual la playlist ha estat marcada com eliminada.

//     Podem dir que existeixen dos tipus de playlists: actives i esborrades. Una playlist que està activa pot ser compartida amb altres usuaris/es, això vol dir que altres usuaris/es poden afegir cançons en ella. En una llista compartida ens interessa saber quin usuari/ària ha estat el que ha afegit cada cançó i en quina data ho va fer.
//     Una cançó només pot pertànyer a un únic àlbum. Un àlbum pot contenir moltes cançons. Un àlbum ha estat publicat per un/a únic/a artista. Un/a artista pot haver publicat molts àlbums. De cada cançó guardem un identificador únic: Un títol, una durada, el nombre de vegades que ha estat reproduïda pels usuaris/es de Spotify.


//     De cada àlbum guardem un identificador únic: Títol, any de publicació, una imatge amb la portada.

//     De cada artista guardem un identificador únic: Nom, una imatge de l'artista


//     Un usuari/ària pot seguir a molts/es artistes. Un/a artista pot estar relacionat/da amb altres artistes que facin música semblant. De manera que Spotify pugui mostrar-nos un llistat d'artistes relacionats/des amb els artistes que ens agraden. També ens interessa guardar quins són els àlbums i les cançons favorites d'un usuari/ària. Un usuari/ària pot seleccionar molts àlbums i moltes cançons com a favorites.

use('spotify');

db.createCollection('usuaris');
db.createCollection('usuaris_premium');
db.createCollection('targetes');
db.createCollection('paypal');
db.createCollection('pagaments');
db.createCollection('artistes');
db.createCollection('albums');
db.createCollection('cancons');

db.usuaris.insertMany([
    {
        email: 'pepe56@gmail.com',
        contrasenya: '1234',
        nom: 'Pepe',
        data_naixement: '1998-02-23',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '67568',
        artistes_seguits: ["Shakira", "Bosé"],
        cancons_preferides: ["Singing in the rain", "Happiness is on the corner"],
        albums_preferits: ["Love me baby", "On fire"]
    },
    {
        email: 'laura67@gmail.com',
        contrasenya: '12345',
        nom: 'Laura',
        data_naixement: '2001-06-29',
        sexe: 'dona',
        pais: 'Espanya',
        codi_postal: '32432',
        cancons_preferides: "Sup",
        albums_preferits: "The world is for you"
    },
    {
        email: 'manuel@gmail.com',
        contrasenya: 'dadfafa',
        nom: 'Manuel',
        data_naixement: '1995-08-01',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '27846',
        artistes_seguits: ["Shakira", "Maluma"],
        cancons_preferides: ["Oh love", "Singing in the rain"],
        albums_preferits: "On fire",
        alteracio_playlists: {
            playlist: "All the love in the world",
            canco_introduida: "Singing in the rain",
            data_introduccio: "2021-09-04"
        }
    },
    {
        email: 'rafael074@gmail.com',
        contrasenya: 'ueuicfsd',
        nom: 'Rafael',
        data_naixement: '1996-07-12',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '32521'
    },
    {
        email: 'sarasarita@gmail.com',
        contrasenya: '345twew',
        nom: 'Sara',
        data_naixement: '1992-05-09',
        sexe: 'dona',
        pais: 'Espanya',
        codi_postal: '47568',
        artistes_seguits: ["Shakira", "Bosé"],
        cancons_preferides: "Conquer"
    },
    {
        email: 'juanjo@gmail.com',
        contrasenya: 'sdvgdg',
        nom: 'Juanjo',
        data_naixement: '1995-02-04',
        sexe: 'home',
        pais: 'Espanya',
        codi_postal: '53754',
        artistes_seguits: "Axel Rose"
    }
]);

db.usuaris_premium.insertMany([
    {
        data_inici: '2021-01-22',
        data_renovacio: '2022-04-30',
        pagament: 'targeta_credit',
        usuari: 'Pepe'
    },
    {
        data_inici: '2021-07-16',
        data_renovacio: '2022-05-10',
        pagament: 'paypal',
        usuari: 'Manuel'
    },
    {
        data_inici: '2021-03-29',
        data_renovacio: '2022-11-15',
        pagament: 'paypal',
        usuari: 'Rafael'
    }
]);

db.targetes.insertOne([
    {
        numero: '4428 7934 3373 5004',
        data_caducitat: '2024-02-28',
        codi_seguretat: '729',
        usuari_premium: 'Pepe'
    }
]);

db.paypal.insertMany([
    {
        nom_usuari: 'Manuel',
        usuari_premium: 'Manuel'
    },
    {
        nom_usuari: 'Rafael',
        usuari_premium: 'Rafael'
    }
]);

db.pagaments.insertOne([
    {
        data_pagament: '2021-09-28',
        numero_ordre: 6,
        total: 19.00,
        usuari_premium: 'Manuel'
    }
]);

db.artistes.insertMany([
    {
        nom: 'Shakira',
        imatge_artista: 'shakira.jpg',
        artistes_relacionats: ["Maluma", "Axel Rose"]
    },
    {
        nom: 'Bosé',
        imatge_artista: 'bose.jpg',
    },
    {
        nom: 'Maluma',
        imatge_artista: 'maluma.jpg',
        artistes_relacionats: ["Shakira", "Axel Rose"]
    },
    {
        nom: 'Axel Rose',
        imatge_artista: 'axel-rose.jpg',
        artistes_relacionats: ["Shakira", "Maluma"]
    }
]);

db.albums.insertMany([
    {
        titol: 'All you need is love',
        any_publicacio: '1993',
        imatge_portada: 'love.jpg',
        artista: 'Shakira'
    },
    {
        titol: 'Love me baby',
        any_publicacio: '1997',
        imatge_portada: 'love-baby.jpg',
        artista: 'Maluma'
    },
    {
        titol: 'On fire',
        any_publicacio: '2001',
        imatge_portada: 'fire.jpg',
        artista: 'Bosé'
    },
    {
        titol: 'The world is for you',
        any_publicacio: '2005',
        imatge_portada: 'world.jpg',
        artista: 'Axel Rose'
    }
]);

db.cancons.insertMany([
    {
        titol: 'All you need is love',
        durada: 12,
        numero_reproduccions: 45,
        album: 'Love me baby'
    },
    {
        titol: 'Singing in the rain',
        durada: 8,
        numero_reproduccions: 90,
        album: 'On fire'
    },
    {
        titol: 'Happiness is on the corner',
        durada: 6,
        numero_reproduccions: 240,
        album: 'On fire'
    },
    {
        titol: 'Conquer',
        durada: 8,
        numero_reproduccions: 90,
        album: 'The world is for you'
    },
    {
        titol: 'Sup',
        durada: 7,
        numero_reproduccions: 120,
        album: 'Love me baby'
    }
]);