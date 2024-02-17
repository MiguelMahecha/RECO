#!/bin/bash

show_last_15_lines() {
    echo "Displaying the last 15 lines of specified log files:"

    log_file1="/var/log/syslog"
    log_file2="/var/log/messages"
    log_file3="/var/log/secure"

    echo "Last 15 lines of $log_file1:"
    tail -n 15 "$log_file1"
    echo "Last 15 lines of $log_file2:"
    tail -n 15 "$log_file2"
    echo "Last 15 lines of $log_file3:"
    tail -n 15 "$log_file3"
}

show_lines_with_word() {
    read -p "Enter the word to search for: " search_word
    echo "Displaying lines containing '$search_word' from the last 15 lines of specified log files:"

    log_file1="/var/log/syslog"
    log_file2="/var/log/messages"
    log_file3="/var/log/secure"

    echo "Lines containing '$search_word' in $log_file1:"
    grep "$search_word" "$log_file1" | tail -n 15
    echo "Lines containing '$search_word' in $log_file2:"
    grep "$search_word" "$log_file2" | tail -n 15
    echo "Lines containing '$search_word' in $log_file3:"
    grep "$search_word" "$log_file3" | tail -n 15
}

display_menu() {
    clear
    echo "Main Menu:"
    echo "1. Show the last 15 lines of specified log files"
    echo "2. Show lines containing a particular word from the last 15 lines of specified log files"
    echo "3. Exit"
}

while true; do
    display_menu

    read -p "Enter your choice: " choice

    case $choice in
        1) show_last_15_lines ;;
        2) show_lines_with_word ;;
        3) echo "Exiting program."; exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    read -p "Press Enter to continue"
done
