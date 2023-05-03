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
    adreca VARCHAR(50) NOT NULL,
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
    adreca VARCHAR(50) NOT NULL,
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
    data_entrega DATETIME,
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

INSERT INTO Clients (nom, cognom1, cognom2, adreca, codi_postal, localitat, provincia, telefon) VALUES
();

INSERT INTO Categories_pizza (nom) VALUES
();

INSERT INTO Botigues (adreca, codi_postal, localitat, provincia) VALUES
();

INSERT INTO Empleats (nom, cognom1, cognom2, nif, telefon, funcio, data_entrega, id_botiga) VALUES
();

INSERT INTO Comandes (data_hora, tipus, numero_pizzes, numero_hamburgueses, numero_begudes, preu, id_client, id_botiga, id_empleat) VALUES
();

INSERT INTO Hamburgueses (nom, descripcio, imatge, preu, id_comanda) VALUES
();

INSERT INTO Begudes (nom, descripcio, imatge, preu, id_comanda) VALUES
();

INSERT INTO Pizzes (nom, descripcio, imatge, preu, id_comanda, id_categoria) VALUES
();

-- Queries pizzeria:

--     Llista quants productes de tipus “Begudes”. s'han venut en una determinada localitat.


--     Llista quantes comandes ha efectuat un determinat empleat/da.

SELECT COUNT(*) FROM Comandes WHERE id_empleat = 1;