#!/bin/bash

mostrar_procesos() {
    echo "Mostrando procesos en ejecución:"
    ps aux | awk '{print "Nombre:", $11, "PID:", $2, "% Memoria:", $4, "% CPU:", $3}'
}

buscar_proceso() {
    read -p "Ingrese el nombre del proceso a buscar: " proceso
    echo "Buscando proceso: $proceso"
    ps aux | grep "$proceso"
}

matar_proceso() {
    read -p "Ingrese el PID del proceso a matar: " pid
    echo "Matando proceso con PID: $pid"
    kill -9 "$pid"
}

reiniciar_proceso() {
    read -p "Ingrese el PID del proceso a reiniciar: " pid
    echo "Reiniciando proceso con PID: $pid"
    kill -HUP "$pid"
}

mostrar_menu() {
    echo "Menú de opciones:"
    echo "a. Mostrar procesos en ejecución"
    echo "b. Buscar un proceso por nombre"
    echo "c. Matar/cerrar un proceso"
    echo "d. Reiniciar un proceso"
    echo "e. Salir"
}

while true; do
    mostrar_menu
    read -p "Seleccione una opción: " opcion

    case $opcion in
        a)
            mostrar_procesos
            ;;
        b)
            buscar_proceso
            ;;
        c)
            matar_proceso
            ;;
        d)
            reiniciar_proceso
            ;;
        e)
            echo "Saliendo del programa."
            break
            ;;
        *)
            echo "Opción inválida. Por favor, seleccione una opción válida."
            ;;
    esac
done
