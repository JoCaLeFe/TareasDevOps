#!/bin/bash

# Verificar si se proporcionó un argumento
if [ -z "$1" ]; then
    echo "Uso: $0 <nombre_pokemon>"
    exit 1
fi

POKEMON=$1
API_URL="https://pokeapi.co/api/v2/pokemon/$POKEMON"
CSV_FILE="pokemon.csv"

# Consultar la API de PokeAPI con curl
RESPONSE=$(curl -s "$API_URL")

# Verificar si la respuesta es válida
if [ -z "$RESPONSE" ] || [ "$RESPONSE" == "Not Found" ]; then
    echo "Error: No se encontró el Pokémon '$POKEMON' en la PokeAPI."
    exit 1
fi

# Extraer los datos con jq
ID=$(echo "$RESPONSE" | jq .id)
NAME=$(echo "$RESPONSE" | jq -r .name)
WEIGHT=$(echo "$RESPONSE" | jq .weight)
HEIGHT=$(echo "$RESPONSE" | jq .height)
ORDER=$(echo "$RESPONSE" | jq .order)

# Imprimir los resultados en formato especificado
echo "${NAME^} (No. $ID)"
echo "Id = $ID"
echo "Weight = $WEIGHT"
echo "Height = $HEIGHT"
echo "Order = $ORDER"
echo

# Verificar si el archivo CSV existe, si no, crear con encabezados
if [ ! -f "$CSV_FILE" ]; then
    echo "id,name,weight,height,order" > "$CSV_FILE"
fi

# Agregar los datos al archivo CSV
echo "$ID,$NAME,$WEIGHT,$HEIGHT,$ORDER" >> "$CSV_FILE"

echo "Datos guardados en $CSV_FILE"