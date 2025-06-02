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
    "name": "createZones",
    "description": "Asigna el permiso de publicar zonas"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getZones",
    "description": "Asigna el permiso de visualizar las zonas"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyZone",
    "description": "Asigna el permiso de modificar zonas"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "deleteZone",
    "description": "Asigna el permiso de borrar zonas"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createDelivery",
    "description": "Asigna el permiso de visualizar los delivery"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyDelivery",
    "description": "Asigna el permiso de modificar los delivery"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getDelivery",
    "description": "Asigna el permiso de visualizar los delivery en base a la proximidad"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "deleteDelivery",
    "description": "Eliminar deliverys"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "createStatus",
    "description": "crea estados"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "getStatus",
    "description": "obtiene los estados"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "modifyStatus",
    "description": "modifica los estados"
}'

curl --location '127.0.0.1:3000/permissions' \
  --header 'Content-Type: application/json' \
  --data '{
    "name": "DeleteStatus",
    "description": "elimina los estados creados"
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
    "code":"Admin",
    "name": "admin_mati",
    "description": "Este rol es de cracks",
    "permissions": [{"name":"admin"}]
}'

curl --location '127.0.0.1:3000/roles' \
  --header 'Content-Type: application/json' \
  --data '{
    "code":"Delivery",
    "name": "delivery",
    "description": "Este rol es para los deliveries",
    "permissions": [{"name":"delivery"}]
}'

curl --location '127.0.0.1:3000/roles' \
  --header 'Content-Type: application/json' \
  --data '{
    "code":"User",
    "name": "user",
    "description": "Este rol es para users",
    "permissions": [{"name":"user"}]
}'

echo "Creando usuario..."

curl --location '127.0.0.1:3000/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "mati@gmail.com",
    "password": "mati"
}'

# Delivery
curl --location '127.0.0.1:3000/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "rama@gmail.com",
    "password": "ramaDelivery"
}'

#User
curl --location '127.0.0.1:3000/register' \
  --header 'Content-Type: application/json' \
  --data-raw '{
    "email": "Lichi@gmail.com",
    "password": "LichiUser"
}'
