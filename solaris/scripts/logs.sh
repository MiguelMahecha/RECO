#!/bin/bash

# Function to display the last 15 lines of 3 log files
show_logs() {
    echo "Displaying the last 15 lines of each log file:"
    echo "=============================================="
    
    # Display the last 15 lines from each log file
    echo "Log 1: /var/log/syslog"
    tail -n 15 /var/log/syslog
    echo "----------------------------------------------"

    echo "Log 2: /var/log/auth.log"
    tail -n 15 /var/log/auth.log
    echo "----------------------------------------------"

    echo "Log 3: /var/log/dmesg"
    tail -n 15 /var/log/dmesg
    echo "=============================================="
}

# Function to search for a particular word in the last 15 lines of the log files
search_word_in_logs() {
    read -p "Enter the word to search for: " search_word

    echo "Searching for '$search_word' in the last 15 lines of each log file:"
    echo "=============================================="

    echo "Log 1: /var/log/syslog"
    tail -n 15 /var/log/syslog | grep -i "$search_word"
    echo "----------------------------------------------"

    echo "Log 2: /var/log/auth.log"
    tail -n 15 /var/log/auth.log | grep -i "$search_word"
    echo "----------------------------------------------"

    echo "Log 3: /var/log/dmesg"
    tail -n 15 /var/log/dmesg | grep -i "$search_word"
    echo "=============================================="
}

# Main menu to select between the two activities
while true; do
    clear
    echo "Select an option:"
    echo "1. Show the last 15 lines of 3 log files"
    echo "2. Search for a word in the last 15 lines of 3 log files"
    echo "3. Exit"

    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            show_logs
            ;;
        2)
            search_word_in_logs
            ;;
        3)
            echo "Exiting..."
            break
            ;;
        *)
            echo "Invalid option. Please try again."
            ;;
    esac

    read -p "Press Enter to continue..."
done
