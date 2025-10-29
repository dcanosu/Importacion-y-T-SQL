-- Daniel Cano Suarez
USE DivisionPolitica
GO

-- Creamos la tabla Moneda
CREATE TABLE Moneda (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Moneda VARCHAR(50),
    Sigla VARCHAR(10),
    Imagen VARCHAR(255)
);

-- Copiamos la información que tiene la tabla Pais/Moneda a la tabla Moneda
INSERT INTO Moneda (Moneda)
SELECT DISTINCT Moneda
FROM Pais
WHERE Moneda IS NOT NULL;

-- Insertamos el nuevo campo IdMoneda a la tabla Pais
ALTER TABLE Pais
ADD IdMoneda INT;

-- Actualizar los datos de la tabla Pais/IdMoneda desde la tabla Moneda/Id
UPDATE P
SET P.IdMoneda = M.Id
FROM Pais AS P
INNER JOIN Moneda AS M ON P.Moneda = M.Moneda
WHERE P.IdMoneda IS NULL;

-- Para integridad de datos, ponemos IdMoneda Not Null antes de crear la llave foranea
ALTER TABLE Pais
ALTER COLUMN IdMoneda INT NOT NULL;

-- Agregar restricción de clave foranea
ALTER TABLE Pais
ADD CONSTRAINT FK_Pais_Moneda
FOREIGN KEY (IdMoneda) REFERENCES Moneda(Id);

-- Ahora que tenemos los datos, podemos eliminar el campo Moneda de la tabla Pais
ALTER TABLE Pais
DROP COLUMN Moneda;

-- Finalmente, agregamos las columnas Mapa y Bandera a Pais
ALTER TABLE Pais
ADD Mapa VARCHAR(255);

ALTER TABLE Pais
ADD Bandera VARCHAR(255);

-- Validamos los datos
SELECT * FROM Pais p 
GO

SELECT * FROM Moneda m
GO

SELECT p.Nombre, p.IdMoneda, m.Id, m.Moneda
FROM Pais p 
JOIN Moneda M ON p.IdMoneda=M.Id