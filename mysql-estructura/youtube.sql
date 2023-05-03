-- Tractarem de fer un model senzill de com seria la base de dades per a una versió reduïda de YouTube.

--     De cada usuari/ària guardem un identificador únic: Email, password, nom d'usuari/ària, data de naixement, sexe, país, codi postal.


--     Un usuari/ària publica vídeos. De cada vídeo guardem un identificador únic: Un títol, una descripció, una grandària, el nom de l'arxiu de vídeo, durada del vídeo, un thumbnail, el nombre de reproduccions, el número de likes, el número de dislikes.


--     Un vídeo pot tenir tres estats diferents: públic, ocult i privat. Un vídeo pot tenir moltes etiquetes. Una etiqueta s'identifica per un identificador únic i un nom d'etiqueta. Interessa guardar qui és l'usuari/ària que publica el vídeo i en quina data/hora el fa.


--     Un usuari/ària pot crear un canal. Un canal té un identificador únic: Un nom, una descripció, una data de creació.


--     Un usuari/ària es pot subscriure als canals d'altres usuaris/es. Un usuari/ària pot donar-li un like o un dislike a un vídeo una única vegada. Caldrà portar un registre dels usuaris/es que li han donat like i dislike a un determinat vídeo i en quina data/hora ho van fer.


--     Un usuari/ària pot crear playlists amb els vídeos que li agraden. Cada playlist té un identificador únic: Un nom, una data de creació, un estat que indica que pot ser pública o privada.


--     Un usuari/ària pot escriure comentaris en un vídeo determinat. Cada comentari està identificat per un identificador únic: El text del comentari, la data/hora en la qual es va realitzar.


--     Un usuari/ària pot marcar un comentari com m'agrada o no m'agrada. Caldrà portar un registre dels usuaris/es que han marcat un comentari com m'agrada/no m'agrada, i en quina data/hora ho van fer.

DROP DATABASE IF EXISTS YouTube;
CREATE DATABASE YouTube CHARACTER SET utf8mb4;
USE YouTube;

CREATE TABLE Usuaris (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    correu VARCHAR(50) NOT NULL,
    contrasenya VARCHAR(50) NOT NULL,
    nom VARCHAR(50) NOT NULL,
    data_naixement DATE NOT NULL,
    sexe ENUM ('home', 'dona') NOT NULL,
    pais VARCHAR(50) NOT NULL,
    codi_postal VARCHAR(50) NOT NULL
);

