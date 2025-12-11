-- Script para crear la base de datos y tablas del sistema de campos de fútbol

-- Crear base de datos
CREATE DATABASE IF NOT EXISTS campos_futbol CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE campos_futbol;

-- Tabla de Usuarios (Administradores y Asesores)
CREATE TABLE IF NOT EXISTS usuario (
    codigo_usuario INT AUTO_INCREMENT PRIMARY KEY,
    nombre_completo VARCHAR(150) NOT NULL,
    nombre_usuario VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(100) NOT NULL UNIQUE,
    contrasena VARCHAR(255) NOT NULL,
    rol VARCHAR(20) NOT NULL COMMENT 'Administrador o Asesor',
    telefono VARCHAR(15),
    estado VARCHAR(10) NOT NULL DEFAULT 'Activo' COMMENT 'Activo o Inactivo',
    fecha_registro DATE NOT NULL,
    INDEX idx_usuario (nombre_usuario),
    INDEX idx_rol (rol)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de Clientes
CREATE TABLE IF NOT EXISTS cliente (
    codigo_cliente INT AUTO_INCREMENT PRIMARY KEY,
    dni VARCHAR(8) NOT NULL UNIQUE,
    nombre_completo VARCHAR(150) NOT NULL,
    telefono VARCHAR(15) NOT NULL,
    email VARCHAR(100),
    direccion VARCHAR(200),
    fecha_registro DATE NOT NULL,
    estado VARCHAR(10) NOT NULL DEFAULT 'Activo' COMMENT 'Activo o Inactivo',
    INDEX idx_dni (dni),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de Campos de Fútbol
CREATE TABLE IF NOT EXISTS campo_futbol (
    codigo_campo INT AUTO_INCREMENT PRIMARY KEY,
    nombre_campo VARCHAR(100) NOT NULL,
    ubicacion_campo VARCHAR(150) NOT NULL,
    tipo_cesped VARCHAR(50) NOT NULL,
    capacidad_personas INT NOT NULL,
    precio_hora DECIMAL(10,2) NOT NULL,
    disponibilidad TINYINT(1) NOT NULL DEFAULT 1 COMMENT '1=Disponible, 0=Ocupado',
    INDEX idx_disponibilidad (disponibilidad)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de Alquileres
CREATE TABLE IF NOT EXISTS alquiler (
    codigo_alquiler INT AUTO_INCREMENT PRIMARY KEY,
    codigo_cliente INT NOT NULL,
    codigo_campo INT NOT NULL,
    fecha_alquiler DATE NOT NULL,
    hora_inicio TIME NOT NULL,
    hora_fin TIME NOT NULL,
    total_horas INT NOT NULL,
    precio_total DECIMAL(10,2) NOT NULL,
    estado VARCHAR(20) NOT NULL DEFAULT 'Pendiente' COMMENT 'Confirmado, Pendiente, Cancelado',
    observaciones VARCHAR(500),
    fecha_registro DATE NOT NULL,
    FOREIGN KEY (codigo_cliente) REFERENCES cliente(codigo_cliente) ON DELETE RESTRICT,
    FOREIGN KEY (codigo_campo) REFERENCES campo_futbol(codigo_campo) ON DELETE RESTRICT,
    INDEX idx_fecha_alquiler (fecha_alquiler),
    INDEX idx_estado (estado)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Tabla de Facturas
CREATE TABLE IF NOT EXISTS factura (
    codigo_factura INT AUTO_INCREMENT PRIMARY KEY,
    numero_factura VARCHAR(20) NOT NULL UNIQUE,
    codigo_alquiler INT NOT NULL,
    fecha_emision DATE NOT NULL,
    subtotal DECIMAL(10,2) NOT NULL,
    igv DECIMAL(10,2) NOT NULL,
    total DECIMAL(10,2) NOT NULL,
    estado_pago VARCHAR(20) NOT NULL DEFAULT 'Pendiente' COMMENT 'Pagado, Pendiente, Anulado',
    observaciones VARCHAR(500),
    FOREIGN KEY (codigo_alquiler) REFERENCES alquiler(codigo_alquiler) ON DELETE RESTRICT,
    INDEX idx_numero_factura (numero_factura),
    INDEX idx_estado_pago (estado_pago)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Insertar usuarios de prueba (contraseñas encriptadas con BCrypt)
-- admin: admin123 / asesor: asesor123
INSERT INTO usuario (nombre_completo, nombre_usuario, email, contrasena, rol, telefono, estado, fecha_registro) VALUES
('Pedro Pablo Camilo', 'admin', 'pedro.camilo@canchas.com', '$2a$10$XlSqwp3rr7M4VJqHZUkqx.vXvxLQjqKPIYlvGxLxQV0kJxYJZVKM.', 'Administrador', '999888777', 'Activo', '2025-01-01'),
('Ana García López', 'asesor', 'ana.garcia@canchas.com', '$2a$10$8XeC/j1qN8vXFjQXGKVYJ.yqP4VYmJVkJXvXQqLKvXFjQXGKVYJe.', 'Asesor', '987654321', 'Activo', '2025-01-15');

-- Insertar campos de fútbol de prueba
INSERT INTO campo_futbol (nombre_campo, ubicacion_campo, tipo_cesped, capacidad_personas, precio_hora, disponibilidad) VALUES
('Campo 001', 'Av. Principal 123', 'Sintético', 22, 80.00, 1),
('Campo 002', 'Jr. Deportes 456', 'Natural', 18, 60.00, 1),
('Campo 003', 'Calle Los Cedros 789', 'Sintético', 14, 50.00, 1),
('Campo VIP', 'Av. Central 321', 'Sintético Premium', 22, 120.00, 1);

-- Insertar clientes de prueba
INSERT INTO cliente (dni, nombre_completo, telefono, email, direccion, fecha_registro, estado) VALUES
('12345678', 'Juan Pérez García', '987123456', 'juan.perez@email.com', 'Av. Los Pinos 123', '2025-11-01', 'Activo'),
('87654321', 'María Rodríguez López', '976543210', 'maria.rodriguez@email.com', 'Jr. Las Flores 456', '2025-11-15', 'Activo'),
('11223344', 'Carlos Díaz Mendoza', '965432198', 'carlos.diaz@email.com', 'Calle Los Robles 789', '2025-12-01', 'Activo');

-- Insertar alquileres de prueba
INSERT INTO alquiler (codigo_cliente, codigo_campo, fecha_alquiler, hora_inicio, hora_fin, total_horas, precio_total, estado, fecha_registro) VALUES
(1, 1, '2025-12-06', '14:00:00', '16:00:00', 2, 160.00, 'Confirmado', '2025-12-05'),
(2, 3, '2025-12-06', '16:00:00', '17:00:00', 1, 50.00, 'Pendiente', '2025-12-06');

-- Insertar facturas de prueba
INSERT INTO factura (numero_factura, codigo_alquiler, fecha_emision, subtotal, igv, total, estado_pago) VALUES
('F-00001', 1, '2025-12-06', 135.59, 24.41, 160.00, 'Pagado'),
('F-00002', 2, '2025-12-06', 42.37, 7.63, 50.00, 'Pendiente');
