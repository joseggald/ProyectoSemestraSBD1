SET foreign_key_checks = 0;

LOAD DATA INFILE '/var/lib/mysql-files/zonas.csv'
INTO TABLE Zona
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Tipo, ID_Padre);


LOAD DATA INFILE '/var/lib/mysql-files/partidos.csv'
INTO TABLE PartidoPolitico
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Sigla);


LOAD DATA INFILE '/var/lib/mysql-files/elecciones.csv'
INTO TABLE Eleccion
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(Nombre, Ano, ID_Zona);


LOAD DATA INFILE '/var/lib/mysql-files/pruebas/resultados.csv'
INTO TABLE ResultadoEleccion
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID_Eleccion, ID_Partido, Votos);


LOAD DATA INFILE '/var/lib/mysql-files/pruebas/demografia.csv'
INTO TABLE Demografia
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(ID_Zona, Sexo, Raza, Educacion, Analfabetos, Alfabetos, Primaria, NivelMedio, Universitarios);


SET foreign_key_checks = 1;
