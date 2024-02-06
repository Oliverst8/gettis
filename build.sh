#!/bin/bash

if [ -d ./build ]; then
    echo "build directory already exists."
else
    echo "Creating /build directory..."
    mkdir ./build
fi

# Initialize an empty string to hold all function definitions
all_functions=""

# Iterate over all shell script files in the src directory
for file in src/*.sh; do
    # Skip the 'gettis' script
    if [[ $file != "src/gettis.sh" ]]; then
        # Set a flag to false indicating we're not inside a function
        inside_function=false

        # Read the file line by line
        while IFS= read -r line; do
            # If the line starts with 'function', set the flag to true
            if [[ $line == function* ]]; then
                inside_function=true
            fi

            # If we're inside a function, append the line to the functions string
            if $inside_function; then
                all_functions+="$line\n"
            fi

            # If the line is a '}', we've reached the end of a function
            if [[ $line == "}" ]]; then
                inside_function=false
            fi
        done < "$file"
    fi
done

# Prepend the function definitions to the 'gettis' script and write to a new file called 'gettis' in the current directory
echo "creating build"
echo -e "$all_functions$(cat src/gettis.sh)" > ./build/gettis
chmod +x ./build/gettis