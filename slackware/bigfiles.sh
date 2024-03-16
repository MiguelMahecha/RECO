#!/bin/sh

start_dir="$1"
file_num="$2"
max_size="$3"

find "$start_dir" -type f -size "-${max_size}c" -printf "%s\t%p\n" | sort -n | head -n "$file_num" | while read -r size path; do
                                                                                                        echo "$(basename "$path") | $path | $size bytes"c