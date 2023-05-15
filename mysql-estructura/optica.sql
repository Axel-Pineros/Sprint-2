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
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Ulleres (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    marca VARCHAR(50) NOT NULL,
    graduacio_vidre VARCHAR(50) NOT NULL,
    tipus_muntura ENUM ('flotant', 'pasta', 'metallica') NOT NULL,
    color_muntura VARCHAR(50) NOT NULL,
    color_vidre VARCHAR(50) NOT NULL,
    preu DECIMAL(10, 2) NOT NULL,
    id_proveidor INT NOT NULL,
    FOREIGN KEY (id_proveidor) REFERENCES Proveidors (id)
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

CREATE TABLE Ventes (
    id_ulleres INT NOT NULL,
    id_client INT NOT NULL,
    id_empleat INT NOT NULL,
    data_venda DATE NOT NULL,
    FOREIGN KEY (id_ulleres) REFERENCES Ulleres (id),
    FOREIGN KEY (id_client) REFERENCES Clients (id),
    FOREIGN KEY (id_empleat) REFERENCES Empleats (id)
);

-- Dades de les taules

INSERT INTO Proveidors (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, fax, nif) VALUES
('Pedro','Plaza del Mesón','156','4','5','Lleida','08798','Espanya','618223876','313414515','82842571K'),
('Jack','College Ave','235','3','1','Badalona','46264','Espanya','922402763','157286114','09656627P'),
('Chris','Olivia Gran Subida','89','3','2','Lleida','34226','Espanya','907296379','835513183','Z1578230K'),
('Laura','Ramírez Ramal','121','8','7','Barcelona','42174','Espanya','918126184','443833118','N9664175H');

INSERT INTO Empleats (nom) VALUES
('Lidia'),
('Tobi'),
('Matias'),
('José'),
('Juan');

INSERT INTO Ulleres (marca, graduacio_vidre, tipus_muntura, color_muntura, color_vidre, preu, id_proveidor) VALUES
('Masvisión','4','flotant','blanc','blau',35.00,1),
('Chin chin','6','pasta','verd','vermell',48.00,2),
('Ojosclaros','4','metallica','blau','verd',24.00,1),
('Prada','8','pasta','groc','taronja',56.00,3),
('Dior','6','metallica','negre','blanc',42.00,3);

INSERT INTO Clients (nom, carrer, numero, pis, porta, ciutat, codi_postal, pais, telefon, correu_electronic, data_registre, id_recomanador) VALUES
('Maria','Teresa Mercado','37','2','8','Barcelona','75745','Espanya','748413247','mariadb@gmail.com','2020-05-16',NULL),
('Carlos','Olvera Vía','146','3','5','Barcelona','35142','Espanya','969060981','carleto099@gmail.com','2020-08-24',NULL),
('Josep','Soledad Ronda','123','1','4','Barcelona','46705','Espanya','590600720','joselito@gmail.com','2020-09-13',1),
('Paco','Véliz Barranco','89','2','5','Barcelona','37306','Espanya','678548013','pacolo@gmail.com','2020-07-02',3);

INSERT INTO Ventes (id_ulleres, id_client, id_empleat, data_venda) VALUES
(1,2,3,'2021-09-04'),
(2,4,3,'2021-10-05'),
(3,1,2,'2021-12-08'),
(4,1,5,'2021-08-16'),
(5,3,1,'2021-10-27');

--     Queries Òptica:

--     Llista el total de compres d’un client/a.

SELECT * FROM Ventes WHERE id_client = 1;

--     Llista les diferents ulleres que ha venut un empleat durant un any.

SELECT ventes.id_ulleres,ventes.id_empleat FROM Ventes WHERE ventes.id_empleat = 3;

--     Llista els diferents proveïdors que han subministrat ulleres venudes amb èxit per l'òptica.

SELECT DISTINCT proveidors.nom AS proveidors_amb_ulleres_venudes FROM Proveidors JOIN Ulleres ON proveidors.id = ulleres.id_proveidor JOIN Ventes on ventes.id_ulleres = ulleres.id;