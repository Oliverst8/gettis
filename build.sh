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
extract_functions_from_files() {
    local all_functions=""
    for file in src/*.sh; do
        if [[ $file != "src/gettis.sh" ]]; then
            local inside_function=false
            while IFS= read -r line; do
                if [[ $line == function* ]]; then
                    inside_function=true
                fi
                if $inside_function; then
                    all_functions+="$line\n"
                fi
                if [[ $line == "}" ]]; then
                    inside_function=false
                    echo "Found function: end"
                fi
            done < "$file"
        fi
    done
    echo "$all_functions"
}

# Call the function to check and create build directory
check_and_create_build_directory

# Extract functions from shell script files
all_functions=$(extract_functions_from_files)

# Prepend functions to the gettis script
echo "creating build"
echo -e "#!/bin/bash\n$all_functions\n$(cat src/gettis.sh)" > ./build/gettis
chmod +x ./build/gettis
