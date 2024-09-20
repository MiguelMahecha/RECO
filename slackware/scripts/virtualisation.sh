#!/bin/bash

# Function to search for files by name
search_file() {
    local directory=$1
    local search_term=$2
    echo "Searching for files containing '$search_term' in directory '$directory':"
    find "$directory" -maxdepth 1 -type f -name "*$search_term*" 2>/dev/null
    local count=
    count=$(find "$directory" -maxdepth 1 -type f -name "*$search_term*" 2>/dev/null | wc -l)
    echo "$count files found."
}

# Function to search for a word in a specific file
search_word() {
    local file=$1
    local search_word=$2
    echo "Searching for word '$search_word' in file '$file':"
    grep -n "$search_word" "$file"
    local count=
    count=$(grep -o "$search_word" "$file" | wc -l)
    echo "$count occurrences found."
}

# Function to search for files and then search for a word in each file
search_file_and_word() {
    local directory=$1
    local file_search_term=$2
    local word_search_term=$3
    echo "Searching for files containing '$file_search_term' in directory '$directory':"
    local files=
    files=$(find "$directory" -maxdepth 1 -type f -name "*$file_search_term*" 2>/dev/null)
    if [ -z "$files" ]; then
        echo "No files found."
        return
    fi
    echo "Found files:"
    echo "$files"
    echo "Searching for word '$word_search_term' in each file:"
    local total_count=0
    for file in $files; do
        echo "In file '$file':"
        grep -n "$word_search_term" "$file"
        local count=
        count=$(grep -o "$word_search_term" "$file" | wc -l)
        total_count=$((total_count + count))
    done
    echo "$total_count total occurrences found."
}

# Function to count the number of lines in a file
count_lines() {
    local file=$1
    local line_count=
    line_count=$(wc -l <"$file")
    echo "The file '$file' has $line_count lines."
}

# Function to display the first 'n' lines of a file
display_first_lines() {
    local file=$1
    local n=$2
    echo "Displaying the first $n lines of '$file':"
    head -n "$n" "$file"
}

# Function to display the last 'n' lines of a file
display_last_lines() {
    local file=$1
    local n=$2
    echo "Displaying the last $n lines of '$file':"
    tail -n "$n" "$file"
}

# Main menu
while true; do
    clear
    echo "Select an option:"
    echo "1. Search for files by name"
    echo "2. Search for a word in a specific file"
    echo "3. Search for files and then search for a word in each file"
    echo "4. Count the number of lines in a file"
    echo "5. Display the first 'n' lines of a file"
    echo "6. Display the last 'n' lines of a file"
    echo "7. Exit"

    read -pr "Enter your choice [1-7]: " choice

    case $choice in
    1)
        read -pr "Enter the directory to search: " directory
        read -pr "Enter the name or part of the name of the file to search for: " file_name
        search_file "$directory" "$file_name"
        ;;
    2)
        read -pr "Enter the file to search: " file
        read -pr "Enter the word or part of the word to search for: " search_word
        search_word "$file" "$search_word"
        ;;
    3)
        read -pr "Enter the directory to search: " directory
        read -pr "Enter the name or part of the name of the file to search for: " file_name
        read -pr "Enter the word or part of the word to search for: " search_word
        search_file_and_word "$directory" "$file_name" "$search_word"
        ;;
    4)
        read -pr "Enter the file to count lines: " file
        count_lines "$file"
        ;;
    5)
        read -pr "Enter the file to display lines from: " file
        read -pr "Enter the number of lines to display: " n
        display_first_lines "$file" "$n"
        ;;
    6)
        read -pr "Enter the file to display lines from: " file
        read -pr "Enter the number of lines to display: " n
        display_last_lines "$file" "$n"
        ;;
    7)
        echo "Exiting..."
        break
        ;;
    *)
        echo "Invalid option. Please try again."
        ;;
    esac

    read -pr "Press Enter to continue..."
done
