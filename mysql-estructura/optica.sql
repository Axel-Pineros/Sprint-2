-- Una òptica, anomenada “Cul d'Ampolla”, vol informatitzar la gestió dels clients/es i vendes d'ulleres.

-- En primer lloc, l'òptica vol saber quin és el proveïdor de cadascuna de les ulleres. En concret vol saber de cada proveïdor: El nom, l'adreça (carrer, número, pis, porta, ciutat, codi postal i país), telèfon, fax, NIF.

-- La política de compres de l'òptica es basa que les ulleres d'una marca es compraran a un únic proveïdor (així en podrà treure més bons preus), però poden comprar ulleres de diverses marques a un proveïdor. De les ulleres vol saber: La marca, la graduació de cadascun dels vidres, el tipus de muntura (flotant, pasta o metàl·lica), el color de la muntura, el color de cada vidre, el preu.

-- Dels clients/es vol emmagatzemar: El nom, l'adreça postal, el telèfon, el correu electrònic, la data de registre.
-- Quan arriba un/a client/a nou, emmagatzemar el/la client/a que li ha recomanat l'establiment (sempre que algú li hagi recomanat).
-- El nostre sistema haurà d’indicar qui ha sigut l’empleat/da que ha venut cada ullera. Defineix un període de temps de vendes.

DROP DATABASE IF EXISTS optica;
CREATE DATABASE optica CHARACTER SET utf8mb4;
USE optica;

CREATE TABLE Proveidors (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    pis VARCHAR(50) NOT NULL,
    porta VARCHAR(50) NOT NULL,
    ciutat VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    fax VARCHAR(20) NOT NULL,
    nif VARCHAR(20) NOT NULL
);

CREATE TABLE Empleats (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
);

CREATE TABLE Ulleres (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    graduacio_vidre VARCHAR(50) NOT NULL,
    tipus_muntura ENUM ('flotant', 'pasta', 'metallica') NOT NULL,
    color_muntura VARCHAR(50) NOT NULL,
    color_vidre VARCHAR(50) NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    data_venda DATE,
    id_proveidor INT NOT NULL,
    id_empleat_venedor INT,
    FOREIGN KEY (id_proveidor) REFERENCES Proveidors (id),
    FOREIGN KEY (id_empleat_venedor) REFERENCES Empleats (id)
);

CREATE TABLE Clients (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    carrer VARCHAR(50) NOT NULL,
    numero VARCHAR(50) NOT NULL,
    pis VARCHAR(50) NOT NULL,
    porta VARCHAR(50) NOT NULL,
    ciutat VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    telefon VARCHAR(20) NOT NULL,
    correu_electronic VARCHAR(50) NOT NULL,
    data_registre DATE NOT NULL,
    id_recomanador INT,
    FOREIGN KEY (id_recomanador) REFERENCES Clients (id)
);

-- CREATE TABLE Ventes (
--     id_ulleres INT NOT NULL,
--     id_client INT NOT NULL,
--     id_empleat INT NOT NULL,
--     data_venda DATE NOT NULL,
--     FOREIGN KEY (id_ulleres) REFERENCES Ulleres (id),
--     FOREIGN KEY (id_client) REFERENCES Clients (id)
-- );

-- Dades de les taules

INSERT INTO Proveidors (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES
('Pedro','Plaza del Mesón','156','4','5','Lleida','08798','Espanya'.'618223876','313414515','82842571K');

INSERT INTO Empleats () VALUES
('Lidia'),
('Tobi'),
('Matias'),
('José'),
('Juan');

INSERT INTO Ulleres (marca, graduacio_vidre, tipus_muntura, color_muntura, color_vidre, preu, data_venda, id_proveidor, id_empleat_venedor) VALUES
(1,);

INSERT INTO Clients (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, correu_electronic, data_registre, id_recomanador) VALUES
('Maria','');

    /*Queries Òptica:

    Llista el total de compres d’un client/a.
    Llista les diferents ulleres que ha venut un empleat durant un any.
    Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.*/
