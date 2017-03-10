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

    // 3. Longest Substring Without Repeating Characters
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/longest-substring-without-repeating-characters/?tab=Description
    public int lengthOfLongestSubstring(String s) {
        HashMap<Character, Integer> hm = new HashMap<>();
        char[] schars = s.toCharArray();
        int start = 0;
        int val = 0;
        int max = 0;
        for (int ix = 0; ix < schars.length; ix++) {
            if (hm.get(schars[ix]) != null && hm.get(schars[ix]) > start) {
                start = hm.get(schars[ix]) + 1;
            }
            // max = Math.max(max, ix - start + 1);
            hm.put(schars[ix], ix);
        }
        return max;
    }
}
