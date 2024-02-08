getMainFile() {

  # Get a list of java files
    local input_files=(*.java)

    local name_of_directory=$(basename $PWD)

    for file in ${input_files[@]}; do
        if [[ $file == $name_of_directory* ]]; then
            echo $file
            return
        fi
    done
    echo ""
}
```