-- Creación de tablas
CREATE TABLE Zona (
    ID_Zona INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Tipo VARCHAR(100),  
    ID_Padre INT,       
    FOREIGN KEY (ID_Padre) REFERENCES Zona(ID_Zona)
);

CREATE TABLE PartidoPolitico (
    ID_Partido INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Sigla VARCHAR(50)
);

CREATE TABLE Eleccion (
    ID_Eleccion INT AUTO_INCREMENT PRIMARY KEY,
    Nombre VARCHAR(255),
    Ano INT,
    ID_Zona INT,
    FOREIGN KEY (ID_Zona) REFERENCES Zona(ID_Zona)
);

CREATE TABLE ResultadoEleccion (
    ID_Resultado INT AUTO_INCREMENT PRIMARY KEY,
    ID_Eleccion INT,
    ID_Partido INT,
    Votos INT,
    FOREIGN KEY (ID_Eleccion) REFERENCES Eleccion(ID_Eleccion),
    FOREIGN KEY (ID_Partido) REFERENCES PartidoPolitico(ID_Partido)
);

CREATE TABLE Demografia (
    ID_Demografia INT AUTO_INCREMENT PRIMARY KEY,
    ID_Zona INT,
    Sexo VARCHAR(50),
    Raza VARCHAR(50),
    Educacion VARCHAR(50),
    Analfabetos INT,
    Alfabetos INT,
    Primaria INT,
    NivelMedio INT,
    Universitarios INT,
    FOREIGN KEY (ID_Zona) REFERENCES Zona(ID_Zona)
);
