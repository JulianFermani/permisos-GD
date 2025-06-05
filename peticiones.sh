echo "Creando permisos... \n"

### PERMISOS DE ROLES ####

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createRole",
    "description": "Crear roles"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getRole",
    "description": "Visualizar roles"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "deleteRole",
    "description": "Eliminar roles"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "updateRole",
    "description": "Actualizar roles"
}'

### PERMISOS DE ZONES ####

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createZones",
    "description": "Asigna el permiso de publicar zonas"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getZones",
    "description": "Asigna el permiso de visualizar las zonas"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyZone",
    "description": "Asigna el permiso de modificar zonas"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "deleteZone",
    "description": "Asigna el permiso de borrar zonas"
}'

### PERMISOS DE DELIVERY ####

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createDelivery",
    "description": "Asigna el permiso de visualizar los delivery"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyDelivery",
    "description": "Asigna el permiso de modificar los delivery"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getDelivery",
    "description": "Asigna el permiso de visualizar los delivery en base a la proximidad"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "deleteDelivery",
    "description": "Eliminar deliverys"
}'

### PERMISOS DE ESTADOS ####

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createStatus",
    "description": "crea estados"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getStatus",
    "description": "obtiene los estados"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyStatus",
    "description": "modifica los estados"
}'

curl --location '127.0.0.1:3001/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "DeleteStatus",
    "description": "elimina los estados creados"
}'

echo "Creando roles... \n"

curl --location '127.0.0.1:3001/roles' \
  --header 'Content-Type: application/json' \
  --data '{
    "code":"admin",
    "name": "admin",
    "description": "Tiene todos los permisos",
    "permissions": [{"name":"getRol"}, {"name":"createRol"}, {"name":"updateRol"}, {"name":"deleteRol"}]
}'

# curl --location '127.0.0.1:3001/roles' \
#   --header 'Content-Type: application/json' \
#   --data '{
#     "code":"Delivery",
#     "name": "delivery",
#     "description": "Este rol es para los deliveries",
#     "permissions": [{"name":"delivery"}]
# }'
#
# curl --location '127.0.0.1:3001/roles' \
#   --header 'Content-Type: application/json' \
#   --data '{
#     "code":"User",
#     "name": "user",
#     "description": "Este rol es para users",
#     "permissions": [{"name":"user"}]
# }'
echo "Creando usuarios... \n"

curl --location '127.0.0.1:3001/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "mati@gmail.com",
    "password": "mati"
}'

# Delivery
curl --location '127.0.0.1:3001/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "rama@gmail.com",
    "password": "ramaDelivery"
}'

#User
curl --location '127.0.0.1:3001/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "Lichi@gmail.com",
    "password": "LichiUser"
}'
