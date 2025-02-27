#!/bin/bash
# Script de despliegue automático para el repositorio "Portfolio"

# Directorio donde se alojará la aplicación
APP_DIR="/var/www/Portfolio"
# URL del repositorio
REPO_URL="https://github.com/JoCaLeFe/Portfolio.git"

echo "Deteniendo NGINX..."
sudo systemctl stop nginx

echo "Deteniendo Ngrok (si está en ejecución)..."
pkill ngrok

# Si ya existe el directorio del repositorio, se actualiza; de lo contrario, se clona
if [ -d "$APP_DIR" ]; then
    echo "Repositorio encontrado en $APP_DIR. Actualizando..."
    cd "$APP_DIR" || { echo "No se pudo acceder a $APP_DIR"; exit 1; }
    git pull origin main
else
    echo "Clonando el repositorio en $APP_DIR..."
    sudo mkdir -p "$APP_DIR"
    # Cambiamos la propiedad del directorio para que tu usuario pueda escribir
    sudo chown "$USER":"$USER" "$APP_DIR"
    git clone "$REPO_URL" "$APP_DIR"
    cd "$APP_DIR" || { echo "No se pudo acceder a $APP_DIR tras clonar"; exit 1; }
fi

echo "Iniciando NGINX..."
sudo systemctl start nginx

echo "Iniciando Ngrok en segundo plano..."
nohup ngrok http 80 > /tmp/ngrok.log 2>&1 &
# Esperamos unos segundos para que Ngrok configure el túnel
sleep 5

echo "Obteniendo la URL pública de Ngrok..."
# Usamos jq para extraer la URL desde la API local de Ngrok
NGROK_URL=$(curl --silent http://127.0.0.1:4040/api/tunnels \
             | jq -r '.tunnels[0].public_url')

echo "La URL pública de Ngrok es: $NGROK_URL"

echo "¡Despliegue completado!"
