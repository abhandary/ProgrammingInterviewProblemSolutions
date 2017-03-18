package com.company;

import java.util.*;
import java.lang.*;

/**
 * Created by akshayb on 2/24/17.
 */
public class Strings {

    // 520. Detect Capital
    // Time: O(n), space:O(c)
    // https://leetcode.com/problems/detect-capital/?tab=Description
    public boolean detectCapitalUse(String word) {
        if (word.length() == 0) { return true; }
        char[] wchars = word.toCharArray();
        char first = wchars[0];
        boolean firstIsUpper = Character.isUpperCase(first);
        boolean hasLower = false;
        boolean needAllUpper = false;
        for (int ix = 1; ix < wchars.length; ix++) {
            if (Character.isUpperCase(wchars[ix])) {
                if (firstIsUpper && ix == 1) { needAllUpper = true; }
                if (!firstIsUpper || hasLower) { return false; }
            }
            if (!Character.isUpperCase(wchars[ix])) {
                hasLower = true;
                if (needAllUpper) { return false; }
            }
        }
        return true;
    }

    public boolean detectCapitalUseRegEx(String word) {
        return word.matches("[A-Z]+|[a-z]+|[A-Z][a-z]+");
    }

    public boolean detectCapitalUse3(String word) {
        int numUpper = 0;
        for (int i=0;i<word.length();i++) {
            if (Character.isUpperCase(word.charAt(i))) numUpper++;
        }
        if (numUpper == 1) return Character.isUpperCase(word.charAt(0));
        return numUpper == 0 || numUpper == word.length();
    }

    public boolean detectCapitalUse4(String word) {
        int cnt = 0;
        for(char c: word.toCharArray()) if('Z' - c >= 0) cnt++;
        return ((cnt==0 || cnt==word.length()) || (cnt==1 && 'Z' - word.charAt(0)>=0));
    }

    // 383. Ransom Note
    // Time: O(n), Space: O(k)
    // https://leetcode.com/problems/ransom-note/?tab=Description
    public boolean canConstruct(String ransomNote, String magazine) {
        HashMap<Character, Integer> hm = new HashMap<>();
        for (char c : ransomNote.toCharArray()) {
            if (hm.get(c) == null) {
                hm.put(c, 1);
            } else {
                hm.put(c, hm.get(c) + 1);
            }
        }
        for (char c : magazine.toCharArray()) {

            if (hm.get(c) != null) {
                int val = hm.get(c);
                val--;
                if (val == 0) {
                    hm.remove(c);
                }
            }
            if (hm.size() == 0) { break; }
        }
        return hm.size() == 0;
    }

    // 345. Reverse Vowels of a String
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/reverse-vowels-of-a-string/?tab=Description
    boolean isVowel(char c) {
        return "aeiou".indexOf(c) != -1;
    }

    public String reverseVowels(String s) {
        char[] chars = s.toCharArray();
        int ix = 0, jx = chars.length;
        while (ix < jx) {
            while (!isVowel(chars[ix]) && ix < jx) {
                ix++;
            }
            while (!isVowel(chars[jx]) && ix < jx) {
                jx--;
            }
            char temp = chars[ix];
            chars[ix] = chars[jx];
            chars[jx] = temp;
            ix++; jx--;
        }
        return new String(chars);
    }

    // 344. Reverse String
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/reverse-string/?tab=Description
    public String reverseString(String s) {

        char [] chars = s.toCharArray();
        int ix = 0, jx = chars.length;
        while (ix < jx) {
            char temp = chars[ix];
            chars[ix] = chars[jx];
            chars[jx] = temp;
            ix++; jx--;
        }
        return new String(chars);
    }

    // 125. Valid Palindrome
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/valid-palindrome/?tab=Description
    public boolean isPalindrome(String s) {

        int ix = 0;
        int jx = s.length() - 1;
        while (ix <= jx) {
            while (ix <= jx && !Character.isLetterOrDigit(s.charAt(ix))) { ix++; }
            while (ix <= jx && !Character.isLetterOrDigit(s.charAt(jx))) { jx--; }
            if (ix <= jx && Character.toLowerCase(s.charAt(ix++)) != Character.toLowerCase(s.charAt(jx--))) return false;
        }
        return true;
    }

    // 71. Simplify Path
    // Time: O(n)
    // https://leetcode.com/problems/simplify-path/?tab=Description
    public String simplifyPath(String path) {
        String[] tokens = path.split("/");
        if (tokens.length == 0) { return "/"; }
        Stack<String> stack = new Stack<>();
        for (int ix = 0; ix < tokens.length; ix++) {
            if (tokens[ix].length() == 0) continue;
            if (tokens[ix].equals(".")) continue;
            if (tokens[ix].equals("..")) { if (!stack.empty()) stack.pop(); }
            else {
                stack.push(tokens[ix]);
            }
        }
        if (stack.empty()) { return "/"; }
        StringBuilder result = new StringBuilder();
        while (!stack.empty()) {
            result.append(new StringBuilder(stack.pop()).reverse().toString());
            result.append("/");
        }
        return result.reverse().toString();
    }

