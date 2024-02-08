
submit(){

        if [ -z "$1" ]; then
        local java_file=$(getMainFile)
    else
        local java_file=$1
    fi

    python3 ~/bin/gettisSYS/submit.py $java_file
}

