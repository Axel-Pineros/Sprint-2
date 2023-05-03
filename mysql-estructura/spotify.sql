-- Tractarem de fer un model senzill de com seria la base de dades necessària per a Spotify.

--     Existeixen dos tipus d'usuaris/es: free i prèmium. De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.


--     Els usuaris/es prèmium fan subscripcions. Les dades necessàries que caldrà guardar per a cada subscripció són: Data d'inici de la subscripció, data de renovació del servei, una forma de pagament, que pot ser mitjançant targeta de crèdit o PayPal.


--     De les targetes de crèdit guardem el número de targeta, mes i any de caducitat i el codi de seguretat. Dels usuaris/es que paguen amb PayPal guardem el nom d'usuari/ària de PayPal. Ens interessa portar un registre de tots els pagaments que un usuari/ària prèmium ha anat realitzant durant el període que està subscrit. De cada pagament es guarda: La data, un número d'ordre (que és únic), un total.


--     Un usuari/ària pot crear moltes playlists. De cada playlist guardem: Un títol, el nombre de cançons que conté, un identificador únic, una data de creació.


--     Quan un usuari/ària esborra una playlist no s'esborra del sistema, sinó que es marca com que ha estat eliminada. D'aquesta manera l'usuari/ària pot tornar a recuperar les seves playlists en cas que les hagi eliminat per error. És necessari emmagatzemar la data en la qual la playlist ha estat marcada com eliminada.

--     Podem dir que existeixen dos tipus de playlists: actives i esborrades. Una playlist que està activa pot ser compartida amb altres usuaris/es, això vol dir que altres usuaris/es poden afegir cançons en ella. En una llista compartida ens interessa saber quin usuari/ària ha estat el que ha afegit cada cançó i en quina data ho va fer.
--     Una cançó només pot pertànyer a un únic àlbum. Un àlbum pot contenir moltes cançons. Un àlbum ha estat publicat per un/a únic/a artista. Un/a artista pot haver publicat molts àlbums. De cada cançó guardem un identificador únic: Un títol, una durada, el nombre de vegades que ha estat reproduïda pels usuaris/es de Spotify.


--     De cada àlbum guardem un identificador únic: Títol, any de publicació, una imatge amb la portada.

--     De cada artista guardem un identificador únic: Nom, una imatge de l'artista


--     Un usuari/ària pot seguir a molts/es artistes. Un/a artista pot estar relacionat/da amb altres artistes que facin música semblant. De manera que Spotify pugui mostrar-nos un llistat d'artistes relacionats/des amb els artistes que ens agraden. També ens interessa guardar quins són els àlbums i les cançons favorites d'un usuari/ària. Un usuari/ària pot seleccionar molts àlbums i moltes cançons com a favorites.


DROP DATABASE IF EXISTS Spotify;
CREATE DATABASE Spotify CHARACTER SET utf8mb4;
USE Spotify;

CREATE TABLE Usuaris (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    email VARCHAR(50) NOT NULL,
    contrasenya VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    data_naixement DATE NOT NULL,
    sexe ENUM ('home', 'dona') NOT NULL,
    pais VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL
);

CREATE TABLE Usuaris_premium (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_inici DATE NOT NULL,
    data_renovacio DATE NOT NULL,
    pagament ENUM ('targeta_credit', 'paypal') NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Targetes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    numero VARCHAR(50) NOT NULL,
    data_caducitat DATE NOT NULL,
    codi_seguretat VARCHAR(50) NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari_premium) REFERENCES Usuaris_premium (id)
);

CREATE TABLE Paypal (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom_paypal VARCHAR(50) NOT NULL,
    id_usuari_premium INT NOT NULL,
    FOREIGN KEY (id_usuari_premium) REFERENCES Usuaris_premium (id)
);

CREATE TABLE Pagaments (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    data_pagament DATE NOT NULL,
    numero_ordre INT(50) NOT NULL,
    total DECIMAL(10, 2) NOT NULL,
    id_usuari_premium INT NOT NULL,
    FOREIGN KEY (id_usuari_premium) REFERENCES Usuaris_premium (id)
);

CREATE TABLE Playlists (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titol VARCHAR(50) NOT NULL,
    nombre_cancons INT(50) NOT NULL,
    data_creacio DATE NOT NULL,
    estat ENUM ('activa', 'eliminada') NOT NULL,
    data_eliminacio DATE,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Artistes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    imatge_artista VARCHAR(50) NOT NULL
);

CREATE TABLE Albums (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titol VARCHAR(50) NOT NULL,
    any_publicacio INT(50) NOT NULL,
    imatge_portada VARCHAR(50) NOT NULL,
    id_artista INT NOT NULL,
    FOREIGN KEY (id_artista) REFERENCES Artistes (id)
);

CREATE TABLE Cancons (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titol VARCHAR(50) NOT NULL,
    durada INT(50) NOT NULL,
    numero_reproduccions INT(50) NOT NULL,
    id_album INT NOT NULL,
    FOREIGN KEY (id_album) REFERENCES Albums (id)
);

CREATE TABLE Artistes_relacionats (
    id_artista INT NOT NULL,
    id_artista_relacionat INT NOT NULL,
    PRIMARY KEY (id_artista, id_artista_relacionat),
    FOREIGN KEY (id_artista) REFERENCES Artistes (id),
    FOREIGN KEY (id_artista_relacionat) REFERENCES Artistes (id)
);

CREATE TABLE Usuaris_i_artistes (
    id_usuari INT NOT NULL,
    id_artista INT NOT NULL,
    PRIMARY KEY (id_usuari, id_artista),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id),
    FOREIGN KEY (id_artista) REFERENCES Artistes (id)
);

CREATE TABLE Usuaris_i_cancons (
    id_usuari INT NOT NULL,
    id_canco INT NOT NULL,
    PRIMARY KEY (id_usuari, id_canco),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id),
    FOREIGN KEY (id_canco) REFERENCES Cancons (id)
);

CREATE TABLE Usuaris_i_albums (
    id_usuari INT NOT NULL,
    id_album INT NOT NULL,
    PRIMARY KEY (id_usuari, id_album),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id),
    FOREIGN KEY (id_album) REFERENCES Albums (id)
);

CREATE TABLE Playlists_i_cancons (
    id_playlist INT NOT NULL,
    id_canco INT NOT NULL,
    id_usuari INT NOT NULL,
    data_introduccio DATE NOT NULL,
    PRIMARY KEY (id_playlist, id_canco, id_usuari),
    FOREIGN KEY (id_playlist) REFERENCES Playlists (id),
    FOREIGN KEY (id_canco) REFERENCES Cancons (id),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

-- Dades de les taules

INSERT INTO Usuaris (email, contrasenya, nom, data_naixement, sexe, pais, codi_postal) VALUES ();

INSERT INTO Usuaris_premium (data_inici, data_renovacio, pagament, id_usuari) VALUES ();

INSERT INTO Targetes (numero, data_caducitat, codi_seguretat, id_usuari_premium) VALUES ();

INSERT INTO PayPal (nom_paypal, id_usuari_premium) VALUES ();

INSERT INTO Pagaments (data_pagament, numero_ordre, total, id_usuari_premium) VALUES ();