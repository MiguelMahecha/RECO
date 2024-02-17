#!/bin/bash

# Function to search for a file or part of a file name in a given directory
search_file() {
    read -p "Enter the directory path: " directory
    read -p "Enter the file name or part of it: " file_name
    grep -rnw "$directory" -e "$file_name"
    grep -rnw "$directory" -e "$file_name" | wc -l
}

# Function to search for a word or part of a word in a given file
search_word() {
    read -p "Enter the file path: " file_path
    read -p "Enter the word or part of it: " word
    grep -in "$word" "$file_path"
    grep -c "$word" "$file_path"
}

# Function to search for a file in a given directory and then search for a word in those files
search_file_and_word() {
    read -p "Enter the directory path: " directory
    read -p "Enter the file name or part of it: " file_name
    read -p "Enter the word or part of it: " word
    find "$directory" -name "*$file_name*" | while read -r file; do
        echo "Results in $file:"
        grep -in "$word" "$file"
    done
    find "$directory" -name "*$file_name*" | xargs grep -c "$word" | awk '{s+=$1} END {print "Total occurrences: ", s}'
}

# Function to count the number of lines in a given file
count_lines() {
    read -p "Enter the file path: " file_path
    wc -l < "$file_path"
}

# Function to display the first n lines of a given file
display_first_lines() {
    read -p "Enter the file path: " file_path
    read -p "Enter the number of lines to display: " num_lines
    head -n "$num_lines" "$file_path"
}

# Function to display the last n lines of a given file
display_last_lines() {
    read -p "Enter the file path: " file_path
    read -p "Enter the number of lines to display: " num_lines
    tail -n "$num_lines" "$file_path"
}

display_menu() {
    clear
    echo "Choose an option:"
    echo "1. Search for a file"
    echo "2. Search for a word in a file"
    echo "3. Search for a file and then search for a word in those files"
    echo "4. Count the number of lines in a file"
    echo "5. Display the first n lines of a file"
    echo "6. Display the last n lines of a file"
    echo "7. Exit"
}

# Main menu
while true; do
    display_menu

    read -p "Enter your choice: " choice

    case $choice in
        1) search_file ;;
        2) search_word ;;
        3) search_file_and_word ;;
        4) count_lines ;;
        5) display_first_lines ;;
        6) display_last_lines ;;
        7) echo "Exiting program."; exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    read -p "Press Enter to continue..."
done
