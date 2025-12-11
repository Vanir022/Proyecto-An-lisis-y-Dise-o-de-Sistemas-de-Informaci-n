-- Verificar usuarios existentes en la base de datos
USE campos_futbol;

-- Mostrar todos los usuarios
SELECT 
    codigo_usuario,
    nombre_completo,
    nombre_usuario,
    email,
    rol,
    estado,
    fecha_registro
FROM usuario;

-- Si necesitas crear/actualizar contraseñas manualmente:
-- Las contraseñas están encriptadas con BCrypt
-- admin123 -> $2a$10$XlSqwp3rr7M4VJqHZUkqx.vXvxLQjqKPIYlvGxLxQV0kJxYJZVKM.
-- asesor123 -> $2a$10$8XeC/j1qN8vXFjQXGKVYJ.yqP4VYmJVkJXvXQqLKvXFjQXGKVYJe.

-- Actualizar contraseña de admin (si es necesario)
-- UPDATE usuario SET contrasena = '$2a$10$XlSqwp3rr7M4VJqHZUkqx.vXvxLQjqKPIYlvGxLxQV0kJxYJZVKM.' WHERE nombre_usuario = 'admin';

-- Actualizar contraseña de asesor (si es necesario)
-- UPDATE usuario SET contrasena = '$2a$10$8XeC/j1qN8vXFjQXGKVYJ.yqP4VYmJVkJXvXQqLKvXFjQXGKVYJe.' WHERE nombre_usuario = 'asesor';
