-- T’han contractat per a dissenyar una web que permeti fer comandes de menjar a domicili per Internet.

--     Tingues en compte les següents indicacions per a modelar com seria la base de dades del projecte:

--     Per a cada client/a emmagatzemem un identificador únic: Nom, cognoms, adreça, codi postal, localitat, província, número de telèfon.
--     Una persona pot realitzar moltes comandes, però una única comanda només pot ser realitzat per una única persona. De cada comanda s'emmagatzema un identificador únic: Data/hora, si la comanda és per a repartiment a domicili o per a recollir en botiga, la quantitat de productes que s'han seleccionat de cada tipus, el preu total.

-- Una comanda pot constar d'un o diversos productes.

--     Els productes poden ser pizzes, hamburgueses i begudes. De cada producte s'emmagatzema un identificador únic: Nom, descripció, imatge, preu.

-- En el cas de les pizzes existeixen diverses categories que poden anar canviant de nom al llarg de l'any. Una pizza només pot estar dins d'una categoria, però una categoria pot tenir moltes pizzes.

--     De cada categoria s'emmagatzema un identificador únic i un nom. Una comanda és gestionada per una única botiga i una botiga pot gestionar moltes comandes. De cada botiga s'emmagatzema un identificador únic: Adreça, codi postal, localitat, província.

--     En una botiga poden treballar molts empleats/des i un empleat/da només pot treballar en una botiga. De cada empleat/da, s'emmagatzema un identificador únic: Nom, cognoms, NIF, Telèfon.

--     Si treballa com a cuiner/a o repartidor/a. Per a les comandes de repartiment a domicili interessa guardar qui és el repartidor/a que fa el lliurament de la comanda i la data/hora del moment del lliurament.

DROP DATABASE IF EXISTS pizzeria;
CREATE DATABASE pizzeria CHARACTER SET utf8mb4;
USE pizzeria;

CREATE TABLE Clients (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    cognom1 VARCHAR(50) NOT NULL,
    cognom2 VARCHAR(50) NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    pis VARCHAR(50) NOT NULL,
    porta VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL,
    localitat VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL,
    telefon VARCHAR(50) NOT NULL
);

CREATE TABLE Categories_pizza (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Botigues (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    pis VARCHAR(50) NOT NULL,
    porta VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL,
    localitat VARCHAR(50) NOT NULL,
    provincia VARCHAR(50) NOT NULL
);

CREATE TABLE Empleats (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    cognom1 VARCHAR(50) NOT NULL,
    cognom2 VARCHAR(50) NOT NULL,
    nif VARCHAR(50) NOT NULL,
    telefon VARCHAR(50) NOT NULL,
    funcio ENUM ('cuiner', 'repartidor') NOT NULL,
    id_botiga INT NOT NULL,
    FOREIGN KEY (id_botiga) REFERENCES Botigues (id)
);

CREATE TABLE Comandes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_hora DATETIME NOT NULL,
    tipus ENUM ('domicili', 'botiga') NOT NULL,
    numero_pizzes INT NOT NULL,
    numero_hamburgueses INT NOT NULL,
    numero_begudes INT NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    id_client INT NOT NULL,
    id_botiga INT NOT NULL,
    id_empleat INT NOT NULL,
    FOREIGN KEY (id_client) REFERENCES Clients (id),
    FOREIGN KEY (id_botiga) REFERENCES Botigues (id),
    FOREIGN KEY (id_empleat) REFERENCES Empleats (id)
);

CREATE TABLE Hamburgueses (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    descripcio VARCHAR(50) NOT NULL,
    imatge VARCHAR(50) NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    id_comanda INT NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES Comandes (id)
);

CREATE TABLE Begudes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    descripcio VARCHAR(50) NOT NULL,
    imatge VARCHAR(50) NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    id_comanda INT NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES Comandes (id)
);

CREATE TABLE Pizzes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    descripcio VARCHAR(50) NOT NULL,
    imatge VARCHAR(50) NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    id_comanda INT NOT NULL,
    id_categoria INT NOT NULL,
    FOREIGN KEY (id_comanda) REFERENCES Comandes (id),
    FOREIGN KEY (id_categoria) REFERENCES Categories_pizza (id)
);

-- Dades de les taules

