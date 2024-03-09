#!/bin/bash

# Verificar si se proporcionan los argumentos necesarios
if [ "$#" -ne 3 ]; then
    echo "Uso: $0 directorio_arranque #archivos TamañoMax"
    exit 1
fi

directorio_arranque=$1
num_archivos=$2
tamano_maximo=$3

# Verificar si el directorio inicial existe
if [ ! -d "$directorio_arranque" ]; then
    echo "El directorio $directorio_arranque no existe."
    exit 1
fi

echo "Buscando los $num_archivos archivos más grandes en el directorio $directorio_arranque y subdirectorios, con un tamaño máximo de $tamano_maximo bytes."

# Utilizar el comando find para buscar archivos
# Ordenar por tamaño y mostrar los n archivos más grandes
find "$directorio_arranque" -type f -size +"$tamano_maximo"c -exec du -h {} + | sort -rh | head -n "$num_archivos" | awk '{print "Nombre de archivo:", $2, "Ruta:", $1, "Tamaño:", $1}'
