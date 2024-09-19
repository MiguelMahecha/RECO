#!/bin/bash

# Function to create a new group with optional GID
newgroup() {
    local group_name=$1
    local group_id=$2

    # If a group ID is provided, create the group with the specified GID
    if [ -z "$group_id" ]; then
        echo "Creating new group: $group_name with default GID"
        sudo groupadd "$group_name"
    else
        echo "Creating new group: $group_name with GID: $group_id"
        sudo groupadd -g "$group_id" "$group_name"
    fi

    if [ $? -eq 0 ]; then
        echo "Group $group_name created successfully."
    else
        echo "Error creating group $group_name."
    fi
}

# Function to create a new user and set permissions
newuser() {
    local user_name=$1
    local group_name=$2
    local description=$3
    local home_directory=$4
    local user_shell=$5
    local user_perm=$6
    local group_perm=$7
    local others_perm=$8

    echo "Creating new user: $user_name in group: $group_name"
    
    # Create the user with the specified home directory and shell, and assign to the group
    sudo useradd -m -d "$home_directory" -s "$user_shell" -c "$description" -g "$group_name" "$user_name"

    if [ $? -eq 0 ]; then
        echo "User $user_name created successfully."
    else
        echo "Error creating user $user_name."
        return
    fi

    # Set permissions on the user's home directory
    chmod "$user_perm$group_perm$others_perm" "$home_directory"
    if [ $? -eq 0 ]; then
        echo "Permissions set successfully for $user_name's home directory."
    else
        echo "Error setting permissions for $user_name's home directory."
    fi
}

# Main menu to create users and groups
while true; do
    clear
    echo "Select an option:"
    echo "1. Create a new group"
    echo "2. Create a new user"
    echo "3. Exit"

    read -p "Enter your choice [1-3]: " choice

    case $choice in
        1)
            read -p "Enter the name of the new group: " group_name
            read -p "Enter the group ID (GID) for the new group (leave blank for default): " group_id
            newgroup "$group_name" "$group_id"
            ;;
        2)
            read -p "Enter the new user's name: " user_name
            read -p "Enter the group for the user: " group_name
            read -p "Enter a description for the user: " description
            read -p "Enter the home directory for the user: " home_directory
            read -p "Enter the shell for the user (e.g., /bin/bash): " user_shell
            read -p "Enter the user permission (e.g., 7 for full permission): " user_perm
            read -p "Enter the group permission (e.g., 5 for read/execute): " group_perm
            read -p "Enter the others permission (e.g., 0 for no permission): " others_perm
            newuser "$user_name" "$group_name" "$description" "$home_directory" "$user_shell" "$user_perm" "$group_perm" "$others_perm"
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
