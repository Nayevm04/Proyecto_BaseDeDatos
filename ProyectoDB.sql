--------- INTEGRANTES ---------- 
-- NAYELY VEGA MURILLO 
-- SEBASTIAN CHAVES ESQUIVEL
-- FIORELLA LAZO REYES
--------------------------------

CREATE DATABASE ProyectoDB
SET LANGUAGE Spanish
USE ProyectoDB


-------------------------- CREACIÓN DE TABLAS --------------------------

-- Tabla Sucursal
CREATE TABLE Sucursal (
    ID_Sucursal INT CONSTRAINT PK_ID_Sucursal PRIMARY KEY,
    Nombre VARCHAR(50),
    Direccion VARCHAR(150)
);

-- Tabla CategoriaProducto
CREATE TABLE CategoriaProducto (
    ID_Categoria INT CONSTRAINT PK_ID_Categoria PRIMARY KEY,
    Nombre VARCHAR(30) CONSTRAINT UK_Nombre_CategoriaProducto UNIQUE,
    Descripcion TEXT
);

-- Tabla Proveedor
CREATE TABLE Proveedor (
    ID_Proveedor INT CONSTRAINT PK_ID_Proveedor PRIMARY KEY,
    Nombre VARCHAR(50),
    Direccion VARCHAR(150),
    Telefono VARCHAR(15),
    CONSTRAINT CK_Telefono_Proveedor CHECK (LEN(Telefono) <= 15)
);

-- Tabla Departamento
CREATE TABLE Departamento (
    ID_Departamento INT CONSTRAINT PK_ID_Departamento PRIMARY KEY,
    Nombre VARCHAR(50) CONSTRAINT UK_Nombre_Departamento UNIQUE,
    Descripcion TEXT,
    ID_Sucursal INT,
    CONSTRAINT FK_ID_Sucursal_Departamento FOREIGN KEY (ID_Sucursal) REFERENCES Sucursal(ID_Sucursal)
);

-- Tabla Cliente
CREATE TABLE Cliente (
    ID_Cliente INT CONSTRAINT PK_ID_Cliente PRIMARY KEY,
    Nombre VARCHAR(30),
    Apellido1 VARCHAR(30),
    Apellido2 VARCHAR(30),
    CorreoElectronico VARCHAR(50) CONSTRAINT UK_CorreoElectronico_Cliente UNIQUE,
    Telefono VARCHAR(15),
    Direccion VARCHAR(150),
    ID_Sucursal INT,
    CONSTRAINT FK_ID_Sucursal_Cliente FOREIGN KEY (ID_Sucursal) REFERENCES Sucursal(ID_Sucursal),
    CONSTRAINT CK_Telefono_Cliente CHECK (LEN(Telefono) <= 15)
);

-- Tabla Producto
CREATE TABLE Producto (
    ID_Producto INT CONSTRAINT PK_ID_Producto PRIMARY KEY,
    Nombre VARCHAR(50),
    Descripcion TEXT,
    Precio DECIMAL(10, 3),
    Existencias INT,
    ID_Categoria INT,
    ID_Proveedor INT,
    CONSTRAINT FK_ID_Categoria_Producto FOREIGN KEY (ID_Categoria) REFERENCES CategoriaProducto(ID_Categoria),
    CONSTRAINT FK_ID_Proveedor_Producto FOREIGN KEY (ID_Proveedor) REFERENCES Proveedor(ID_Proveedor)
);

-- Tabla Empleado
CREATE TABLE Empleado (
    ID_Empleado INT CONSTRAINT PK_ID_Empleado PRIMARY KEY,
    Nombre VARCHAR(30),
    Apellido1 VARCHAR(30),
    Apellido2 VARCHAR(30),
    Cargo VARCHAR(30),
    Salario DECIMAL(10, 3),
    ID_Departamento INT,
    CONSTRAINT FK_ID_Departamento_Empleado FOREIGN KEY (ID_Departamento) REFERENCES Departamento(ID_Departamento)
);