CREATE TABLE Videos (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    titol VARCHAR(50) NOT NULL,
    descripcio VARCHAR(50) NOT NULL,
    tamany_mb INT(50) NOT NULL,
    nom_arxiu VARCHAR(50) NOT NULL,
    durada TIME NOT NULL,
    miniatura VARCHAR(50) NOT NULL,
    reproduccions INT(50) NOT NULL,
    likes INT(50) NOT NULL,
    dislikes INT(50) NOT NULL,
    estat ENUM ('public', 'ocult', 'privat') NOT NULL,
    data_hora_publicacio DATETIME NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Etiquetes (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL
);

CREATE TABLE Canals (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    descripcio VARCHAR(50) NOT NULL,
    data_creacio DATE NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Playlists (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    nom VARCHAR(50) NOT NULL,
    data_creacio DATE NOT NULL,
    estat ENUM ('publica', 'privada') NOT NULL,
    id_usuari INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Comentaris (
    id INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
    contingut VARCHAR(50) NOT NULL,
    data_creacio DATETIME NOT NULL,
    id_usuari INT NOT NULL,
    id_video INT NOT NULL,
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id),
    FOREIGN KEY (id_video) REFERENCES Videos (id)
);

CREATE TABLE Usuaris_i_comentaris (
    id_usuari INT NOT NULL,
    id_comentari INT NOT NULL,
    valoracio ENUM ('like', 'dislike') NOT NULL,
    data_valoracio DATETIME NOT NULL,
    PRIMARY KEY (id_usuari, id_comentari),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id),
    FOREIGN KEY (id_comentari) REFERENCES Comentaris (id)
);

CREATE TABLE Videos_i_etiquetes (
    id_video INT NOT NULL,
    id_etiqueta INT NOT NULL,
    PRIMARY KEY (id_video, id_etiqueta),
    FOREIGN KEY (id_video) REFERENCES Videos (id),
    FOREIGN KEY (id_etiqueta) REFERENCES Etiquetes (id)
);

CREATE TABLE Playlists_i_videos (
    id_playlist INT NOT NULL,
    id_video INT NOT NULL,
    PRIMARY KEY (id_playlist, id_video),
    FOREIGN KEY (id_playlist) REFERENCES Playlists (id),
    FOREIGN KEY (id_video) REFERENCES Videos (id)
);

CREATE TABLE Canals_usuaris_suscriptors (
    id_canal INT NOT NULL,
    id_usuari INT NOT NULL,
    PRIMARY KEY (id_canal, id_usuari),
    FOREIGN KEY (id_canal) REFERENCES Canals (id),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

CREATE TABLE Usuaris_videos_valoracions (
    id_video INT NOT NULL,
    id_usuari INT NOT NULL,
    valoracio ENUM ('like', 'dislike') NOT NULL,
    data_valoracio DATETIME NOT NULL,
    PRIMARY KEY (id_video, id_usuari),
    FOREIGN KEY (id_video) REFERENCES Videos (id),
    FOREIGN KEY (id_usuari) REFERENCES Usuaris (id)
);

-- Dades de les taules

INSERT INTO Usuaris (correu, contrasenya, nom, data_naixement, sexe, pais, codi_postal) VALUES
('pepitogrillo@gmail.com', '123pruebaotravez', 'Pepe', '1998-02-21', 'home', 'Espanya', '09632'),
('armadillo@gmail.com', 'HolaAMIGOS', 'Luis', '1987-06-10', 'home', 'Espanya', '04587'),
('colorderosa@gmail.com', 'estoesuninsulto', 'Pepa', '1999-03-30', 'dona', 'Espanya', '52170');

INSERT INTO Videos (titol, descripcio, tamany_mb, nom_arxiu, durada, miniatura, reproduccions, likes, dislikes, estat, data_hora_publicacio, id_usuari) VALUES
('Saltant per la finestra', 'Un tipus molt estúpid surt corrents per la finestra fugint del seu gat', 700, 'Paio estúpid', '00:10:30', 'pobre-tonto.jpg', 2579, 260, 68, 'public', '2023-05-02 11:42:49', 3);

INSERT INTO Etiquetes (nom) VALUES
('Humor'),
('Documental'),
('Teories conspiració'),
('Bromes pesades');

INSERT INTO Canals (nom, descripcio, data_creacio, id_usuari) VALUES
('El rei del mambo', 'En aquest canal veureu les idiotades més idiotes que un idiota podia inventar', '2021-0-02', 2);

INSERT INTO Playlists (nom, data_creacio, estat, id_usuari) VALUES
('Caigudes tontes', '1990-09-02', 'privada', 3);

INSERT INTO Comentaris (contingut, data_creacio, id_usuari, id_video) VALUES
('Jajjajajaja que bo xdddddd', '2008-10-13 19:23:41', 1, 3);

INSERT INTO Usuaris_i_comentaris (id_usuari, id_comentari, valoracio, data_valoracio) VALUES
(2,1, 'like', '2008-10-13 19:23:41');

INSERT INTO Videos_i_etiquetes (id_video, id_etiqueta) VALUES
(1,1),
(1,4);

INSERT INTO Playlists_i_videos (id_playlist, id_video) VALUES
(1,1);

INSERT INTO Canals_usuaris_suscriptors (id_canal, id_usuari) VALUES
();

INSERT INTO Usuaris_videos_valoracions (id_video, id_usuari, valoracio, data_valoracio) VALUES
();