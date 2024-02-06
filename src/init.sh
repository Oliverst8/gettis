function init() {

    # Extract Java file name without extension
    kattis_ID=$(basename "$1" .java)

    if [ "$#" -ne 1 ]; then
        echo "Usage: ${kattis_ID} <KattisProblemId>"
        exit 1
    fi
    if [ -d "./$1" ]; then
        echo -n "Do you want to overwrite the current ${kattis_ID} directory? [y/N] "
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
            rm -r "./${kattis_ID}"
            mkdir "./${kattis_ID}"
        else
            echo "Could not initialize."
            exit
        fi
    else
        mkdir "./${kattis_ID}"
    fi
    cd "./$kattis_ID"
    fetch "$kattis_ID"
    echo "import java.util.Scanner;

public class ${kattis_ID} {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
    }
}" > "${kattis_ID}.java"

}
#End of function