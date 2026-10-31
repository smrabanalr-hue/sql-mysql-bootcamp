SET NAMES utf8mb4;
SET CHARACTER SET utf8mb4;

-- ==============================================================================
-- DATASET: Tienda Retail (E-commerce / Retail Analytics)
-- Motor: MySQL 8.0+ | Charset: utf8mb4 | Collation: utf8mb4_unicode_ci
-- ==============================================================================

DROP DATABASE IF EXISTS tienda_retail;
CREATE DATABASE tienda_retail CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE tienda_retail;

-- 1. Tabla Categorias
CREATE TABLE categorias (
    categoria_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL UNIQUE,
    descripcion TEXT,
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 2. Tabla Clientes
CREATE TABLE clientes (
    cliente_id INT AUTO_INCREMENT PRIMARY KEY,
    nombre VARCHAR(100) NOT NULL,
    apellido VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    telefono VARCHAR(30),
    ciudad VARCHAR(100) NOT NULL,
    pais VARCHAR(60) NOT NULL DEFAULT 'Perú',
    fecha_registro DATE NOT NULL,
    segmento ENUM('Básico', 'Premium', 'Corporativo') DEFAULT 'Básico',
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB;

-- 3. Tabla Productos
CREATE TABLE productos (
    producto_id INT AUTO_INCREMENT PRIMARY KEY,
    sku VARCHAR(50) NOT NULL UNIQUE,
    nombre VARCHAR(150) NOT NULL,
    categoria_id INT NOT NULL,
    precio DECIMAL(10,2) NOT NULL CHECK (precio >= 0),
    costo DECIMAL(10,2) NOT NULL CHECK (costo >= 0),
    stock_actual INT NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    activo BOOLEAN DEFAULT TRUE,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_productos_categorias FOREIGN KEY (categoria_id) 
        REFERENCES categorias(categoria_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 4. Tabla Pedidos
CREATE TABLE pedidos (
    pedido_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_pedido VARCHAR(30) NOT NULL UNIQUE,
    cliente_id INT NOT NULL,
    fecha_pedido DATETIME NOT NULL,
    estado ENUM('Pendiente', 'Procesando', 'Enviado', 'Entregado', 'Cancelado') DEFAULT 'Pendiente',
    canal_venta ENUM('Web', 'App Móvil', 'Tienda Física') DEFAULT 'Web',
    total_bruto DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    descuento DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    total_neto DECIMAL(12,2) NOT NULL DEFAULT 0.00,
    creado_en TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_pedidos_clientes FOREIGN KEY (cliente_id)
        REFERENCES clientes(cliente_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- 5. Tabla Detalle Pedidos
CREATE TABLE detalle_pedidos (
    detalle_id INT AUTO_INCREMENT PRIMARY KEY,
    pedido_id INT NOT NULL,
    producto_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    precio_unitario DECIMAL(10,2) NOT NULL CHECK (precio_unitario >= 0),
    subtotal DECIMAL(12,2) NOT NULL CHECK (subtotal >= 0),
    CONSTRAINT fk_detalle_pedidos FOREIGN KEY (pedido_id)
        REFERENCES pedidos(pedido_id) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_detalle_productos FOREIGN KEY (producto_id)
        REFERENCES productos(producto_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Índices estratégicos
CREATE INDEX idx_pedidos_fecha ON pedidos(fecha_pedido);
CREATE INDEX idx_pedidos_cliente ON pedidos(cliente_id);
CREATE INDEX idx_productos_categoria ON productos(categoria_id);
