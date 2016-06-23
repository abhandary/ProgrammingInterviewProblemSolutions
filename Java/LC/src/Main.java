


public class Main {
	
	// 345. Reverse vowels in a string
	boolean isVowel(char c) 
	{
		String vowelStr = "aeiouAEIOU";
		return vowelStr.indexOf(c) >= 0;
	}
	
	public String reverseVowels(String s) {
        
        char[] result = s.toCharArray();
        int left = 0;
        int right = s.length() - 1;
        while (left < right) {
        	if (!isVowel(result[left])) {
        		left++; continue;
        	}
        	if (!isVowel(result[right])) {
        		right--; continue;
        	}
        	char temp = result[left];
        	result[left] = result[right];
        	result[right] = temp;
        	left++; right--;
        }
        return new String(result);
    }
	
	// 344. Reverse a String
	public String reverseString(String s) {
		char[] result = s.toCharArray();
		int left = 0;
		int right = s.length() - 1;
		while (left < right) {
			char temp = result[left];
			result[left] = result[right];
			result[right] = temp;
			left++; right--;
		}
		return new String(result);
	}
	
	public static void main(String[] args)
	{
		Main m = new Main();
	    System.out.println("Test is a test");
	    System.out.println(m.reverseString("afadfasdfaeefqt4"));
	}
}
