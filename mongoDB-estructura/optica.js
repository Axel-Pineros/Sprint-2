// Una òptica, anomenada “Cul d'Ampolla”, vol informatitzar la gestió dels clients/es i vendes d'ulleres.

//     En primer lloc, l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor: El nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF.


//     La política de compres de l'òptica es basa que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber: La marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl·lica), el color de la muntura, el color de cada vidre, el preu.


//     Dels clients/es vol emmagatzemar: El nom, l'adreça postal, el telèfon, el correu electrònic, la data de registre.
//     Quan arriba un/a client/a nou, emmagatzemar el/la client/a que li ha recomanat l'establiment (sempre que algú li hagi recomanat).
//     El nostre sistema haurà d’indicar qui ha sigut l’empleat/da que ha venut cada ullera. Defineix un període de temps de vendes.

use('optica');

db.createCollection('proveidors');
db.createCollection('empleats');
db.createCollection('ulleres');
db.createCollection('clients');

db.proveidors.insertMany([
    {
        nom: 'Pedro',
        carrer: 'Plaza del Mesón',
        numero: '156',
        pis: '4',
        porta: '5',
        ciutat: 'Lleida',
        codi_postal: '08798',
        pais: 'Espanya',
        telefon: '618223876',
        fax: '313414515',
        nif: '82842571K'
    },
    {
        nom: 'Jack',
        carrer: 'College Ave',
        numero: '235',
        pis: '3',
        porta: '1',
        ciutat: 'Badalona',
        codi_postal: '46264',
        pais: 'Espanya',
        telefon: '922402763',
        fax: '157286114',
        nif: '09656627P'
    },
    {
        nom: 'Chris',
        carrer: 'Olivia Gran Subida',
        numero: '89',
        pis: '3',
        porta: '2',
        ciutat: 'Lleida',
        codi_postal: '34226',
        pais: 'Espanya',
        telefon: '907296379',
        fax: '835513183',
        nif: 'Z1578230K'
    },
    {
        nom: 'Laura',
        carrer: 'Ramírez Ramal',
        numero: '121',
        pis: '8',
        porta: '7',
        ciutat: 'Barcelona',
        codi_postal: '42174',
        pais: 'Espanya',
        telefon: '918126184',
        fax: '443833118',
        nif: 'N9664175H'
    }
]);

db.empleats.insertMany([
    {
        nom: 'Lidia',
    },
    {
        nom: 'Tobi',
    },
    {
        nom: 'Matias',
    },
    {
        nom: 'José',
    },
    {
        nom: 'Juan',
    }
]);

db.ulleres.insertMany([
    {
        marca: 'Masvisión',
        graduacio_vidre: '4',
        tipus_muntura: 'flotant',
        color_muntura: 'blanc',
        color_vidre: 'blau',
        preu: 35.00,
        proveidor: 'Pedro',
        client: 'Carlos',
        empleat: 'Matias',
        data_venda: '2021-09-04'
    },
    {
        marca: 'Chin chin',
        graduacio_vidre: '6',
        tipus_muntura: 'pasta',
        color_muntura: 'verd',
        color_vidre: 'vermell',
        preu: 48.00,
        proveidor: 'Jack',
        client: 'Paco',
        empleat: 'Matias',
        data_venda: '2021-10-05'
    },
    {
        marca: 'Ojosclaros',
        graduacio_vidre: '4',
        tipus_muntura: 'metallica',
        color_muntura: 'blau',
        color_vidre: 'verd',
        preu: 24.00,
        proveidor: 'Pedro',
        client: 'Maria',
        empleat: 'Tobi',
        data_venda: '2021-12-08'
    },
    {
        marca: 'Prada',
        graduacio_vidre: '8',
        tipus_muntura: 'pasta',
        color_muntura: 'groc',
        color_vidre: 'taronja',
        preu: 56.00,
        proveidor: 'Chris',
        client: 'Maria',
        empleat: 'Juan',
        data_venda: '2021-08-16'
    },
    {
        marca: 'Dior',
        graduacio_vidre: '6',
        tipus_muntura: 'metallica',
        color_muntura: 'negre',
        color_vidre: 'blanc',
        preu: 42.00,
        proveidor: 'Chris',
        client: 'Josep',
        empleat: 'Lidia',
        data_venda: '2021-10-27'
    }
]);

db.clients.insertMany([
    {
        nom: 'Maria',
        carrer: 'Teresa Mercado',
        numero: '37',
        pis: '2',
        porta: '8',
        ciutat: 'Barcelona',
        codi_postal: '75745',
        pais: 'Espanya',
        telefon: '748413247',
        correu_electronic: 'mariadb@gmail.com',
        data_registre: '2020-05-16',
        recomanador: null
    },
    {
        nom: 'Carlos',
        carrer: 'Olvera Vía',
        numero: '146',
        pis: '3',
        porta: '5',
        ciutat: 'Barcelona',
        codi_postal: '35142',
        pais: 'Espanya',
        telefon: '969060981',
        correu_electronic: 'carleto099@gmail.com',
        data_registre: '2020-08-24',
        recomanador: null
    },
    {
        nom: 'Josep',
        carrer: 'Soledad Ronda',
        numero: '123',
        pis: '1',
        porta: '4',
        ciutat: 'Barcelona',
        codi_postal: '46705',
        pais: 'Espanya',
        telefon: '590600720',
        correu_electronic: 'joselito@gmail.com',
        data_registre: '2020-09-13',
        recomanador: 'Maria'
    },
    {
        nom: 'Paco',
        carrer: 'Teresa Mercado',
        numero: '89',
        pis: '2',
        porta: '5',
        ciutat: 'Barcelona',
        codi_postal: '37306',
        pais: 'Espanya',
        telefon: '678548013',
        correu_electronic: 'pacolo@gmail.com',
        data_registre: '2020-07-02',
        recomanador: 'Josep'
    },
]);