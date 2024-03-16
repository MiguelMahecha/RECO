#!/bin/bash

clear
while true; do
    echo "----------------------------------| MENU |----------------------------------"
    echo "1. Ver los procesos que estan corriendo"
    echo "2. Buscar un proceso"
    echo "3. Reiniciar un proceso"
    echo "4. Finalizar un proceso"
    echo "5. Salir del Menu"
    echo "6. Easter egg"
    echo "----------------------------------------------------------------------------"

    read -p "Ingresa tu opcion: "  valor
    case $valor in
        1)
            echo "Procesos en ejecucion"
            ps aux | awk '{print $2, " ", $3 " ", $4 " ", $11}' | less
            ;;
        2)
            read -p "Nombre: " psnombre
            echo "Procesos encontrados"
            ps aux | head -n 1
            ps aux | grep $pasnombre
            ;;
        3)
            read -p "Nombre del proceso: " psnombre
            kill -HUP "$psnombre"
            echo "Proceso reiniciado"
            ;;
        4)
            read -p "Nombre del proceso: " psnombre
            psID=$(ps | grep $psnombre | awk '{print $1}')
            kill -9 $psID
            echo "Proceso $psnombre finalizado"
            ;;
        5)
            break
            clear
            ;;
        6)
            echo "Joan estuvo aqui"
            ;;
        *)
            echo "Opcion no valida"
            ;;
    esac
done
