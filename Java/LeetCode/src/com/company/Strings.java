package com.company;

import java.util.*;

/**
 * Created by akshayb on 2/24/17.
 */
public class Strings {


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
}
