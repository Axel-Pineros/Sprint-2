// T’han contractat per a dissenyar una web que permeti fer comandes de menjar a domicili per Internet.

//     Tingues en compte les següents indicacions per a modelar com seria la base de dades del projecte:
//     Per a cada client/a emmagatzemem un identificador únic: Nom, cognoms, adreça, codi postal, localitat, província, número de telèfon.
//     Una persona pot realitzar moltes comandes, però una única comanda només pot ser realitzat per una única persona. De cada comanda s'emmagatzema un identificador únic: Data/hora, si la comanda és per a repartiment a domicili o per a recollir en botiga, la quantitat de productes que s'han seleccionat de cada tipus, el preu total.


// Una comanda pot constar d'un o diversos productes.

//     Els productes poden ser pizzes, hamburgueses i begudes. De cada producte s'emmagatzema un identificador únic: Nom, descripció, imatge, preu.


// En el cas de les pizzes existeixen diverses categories que poden anar canviant de nom al llarg de l'any. Una pizza només pot estar dins d'una categoria, però una categoria pot tenir moltes pizzes.

//     De cada categoria s'emmagatzema un identificador únic i un nom. Una comanda és gestionada per una única botiga i una botiga pot gestionar moltes comandes. De cada botiga s'emmagatzema un identificador únic: Adreça, codi postal, localitat, província.


//     En una botiga poden treballar molts empleats/des i un empleat/da només pot treballar en una botiga. De cada empleat/da, s'emmagatzema un identificador únic: Nom, cognoms, NIF, Telèfon.
//     Si treballa com a cuiner/a o repartidor/a. Per a les comandes de repartiment a domicili interessa guardar qui és el repartidor/a que fa el lliurament de la comanda i la data/hora del moment del lliurament.

use('pizzeria');

db.createCollection('clients');
db.createCollection('botigues');
db.createCollection('empleats');
db.createCollection('comandes');
db.createCollection('hamburgueses');
db.createCollection('begudes');
db.createCollection('pizzes');

db.clients.insertMany([
    {
        nom: 'Sandra',
        cognom1: 'Manchon',
        cognom2: 'Torrejon',
        carrer: 'Libby Street',
        numero: '3052',
        pis: '3',
        porta: '2',
        codi_postal: '90274',
        localitat: 'Tarragona',
        provincia: 'Tarragona',
        telefon: '635835547'
    },
    {
        nom: 'Paco',
        cognom1: 'Fernandez',
        cognom2: 'Prueba',
        carrer: 'Valley View Drive',
        numero: '3778',
        pis: '4',
        porta: '5',
        codi_postal: '02141',
        localitat: 'Badalona',
        provincia: 'Barcelona',
        telefon: '698717627'
    },
    {
        nom: 'Luís',
        cognom1: 'Piedraita',
        cognom2: 'Recio',
        carrer: 'Lords Way',
        numero: '4946',
        pis: '1',
        porta: '6',
        codi_postal: '38012',
        localitat: 'Hospitalet de Llobregat',
        provincia: 'Barcelona',
        telefon: '783441473'
    },
    {
        nom: 'Miguel',
        cognom1: 'Hernandez',
        cognom2: 'Sanchis',
        carrer: 'Werninger Street',
        numero: '2503',
        pis: '2',
        porta: '2',
        codi_postal: '77099',
        localitat: 'Hospitalet de Llobregat',
        provincia: 'Barcelona',
        telefon: '969060972'
    },
    {
        nom: 'Marta',
        cognom1: 'López',
        cognom2: 'Gallego',
        carrer: 'Maple Street',
        numero: '4004',
        pis: '3',
        porta: '2',
        codi_postal: '90017',
        localitat: 'Hospitalet de Llobregat',
        provincia: 'Barcelona',
        telefon: '590600474'
    }
]);

db.botigues.insertMany([
    {
        numero_botiga: 1,
        carrer: 'Lynch Street',
        numero: '105',
        pis: '1',
        porta: '5',
        codi_postal: '53151',
        localitat: 'Hospitalet de Llobregat',
        provincia: 'Barcelona'
    },
    {
        numero_botiga: 2,
        carrer: 'Star Trek Drive',
        numero: '2587',
        pis: '3',
        porta: '7',
        codi_postal: '32466',
        localitat: 'Hospitalet de Llobregat',
        provincia: 'Barcelona'
    },
    {
        numero_botiga: 3,
        carrer: 'Mandan Road',
        numero: '213',
        pis: '2',
        porta: '4',
        codi_postal: '63080',
        localitat: 'Badalona',
        provincia: 'Barcelona'
    }
]);

