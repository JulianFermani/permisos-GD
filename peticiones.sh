#!/bin/bash

# Colores y estilos
GREEN='\033[0;32m'
BLUE='\033[1;34m'
YELLOW='\033[1;33m'
CYAN='\033[1;36m'
NC='\033[0m' # Sin color

print_section() {
  echo -e "\n${CYAN}====================================================${NC}"
  echo -e "${BLUE} $1 ${NC}"
  echo -e "${CYAN}====================================================${NC}\n"
}

print_step() {
  echo -e "${YELLOW}➡️  $1...${NC}"
}

print_success() {
  echo -e "${GREEN}✅ $1 creado correctamente${NC}\n"
}

# Permisos a crear (nombre y descripción)
declare -A PERMISOS=(
  # Roles
  ["createRole"]="Crear roles"
  ["getRole"]="Visualizar roles"
  ["deleteRole"]="Eliminar roles"
  ["updateRole"]="Actualizar roles"
  # Permisos
  ["createPermission"]="Crear permisos"
  ["getPermission"]="Visualizar permisos"
  ["deletePermission"]="Eliminar permisos"
  ["updatePermission"]="Actualizar permisos"
  # Zonas
  ["createZones"]="Asigna el permiso de publicar zonas"
  ["getZones"]="Asigna el permiso de visualizar las zonas"
  ["modifyZone"]="Asigna el permiso de modificar zonas"
  ["deleteZone"]="Asigna el permiso de borrar zonas"
  # Delivery
  ["createDelivery"]="Asigna el permiso de visualizar los delivery"
  ["modifyDelivery"]="Asigna el permiso de modificar los delivery"
  ["getDelivery"]="Asigna el permiso de visualizar los delivery en base a la proximidad"
  ["deleteDelivery"]="Eliminar deliverys"
  # Estados
  ["createStatus"]="crea estados"
  ["getStatus"]="obtiene los estados"
  ["modifyStatus"]="modifica los estados"
  ["DeleteStatus"]="elimina los estados creados"
)

# Roles a crear
declare -A ROLES=(
  ["admin"]='{"code":"admin","name":"admin","description":"Tiene todos los permisos","permissions":[{"name":"getRole"},{"name":"createRole"},{"name":"updateRole"},{"name":"deleteRole"}]}'
  # Puedes agregar más roles aquí
)

# Usuarios a crear (email y password)
declare -A USERS=(
  ["mati@gmail.com"]="mati"
  ["rama@gmail.com"]="ramaDelivery"
  ["Lichi@gmail.com"]="LichiUser"
)

print_section "Creando permisos 🚦"

for name in "${!PERMISOS[@]}"; do
  desc=${PERMISOS[$name]}
  print_step "Creando permiso: $name"
  curl -s --location '127.0.0.1:3001/permissions' \
    --header 'Content-Type: application/json' \
    --data "{\"name\": \"$name\", \"description\": \"$desc\"}" > /dev/null
  print_success "$name"
done

print_section "Creando roles 🧑‍💼"

for role in "${!ROLES[@]}"; do
  print_step "Creando rol: $role"
  curl -s --location '127.0.0.1:3001/roles' \
    --header 'Content-Type: application/json' \
    --data "${ROLES[$role]}" > /dev/null
  print_success "$role"
done

print_section "Creando usuarios 👤"

for email in "${!USERS[@]}"; do
  pass=${USERS[$email]}
  print_step "Creando usuario: $email"
  curl -s --location '127.0.0.1:3001/register' \
    --header 'Content-Type: application/json' \
    --data-raw "{\"email\": \"$email\", \"password\": \"$pass\"}" > /dev/null
  print_success "$email"
done

echo -e "${GREEN}🎉 ¡Todos los permisos, roles y usuarios han sido creados!${NC}\n"

