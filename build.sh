#!/bin/bash

# Function to check if build directory exists and create it if not
check_and_create_build_directory() {
    if [ -d ./build ]; then
        echo "build directory already exists."
    else
        echo "Creating /build directory..."
        mkdir ./build
    fi
}

# Function to extract functions from shell script files in the src directory
extract_lines_from_files() {
    for file in src/*.sh; do
        if [[ $file != "src/gettis.sh" ]]; then
            while IFS= read -r line; do
                echo "$line"
            done < "$file"
        fi
    done
    while IFS= read -r line; do
        echo "$line"
    done < "src/gettis.sh"
}

# Call the function to check and create build directory
check_and_create_build_directory

# Prepend functions to the gettis script
echo "creating build"
extract_lines_from_files > build/gettis
chmod +x ./build/gettis
