#!/bin/bash

API_URL="http://localhost:3001"
DLV_URL="http://localhost:3000"
JWT_FILE=".jwt_token"

function register() {
  echo "Registrando usuario pepito..."
  curl -s --location "$API_URL/register" \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "email": "pepito@normal.com",
      "password": "pepito"
    }' | jq
}

function login_as_admin() {
  echo "Logueando como admin..."
  RESPONSE=$(curl -s --location "$API_URL/login" \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "email": "admin@sistema.com",
      "password": "admin123"
    }')

  echo "$RESPONSE" | jq

  JWT=$(echo "$RESPONSE" | jq -r '.accessToken')

  if [[ "$JWT" == "null" || -z "$JWT" ]]; then
    echo "❌ No se pudo obtener el JWT."
  else
    echo "✅ JWT obtenido y guardado."
    echo "$JWT" > "$JWT_FILE"
  fi
}

function login_as_user() {
  echo "Logueando como pepito..."
  RESPONSE=$(curl -s --location "$API_URL/login" \
    --header 'Content-Type: application/json' \
    --data-raw '{
      "email": "pepito@normal.com",
      "password": "pepito"
    }')

  echo "$RESPONSE" | jq

  JWT=$(echo "$RESPONSE" | jq -r '.accessToken')

  if [[ "$JWT" == "null" || -z "$JWT" ]]; then
    echo "❌ No se pudo obtener el JWT."
  else
    echo "✅ JWT obtenido y guardado."
    echo "$JWT" > "$JWT_FILE"
  fi
}

function get_permissions() {
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  echo "Consultando /permissions con JWT..."
  curl -s --location "$API_URL/permissions/" \
    --header "Authorization: Bearer $JWT" | jq
}

function get_roles() {
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  echo "Consultando /roles con JWT..."
  curl -s --location "$API_URL/roles/" \
    --header "Authorization: Bearer $JWT" | jq
}

function delivery_assign_zone(){
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  curl -s --location "$DLV_URL/api/v1/delivery/1/assignZone" \
    --header 'Content-Type: application/json' \
    --header "Authorization: Bearer $JWT" \
    --data-raw '{
      "zoneIds": [1]
    }' | jq
}

function delete_zone(){
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  curl -s --location --request DELETE "$DLV_URL/api/v1/zones/3" \
    --header "Authorization: Bearer $JWT" | jq
}

function put_zone(){
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  curl -s --location --request PUT "$DLV_URL/api/v1/zones/1" \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $JWT" \
  --data '{
    "name": "Zona Sur",
    "radius": 20,
    "location": {
        "lat": 12.0,
        "lng": 11.0
    }
  }' | jq
}

function patch_zone(){
  if [ ! -f "$JWT_FILE" ]; then
    echo "❌ No hay JWT guardado. Hacé login primero."
    return
  fi

  JWT=$(cat "$JWT_FILE")

  curl -s --location --request PATCH "$DLV_URL/api/v1/zones/1" \
  --header 'Content-Type: application/json' \
  --header "Authorization: Bearer $JWT" \
  --data '{
    "name": "Zona Centro"
  }' | jq
}


function menu() {
  clear
  echo "=============================="
  echo "  🚀 Menú de API Bash Client"
  echo "=============================="
  echo "1) Registrar a pepito"
  echo "2) Login como admin"
  echo "3) Login como pepito"
  echo "4) Consultar /permissions"
  echo "5) Consultar /roles"
  echo "6) Delete de una zona"
  echo "7) Put de una zona (cambia todo)"
  echo "8) Patch de una zona (cambia solo el nombre)"
  echo "0) Salir"
  echo "------------------------------"
  read -p "Elegí una opción: " choice

  case $choice in
    1) register ;;
    2) login_as_admin ;;
    3) login_as_user ;;
    4) get_permissions ;;
    5) get_roles ;;
    6) delete_zone ;;
    7) put_zone ;;
    8) patch_zone ;;
    0) echo "Chau 👋"; exit 0 ;;
    *) echo "Opción inválida" ;;
  esac
}

while true; do
  menu
  echo
  read -p "Presioná Enter para continuar..."
done

