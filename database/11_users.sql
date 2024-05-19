USE redHatDataGridVideo;

# Crear usuario administrador para consultar, insertar, actualizar y eliminar registros.
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin';

# Crear usuario para consultar registros.
CREATE USER 'guest'@'%' IDENTIFIED BY 'guest';

# Asignar privilegios
GRANT INSERT, SELECT, UPDATE, DELETE ON redHatDataGridVideo.* TO 'admin'@'%';
GRANT SELECT ON redHatDataGridVideo.* TO 'guest'@'%';

# Recargar privilegios
FLUSH PRIVILEGES;

ALTER SCHEMA `redHatDataGridVideo`  DEFAULT CHARACTER SET utf8mb4  DEFAULT COLLATE utf8mb4_unicode_ci ;