#!/bin/bash

# Usage: ./tree_limited.sh [directory]
# Default directory is current directory
DIR=${1:-.}

show_tree() {
    local dir="$1"
    local indent="$2"
    local limit=10
    local count=0

    echo "${indent}${dir##*/}/"

    # Get children
    local children=("$dir"/*)

    for item in "${children[@]}"; do
        count=$((count + 1))

        # If reached limit
        if (( count > limit )); then
            echo "${indent}  ... (more)"
            break
        fi

        if [ -d "$item" ]; then
            # directory
            show_tree "$item" "  $indent"
        else
            # file
            echo "  ${indent}${item##*/}"
        fi
    done
}

show_tree "$DIR" ""