db.empleats.insertMany([
    {
        nom: 'Matias',
        cognom1: 'Biden',
        cognom2: 'Trump',
        nif: '46287483Y',
        telefon: '648267048',
        funcio: 'cuiner',
        botiga: 1
    },
    {
        nom: 'Fontvella',
        cognom1: 'Morel',
        cognom2: 'Park',
        nif: '21972026B',
        telefon: '640745048',
        funcio: 'repartidor',
        botiga: 2
    },
    {
        nom: 'John',
        cognom1: 'Locke',
        cognom2: 'Iturralde',
        nif: '73732471Z',
        telefon: '590600464',
        funcio: 'repartidor',
        botiga: 3
    }
]);

db.comandes.insertMany([
    {
        data_hora: '2022-12-27 12:57:17',
        tipus: 'domicili',
        numero_pizzes: 1,
        numero_hamburgueses: 2,
        numero_begudes: 2,
        preu: 30.25,
        client: 'Sandra',
        botiga: 2,
        empleat: 'Matias'
    },
    {
        data_hora: '2022-10-14 23:14:09',
        tipus: 'botiga',
        numero_pizzes: 2,
        numero_hamburgueses: 1,
        numero_begudes: 1,
        preu: 29.00,
        client: 'Miguel',
        botiga: 3,
        empleat: 'Matias'
    },
    {
        data_hora: '2022-01-30 09:25:46',
        tipus: 'botiga',
        numero_pizzes: 1,
        numero_hamburgueses: 1,
        numero_begudes: 2,
        preu: 27.75,
        client: 'Luis',
        botiga: 1,
        empleat: 'Fontvella'
    }
])

db.pizzes.insertMany([
    {
        nom: 'Ristorante Carbonara',
        descripcio: 'Una deliciosa pizza de carbonara',
        imatge: 'pizza_carbonara.jpg',
        preu: 7.45,
        comanda: 2,
        categoria: 'Carbonara'
    },
    {
        nom: 'Ristorante Margarita',
        descripcio: 'Una deliciosa pizza de margarita',
        imatge: 'margarita.jpg',
        preu: 9.70,
        comanda: 3,
        categoria: 'Margarita'
    },
    {
        nom: 'Dr.Oetker Margarita',
        descripcio: 'Una exquisita pizza de margarita',
        imatge: 'margarita2.jpg',
        preu: 9.30,
        comanda: 2,
        categoria: 'Margarita'
    },
    {
        nom: 'Dr.Oetker quatre formatges',
        descripcio: 'Una exquisita pizza de quatre formatges',
        imatge: 'quatre-formatges.jpg',
        preu: 6.15,
        comanda: 1,
        categoria: 'Quatre formatges'
    }
]);

db.begudes.insertMany([
    {
        nom: 'Coca-cola',
        descripcio: 'El refresc ideal per treure la set',
        imatge: 'coca_cola.jpg',
        preu: 6.80,
        comanda: 1
    },
    {
        nom: 'Coca-cola',
        descripcio: 'El refresc ideal per treure la set',
        imatge: 'coca_cola.jpg',
        preu: 6.80,
        comanda: 3
    },
    {
        nom: 'Pepsi',
        descripcio: 'Res millor que una Pepsi per veure',
        imatge: 'pepsi.jpg',
        preu: 8.25,
        comanda: 3
    },
    {
        nom: 'Pepsi',
        descripcio: 'Res millor que una Pepsi per veure',
        imatge: 'pepsi.jpg',
        preu: 8.25,
        comanda: 2
    },
    {
        nom: 'Suc taronja',
        descripcio: 'Vitamina C per un tub',
        imatge: 'taronja.jpg',
        preu: 5.00,
        comanda: 1
    }
]);

db.hamburgueses.insertMany([
    {
        nom: 'HAM-HAM',
        descripcio: 'La millor hamburguesa del món',
        imatge: 'hamburguesa.jpg',
        preu: 5.00,
        comanda: 1
    },
    {
        nom: 'Hambu',
        descripcio: 'La preferida dels peques',
        imatge: 'hambu.jpg',
        preu: 3.00,
        comanda: 3
    },
    {
        nom: 'Super Ham',
        descripcio: 'Hamburguesa de qualitat',
        imatge: 'super-ham.jpg',
        preu: 4.00,
        comanda: 2
    },
    {
        nom: 'Ham Fun',
        descripcio: 'Una hamburguesa super divertida',
        imatge: 'ham-fun.jpg',
        preu: 6.00,
        comanda: 1
    },
]);