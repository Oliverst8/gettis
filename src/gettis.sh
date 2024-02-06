#!/bin/bash

# Colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if the correct number of arguments is provided
if [ "$#" -ne 1 ]; then
	echo "Usage: $0 <JavaFileName>"
	exit 1
fi

# Extract Java file name without extension
java_file=$(basename "$1" .java)

# Check if test files exist, and download them if not
if [ ! "$(ls *.in 2>/dev/null)" ] || [ ! "$(ls *.ans 2>/dev/null)" ]; then
	echo "Downloading test files..."
	curl -O "https://open.kattis.com/problems/${java_file}/file/statement/samples.zip"
	echo "Test files downloaded to 'samples.zip'"
	unzip -q samples.zip
	rm samples.zip
fi

# Compile the Java file
javac "$1"

# Check if compilation was successful
if [ $? -ne 0 ]; then
	echo -e "${RED}Compilation failed. Exiting.${NC}"
	exit 1
fi

# Get a list of input files
input_files=(*.in)

# Variable to track whether there are mismatches
mismatch_found=false

# Loop through each input file
for input_file in "${input_files[@]}"; do
	# Form the output file name based on the input file
	output_file="${input_file%.in}.ans"

	# Execute the compiled Java program with the current input file
	java_output=$(java "$java_file" <"$input_file")

	# Get the expected output
	expected_output=$(cat "$output_file")

	# Compare the generated output with the expected output
	if [ "$java_output" != "$expected_output" ]; then
		if [ "$mismatch_found" = false ]; then
			echo "------------------------------------------------------"
		fi
		echo -e "${RED}Mismatch found for input file: $input_file${NC}"
		echo -e "${RED}  Outcome:${NC}"
		echo -e "${RED}$java_output${NC}" | sed 's/^/  /' # Add two spaces of indentation to each line
		echo -e "${RED}  Expected:${NC}"
		echo -e "${RED}$expected_output${NC}" | sed 's/^/  /' # Add two spaces of indentation to each line
		echo "------------------------------------------------------"
		mismatch_found=true
	fi
done

# Clean up compiled class files
rm -f "$java_file.class"

# Print a message if everything is correct
if [ "$mismatch_found" = false ]; then
	echo "---------------------------------"
	echo -e "${GREEN}All tests passed${NC}"
	echo "---------------------------------"
fi
