update_progress_bar() {
    # Print updating progress bar
        printf "\r[${progress}"
        for ((i = total_tests + 1; i <= ${#input_files[@]}; i++)); do
            printf "${WHITE}-"
        done
        printf "${NC}] $passed_tests/${#input_files[@]} tests passed"
}


test() {

    # Sets the main file if there is no argument
    if [ -z "$1" ]; then
        local java_file=$(basename "$(getMainFile)" .java)
    else
        local java_file=$(basename "$1" .java)
    fi

    #Exits if no file found
    if [ -z "$java_file" ]; then
        echo "No main file found, please add the name of your main file as an argument."
        exit 1
    fi


    
    local total_tests=0
    local passed_tests=0
    local progress=""

    fetch "$java_file"

    # Colors
    GREEN='\033[0;32m'
    RED='\033[0;31m'
    WHITE='\033[0;37m'
    NC='\033[0m' # No Color

    # Compile the java files with the main files last

    for file in *.java; do
        if [[ $file != $java_file.java ]]; then
            javac "$file"
        fi
    done

    javac "$java_file.java"

    # Check if compilation was successful
    if [ $? -ne 0 ]; then
        echo -e "${RED}Compilation failed. Exiting.${NC}"
        exit 1
    fi

    # Get a list of input files
    local input_files=(*.in)

    # Variable to track whether there are mismatches
    local mismatch_found=false

    printf "test_passed=" > gettis.out

    # Loop through each input file
    for input_file in "${input_files[@]}"; do
        # Increment total tests
        ((total_tests++))

        # Form the output file name based on the input file
        local output_file="${input_file%.in}.ans"

        # Execute the compiled Java program with the current input file
        local java_output=$(java "$java_file" <"$input_file")

        # Get the expected output
        local expected_output=$(cat "$output_file")

        # Compare the generated output with the expected output
        if [ "$java_output" != "$expected_output" ]; then
            printf "\n"
            echo "------------------------------------------------------"
            echo -e "${RED}Mismatch found for input file: $input_file${NC}"
            echo -e "${RED}  Outcome:${NC}"
            echo -e "${RED}  $java_output${NC}" | sed 's/^/  /' # Add two spaces of indentation to each line
            echo -e "${RED}  Expected:${NC}"
            echo -e "${RED}$expected_output${NC}" | sed 's/^/  /' # Add two spaces of indentation to each line
            printf "\n"
            echo "------------------------------------------------------"
            mismatch_found=true
            progress+="${RED}X"
        else
            ((passed_tests++))
            progress+="${GREEN}#"
        fi

        update_progress_bar "$passed_tests" "$total_tests" "$progress"
        

    done

    # Clean up compiled class files
    rm -f "$java_file.class"

    # Print a message if everything is correct
    if [ "$mismatch_found" = false ]; then
        printf "\n"
        echo "---------------------------------"
        echo -e "${GREEN}All tests passed${NC}"
        echo "---------------------------------"
        printf "true" >> gettis.out
    else
        printf "\n"
        printf "false" >> gettis.out
    fi
    
}
