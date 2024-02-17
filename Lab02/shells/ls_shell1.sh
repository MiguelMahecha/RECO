#!/bin/bash

# Function to display the menu
display_menu() {
    clear
    echo "Seleccione una opción:"
    echo "1. Listar archivos por más reciente"
    echo "2. Listar archivos por más antiguo"
    echo "3. Listar archivos por tamaño de mayor a menor"
    echo "4. Listar archivos por tamaño de menor a mayor"
    echo "5. Listar archivos por tipo (archivo/directorio)"
    echo "6. Condiciones de búsqueda"
    echo "7. Salir"
}

print_same_dates() {
    printf "Count of files/directories by creation date:\n"
    find "$1" -maxdepth 1 -printf '%Td-%Tm-%TY %p\n' | 
        awk -F " " '{print $1}' | 
        uniq -c |
        while read -r count date; do
            printf "%d files/directories created on %s\n" "$count" "$date"
        done
}

print_same_size() {
    printf "Count of files/directories by size:\n"
    find "$path" -maxdepth 1 -printf "%s %p\n" | 
        sort -nr -k1 | 
        awk -F " " '{print $1}' | 
        uniq -c |
        while read -r count size; do
            printf "%d files/directories with size %s\n" "$count" "$size"
        done
}

list_recent_files() {
    printf "Enter path: "
    read -r path
    
    printf "List of files:\n"
    ls -ltr "$path"

    printf "\n"
    
    print_same_dates "$path"
}

list_oldest_files() {
    printf "Enter path: "
    read -r path
    
    printf "List of files:\n"
    ls -lt "$path"
    
    printf "\n"
    
    print_same_dates "$path"
}

list_files_by_size_desc() {
    printf "Enter path: "
    read -r path

    printf "List of files:\n"
    find "$path" -maxdepth 1 -printf "%s %p\n" | sort -nr -k1


    printf "\n"

    print_same_size "$path"
}

list_files_by_size_asc() {
    printf "Enter path: "
    read -r path

    printf "List of files:\n"
    find "$path" -maxdepth 1 -printf "%s %p\n" | sort -n -k1

    printf "\n"

    print_same_size "$path"
}

list_files_by_type() {
    read -p "File or dir " c_type
    read -p "Path " path
    if [ "$c_type" = "dir" ]; then
        num_contents=$(find "$path" -maxdepth 1 -type d | wc -l)
        echo "There are $num_contents directories."
    elif [ "$c_type" = "file" ]; then
        num_contents=$(find "$path" -maxdepth 1 -type f | wc -l)
        echo "There are $num_contents files."
    else
        echo "Invalid argument. Please provide 'dir' or 'file'."
    fi
}

starts_with() {
    read -p "Enter pattern " pattern
    
    if [ "$2" = "true" ]; then
        find "$1" -name "$pattern*"
    elif [ "$2" = "false" ]; then
        find "$1" -maxdepth 1 -name "$pattern*"
    else
        echo "Invalid options"
    fi
}

ends_with() {
    read -p "Enter pattern " pattern
    
    if [ "$2" = "true" ]; then
        find "$1" -name "*$pattern"
    elif [ "$2" = "false" ]; then
        find "$1" -maxdepth 1 -name "*$pattern"
    else
        echo "Invalid options"
    fi
}

contains_str() {
    read -p "Enter pattern " pattern
    
    if [ "$2" = "true" ]; then
        find "$1" -name "*$pattern*"
    elif [ "$2" = "false" ]; then
        find "$1" -maxdepth 1 -name "*$pattern*"
    else
        echo "Invalid options"
    fi
}

search_contents() {
    read -p "Enter path " path
    read -p "recursive? (true | false) " recursive

    echo "1. Start with given string"
    echo "2. End with given string"
    echo "3. Contains given string"

    read -p "Select search method: " choice

    case $choice in
        1)
            starts_with "$path" "$recursive"
            ;;
        2)
            ends_with "$path" "$recursive"
            ;;
        3)
            contains_str "$path" "$recursive"
            ;;
        *)
            echo "Invalid"
            ;;
    esac
}

while true; do
    display_menu

    read -p "Choose an option: " choice

    case $choice in
        1)
            list_recent_files
            ;;
        2)
            list_oldest_files
            ;;
        3)
            list_files_by_size_desc
            ;;
        4)
            list_files_by_size_asc
            ;;
        5)
            list_files_by_type
            ;;
        6)
            search_contents
            ;;
        7)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please select a valid option."
            ;;
    esac

    read -p "Press Enter to continue..."
done
