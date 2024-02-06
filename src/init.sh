function init() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: $1 <KattisProblemId>"
        exit 1
    fi
    if [ -d "./$1" ]; then
        echo -n "Do you want to overwrite the current $1 directory? [y/N] "
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
            rm -r "./$1"
            mkdir "./$1"
        else
            echo "Could not initialize."
            exit
        fi
    else
        mkdir "./$1"
    fi
    cd "./$1"
    fetch "$1"
    echo "import java.util.Scanner;

public class $1 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
    }
}" > "$1.java"

}
