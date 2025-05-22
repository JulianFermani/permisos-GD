echo "Creando permisos..."

curl --location '127.0.0.1:3000/permissions' \
--header 'Content-Type: application/json' \
--data '{
    "name": "admin",
    "description": "Este permiso es de admins"
}'

curl --location '127.0.0.1:3000/permissions' \
--header 'Content-Type: application/json' \
--data '{
    "name": "mati",
    "description": "Este permiso es del profe"
}'

echo "Creando rol..."

curl --location '127.0.0.1:3000/roles' \
--header 'Content-Type: application/json' \
--data '{
    "code":"ADMIN",
    "name": "admin_mati",
    "description": "Este rol es de cracks",
    "permissions": [{"name":"admin"}]
}'

echo "Creando usuario..."

curl --location '127.0.0.1:3000/register' \
--header 'Content-Type: application/json' \
--data-raw '{
    "email": "mati@gmail.com",
    "password": "mati"
}'
