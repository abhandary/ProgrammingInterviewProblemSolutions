package com.company;

import java.util.ArrayList;
import java.util.Hashtable;
import java.util.stream.Stream;

/**
 * Created by akshayb on 2/21/17.
 */
public class Hashtables {

    // 500. Keyboard Row
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/keyboard-row/?tab=Description
    public String[] findWords(String[] words) {
        String[] strs = {"qwertyuiop", "asdfghjkl", "zxcvbnm"};

        Hashtable<Character, Integer> ht = new Hashtable<>();

        for (int ix = 0; ix < strs.length; ix++) {
            for (char c : strs[ix].toCharArray()) {
                ht.put(c, ix);
            }
        }

        ArrayList<String> output = new ArrayList<>();
        for (String word : words) {
            if (word.length() == 0) { continue; }

            int row = ht.get(Character.toLowerCase(word.charAt(0)));

            for (char c : word.toLowerCase().toCharArray()) {
                if (ht.get(c) != row) {
                    row = -1;
                    break;
                }
            }
            if (row != -1) {
                output.add(word);
            }
        }

        return output.toArray(new String[output.size()]);
    }

    public String[] findWordsRegEx(String[] words) {
        return Stream.of(words).filter(s -> s.toLowerCase().matches("[qwertyuiop]*|[asdfghjkl]*|[zxcvbnm]*")).toArray(String[]::new);
    }

    // 389. Find the Difference
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/find-the-difference/?tab=Description
    public char findTheDifference(String s, String t) {
        char result = 0;
        Hashtable<Character, Integer> hs = new Hashtable<>();
        for (char c : s.toCharArray()) {
            if (hs.get(c) == null) {
                hs.put(c, 1);
            } else {
                hs.put(c, hs.get(c) + 1);
            }
        }
        for (char c : t.toCharArray()) {
            if (hs.get(c) == null) {
                return c;
            } else if (hs.get(c) == 1) {
                hs.remove(c);
            } else {
                hs.put(c, hs.get(c) - 1);
            }
        }
        return result;
    }

    // Time: O(n), Space: O(c)
    public char findTheDifferenceMath(String s, String t) {
        // Initialize variables to store sum of ASCII codes for
        // each string
        int charCodeS = 0, charCodeT = 0;
        // Iterate through both strings and char codes
        for (int i = 0; i < s.length(); ++i) charCodeS += (int)s.charAt(i);
        for (int i = 0; i < t.length(); ++i) charCodeT += (int)t.charAt(i);
        // Return the difference between 2 strings as char
        return (char)(charCodeT - charCodeS);
    }

    // Time: O(n), Space: O(c)
    public char findTheDifferenceBits(String s, String t) {
        char c = 0;
        for (int i = 0; i < s.length(); ++i) {
            c ^= s.charAt(i);
        }
        for (int i = 0; i < t.length(); ++i) {
            c ^= t.charAt(i);
        }
        return c;
    }


}