-- Tabla Pedido
CREATE TABLE Pedido (
    ID_Pedido INT CONSTRAINT PK_ID_Pedido PRIMARY KEY,
    Fecha_Pedido DATE,
    Estado VARCHAR(15),
    ID_Cliente INT,
    CONSTRAINT FK_ID_Cliente_Pedido FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabla Envio
CREATE TABLE Envio (
    ID_Envio INT CONSTRAINT PK_ID_Envio PRIMARY KEY,
    Fecha_Envio DATE,
    Estado VARCHAR(30),
    ID_Pedido INT,
    CONSTRAINT FK_ID_Pedido_Envio FOREIGN KEY (ID_Pedido) REFERENCES Pedido(ID_Pedido)
);

-- Tabla Pago
CREATE TABLE Pago (
    ID_Pago INT CONSTRAINT PK_ID_Pago PRIMARY KEY,
    MetodoPago VARCHAR(30),
    Monto DECIMAL(10, 3),
    Fecha_Pago DATE,
    ID_Cliente INT,
    ID_Producto INT,
    Telefono VARCHAR(15),
    CONSTRAINT FK_ID_Cliente_Pago FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente),
    CONSTRAINT FK_ID_Producto_Pago FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    CONSTRAINT CK_Telefono_Pago CHECK (LEN(Telefono) <= 15)
);


-- Tabla Comentario
CREATE TABLE Comentario (
    ID_Comentario INT CONSTRAINT PK_ID_Comentario PRIMARY KEY,
    Texto TEXT,
    ID_Producto INT,
    ID_Cliente INT,
    CONSTRAINT FK_ID_Producto_Comentario FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    CONSTRAINT FK_ID_Cliente_Comentario FOREIGN KEY (ID_Cliente) REFERENCES Cliente(ID_Cliente)
);

-- Tabla Promocion
CREATE TABLE Promocion (
    ID_Promocion INT CONSTRAINT PK_ID_Promocion PRIMARY KEY,
    CodigoPromocion VARCHAR(15) CONSTRAINT UK_CodigoPromocion_Promocion UNIQUE,
    FechaInicio DATE,
    FechaFin DATE,
    ID_Producto INT,
    CONSTRAINT FK_ID_Producto_Promocion FOREIGN KEY (ID_Producto) REFERENCES Producto(ID_Producto),
    CONSTRAINT CK_Fecha_Promocion CHECK (FechaFin > FechaInicio)
);



-------------------------- INSERCIONES DE TABLAS --------------------------

-- Inserts correspondientes a la tabla Sucursal
INSERT INTO Sucursal (ID_Sucursal, Nombre, Direccion)
VALUES 
    (1, 'Sucursal Ciudad Quesada', 'Ciudad Quesada, 150 este de la Catedral, Provincia de Alajuela'),
    (2, 'Sucursal Aguas Zarcas', ' 350 oeste de la Iglesia Católica, Provincia de Alajuela'),
    (3, 'Sucursal Santa Rosa de Pocosol', 'Santa Rosa, Pocosol, frente Servicentro Santa Rosa, Provincia de Alajuela'),
    (4, 'Sucursal Fortuna', 'La Fortuna, 200 este de la Iglesia Católica, Provincia de Alajuela'),
    (5, 'Sucursal Pital', 'Pital Centro, Frente a la terminal de buses de Pital.');

-- Inserts correspondientes a la tabla CategoriaProducto
INSERT INTO CategoriaProducto (ID_Categoria, Nombre, Descripcion)
VALUES 
    (1, 'Electrónica', 'Productos electrónicos en general'),
    (2, 'Electrodomésticos', 'Electrodomésticos para el hogar'),
    (3, 'Accesorios', 'Accesorios para dispositivos electrónicos'),
    (4, 'Computadoras', 'Computadoras de escritorio y portátiles'),
    (5, 'Televisores', 'Televisores de diferentes tamaños y marcas'),
    (6, 'Audio', 'Equipos de sonido y accesorios para música'),
    (7, 'Cámaras', 'Cámaras fotográficas y de video');

-- Inserts correspondientes a la tabla Proveedor
INSERT INTO Proveedor (ID_Proveedor, Nombre, Direccion, Telefono)
VALUES 
    (1, 'ElectroTech', 'Avenida Escazú, San José Costa Rica', '+506 1234-5678'),
    (2, 'ElectroWorld', 'Avenida 1, Calle 2, San José Costa Rica', '+506 9876-5432'),
    (3, 'ElectroPlus', 'Frente a la estacion Gasolinera de El Pavón, Los Chiles, Costa Rica', '+506 4567-8901'),
    (4, 'ElectroMax', 'Frente a McDonald´s, Alajuela, Costa Rica', '+506 3216-5498'),
    (5, 'ElectroGoods', 'Calle 3, Av. 5, Heredia Centro, Costa Rica','+506 8596-1423'),
    (6, 'ElectroSupplies', 'Avigiras E13-140 y Guayacanes Urb, Ecuador', '+593 628 0432'),
    (7, 'ElectroCenter', 'Miami 179 Northwest 25th Street Miami, FL 33127', '+1 3232-3223');

