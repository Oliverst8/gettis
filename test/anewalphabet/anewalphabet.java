import java.util.Scanner;
import java.util.HashMap;

public class anewalphabet {
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
	HashMap<String, String> dictionary = new HashMap<>();
	dictionary.put("a", "@");
	dictionary.put("b", "8");
	dictionary.put("c", "(");
	dictionary.put("d", "|)");
	dictionary.put("e", "3");
	dictionary.put("f", "#");
	dictionary.put("g", "6");
	dictionary.put("h", "[-]");
	dictionary.put("i", "|");
	dictionary.put("j", "_|");
	dictionary.put("k", "|<");
	dictionary.put("l", "1");
	dictionary.put("m", "[]\\/[]");
	dictionary.put("n", "[]\\[]");
	dictionary.put("o", "0");
	dictionary.put("p", "|D");
	dictionary.put("q", "(,)");
	dictionary.put("r", "|Z");
	dictionary.put("s", "$");
	dictionary.put("t", "']['");
	dictionary.put("u", "|_|");
	dictionary.put("v", "\\/");
	dictionary.put("w", "\\/\\/");
	dictionary.put("x", "}{");
	dictionary.put("y", "`/");
	dictionary.put("z", "2");
	String input = scanner.nextLine().toLowerCase();
	StringBuilder builder = new StringBuilder();
	for(int i = 0; i < input.length(); i++){
		builder.append(dictionary.getOrDefault(String.valueOf(input.charAt(i)),String.valueOf(input.charAt(i))));
	}
	System.out.println(builder.toString());
		
    }
}
