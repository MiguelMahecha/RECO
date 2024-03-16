#!/bin/sh

start_dir="$1"
file_num="$2"
max_size="$3"

find "$start_dir" -type f -size "-${max_size}c" -print0 | xargs -O ls -lS | head -n "$file_num | awk '{print $5, $9}'