-- Inserts correspondientes a la tabla Departamento
INSERT INTO Departamento (ID_Departamento, Nombre, Descripcion, ID_Sucursal)
VALUES 
    (1, 'Departamento de Ventas', 'Encargado de las ventas', 1),
    (2, 'Departamento de Finanzas', 'Manejo de las finanzas', 1),
    (3, 'Departamento de Recursos Humanos', 'Gestión de personal', 1),
    (4, 'Departamento de Almacén', 'Control del almacén', 1),
    (5, 'Departamento de Marketing', 'Encargado del marketing', 1);

-- Inserts correspondientes a la tabla Cliente
INSERT INTO Cliente (ID_Cliente, Nombre, Apellido1, Apellido2, CorreoElectronico, Telefono, Direccion, ID_Sucursal)
VALUES 
    (1, 'Juan', 'Perez', 'Gutierrez', 'juan@gmail.com', '+506 1234-5678', 'Calle 5, San José, Costa Rica', 1),
    (2, 'María', 'González', 'Castro', 'maria@gmail.com', '+506 9876-5432', 'Avenida 10, Heredia, Costa Rica', 1),
    (3, 'Carlos', 'Rodríguez', 'Morales', 'carlos@gmail.com', '+506 4567-8901', 'Calle 3, Cartago, Costa Rica', 2),
    (4, 'Ana', 'López', 'Soto', 'ana@gmail.com', '+506 3216-5498', 'Avenida 7, Alajuela, Costa Rica', 2),
    (5, 'Pedro', 'Martínez', 'Vargas', 'pedro@gmail.com', '+506 6543-8732', 'Calle 2, Limón, Costa Rica', 3),
    (6, 'Laura', 'Sánchez', 'Chavarría', 'laura@gmail.com', '+506 7890-1234', 'Calle 8, Puntarenas, Costa Rica', 3),
    (7, 'Sofía', 'Hernández', 'Fernández', 'sofia@gmail.com', '+506 1592-6348', 'Avenida 6, Guanacaste, Costa Rica', 4),
    (8, 'Alejandro', 'Ramírez', 'Brenes', 'alejandro@gmail.com', '+506 1234-5678', 'Calle 9, San José, Costa Rica', 4),
    (9, 'Isabella', 'Fernández', 'Alvarado', 'isabella@gmail.com', '+506 9876-5432', 'Avenida 12, Heredia, Costa Rica', 5),
    (10, 'Diego', 'Soto', 'Campos', 'diego@gmail.com', '+506 4567-8901', 'Calle 4, Cartago, Costa Rica', 5);

-- Inserts correspondientes a la tabla Producto
INSERT INTO Producto (ID_Producto, Nombre, Descripcion, Precio, Existencias, ID_Categoria, ID_Proveedor)
VALUES 
    (1, 'Smartphone', 'Teléfono inteligente con pantalla táctil', 340.000, 100, 1, 1),
    (2, 'Portátil', 'Computadora portátil con procesador i5', 210.000, 50, 4, 2),
    (3, 'Televisor LED', 'Televisor LED de 55 pulgadas', 245.000, 30, 5, 3),
    (4, 'Auriculares Bluetooth', 'Auriculares inalámbricos con cancelación de ruido', 45.000, 80, 3, 4),
    (5, 'Cámara DSLR', 'Cámara réflex digital con lente intercambiable', 120.000, 20, 7, 5),
    (6, 'Licuadora', 'Licuadora de alta potencia con múltiples velocidades', 51.200, 50, 2, 6),
    (7, 'Tablet', 'Tablet Android de 10 pulgadas', 100.000, 60, 1, 1);

-- Inserts correspondientes a la tabla Empleado
INSERT INTO Empleado (ID_Empleado, Nombre, Apellido1, Apellido2, Cargo, Salario, ID_Departamento)
VALUES 
    (1, 'Luis', 'Hernández', 'Campos', 'Gerente de Tienda', 210.000, 1),
    (2, 'Ana', 'Soto', 'Chavarría', 'Contadora', 320.000, 2),
    (3, 'Jorge', 'Martínez', 'Fernández', 'Jefe de Recursos Humanos', 300.000, 3),
    (4, 'María', 'López', 'González', 'Supervisor de Almacén', 225.000, 4),
    (5, 'Pedro', 'Rodríguez', 'Morales', 'Especialista en Marketing', 210.000, 5);

