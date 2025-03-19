
DROP DATABASE IF EXISTS FitLife; 
CREATE DATABASE FitLife; 
USE FitLife;

-- Tabla Socio
CREATE TABLE Socio (
    Id_socio INT NOT NULL AUTO_INCREMENT,
    Dni_socio VARCHAR(25) NOT NULL,
    Nombre_socio VARCHAR(15) NOT NULL,
    Primer_apellido VARCHAR(15) NOT NULL,
    Segundo_apellido VARCHAR(15) NULL,
    Telefono_socio VARCHAR(12) NOT NULL,
    Email_socio VARCHAR(25) UNIQUE NOT NULL,
    Direccion_socio TEXT NOT NULL,
    Fecha_inscripcion DATE NOT NULL DEFAULT (CURDATE()),
    Fecha_inactivo DATE NULL,
    Estado ENUM ('Activo', 'No activo') DEFAULT 'Activo',
    PRIMARY KEY (Id_socio)
);

-- Tabla Plan_Pago
CREATE TABLE Plan_Pago (
    Id_PlanPago INT NOT NULL AUTO_INCREMENT,
    Id_socio INT,
    Plan_pago ENUM ('Plan basico', 'Plan Premium', 'Plan familiar') NOT NULL,
    PRIMARY KEY (Id_PlanPago),
    FOREIGN KEY (Id_socio) REFERENCES Socio (Id_socio) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla Pago
CREATE TABLE Pago (
    Id_Pago INT NOT NULL AUTO_INCREMENT,
    Id_socio INT,
    Monto_Pagado DECIMAL(10,2) NOT NULL,
    Fecha_de_pago DATE NOT NULL,
    Metodo_de_pago ENUM ('Efectivo', 'Tarjeta', 'Transferencia') NOT NULL,
    PRIMARY KEY (Id_Pago),
    FOREIGN KEY (Id_socio) REFERENCES Socio (Id_socio) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla Entrenador
CREATE TABLE Entrenador (
    Id_entrenador INT NOT NULL AUTO_INCREMENT,
    Nombre_entrenador VARCHAR(25) NOT NULL,
    Primer_apellido VARCHAR(25) NOT NULL,
    Segundo_apellido VARCHAR(25) NOT NULL,
    Especialidad ENUM ('Entrenador Sala', 'Entrenador Clase') NOT NULL,
    Salario_entrenador DECIMAL(10,2) NOT NULL DEFAULT 1500.00,
    Fecha_contratacion_entrenador DATE NOT NULL,
    Fecha_baja DATE NULL,
    PRIMARY KEY (Id_entrenador)
);

-- Tabla Clase
CREATE TABLE Clase (
    Id_Clase INT NOT NULL AUTO_INCREMENT,
    Id_entrenador INT,
    Nombre_Clase ENUM ('Spinning', 'Pilates', 'HIIT') NOT NULL,
    Dia_clase ENUM ('Martes', 'Sabado') NOT NULL,
    Hora_clase ENUM ('9.00', '10.00', '11.00', '16.00', '17.00', '18.00') NOT NULL,
    Cupo_Maximo INT NOT NULL DEFAULT 10,
    PRIMARY KEY (Id_Clase),
    FOREIGN KEY (Id_entrenador) REFERENCES Entrenador (Id_entrenador) ON DELETE CASCADE ON UPDATE CASCADE
);

-- Tabla SOCIO_CLASE
CREATE TABLE SOCIO_CLASE (
    Id_Clase INT NOT NULL,
    Id_socio INT NOT NULL,
    PRIMARY KEY (Id_Clase, Id_socio),
    FOREIGN KEY (Id_Clase) REFERENCES Clase (Id_Clase) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (Id_socio) REFERENCES Socio (Id_socio) ON DELETE CASCADE ON UPDATE CASCADE
);

-- INSERTS

INSERT INTO Socio (Dni_socio, Nombre_socio, Primer_apellido, Segundo_apellido, Telefono_socio, Email_socio, Direccion_socio)
VALUES
('54214459D', 'Cecilia', 'Molina', 'García', '652027353', 'hola@gmail.com', 'Calle 23, Madrid'),
('123456P', 'Manuel', 'Rodriguez', 'Sanchez', '661772887', 'Sanchez@gmail.com', 'Calle Rosas 23'),
('4356543G', 'Rosa', 'Lopez', 'Hernandez', '655776876', 'lopez@gmail.com', 'Calle Inventada');

INSERT INTO Pago (Id_socio, Monto_Pagado, Fecha_de_pago, Metodo_de_pago)
VALUES
(1, 10.20, '2005-02-12', 'Efectivo'),
(2, 100.20, '2023-02-12', 'Tarjeta'),
(3, 200.20, '2025-02-12', 'Transferencia');

INSERT INTO Entrenador (Nombre_entrenador, Primer_apellido, Segundo_apellido, Especialidad, Salario_entrenador, Fecha_contratacion_entrenador)
VALUES
('Montoro', 'Sanchez', 'García', 'Entrenador Sala', 1000.00, '2025-08-12'),
('Arturo', 'Lopez', 'Sanchez', 'Entrenador Clase', 1200.00, '2022-08-12'),
('Sofía', 'Sanchez', 'Petrova', 'Entrenador Sala', 2000.00, '2025-08-12');

INSERT INTO Clase (Id_entrenador, Nombre_Clase, Dia_clase, Hora_clase)
VALUES
(1, 'Spinning', 'Martes', '9.00'),
(2, 'Pilates', 'Sabado', '10.00'),
(3, 'HIIT', 'Martes', '11.00');

