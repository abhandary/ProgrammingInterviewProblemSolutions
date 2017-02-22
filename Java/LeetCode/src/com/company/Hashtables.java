package com.company;

import java.util.*;
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

    // 350. Intersection of Two Arrays II
    // Time: O(m + n), Space: O(m + n)
    // https://leetcode.com/problems/intersection-of-two-arrays-ii/?tab=Description
    public int[] intersect(int[] nums1, int[] nums2) {
        HashMap<Integer, Integer> hm1 = new HashMap<>();
        HashMap<Integer, Integer> hm2 = new HashMap<>();

        for (int n : nums1) {
            if (hm1.get(n) == null) {
                hm1.put(n, 1);
            } else {
                hm1.put(n, hm1.get(n) + 1);
            }
        }
        for (int n : nums2) {
            if (hm2.get(n) == null) {
                hm2.put(n, 1);
            } else {
                hm2.put(n, hm2.get(n) + 1);
            }
        }
        ArrayList<Integer> list = new ArrayList<>();
        for (int key : hm1.keySet()) {
            if (hm1.get(key) != null && hm2.get(key) != null) {
                int min = Math.min(hm1.get(key), hm2.get(key));
                for (int ix = 0; ix < min; ix++) {
                    list.add(key);
                }
            }
        }
        int[] output = new int[list.size()];
        int ix = 0;
        for (int val : list) {
            output[ix++] = val;
        }
        return output;
    }

    // alt
    public int[] intersectAlt(int[] nums1, int[] nums2) {
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        ArrayList<Integer> result = new ArrayList<Integer>();
        for(int i = 0; i < nums1.length; i++)
        {
            if(map.containsKey(nums1[i])) map.put(nums1[i], map.get(nums1[i])+1);
            else map.put(nums1[i], 1);
        }

        for(int i = 0; i < nums2.length; i++)
        {
            if(map.containsKey(nums2[i]) && map.get(nums2[i]) > 0)
            {
                result.add(nums2[i]);
                map.put(nums2[i], map.get(nums2[i])-1);
            }
        }

        int[] r = new int[result.size()];
        for(int i = 0; i < result.size(); i++)
        {
            r[i] = result.get(i);
        }

        return r;
    }

    // 349. Intersection of Two Arrays
    // Time: O(m + n), Space: O(m + n)
    // https://leetcode.com/problems/intersection-of-two-arrays/?tab=Description
    public int[] intersection(int[] nums1, int[] nums2) {
        Set<Integer> s1 = new HashSet<Integer>();
        Set<Integer> s2 = new HashSet<Integer>();
        for (int n : nums1) {
            s1.add(n);
        }
        for (int n : nums2) {
            s2.add(n);
        }

        ArrayList<Integer> list = new ArrayList<>();
        for (int n2 : s2) {
            if (s1.contains(n2)) {
                list.add(n2);
            }
        }
        int[] output = new int[list.size()];
        for (int ix = 0; ix < list.size(); ix++) {
            output[ix] = list.get(ix).intValue();
        }
        return output;
    }

    // alt
    public int[] intersection2(int[] nums1, int[] nums2) {
        Set<Integer> set = new HashSet<>();
        Set<Integer> intersect = new HashSet<>();
        for (int i = 0; i < nums1.length; i++) {
            set.add(nums1[i]);
        }
        for (int i = 0; i < nums2.length; i++) {
            if (set.contains(nums2[i])) {
                intersect.add(nums2[i]);
            }
        }
        int[] result = new int[intersect.size()];
        int i = 0;
        for (Integer num : intersect) {
            result[i++] = num;
        }
        return result;
    }


    // 205. Isomorphic Strings
    // Time: O(n), Space: O(n)
    // https://leetcode.com/problems/isomorphic-strings/?tab=Description
    public boolean isIsomorphic(String s, String t) {
        if (s.length() != t.length()) { return false; };

        HashMap<Character, Character> hm1 = new HashMap<>();
        HashMap<Character, Character> hm2 = new HashMap<>();

        char[] schars = s.toCharArray();
        char[] tchars = t.toCharArray();
        for (int ix = 0; ix < schars.length; ix++) {
            if (hm1.get(schars[ix]) == null && hm2.get(tchars[ix]) == null) {
                hm1.put(schars[ix], tchars[ix]);
                hm2.put(tchars[ix], schars[ix]);
            }
            else if (hm1.get(schars[ix]) != null && hm2.get(tchars[ix]) != null) {
                if (hm1.get(schars[ix]) != tchars[ix] || hm2.get(tchars[ix]) != schars[ix]) {
                    return false;
                }
            } else {
                return false;
            }
        }
        return true;
    }
}