-- Inserts correspondientes a la tabla Pedido
INSERT INTO Pedido (ID_Pedido, Fecha_Pedido, Estado, ID_Cliente)
VALUES 
    (1, '2024-04-23', 'Pendiente', 1),
    (2, '2024-04-23', 'Entregado', 2),
    (3, '2024-04-24', 'Cancelado', 3),
    (4, '2024-04-24', 'Entregado', 4),
    (5, '2024-04-25', 'Entregado', 5),
    (6, '2024-04-25', 'Cancelado', 6),
	(7, '2024-02-05', 'Entregado', 6);

-- Inserts correspondientes a la tabla Envio
INSERT INTO Envio (ID_Envio, Fecha_Envio, Estado, ID_Pedido)
VALUES 
    (1, '2024-04-23', 'En Tránsito', 1),
    (2, '2024-04-23', 'Entregado', 2),
    (3, '2024-04-24', 'Devuelto', 3),
    (4, '2024-04-24', 'Entregado', 4),
    (5, '2024-04-25', 'Entregado', 5),
    (6, '2024-04-25', 'Devuelto', 6),
	(7, '2024-02-06', 'Entregado', 6);

-- Inserts correspondientes a la tabla Pago
INSERT INTO Pago (ID_Pago, MetodoPago, Monto, Fecha_Pago, ID_Cliente, ID_Producto, Telefono)
VALUES 
    (1, 'Tarjeta de Crédito', 340.000, '2024-04-23', 1, 1, '+506 1234-5678'),
    (2, 'Transferencia Bancaria', 210.000, '2024-04-23', 2, 2, '+506 9876-5432'),
    (3, 'PayPal', 245.000, '2024-04-24', 3, 3, '+506 4567-8901'),
    (4, 'Tarjeta de Débito', 45.000, '2024-04-24', 4, 4, '+506 3216-5498'),
    (5, 'Efectivo', 120.000, '2024-04-25', 5, 5, '+506 6543-8732'),
    (6, 'Transferencia Bancaria', 51.200, '2024-04-25', 6, 6, '+506 7890-1234'),
    (7, 'Efectivo', 100.000, '2024-04-25', 6, 7, '+506 7890-1234');


-- Inserts correspondientes a la tabla Comentario
INSERT INTO Comentario (ID_Comentario, Texto, ID_Producto, ID_Cliente)
VALUES 
    (1, 'El pedido está actualmente en proceso de envío.', 1, 1),
    (2, 'El pedido ha sido entregado satisfactoriamente.', 2, 2),
    (3, 'El pedido fue rechazado y se está gestionando una solución.', 3, 3),
    (4, 'El pedido ha sido entregado satisfactoriamente.', 4, 4),
    (5, 'El pedido ha sido entregado satisfactoriamente.', 5, 5),
    (6, 'El pedido fue rechazado y se está gestionando una solución.', 6, 6),
	(7, 'El pedido ha sido entregado satisfactoriamente.', 5, 6);


INSERT INTO Promocion (ID_Promocion, CodigoPromocion, FechaInicio, FechaFin, ID_Producto)
VALUES 
    (1, 'DESC10', '2024-04-22', '2024-04-30', 1),
    (2, 'OFERTA20', '2024-04-22', '2024-05-15', 3),
    (3, 'SUPERVENTAS', '2024-04-23', '2024-05-10', 5),
    (4, 'DESC15', '2024-04-22', '2024-04-30', 2),
    (5, 'OFERTA25', '2024-04-22', '2024-05-15', 4),
    (6, 'SUPERDESC', '2024-04-23', '2024-05-10', 6);

SELECT * FROM Sucursal;
SELECT * FROM CategoriaProducto;
SELECT * FROM Proveedor;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Empleado;
SELECT * FROM Pedido;
SELECT * FROM Envio;
SELECT * FROM Pago;
SELECT * FROM Comentario;
SELECT * FROM Promocion;

-------------------------- CONSULTAS --------------------------

