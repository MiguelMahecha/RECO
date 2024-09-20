#!/bin/bash

# Strict error handling
set -euo pipefail

# Logging function
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1"
}

# Error handling
error_exit() {
    log "ERROR: $1"
    exit 1
}

# Function to create a backup safely
backup_file() {
    local file_path=$1
    if [ -e "$file_path" ]; then
        local backup_path="${file_path}.bak"
        log "Backing up $file_path to $backup_path"
        cp -f "$file_path" "$backup_path" || error_exit "Failed to backup $file_path"
    fi
}

# Function to safely create symbolic links
create_symlink() {
    local target=$1
    local link_name=$2

    if [ -L "$link_name" ]; then
        log "Removing existing symlink: $link_name"
        rm -f "$link_name" || error_exit "Failed to remove existing symlink $link_name"
    elif [ -e "$link_name" ]; then
        log "ERROR: $link_name already exists and is not a symlink."
        error_exit "$link_name exists and is not a symlink"
    fi

    log "Creating symlink: $link_name -> $target"
    ln -s "$target" "$link_name" || error_exit "Failed to create symlink $link_name"
}

# Function to move directories with backup
move_directory() {
    local dir_path=$1
    if [ -d "$dir_path" ]; then
        local backup_path="${dir_path}.bak"
        log "Backing up directory $dir_path to $backup_path"
        mv "$dir_path" "$backup_path" || error_exit "Failed to backup directory $dir_path"
    fi
}

# Setup Samba configuration
setup_samba() {
    log "Setting up Samba"
    backup_file "/etc/samba/smb.conf"
    create_symlink "./samba/smb.conf" "/etc/samba/smb.conf"
}

# Setup BIND configuration
setup_bind() {
    log "Setting up BIND"
    backup_file "/etc/named.conf"

    if [ -d "/etc/dns" ]; then
        move_directory "/etc/dns"
    fi

    create_symlink "./bind/named.conf" "/etc/named.conf"
    create_symlink "./bind/dns" "/etc/dns"
}

# Setup shells
setup_shells() {
    log "Setting up shells"
    move_directory "/shells"
    create_symlink "./shells" "/shells"
}

# Run setup functions
setup_samba
setup_bind
setup_shells

log "Setup completed successfully"
