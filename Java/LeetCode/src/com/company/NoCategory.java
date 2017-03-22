package com.company;

import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/8/17.
 */
public class NoCategory {



    // 412. Fizz Buzz
    // Time: O(n), Space: O(c) outside of the result, O(n) for the result
    // https://leetcode.com/problems/fizz-buzz/?tab=Description
    public List<String> fizzBuzz(int n) {

        List<String> result = new ArrayList<>();
        for (int ix = 1; ix <=n; ix++) {
            if (ix % 15 == 0) {
                result.add("FizzBuzz");
            } else if (ix % 3 == 0) {
                result.add("Fizz");
            } else if (ix % 5 == 0) {
                result.add("Buzz");
            } else {
                result.add("" + ix);
            }
        }
        return result;
    }

    // 387. First Unique Character in a String
    // Time: O(n), Space: O(n)
    // https://leetcode.com/problems/first-unique-character-in-a-string/?tab=Description
    public int firstUniqChar(String s) {
        if (s.length() == 0) { return -1; }
        HashMap<Character, Integer> hm = new HashMap<>();
        HashSet<Character> set = new HashSet<>();
        char[] chars = s.toCharArray();
        for (int ix = 0; ix < chars.length; ix++) {
            if (!set.contains(chars[ix])) {
                hm.put(chars[ix], ix);
                set.add(chars[ix]);
            } else {
                hm.remove(chars[ix]);
            }
        }
        if (hm.size() == 0) { return -1; }
        int min = Integer.MAX_VALUE;
        for (int ix : hm.values()) {
            min = Math.min(min, ix);
        }
        return min;
    }

    public int firstUniqChar2(String s) {
        int freq [] = new int[26];
        for(int i = 0; i < s.length(); i ++)
            freq [s.charAt(i) - 'a'] ++;
        for(int i = 0; i < s.length(); i ++)
            if(freq [s.charAt(i) - 'a'] == 1)
                return i;
        return -1;
    }
}