-- Consulta 1: Obtener el nombre, dirección y estado de los pedidos entregados realizados por los clientes.
SELECT c.Nombre, c.Direccion, p.Estado AS EstadoPedido
FROM Cliente c
INNER JOIN Pedido p ON c.ID_Cliente = p.ID_Cliente
INNER JOIN Envio e ON p.ID_Pedido = e.ID_Pedido
WHERE p.Estado = 'Entregado';


-- Consulta 2: Obtener el nombre, salario, sucursal y departamento de los empleados que trabajan en el Departamento de Ventas.
SELECT e.Nombre, e.Salario, s.Nombre AS NombreSucursal, d.Nombre AS NombreDepartamento
FROM Empleado e
INNER JOIN Departamento d ON e.ID_Departamento = d.ID_Departamento
INNER JOIN Sucursal s ON d.ID_Sucursal = s.ID_Sucursal
WHERE d.Nombre = 'Departamento de Ventas';


-- Consulta 3: Obtener el nombre, la cantidad disponible, la descripción y el nombre de la categoría de los productos de la categoría 'Electrónica'.
SELECT p.Nombre, p.Existencias, p.Descripcion, cp.Nombre AS Categoria
FROM Producto p
INNER JOIN CategoriaProducto cp ON p.ID_Categoria = cp.ID_Categoria
WHERE cp.Nombre = 'Electrónica';

-- Consulta 4: Obtener el nombre, apellidos, método de pago y monto de los clientes que han realizado pagos con Efectivo.
SELECT c.Nombre, c.Apellido1, c.Apellido2, pa.MetodoPago, pa.Monto
FROM Cliente c
INNER JOIN Pago pa ON c.ID_Cliente = pa.ID_Cliente
WHERE pa.MetodoPago = 'Efectivo';

-- Consulta 5: Obtener el nombre, la fecha de inicio y la fecha final de todas las promociones.
SELECT pr.CodigoPromocion AS Nombre_Promocion, pr.FechaInicio, pr.FechaFin
FROM Promocion pr;


-- Consulta 6: Obtener el nombre, el estado y la fecha de entrega de los pedidos realizados por clientes que tienen al menos un comentario asociado.
SELECT c.Nombre, p.Estado, e.Fecha_Envio
FROM Cliente c
INNER JOIN Pedido p ON c.ID_Cliente = p.ID_Cliente
INNER JOIN Envio e ON p.ID_Pedido = e.ID_Pedido
WHERE c.ID_Cliente IN (SELECT DISTINCT ID_Cliente FROM Comentario);

-- Consulta 7: Obtener el nombre, el total gastado y el número de pagos realizados por cada cliente.
SELECT c.Nombre, SUM(pa.Monto) AS TotalGastado, COUNT(*) AS NumeroPagos
FROM Cliente c
INNER JOIN Pago pa ON c.ID_Cliente = pa.ID_Cliente
GROUP BY c.Nombre;

-- Consulta 5: Obtener el nombre, la descripción y la fecha de inicio y final de las promociones asociadas a los productos.
SELECT p.Nombre AS NombreProducto, p.Descripcion AS DescripcionProducto, pr.FechaInicio, pr.FechaFin
FROM Producto p
INNER JOIN Promocion pr ON p.ID_Producto = pr.ID_Producto;

-- Consulta 9: Obtener el nombre, apellidos y método de pago de los clientes que han realizado pagos por transferencia bancaria o PayPal, ordenados de manera descendente por el nombre del cliente.
SELECT c.Nombre, c.Apellido1, c.Apellido2, pa.MetodoPago
FROM Cliente c
INNER JOIN Pago pa ON c.ID_Cliente = pa.ID_Cliente
WHERE pa.MetodoPago IN ('Transferencia Bancaria', 'PayPal')
ORDER BY c.Nombre DESC;



-- Consulta 10: Obtener el nombre, el salario máximo y el departamento al que pertenece cada empleado.
SELECT e.Nombre, MAX(e.Salario) AS Salario_Maximo, d.Nombre AS Departamento
FROM Empleado e
INNER JOIN Departamento d ON e.ID_Departamento = d.ID_Departamento
GROUP BY e.Nombre, d.Nombre;

-- Consulta 11: Obtener el nombre, la cantidad de productos entregados en cada pedido y la fecha de entrega.
SELECT p.Nombre, COUNT(*) AS Cantidad_Entregada, e.Fecha_Envio
FROM Pedido pe
INNER JOIN Envio e ON pe.ID_Pedido = e.ID_Pedido
INNER JOIN Producto p ON pe.ID_Pedido = p.ID_Producto
WHERE pe.Estado = 'Entregado'
GROUP BY p.Nombre, e.Fecha_Envio;