INSERT INTO Clients (nom, cognom1, cognom2, carrer, numero, pis, porta, codi_postal, localitat, provincia, telefon) VALUES
('Sandra','Manchon','Torrejon','Libby Street','3052','3','2','90274','Tarragona','Tarragona','635835547'),
('Paco','Fernandez','Prueba','Valley View Drive','3778','4','5','02141','Badalona','Barcelona','698717627'),
('Luís','Piedraita','Recio','Lords Way','4946','1','6','38012','Hospitalet de Llobregat','Barcelona','783441473'),
('Miguel','Hernandez','Sanchis','Werninger Street','2503','2','2','77099','Hospitalet de Llobregat','Barcelona','969060972'),
('Marta','López','Gallego','Maple Street','4004','3','2','90017','Hospitalet de Llobregat','Barcelona','590600474');

INSERT INTO Categories_pizza (nom) VALUES
('Carbonara'),
('Margarita'),
('Quatre formatges'),
('Tonyina i bacon');

INSERT INTO Botigues (carrer, numero, pis, porta, codi_postal, localitat, provincia) VALUES
('Lynch Street','105','1','5','53151','Hospitalet de Llobregat','Barcelona'),
('Star Trek Drive','2587','3','7','32466','Hospitalet de Llobregat','Barcelona'),
('Mandan Road','213','2','4','63080','Badalona','Barcelona');

INSERT INTO Empleats (nom, cognom1, cognom2, nif, telefon, funcio, id_botiga) VALUES
('Matias','Biden','Trump','46287483Y','648267048','cuiner',1),
('Fontvella','Morel','Park','21972026B','640745048','repartidor',2),
('John','Locke','Iturralde','73732471Z','590600464','repartidor',3);

INSERT INTO Comandes (data_hora, tipus, numero_pizzes, numero_hamburgueses, numero_begudes, preu, id_client, id_botiga, id_empleat) VALUES
('2022-12-27 12:57:17','domicili',1,2,2,30.25,1,2,1),
('2022-10-14 23:14:09','botiga',2,1,1,29.00,4,3,1),
('2022-01-30 09:25:46','botiga',1,1,2,27.75,3,1,2);

INSERT INTO Hamburgueses (nom, descripcio, imatge, preu, id_comanda) VALUES
('HAM-HAM','La millor hamburguesa del món','hamburguesa.jpg',5.00,1),
('Hambu','La preferida dels peques','hambu.jpg',3.00,3),
('Super Ham','Hamburguesa de qualitat','super-ham.jpg',4.00,2),
('Ham Fun','Una hamburguesa super divertida','ham-fun.jpg',6.00,1);

INSERT INTO Begudes (nom, descripcio, imatge, preu, id_comanda) VALUES
('Coca-cola','El refresc ideal per treure la set','coca_cola.jpg',6.80,1),
('Coca-cola','El refresc ideal per treure la set','coca_cola.jpg',6.80,3),
('Pepsi','Res millor que una Pepsi per veure','pepsi.jpg',8.25,3),
('Pepsi','Res millor que una Pepsi per veure','pepsi.jpg',8.25,2),
('Suc taronja','Vitamina C per un tub','taronja.jpg',5.00,1);

INSERT INTO Pizzes (nom, descripcio, imatge, preu, id_comanda, id_categoria) VALUES
('Ristorante Carbonara','Una deliciosa pizza de carbonara','pizza_carbonara.jpg',7.45,2,1),
('Ristorante Margarita','Una deliciosa pizza de margarita','margarita.jpg',9.70,3,3),
('Dr.Oetker Margarita','Una exquisita pizza de margarita','margarita2.jpg',9.30,2,2),
('Dr.Oetker quatre formatges','Una exquisita pizza de quatre formatges','quatre-formatges.jpg',6.15,1,3);

-- Queries pizzeria:

--     Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.

SELECT SUM(Comandes.numero_begudes) AS numero_begudes,clients.localitat FROM Comandes JOIN CLients ON Comandes.id_client = Clients.id WHERE Clients.localitat = "Hospitalet de Llobregat";

-- --     Llista quantes comandes ha efectuat un determinat empleat/da.

SELECT COUNT(Comandes.id) AS numero_comandes,Comandes.id_empleat FROM Comandes WHERE id_empleat = 1;