    public String simplifyPath2(String path) {
        Deque<String> stack = new LinkedList<>();
        Set<String> skip = new HashSet<>(Arrays.asList("..",".",""));
        for (String dir : path.split("/")) {
            if (dir.equals("..") && !stack.isEmpty()) stack.pop();
            else if (!skip.contains(dir)) stack.push(dir);
        }
        String res = "";
        for (String dir : stack) res = "/" + dir + res;
        return res.isEmpty() ? "/" : res;
    }

    // 58. Length of Last Word
    // https://leetcode.com/problems/length-of-last-word/?tab=Description
    public int lengthOfLastWord(String s) {

        if (s.length() == 0) { return 0; }
        s = s.trim();
        char[] schars = s.toCharArray();
        if (s.indexOf(' ') == -1) { return schars.length; }

        int ix = 0;

        for (ix = schars.length - 1; ix >= 0; ix--) {
            if (schars[ix] == ' ') break;
        }
        return schars.length - ix - 1;
    }

    public int lengthOfLastWord2(String s) {

        if (s.length() == 0) { return 0; }

        char[] schars = s.toCharArray();

        int jx = schars.length - 1;

        int ix = 0;
        while (jx >= 0 && schars[jx] == ' ') { jx--; }

        for (ix = jx; ix >= 0; ix--) {
            if (schars[ix] == ' ') break;
        }
        return jx - ix;
    }

    // 38. Count and Say
    // Time: ??, space: ??
    // https://leetcode.com/problems/count-and-say/?tab=Description
    public String countAndSay(int n) {

        String result = "1";
        for (int ix = 1; ix < n; ix++) {
            StringBuilder sb = new StringBuilder();
            char[] rchars = result.toCharArray();
            int count = 1;
            int jx = 1;
            for (jx = 1; jx < rchars.length; jx++) {
                if (rchars[jx - 1] == rchars[jx]) {
                    count++;
                } else {
                    sb.append(count);
                    sb.append(rchars[jx - 1]);
                    count = 1;
                }
            }
            sb.append(count);
            sb.append(rchars[jx - 1]);
            result = sb.toString();
        }
        return result;
    }

    // 151. Reverse Words in a String
    // Time: O(n), space: O(c)
    // https://leetcode.com/problems/reverse-words-in-a-string/?tab=Description
    public String reverseWords(String s) {
        String[] parts = s.trim().split("\\s+");
        String out = "";
        for (int ix = parts.length - 1; ix > 0; ix--) {
            out += parts[ix] + " ";
        }
        out += parts[0];
        return out;
    }


    // 14. Longest Common Prefix
    // Time: O(longest string in strs), Space: O(c) outside of the result
    // https://leetcode.com/problems/longest-common-prefix/?tab=Description
    public String longestCommonPrefix(String[] strs) {
        String prefix = "";
        int jx = 0;
        char c = 0;
        if (strs.length == 0) { return prefix; }
        while (true) {
            int ix = 0;
            for (ix = 0; ix < strs.length; ix++) {
                if (jx >= strs[ix].length()) return prefix;
                if (ix == 0) { c = strs[ix].charAt(jx); }
                else if (c != strs[ix].charAt(jx)) break;
            }
            if (ix == strs.length) { prefix += c; }
            else return prefix;
            jx++;
        }
    }

    // 5. Longest Palindromic Substring
    // PRACTICE, VERIFY WITH TEST CASES
    // https://leetcode.com/problems/longest-palindromic-substring/?tab=Description
    int[] palindromeLength(char[] schars, int ix, int jx) {

        do {
            ix--; jx++;
        }while(ix >= 0 && jx < schars.length && schars[ix] == schars[jx]);

        return new int[]{ix + 1, jx - 1};
    }

    // "babad"

    public String longestPalindrome(String s) {
        char[] schars = s.toCharArray();
        int[] maxResult = new int[]{0, 0};
        int maxSoFar = 1;
        for (int ix = 0; ix < schars.length - 1; ix++) {
            int[] result = palindromeLength(schars, ix, ix);
            int len = result[1] - result[0] + 1;
            if (len > maxSoFar) {
                maxSoFar = len;
                maxResult = result;
            }
            if (schars[ix] != schars[ix + 1]) continue;
            result = palindromeLength(schars, ix, ix + 1);
            len = result[1] - result[0] + 1;
            if (len > maxSoFar) {
                maxSoFar = len;
                maxResult = result;
            }
        }
        return s.substring(maxResult[0], maxResult[1] + 1);
    }

    // LC: 3. Longest Substring Without Repeating Characters
    // @see Hashtables
}
