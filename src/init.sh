function init() {
    if [ "$#" -ne 1 ]; then
        echo "Usage: $0 <KattisProblemId>"
        exit 1
    fi
    if [ -d "./$0" ]; then
        echo -n "Do you want to overwrite the current $0 directory? [y/N] "
        read answer
        if [ "$answer" != "${answer#[Yy]}" ] ;then
            rm -f "./$0"
        else
            echo "Could not initialize."
            exit
        fi
    fi
    cd "./$0"
    fetch "$0"
    echo "import java.util.Scanner;

public class $0 {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        
    }
}" > "$0.java"

}
