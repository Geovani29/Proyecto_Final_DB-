CREATE DATABASE bakery;
USE bakery;

-- Tabla 'usuario'
CREATE TABLE users (
    id INT(11) NOT NULL AUTO_INCREMENT,
    username varchar(50) NOT NULL,
    password varchar(60) NOT NULL,
    id_persona INT,
    cart json,
    PRIMARY KEY (id),
    unique(username)
);
ALTER TABLE users ADD COLUMN roles ENUM('usuario', 'admin', 'domiciliario', 'cocinero') DEFAULT 'usuario';

ALTER TABLE users AUTO_INCREMENT = 1; 

CREATE TABLE cliente (
    id INT PRIMARY KEY,
    nombre VARCHAR(50),
    apellido VARCHAR(50),
    id_usuario INT,
    FOREIGN KEY (id_usuario) REFERENCES users(id)
);

-- Tabla 'direcciones'
CREATE TABLE direcciones (
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    direccionCliente VARCHAR(100),
    id_cliente INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);
ALTER TABLE direcciones AUTO_INCREMENT = 1; 
-- Tabla 'producto'
CREATE TABLE producto (
    id INT PRIMARY KEY,
    cantidad INT,
    urlimagen VARCHAR(255),
    confirmaciondedisponibilidad VARCHAR(10),
    nombre VARCHAR(100),
    descripcion TEXT,
    precio DECIMAL(10,2),
    categoria VARCHAR(50)
);

-- Tabla 'caja'
CREATE TABLE caja (
    id INT PRIMARY KEY,
    detalle_tarifa VARCHAR(100),
    pago_pedido DECIMAL(10,2)
);
-- Tabla 'cocina'
CREATE TABLE pedidos_cocina (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT NOT NULL,
    estado VARCHAR(50) DEFAULT 'pendiente',
    FOREIGN KEY (id_compra) REFERENCES compras(id)
);
ALTER TABLE pedidos_cocina AUTO_INCREMENT = 1;

-- Tabla 'compras'
CREATE TABLE compras (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_cliente INT,
    fecha_compra DATE,
    hora_compra TIME,
    total DECIMAL(10,2),
    FOREIGN KEY (id_cliente) REFERENCES cliente(id)
);

-- Tabla 'detalle_compra'
CREATE TABLE detalle_compra (
    id INT PRIMARY KEY AUTO_INCREMENT,
    id_compra INT,
    id_producto INT,
    cantidad INT,
    precio_unitario DECIMAL(10,2),
    FOREIGN KEY (id_compra) REFERENCES compras(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

CREATE TABLE empleados (
    nombre_completo VARCHAR(250) NOT NULL,
    numero_identificacion VARCHAR(50) PRIMARY KEY,
    telefono VARCHAR(20) NOT NULL,
    roles VARCHAR(50) NOT NULL,
    username VARCHAR(255),
    FOREIGN KEY (username) REFERENCES users(username)
);

-- Tabla 'domiciliario'
CREATE TABLE domiciliario (
    id INT PRIMARY KEY AUTO_INCREMENT,
    numero_identificacion varchar(50),
    medio_transporte VARCHAR(50),
    horario_disponible DATETIME default CURRENT_TIMESTAMP,
    licencia_conduccion INT,
    fecha_fin_licencia DATE,
    estado VARCHAR(2) default 'Si',
    FOREIGN KEY (numero_identificacion) REFERENCES empleados(numero_identificacion)
);


-- Tabla 'decide_recoger_producto'
CREATE TABLE decide_recoger_producto (
    id INT PRIMARY KEY,
    direccion_tienda_unica VARCHAR(100),
    id_cliente INT,
    fecha_asignada_recoger DATE,
    hora_asignada_recoger TIME,
    id_producto INT,
    FOREIGN KEY (id_cliente) REFERENCES cliente(id),
    FOREIGN KEY (id_producto) REFERENCES producto(id)
);

CREATE TABLE domicilios (
    id int PRIMARY KEY AUTO_INCREMENT,
    id_compra int,
    id_domiciliario int,
    fecha_envio DATE,
    hora_envio TIME,
    fecha_entrega DATE,
    hora_entrega TIME,
    FOREIGN KEY (id_compra) REFERENCES compras(id),
    FOREIGN KEY (id_domiciliario) REFERENCES domiciliario(id)
);
ALTER TABLE domicilios  AUTO_INCREMENT = 1;

