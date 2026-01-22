CREATE DATABASE COVID19;
USE COVID19;
CREATE TABLE estado(
	idEstado       INT NOT NULL,
	nombre         VARCHAR(80) NOT NULL,
	poblacion      INT NOT NULL,
	PRIMARY KEY(idEstado)
	);

CREATE TABLE indicador(
	idIndicador       INT NOT NULL,
	nombre            VARCHAR(80) NOT NULL,
	descripción       VARCHAR(200) NOT NULL,
	PRIMARY KEY(idIndicador)
	);

CREATE TABLE municipio(
	idMunicipio	INT NOT NULL,
	nombre          VARCHAR(80) NOT NULL,
	poblacion       INT NOT NULL,
	idEstado        INT NOT NULL,
	PRIMARY KEY(idMunicipio),
	FOREIGN KEY(idEstado) REFERENCES estado(idEstado)
	);

CREATE TABLE municipioIndicador(
	idMunicipioIndicador	INT NOT NULL,
	fecha		        DATE,
	valor		        INT NOT NULL,
	idMunicipio		INT NOT NULL,
	idIndicador       	INT NOT NULL,
	PRIMARY KEY(idMunicipioIndicador),
	FOREIGN KEY(idMunicipio) REFERENCES municipio(idMunicipio),
	FOREIGN KEY(idIndicador) REFERENCES indicador(idIndicador)
	);
		
INSERT INTO estado (idEstado, nombre, poblacion) VALUES
(1, 'Aguascalientes', 1425607),
(2, 'Baja California', 3769020),
(3, 'Chihuahua', 3741869);

INSERT INTO indicador (idIndicador, nombre, descripción) VALUES
(1, 'casos', 'Número total de casos confirmados'),
(2, 'fallecidos', 'Número de personas fallecidas'),
(3, 'letalidad', 'Porcentaje de letalidad del Covid19');

INSERT INTO municipio (idMunicipio, nombre, poblacion, idEstado) VALUES
-- Aguascalientes (idEstado: 1)
(1, 'Aguascalientes', 877190, 1),
(2, 'Jesús María', 120405, 1),
(3, 'Calvillo', 56748, 1),

-- Baja California (idEstado: 2)
(4, 'Tijuana', 1991561, 2),
(5, 'Mexicali', 1104608, 2),
(6, 'Ensenada', 557431, 2),

-- Chihuahua (idEstado: 3)
(7, 'Juárez', 1501558, 3),
(8, 'Chihuahua', 948934, 3),
(9, 'Delicias', 150506, 3);


INSERT INTO municipioindicador(idMunicipioindicador, fecha, valor, idMunicipio, idIndicador) VALUES
(1, '2020-01-12', 10, 1, 1),
(2, '2020-01-13', 12, 1, 2),
(3, '2020-01-14', 09, 1, 3),

(4, '2020-01-15', 10, 2, 1),
(5, '2020-01-16', 12, 2, 2),
(6, '2020-01-17', 09, 2, 3),

(7, '2020-01-12', 10, 3, 1),
(8, '2020-01-13', 12, 3, 2),
(9, '2020-01-14', 09, 3, 3),

(10, '2020-01-15', 10, 4, 1),
(11, '2020-01-16', 12, 4, 2),
(12, '2020-01-17', 09, 4, 3),

(13, '2020-01-12', 10, 5, 1),
(14, '2020-01-13', 12, 5, 2),
(15, '2020-01-14', 09, 5, 3),

(16, '2020-01-15', 10, 6, 1),
(17, '2020-01-16', 12, 6, 2),
(18, '2020-01-17', 09, 6, 3),

(19, '2020-01-12', 10, 7, 1),
(20, '2020-01-13', 12, 7, 2),
(21, '2020-01-14', 09, 7, 3),

(22, '2020-01-15', 10, 8, 1),
(23, '2020-01-16', 12, 8, 2),
(24, '2020-01-17', 09, 8, 3),

(25, '2020-01-15', 10, 9, 1),
(26, '2020-01-16', 12, 9, 2),
(27, '2020-01-17', 09, 9, 3);
