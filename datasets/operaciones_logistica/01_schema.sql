-- ==============================================================================
-- DATASET: Operaciones y Logística (Gestión de Almacenes y Kardex)
-- Motor: MySQL 8.0+ | Charset: utf8mb4 | Collation: utf8mb4_unicode_ci
-- ==============================================================================

DROP DATABASE IF EXISTS operaciones_logistica;
CREATE DATABASE operaciones_logistica CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE operaciones_logistica;

-- 1. Almacenes
CREATE TABLE almacenes (
    almacen_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo VARCHAR(20) NOT NULL UNIQUE,
    nombre VARCHAR(100) NOT NULL,
    ciudad VARCHAR(100) NOT NULL,
    direccion VARCHAR(255) NOT NULL,
    capacidad_m3 DECIMAL(10,2) NOT NULL,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 2. Artículos de Catálogo Logístico
CREATE TABLE articulos (
    articulo_id INT AUTO_INCREMENT PRIMARY KEY,
    codigo_sku VARCHAR(50) NOT NULL UNIQUE,
    descripcion VARCHAR(200) NOT NULL,
    unidad_medida VARCHAR(20) DEFAULT 'UND',
    peso_kg DECIMAL(8,3) DEFAULT 0.000,
    volumen_m3 DECIMAL(8,4) DEFAULT 0.0000,
    costo_promedio DECIMAL(12,4) DEFAULT 0.0000,
    punto_reorden INT DEFAULT 10,
    stock_minimo INT DEFAULT 5,
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

-- 3. Stock por Almacén
CREATE TABLE stock_almacen (
    almacen_id INT NOT NULL,
    articulo_id INT NOT NULL,
    cantidad_disponible INT NOT NULL DEFAULT 0,
    cantidad_reservada INT NOT NULL DEFAULT 0,
    ultima_actualizacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (almacen_id, articulo_id),
    CONSTRAINT fk_stock_almacenes FOREIGN KEY (almacen_id) REFERENCES almacenes(almacen_id),
    CONSTRAINT fk_stock_articulos FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id)
) ENGINE=InnoDB;

-- 4. Movimientos de Kardex
CREATE TABLE kardex_movimientos (
    movimiento_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    fecha_hora DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    tipo_movimiento ENUM('ENTRADA_COMPRA', 'SALIDA_VENTA', 'TRANSFERENCIA_IN', 'TRANSFERENCIA_OUT', 'AJUSTE_POSITIVO', 'AJUSTE_NEGATIVO') NOT NULL,
    almacen_id INT NOT NULL,
    articulo_id INT NOT NULL,
    cantidad INT NOT NULL CHECK (cantidad > 0),
    costo_unitario DECIMAL(12,4) NOT NULL,
    saldo_anterior_cantidad INT NOT NULL,
    saldo_nuevo_cantidad INT NOT NULL,
    saldo_anterior_costo_prom DECIMAL(12,4) NOT NULL,
    saldo_nuevo_costo_prom DECIMAL(12,4) NOT NULL,
    documento_referencia VARCHAR(100),
    usuario VARCHAR(50) DEFAULT 'SISTEMA',
    observaciones TEXT,
    CONSTRAINT fk_kardex_almacenes FOREIGN KEY (almacen_id) REFERENCES almacenes(almacen_id),
    CONSTRAINT fk_kardex_articulos FOREIGN KEY (articulo_id) REFERENCES articulos(articulo_id)
) ENGINE=InnoDB;

-- 5. Transportistas y Envíos
CREATE TABLE transportistas (
    transportista_id INT AUTO_INCREMENT PRIMARY KEY,
    ruc VARCHAR(20) NOT NULL UNIQUE,
    razon_social VARCHAR(150) NOT NULL,
    tipo_flota ENUM('Propia', 'Tercerizada') DEFAULT 'Tercerizada',
    activo BOOLEAN DEFAULT TRUE
) ENGINE=InnoDB;

CREATE TABLE envios (
    envio_id INT AUTO_INCREMENT PRIMARY KEY,
    guia_remision VARCHAR(50) NOT NULL UNIQUE,
    almacen_origen_id INT NOT NULL,
    transportista_id INT NOT NULL,
    destino_ciudad VARCHAR(100) NOT NULL,
    fecha_despacho DATETIME NOT NULL,
    fecha_entrega_estimada DATETIME NOT NULL,
    fecha_entrega_real DATETIME NULL,
    estado ENUM('Preparado', 'En Tránsito', 'Entregado', 'Devuelto', 'Siniestrado') DEFAULT 'Preparado',
    peso_total_kg DECIMAL(10,2) NOT NULL,
    costo_flete DECIMAL(10,2) NOT NULL,
    CONSTRAINT fk_envios_almacen FOREIGN KEY (almacen_origen_id) REFERENCES almacenes(almacen_id),
    CONSTRAINT fk_envios_transportista FOREIGN KEY (transportista_id) REFERENCES transportistas(transportista_id)
) ENGINE=InnoDB;

-- Índices
CREATE INDEX idx_kardex_fecha ON kardex_movimientos(fecha_hora);
CREATE INDEX idx_kardex_art_alm ON kardex_movimientos(articulo_id, almacen_id);
CREATE INDEX idx_envios_estado_fecha ON envios(estado, fecha_despacho);