-- Consulta 12: Obtener el nombre, el total gastado y la fecha de pago de los clientes en pagos realizados después del 2024-04-15.
SELECT c.Nombre, SUM(pa.Monto) AS TotalGastado, pa.Fecha_Pago
FROM Cliente c
INNER JOIN Pago pa ON c.ID_Cliente = pa.ID_Cliente
WHERE pa.Fecha_Pago > '2024-04-15'
GROUP BY c.Nombre, pa.Fecha_Pago;

-- Consulta: Obtener el nombre y apellidos de todos los clientes en orden descendente.
SELECT CONCAT(Nombre, ' ', Apellido1, ' ', Apellido2) AS Nombre_Completo
FROM Cliente
ORDER BY Nombre_Completo ASC;

-- Consulta 14: Obtener el nombre y el total de comentarios asociados a cada producto, y la descripción del producto.
SELECT p.Nombre, COUNT(c.ID_Comentario) AS TotalComentarios, p.Descripcion
FROM Producto p
LEFT JOIN Comentario c ON p.ID_Producto = c.ID_Producto
GROUP BY p.Nombre, p.Descripcion;

-- Consulta 15: Obtener el nombre del departamento, el salario promedio y la descripción de cada departamento.
SELECT d.Nombre, AVG(e.Salario) AS SalarioPromedio, d.Descripcion
FROM Departamento d
INNER JOIN Empleado e ON d.ID_Departamento = e.ID_Departamento
GROUP BY d.Nombre, d.Descripcion;

-- Consulta 16: Obtener el nombre del proveedor, la cantidad total de productos en existencia y la dirección de cada proveedor.
SELECT pr.Nombre, SUM(p.Existencias) AS TotalExistencias, pr.Direccion
FROM Proveedor pr
INNER JOIN Producto p ON pr.ID_Proveedor = p.ID_Proveedor
GROUP BY pr.Nombre, pr.Direccion;

-- Consulta 17: Obtener el nombre, el total gastado y la fecha de pago de los clientes en pagos realizados con tarjeta de crédito después del 2024-04-15.
SELECT c.Nombre, SUM(pa.Monto) AS Total_Gastado, pa.Fecha_Pago
FROM Cliente c
INNER JOIN Pago pa ON c.ID_Cliente = pa.ID_Cliente
WHERE pa.Fecha_Pago > '2024-04-15' AND pa.MetodoPago = 'Tarjeta de Crédito'
GROUP BY c.Nombre, pa.Fecha_Pago;

-- Consulta 18: Obtener el nombre completo de los clientes, el nombre del producto, la categoría del producto y el estado del pedido para aquellos pedidos que hayan sido cancelados.
SELECT CONCAT(c.Nombre, ' ', c.Apellido1, ' ', c.Apellido2) AS Nombre_Completo, p.Nombre AS Nombre_Producto, cp.Nombre AS Categoria, pe.Estado AS Estado_Pedido
FROM Cliente c
INNER JOIN Pedido pe ON c.ID_Cliente = pe.ID_Cliente
INNER JOIN Envio e ON pe.ID_Pedido = e.ID_Pedido
INNER JOIN Producto p ON pe.ID_Pedido = p.ID_Producto
INNER JOIN CategoriaProducto cp ON p.ID_Categoria = cp.ID_Categoria
WHERE pe.Estado = 'Cancelado';

-------------------------- MODIFICACIONES DE TABLAS --------------------------

-- Modificar el nombre de la Sucursal con ID_Sucursal = 1
UPDATE Sucursal
SET Nombre = 'Sucursal Ciudad Quesada #2'
WHERE ID_Sucursal = 1;

-- Modificar el cargo del Empleado con ID_Empleado = 1
UPDATE Empleado
SET Cargo = 'Gerente de Operaciones'
WHERE ID_Empleado = 1;

-- Modificar el estado del Pedido con ID_Pedido = 3
UPDATE Pedido
SET Estado = 'En proceso'
WHERE ID_Pedido = 3;

-- Modificar el método de pago del Pago con ID_Pago = 2
UPDATE Pago
SET MetodoPago = 'Tarjeta de Débito'
WHERE ID_Pago = 2;

