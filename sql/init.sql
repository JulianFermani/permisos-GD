-- 1. Insertar permisos 
INSERT INTO PERMISSION (id, name, description) VALUES 
(1, 'getRole', 'Visualizar roles'),
(2, 'createRole', 'Crear roles'),
(3, 'updateRole', 'Actualizar roles'),
(4, 'deleteRole', 'Borrar roles'),
(5, 'getPermission', 'Visualizar permisos'),
(6, 'createPermission', 'Crear permisos'),
(7, 'updatePermission', 'Actualizar permisos'),
(8, 'deletePermission', 'Borrar permisos');

-- 2. Crear el rol de administrador
INSERT INTO ROL (id, code, name, description) VALUES 
(1, 'ADMIN', 'Administrador', 'Rol con acceso completo al sistema');

-- 3. Asociar todos los permisos al rol de administrador
INSERT INTO ROL_PERMISSIONS_PERMISSION ("rolId", "permissionId") VALUES 
(1, 1), -- getRole
(1, 2), -- createRole
(1, 3), -- updateRole
(1, 4), -- deleteRole
(1, 5), -- getPermission
(1, 6), -- createPermission
(1, 7), -- updatePermission
(1, 8); -- deletePermission

-- 4. Crear el usuario administrador
-- La contraseña es admin123
INSERT INTO USERS (id, email, password, "rolId") VALUES 
(1, 'admin@sistema.com', '$2b$10$MfHtev23g1zjSx7.JAd9h.a4pFzw3FBmBF0dQ4jzE7FOOTPoLJd6W', 1);

