#!/usr/bin/env bash

# Function to check the entered path
check_path() {
    local path="$1"

    if [ -f "$path" ]; then
        local lines
        lines=$(wc -l < "$path")
        echo "File found: $path"
        echo "Number of lines: $lines"

    elif [ -d "$path" ]; then
        echo "$path is a directory, not a regular file."

    else
        echo "Path not found: $path"
    fi
}

# Keep asking for a path
while true; do
    read -r -p "Enter a file path (or quit): " path

    if [ "$path" = "quit" ]; then
        echo "Goodbye!"
        break
    fi

    check_path "$path"
    echo
done