-- Modificar el texto del Comentario con ID_Comentario = 5
UPDATE Comentario
SET Texto = 'El pedido fue entregado con retraso.'
WHERE ID_Comentario = 5;

-- Modificar la fecha de inicio de la Promoción con ID_Promocion = 3
UPDATE Promocion
SET FechaInicio = '2024-04-24'
WHERE ID_Promocion = 3;

-- Modificar la dirección del Proveedor con ID_Proveedor = 1
UPDATE Proveedor
SET Direccion = 'Detrás del Hospital México, San José Costa Rica'
WHERE ID_Proveedor = 1;

-- Modificar la cantidad de Existencias del Producto con ID_Producto = 6
UPDATE Producto
SET Existencias = 30
WHERE ID_Producto = 6;

-- Modificar el apellido del Cliente con ID_Cliente = 8
UPDATE Cliente
SET Apellido2 = 'López'
WHERE ID_Cliente = 8;

-- Modificar la fecha de inicio y fin de la Promoción con ID_Promocion = 3
UPDATE Promocion
SET FechaInicio = '2024-01-01',
    FechaFin = '2024-01-15'
WHERE ID_Promocion = 3;


SELECT * FROM Sucursal;
SELECT * FROM CategoriaProducto;
SELECT * FROM Proveedor;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Empleado;
SELECT * FROM Pedido;
SELECT * FROM Envio;
SELECT * FROM Pago;
SELECT * FROM Comentario;
SELECT * FROM Promocion;
-------------------------- ELIMINACIONES --------------------------

-- 1. Eliminar un registro de la tabla Cliente que no tenga asociado ningún pedido:
DELETE FROM Cliente
WHERE ID_Cliente NOT IN (SELECT ID_Cliente FROM Pedido);

-- 2. Eliminar los comentarios asociados al producto "Licuadora
DELETE FROM Comentario
WHERE ID_Producto = (SELECT ID_Producto FROM Producto WHERE Nombre = 'Licuadora');

-- 3. Eliminar la promoción del producto "Licuadora"
DELETE FROM Promocion
WHERE ID_Producto = (SELECT ID_Producto FROM Producto WHERE Nombre = 'Licuadora');

-- 4. Eliminar un registro de la tabla Proveedor que no tenga ningún producto asociado:
DELETE FROM Proveedor
WHERE ID_Proveedor NOT IN (SELECT ID_Proveedor FROM Producto);

-- 5. Eliminar los comentarios relacionados con el producto "Portátil"
DELETE FROM Comentario
WHERE ID_Producto = (
    SELECT ID_Producto
    FROM Producto
    WHERE Nombre = 'Portátil'
);

-- 5.1. Eliminar la promoción del producto "Portátil"
DELETE FROM Promocion
WHERE ID_Producto = (SELECT ID_Producto FROM Producto WHERE Nombre = 'Portátil');

-- 6. Eliminar un registro de la tabla Envio que esté asociado con ningún pedido entregado:
DELETE FROM Envio
WHERE ID_Pedido NOT IN (SELECT ID_Pedido FROM Pedido WHERE Estado = 'Entregado');

-- 7. Eliminar un registro de la tabla Comentario que esté asociado con un cliente específico:
DELETE FROM Comentario
WHERE ID_Comentario IN (
    SELECT TOP 1 ID_Comentario
    FROM Comentario
    WHERE ID_Cliente = (SELECT TOP 1 ID_Cliente FROM Cliente)
    ORDER BY ID_Comentario DESC
);


-- 8. Eliminar un registro de la tabla Promocion que posee X fecha
DELETE FROM Promocion
WHERE FechaInicio >= '2024-01-01' AND FechaFin <= '2024-01-15';

-- 9. Eliminar la Sucursal Fortuna
DELETE FROM Sucursal
WHERE ID_Sucursal = 4;


-- 10. Eliminar un registro de la tabla CategoriaProducto que no esté asociado con ningún producto:
DELETE FROM CategoriaProducto
WHERE ID_Categoria NOT IN (SELECT DISTINCT ID_Categoria FROM Producto);

SELECT * FROM Sucursal;
SELECT * FROM CategoriaProducto;
SELECT * FROM Proveedor;
SELECT * FROM Cliente;
SELECT * FROM Producto;
SELECT * FROM Empleado;
SELECT * FROM Pedido;
SELECT * FROM Envio;
SELECT * FROM Pago;
SELECT * FROM Comentario;
SELECT * FROM Promocion;