#!/bin/bash

# Function to create a new user
create_new_user() {
    read -p "Enter username: " username
    read -p "Enter comma-separated list of group names for the user: " group_names
    read -p "Enter user description: " description
    read -p "Enter home directory for the user: " home_directory
    read -p "Enter shell for the user: " shell
    read -p "Enter user permissions (in numeric form): " user_permissions
    read -p "Enter group permissions (in numeric form): " group_permissions
    read -p "Enter others permissions (in numeric form): " others_permissions

    # Convert comma-separated list to array
    IFS=', ' read -r -a groups <<< "$group_names"

    # Create user with primary group as the first group in the list
    sudo useradd -m -d "$home_directory" -s "$shell" -c "$description" -U -G "${groups[0]}" "$username"

    # Add additional groups to the user
    for group in "${groups[@]:1}"; do
        sudo usermod -aG "$group" "$username"
    done

    # Set permissions
    sudo chmod "$user_permissions:$group_permissions:$others_permissions" "$home_directory"

    echo "User '$username' has been created with groups '$group_names' and given specified permissions."
}

# Function to create a new group
create_new_group() {
    read -p "Enter group name: " group_name
    read -p "Enter group ID: " group_id

    # Create group
    sudo groupadd -g "$group_id" "$group_name"

    echo "Group '$group_name' with ID '$group_id' has been created."
}

display_menu() {
    clear
    echo "Main Menu:"
    echo "1. Create a new user"
    echo "2. Create a new group"
    echo "3. Exit"
}

# Main menu
while true; do
    display_menu

    read -p "Enter your choice: " choice

    case $choice in
        1) create_new_user ;;
        2) create_new_group ;;
        3) echo "Exiting program."; exit ;;
        *) echo "Invalid option. Please try again." ;;
    esac

    read -p "Press Enter to continue"
done
