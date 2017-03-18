package com.company;

import java.util.*;
import java.util.stream.Stream;
import java.lang.Math;

/**
 * Created by akshayb on 2/21/17.
 */
public class Hashtables {

    // LC: 535. Encode and Decode TinyURL
    // TinyURL is a URL shortening service where you enter a URL such as https://leetcode.com/problems/design-tinyurl
    // and it returns a short URL such as http://tinyurl.com/4e9iAk.
    // Design the encode and decode methods for the TinyURL service. There is no restriction on how your encode/decode
    // algorithm should work. You just need to ensure that a URL can be encoded to a tiny URL and the tiny URL can be
    // decoded to the original URL.
    // Subscribe to see which companies asked this question.
    // https://discuss.leetcode.com/topic/81637/two-solutions-and-thoughts
    public class Codec {
        List<String> urls = new ArrayList<String>();
        // Encodes a URL to a shortened URL.
        public String encode(String longUrl) {
            urls.add(longUrl);
            return String.valueOf(urls.size()-1);
        }

        // Decodes a shortened URL to its original URL.
        public String decode(String shortUrl) {
            int index = Integer.valueOf(shortUrl);
            return (index<urls.size())?urls.get(index):"";
        }
    }

    // LC: 525. Contiguous Array
    // Given a binary array, find the maximum length of a contiguous subarray with equal number of 0 and 1.
    // https://discuss.leetcode.com/topic/79977/python-and-java-with-little-tricks-incl-a-oneliner/2
    public int findMaxLength(int[] nums) {
        Map<Integer, Integer> index = new HashMap<>();
        index.put(0, -1);
        int balance = 0, maxlen = 0;
        for (int i = 0; i < nums.length; i++) {
            balance += nums[i] * 2 - 1;
            Integer first = index.putIfAbsent(balance, i);
            if (first != null)
                maxlen = Math.max(maxlen, i - first);
        }
        return maxlen;
    }

    // LC: 500. Keyboard Row
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

    // LC: 508. Most Frequent Subtree Sum
    // Given the root of a tree, you are asked to find the most frequent subtree sum. The subtree sum of a node is
    // defined as the sum of all the node values formed by the subtree rooted at that node (including the node itself).
    // So what is the most frequent subtree sum value? If there is a tie, return all the values with the highest
    // frequency in any order.
    // https://discuss.leetcode.com/topic/77775/verbose-java-solution-postorder-traverse-hashmap-18ms
    Map<Integer, Integer> sumToCount;
    int maxCount;

    public int[] findFrequentTreeSum(TreeNode root) {
        maxCount = 0;
        sumToCount = new HashMap<Integer, Integer>();

        postOrder(root);

        List<Integer> res = new ArrayList<>();
        for (int key : sumToCount.keySet()) {
            if (sumToCount.get(key) == maxCount) {
                res.add(key);
            }
        }

        int[] result = new int[res.size()];
        for (int i = 0; i < res.size(); i++) {
            result[i] = res.get(i);
        }
        return result;
    }

    private int postOrder(TreeNode root) {
        if (root == null) return 0;

        int left = postOrder(root.left);
        int right = postOrder(root.right);

        int sum = left + right + root.val;
        int count = sumToCount.getOrDefault(sum, 0) + 1;
        sumToCount.put(sum, count);

        maxCount = Math.max(maxCount, count);

        return sum;
    }

    // LC: 463. Island Perimeter
    // You are given a map in form of a two-dimensional integer grid where 1 represents land and 0 represents water.
    // Grid cells are connected horizontally/vertically (not diagonally). The grid is completely surrounded by water,
    // and there is exactly one island (i.e., one or more connected land cells). The island doesn't have "lakes"
    // (water inside that isn't connected to the water around the island). One cell is a square with side length 1.
    // The grid is rectangular, width and height don't exceed 100. Determine the perimeter of the island.
    // https://discuss.leetcode.com/topic/68786/clear-and-easy-java-solution/2
    public int islandPerimeter(int[][] grid) {
        int islands = 0, neighbours = 0;

        for (int i = 0; i < grid.length; i++) {
            for (int j = 0; j < grid[i].length; j++) {
                if (grid[i][j] == 1) {
                    islands++; // count islands
                    if (i < grid.length - 1 && grid[i + 1][j] == 1) neighbours++; // count down neighbours
                    if (j < grid[i].length - 1 && grid[i][j + 1] == 1) neighbours++; // count right neighbours
                }
            }
        }

        return islands * 4 - neighbours * 2;
    }

    // LC: 454. 4Sum II
    // Given four lists A, B, C, D of integer values, compute how many tuples (i, j, k, l) there are such that
    // A[i] + B[j] + C[k] + D[l] is zero.
    // To make problem a bit easier, all A, B, C, D have same length of N where 0 ≤ N ≤ 500. All integers are in the
    // range of -228 to 228 - 1 and the result is guaranteed to be at most 231 - 1.
    // Time:  O(n^2), Space: O(n^2)
    public int fourSumCount(int[] A, int[] B, int[] C, int[] D) {
        Map<Integer, Integer> map = new HashMap<>();

        for(int i=0; i<C.length; i++) {
            for(int j=0; j<D.length; j++) {
                int sum = C[i] + D[j];
                map.put(sum, map.getOrDefault(sum, 0) + 1);
            }
        }

        int res=0;
        for(int i=0; i<A.length; i++) {
            for(int j=0; j<B.length; j++) {
                res += map.getOrDefault(-1 * (A[i]+B[j]), 0);
            }
        }

        return res;
    }

    // LC: 451. Sort Characters By Frequency
    // Given a string, sort it in decreasing order based on the frequency of characters.
    // https://discuss.leetcode.com/topic/65947/o-n-easy-to-understand-java-solution
    public String frequencySort(String s) {
        if (s == null) {
            return null;
        }
        Map<Character, Integer> map = new HashMap();
        char[] charArray = s.toCharArray();
        int max = 0;
        for (Character c : charArray) {
            if (!map.containsKey(c)) {
                map.put(c, 0);
            }
            map.put(c, map.get(c) + 1);
            max = Math.max(max, map.get(c));
        }

        List<Character>[] array = buildArray(map, max);

        return buildString(array);
    }

    private List<Character>[] buildArray(Map<Character, Integer> map, int maxCount) {
        List<Character>[] array = new List[maxCount + 1];
        for (Character c : map.keySet()) {
            int count = map.get(c);
            if (array[count] == null) {
                array[count] = new ArrayList();
            }
            array[count].add(c);
        }
        return array;
    }

    private String buildString(List<Character>[] array) {
        StringBuilder sb = new StringBuilder();
        for (int i = array.length - 1; i > 0; i--) {
            List<Character> list = array[i];
            if (list != null) {
                for (Character c : list) {
                    for (int j = 0; j < i; j++) {
                        sb.append(c);
                    }
                }
            }
        }
        return sb.toString();
    }

    // LC: 447. Number of Boomerangs
    // Given n points in the plane that are all pairwise distinct, a "boomerang" is a tuple of points (i, j, k) such
    // that the distance between i and j equals the distance between i and k (the order of the tuple matters).
    // Find the number of boomerangs. You may assume that n will be at most 500 and coordinates of points are all in
    // the range [-10000, 10000] (inclusive).
    // https://discuss.leetcode.com/topic/66587/clean-java-solution-o-n-2-166ms
    // Time:  O(n^2), Space: O(n)
    public int numberOfBoomerangs(int[][] points) {
        int res = 0;

        Map<Integer, Integer> map = new HashMap<>();
        for(int i=0; i<points.length; i++) {
            for(int j=0; j<points.length; j++) {
                if(i == j)
                    continue;

                int d = getDistance(points[i], points[j]);
                map.put(d, map.getOrDefault(d, 0) + 1);
            }

            for(int val : map.values()) {
                res += val * (val-1);
            }
            map.clear();
        }

        return res;
    }

    private int getDistance(int[] a, int[] b) {
        int dx = a[0] - b[0];
        int dy = a[1] - b[1];

        return dx*dx + dy*dy;
    }

    // LC: 438. Find All Anagrams in a String
    // Given a string s and a non-empty string p, find all the start indices of p's anagrams in s.
    // Strings consists of lowercase English letters only and the length of both strings s and p will not be larger than 20,100.
    // The order of output does not matter.
    // https://discuss.leetcode.com/topic/64434/shortest-concise-java-o-n-sliding-window-solution
    public List<Integer> findAnagrams(String s, String p) {
        List<Integer> list = new ArrayList<>();
        if (s == null || s.length() == 0 || p == null || p.length() == 0) return list;
        int[] hash = new int[256]; //character hash
        //record each character in p to hash
        for (char c : p.toCharArray()) {
            hash[c]++;
        }
        //two points, initialize count to p's length
        int left = 0, right = 0, count = p.length();
        while (right < s.length()) {
            //move right everytime, if the character exists in p's hash, decrease the count
            //current hash value >= 1 means the character is existing in p
            if (hash[s.charAt(right++)]-- >= 1) count--;

            //when the count is down to 0, means we found the right anagram
            //then add window's left to result list
            if (count == 0) list.add(left);

            //if we find the window's size equals to p, then we have to move left (narrow the window) to find the new match window
            //++ to reset the hash because we kicked out the left
            //only increase the count if the character is in p
            //the count >= 0 indicate it was original in the hash, cuz it won't go below 0
            if (right - left == p.length() && hash[s.charAt(left++)]++ >= 0) count++;
        }
        return list;
    }

    // LC: 409. Longest Palindrome
    // Given a string which consists of lowercase or uppercase letters, find the length of the longest palindromes that can be built with those letters.
    // This is case sensitive, for example "Aa" is not considered a palindrome here.
    // Note: Assume the length of given string will not exceed 1,010.
    // https://discuss.leetcode.com/topic/61300/simple-hashset-solution-java/2
    public int longestPalindrome(String s) {
        if(s==null || s.length()==0) return 0;
        HashSet<Character> hs = new HashSet<Character>();
        int count = 0;
        for(int i=0; i<s.length(); i++){
            if(hs.contains(s.charAt(i))){
                hs.remove(s.charAt(i));
                count++;
            }else{
                hs.add(s.charAt(i));
            }
        }
        if(!hs.isEmpty()) return count*2+1;
        return count*2;
    }

    // LC: 389. Find the Difference
    // Given two strings s and t which consist of only lowercase letters.
    // String t is generated by random shuffling string s and then add one more letter at a random position.
    // Find the letter that was added in t.
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/55912/java-solution-using-bit-manipulation
    // @also Bits
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

    // LC: 381. Insert Delete GetRandom O(1) - Duplicates allowed
    // In it's own file

    // LC: 380. Insert Delete GetRandom O(1)
    // In it's own file

    // LC: 355. Design Twitter
    // @see Design

    // LC: 350. Intersection of Two Arrays II
    // Given two arrays, write a function to compute their intersection.
    // Example:
    // Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2, 2].
    // Time: O(m + n), Space: O(m + n)
    // https://discuss.leetcode.com/topic/45920/ac-solution-using-java-hashmap
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

    // LC: 349. Intersection of Two Arrays
    // Time: O(m + n), Space: O(m + n)
    // Given two arrays, write a function to compute their intersection.
    // Example:/
    // Given nums1 = [1, 2, 2, 1], nums2 = [2, 2], return [2].
    // https://discuss.leetcode.com/topic/45685/three-java-solutions
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

    // LC: 347. Top K Frequent Elements
    // Given a non-empty array of integers, return the k most frequent elements.
    // For example,
    // Given [1,1,1,2,2,3] and k = 2, return [1,2].
    // https://discuss.leetcode.com/topic/44237/java-o-n-solution-bucket-sort
    public List<Integer> topKFrequent(int[] nums, int k) {
        List<Integer>[] bucket = new List[nums.length + 1];
        Map<Integer, Integer> frequencyMap = new HashMap<Integer, Integer>();

        for (int n : nums) {
            frequencyMap.put(n, frequencyMap.getOrDefault(n, 0) + 1);
        }

        for (int key : frequencyMap.keySet()) {
            int frequency = frequencyMap.get(key);
            if (bucket[frequency] == null) {
                bucket[frequency] = new ArrayList<>();
            }
            bucket[frequency].add(key);
        }

        List<Integer> res = new ArrayList<>();

        for (int pos = bucket.length - 1; pos >= 0 && res.size() < k; pos--) {
            if (bucket[pos] != null) {
                res.addAll(bucket[pos]);
            }
        }
        return res;
    }

    // LC: 336. Palindrome Pairs
    // Given a list of unique words, find all pairs of distinct indices (i, j) in the given list, so that the
    // concatenation of the two words, i.e. words[i] + words[j] is a palindrome.
    // https://discuss.leetcode.com/topic/39585/o-n-k-2-java-solution-with-trie-structure-n-total-number-of-words-k-average-length-of-each-word/2
    class TrieNode {
        TrieNode[] next;
        int index;
        List<Integer> list;

        TrieNode() {
            next = new TrieNode[26];
            index = -1;
            list = new ArrayList<>();
        }
    }

    public List<List<Integer>> palindromePairs(String[] words) {
        List<List<Integer>> res = new ArrayList<>();

        TrieNode root = new TrieNode();
        for (int i = 0; i < words.length; i++) addWord(root, words[i], i);
        for (int i = 0; i < words.length; i++) search(words, i, root, res);

        return res;
    }

    private void addWord(TrieNode root, String word, int index) {
        for (int i = word.length() - 1; i >= 0; i--) {
            int j = word.charAt(i) - 'a';
            if (root.next[j] == null) root.next[j] = new TrieNode();
            if (isPalindrome(word, 0, i)) root.list.add(index);
            root = root.next[j];
        }

        root.list.add(index);
        root.index = index;
    }

    private void search(String[] words, int i, TrieNode root, List<List<Integer>> res) {
        for (int j = 0; j < words[i].length(); j++) {
            if (root.index >= 0 && root.index != i && isPalindrome(words[i], j, words[i].length() - 1)) {
                res.add(Arrays.asList(i, root.index));
            }

            root = root.next[words[i].charAt(j) - 'a'];
            if (root == null) return;
        }

        for (int j : root.list) {
            if (i == j) continue;
            res.add(Arrays.asList(i, j));
        }
    }

    private boolean isPalindrome(String word, int i, int j) {
        while (i < j) {
            if (word.charAt(i++) != word.charAt(j--)) return false;
        }

        return true;
    }

    // LC: 290. Word Pattern
    // Given a pattern and a string str, find if str follows the same pattern.
    // Here follow means a full match, such that there is a bijection between a letter in pattern and a non-empty word
    // in str.
    // Time: O(n), Space: O(n)
    public boolean wordPattern(String pattern, String str) {
        String[] words = str.split(" ");

        if (words.length != pattern.length()) { return false; }

        HashMap<Character, String> hm = new HashMap<>();
        HashMap<String, Character> reverse = new HashMap<>();

        int ix = 0;
        for (char c : pattern.toCharArray()) {
            if (hm.get(c) == null && reverse.get(words[ix]) == null) {
                hm.put(c, words[ix]);
                reverse.put(words[ix], c);
            }
            else if (hm.get(c) != null && reverse.get(words[ix]) != null) {
                if (!hm.get(c).equals(words[ix]) || reverse.get(words[ix]) != c) {
                    return false;
                }
            }
            else {
                return false;
            }
            ix += 1;
        }
        return true;
    }

    // LC: 299. Bulls and Cows
    // You are playing the following Bulls and Cows game with your friend: You write down a number and ask your friend
    // to guess what the number is. Each time your friend makes a guess, you provide a hint that indicates how many
    // digits in said guess match your secret number exactly in both digit and position (called "bulls") and how many
    // digits match the secret number but locate in the wrong position (called "cows"). Your friend will use successive
    // guesses and hints to eventually derive the secret number.
    // https://discuss.leetcode.com/topic/28463/one-pass-java-solution
    public String getHint(String secret, String guess) {
        int bulls = 0;
        int cows = 0;
        int[] numbers = new int[10];
        for (int i = 0; i<secret.length(); i++) {
            int s = Character.getNumericValue(secret.charAt(i));
            int g = Character.getNumericValue(guess.charAt(i));
            if (s == g) bulls++;
            else {
                if (numbers[s] < 0) cows++;
                if (numbers[g] > 0) cows++;
                numbers[s] ++;
                numbers[g] --;
            }
        }
        return bulls + "A" + cows + "B";
    }

    public boolean wordPattern2(String pattern, String str) {
        String[] words = str.split(" ");
        if (words.length != pattern.length())
            return false;
        Map index = new HashMap();
        for (Integer i=0; i<words.length; ++i)
            if (index.put(pattern.charAt(i), i) != index.put(words[i], i))
                return false;
        return true;
    }

    // LC: 274. H-Index
    // Given an array of citations (each citation is a non-negative integer) of a researcher, write a function to
    // compute the researcher's h-index.
    // According to the definition of h-index on Wikipedia: "A scientist has index h if h of his/her N papers have at
    // least h citations each, and the other N − h papers have no more than h citations each."
    // For example, given citations = [3, 0, 6, 1, 5], which means the researcher has 5 papers in total and each of
    // them had received 3, 0, 6, 1, 5 citations respectively. Since the researcher has 3 papers with at least 3
    // citations each and the remaining two with no more than 3 citations each, his h-index is 3.
    // Note: If there are several possible values for h, the maximum one is taken as the h-index.
    // https://discuss.leetcode.com/topic/23307/my-o-n-time-solution-use-java
    // https://discuss.leetcode.com/topic/23358/a-clean-o-n-solution-in-java/2
    public int hIndex(int[] citations) {
        int length = citations.length;
        if (length == 0) {
            return 0;
        }

        int[] array2 = new int[length + 1];
        for (int i = 0; i < length; i++) {
            if (citations[i] > length) {
                array2[length] += 1;
            } else {
                array2[citations[i]] += 1;
            }
        }
        int t = 0;
        int result = 0;

        for (int i = length; i >= 0; i--) {
            t = t + array2[i];
            if (t >= i) {
                return i;
            }
        }
        return 0;
    }

    // LC: 242. Valid Anagram
    // @see Sort

    // LC: 219. Contains Duplicate II
    // @see Arrays

    // LC: 217. Contains Duplicate
    // @see Arrays

    // LC: 205. Isomorphic Strings
    // Given two strings s and t, determine if they are isomorphic.
    // Two strings are isomorphic if the characters in s can be replaced to get t.
    // All occurrences of a character must be replaced with another character while preserving the order of characters.
    // No two characters may map to the same character but a character may map to itself.
    // Time: O(n), Space: O(n)
    // https://discuss.leetcode.com/topic/13001/short-java-solution-without-maps
    // https://discuss.leetcode.com/topic/14158/java-solution-using-hashmap
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


    // LC: 204. Count Primes
    // Count the number of prime numbers less than a non-negative number, n.
    // https://discuss.leetcode.com/topic/13654/my-simple-java-solution
    public int countPrimes(int n) {
        boolean[] notPrime = new boolean[n];
        int count = 0;
        for (int i = 2; i < n; i++) {
            if (notPrime[i] == false) {
                count++;
                for (int j = 2; i*j < n; j++) {
                    notPrime[i*j] = true;
                }
            }
        }

        return count;
    }

    // LC: 202. Happy Number
    // Write an algorithm to determine if a number is "happy".
    // A happy number is a number defined by the following process: Starting with any positive integer, replace the number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends in 1 are happy numbers.
    // Example: 19 is a happy number
    //  12 + 92 = 82
    //  82 + 22 = 68
    //  62 + 82 = 100
    //  12 + 02 + 02 = 1
    // https://discuss.leetcode.com/topic/25026/beat-90-fast-easy-understand-java-solution-with-brief-explanation
    public boolean isHappy(int n) {
        Set<Integer> inLoop = new HashSet<Integer>();
        int squareSum,remain;
        while (inLoop.add(n)) {
            squareSum = 0;
            while (n > 0) {
                remain = n%10;
                squareSum += remain*remain;
                n /= 10;
            }
            if (squareSum == 1)
                return true;
            else
                n = squareSum;

        }
        return false;

    }

    // LC: 187. Repeated DNA Sequences
    // All DNA is composed of a series of nucleotides abbreviated as A, C, G, and T, for example: "ACGAATTCCG".
    // When studying DNA, it is sometimes useful to identify repeated sequences within the DNA.
    // Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule.
    // https://discuss.leetcode.com/topic/8487/i-did-it-in-10-lines-of-c
    // https://discuss.leetcode.com/topic/8894/clean-java-solution-hashmap-bits-manipulation
    // https://discuss.leetcode.com/topic/27517/7-lines-simple-java-o-n/2
    public List<String> findRepeatedDnaSequences(String s) {
        Set<Integer> words = new HashSet<>();
        Set<Integer> doubleWords = new HashSet<>();
        List<String> rv = new ArrayList<>();
        char[] map = new char[26];
        //map['A' - 'A'] = 0;
        map['C' - 'A'] = 1;
        map['G' - 'A'] = 2;
        map['T' - 'A'] = 3;

        for(int i = 0; i < s.length() - 9; i++) {
            int v = 0;
            for(int j = i; j < i + 10; j++) {
                v <<= 2;
                v |= map[s.charAt(j) - 'A'];
            }
            if(!words.add(v) && doubleWords.add(v)) {
                rv.add(s.substring(i, i + 10));
            }
        }
        return rv;
    }

    public List<String> findRepeatedDnaSequences2(String s) {
        Set seen = new HashSet(), repeated = new HashSet();
        for (int i = 0; i + 9 < s.length(); i++) {
            String ten = s.substring(i, i + 10);
            if (!seen.add(ten))
                repeated.add(ten);
        }
        return new ArrayList(repeated);
    }



    // LC: 166. Fraction to Recurring Decimal
    // Given two integers representing the numerator and denominator of a fraction, return the fraction in string format.
    // If the fractional part is repeating, enclose the repeating part in parentheses.
    // https://discuss.leetcode.com/topic/7876/my-clean-java-solution
    public String fractionToDecimal(int numerator, int denominator) {
        if (numerator == 0) {
            return "0";
        }
        StringBuilder res = new StringBuilder();
        // "+" or "-"
        res.append(((numerator > 0) ^ (denominator > 0)) ? "-" : "");
        long num = Math.abs((long)numerator);
        long den = Math.abs((long)denominator);

        // integral part
        res.append(num / den);
        num %= den;
        if (num == 0) {
            return res.toString();
        }

        // fractional part
        res.append(".");
        HashMap<Long, Integer> map = new HashMap<Long, Integer>();
        map.put(num, res.length());
        while (num != 0) {
            num *= 10;
            res.append(num / den);
            num %= den;
            if (map.containsKey(num)) {
                int index = map.get(num);
                res.insert(index, "(");
                res.append(")");
                break;
            }
            else {
                map.put(num, res.length());
            }
        }
        return res.toString();

    }

    // LC: 149. Max Points on a Line
    // Given n points on a 2D plane, find the maximum number of points that lie on the same straight line.
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/2979/a-java-solution-with-notes
    // https://discuss.leetcode.com/topic/6028/sharing-my-simple-solution-with-explanation
    class Point {
        int x;
        int y;
        Point() { x = 0; y = 0; }
        Point(int a, int b) { x = a; y = b; }
    }
    public int maxPoints(Point[] points) {
        if (points==null) return 0;
        if (points.length<=2) return points.length;

        Map<Integer,Map<Integer,Integer>> map = new HashMap<Integer,Map<Integer,Integer>>();
        int result=0;
        for (int i=0;i<points.length;i++){
            map.clear();
            int overlap=0,max=0;
            for (int j=i+1;j<points.length;j++){
                int x=points[j].x-points[i].x;
                int y=points[j].y-points[i].y;
                if (x==0&&y==0){
                    overlap++;
                    continue;
                }
                int gcd=generateGCD(x,y);
                if (gcd!=0){
                    x/=gcd;
                    y/=gcd;
                }

                if (map.containsKey(x)){
                    if (map.get(x).containsKey(y)){
                        map.get(x).put(y, map.get(x).get(y)+1);
                    }else{
                        map.get(x).put(y, 1);
                    }
                }else{
                    Map<Integer,Integer> m = new HashMap<Integer,Integer>();
                    m.put(y, 1);
                    map.put(x, m);
                }
                max=Math.max(max, map.get(x).get(y));
            }
            result=Math.max(result, max+overlap+1);
        }
        return result;


    }
    private int generateGCD(int a,int b){

        if (b==0) return a;
        else return generateGCD(b,a%b);

    }

    // LC: 138. Copy List with Random Pointer
    // A linked list is given such that each node contains an additional random pointer which could point
    // to any node in the list or null.
    // https://discuss.leetcode.com/topic/7594/a-solution-with-constant-space-complexity-o-1-and-linear-time-complexity-o-n
    class RandomListNode {
        int label;
        RandomListNode next, random;
        RandomListNode(int x) { this.label = x; }
    };
    public RandomListNode copyRandomList(RandomListNode head) {
        RandomListNode iter = head, next;

        // First round: make copy of each node,
        // and link them together side-by-side in a single list.
        while (iter != null) {
            next = iter.next;

            RandomListNode copy = new RandomListNode(iter.label);
            iter.next = copy;
            copy.next = next;

            iter = next;
        }

        // Second round: assign random pointers for the copy nodes.
        iter = head;
        while (iter != null) {
            if (iter.random != null) {
                iter.next.random = iter.random.next;
            }
            iter = iter.next.next;
        }

        // Third round: restore the original list, and extract the copy list.
        iter = head;
        RandomListNode pseudoHead = new RandomListNode(0);
        RandomListNode copy, copyIter = pseudoHead;

        while (iter != null) {
            next = iter.next.next;

            // extract the copy
            copy = iter.next;
            copyIter.next = copy;
            copyIter = copy;

            // restore the original list
            iter.next = next;

            iter = next;
        }

        return pseudoHead.next;
    }

    // LC: 136. Single Number
    // @see Bits

    // LC: 94. Binary Tree Inorder Traversal
    // @see Stacks

    // LC: 85. Maximal Rectangle
    // @see Arrays


//    int maximalRectangle(vector<vector<char> > &matrix) {
//        if(matrix.empty()) return 0;
//    const int m = matrix.size();
//    const int n = matrix[0].size();
//        int left[n], right[n], height[n];
//        fill_n(left,n,0); fill_n(right,n,n); fill_n(height,n,0);
//        int maxA = 0;
//        for(int i=0; i<m; i++) {
//            int cur_left=0, cur_right=n;
//            for(int j=0; j<n; j++) { // compute height (can do this from either side)
//                if(matrix[i][j]=='1') height[j]++;
//                else height[j]=0;
//            }
//            for(int j=0; j<n; j++) { // compute left (from left to right)
//                if(matrix[i][j]=='1') left[j]=max(left[j],cur_left);
//                else {left[j]=0; cur_left=j+1;}
//            }
//            // compute right (from right to left)
//            for(int j=n-1; j>=0; j--) {
//                if(matrix[i][j]=='1') right[j]=min(right[j],cur_right);
//                else {right[j]=n; cur_right=j;}
//            }
//            // compute the area of rectangle (can do this from either side)
//            for(int j=0; j<n; j++)
//                maxA = max(maxA,(right[j]-left[j])*height[j]);
//        }
//        return maxA;
//    }


    // LC: 76. Minimum Window Substring
    // Given a string S and a string T, find the minimum window in S which will contain all the characters in T in complexity O(n).
    // For example,
    // S = "ADOBECODEBANC"  T = "ABC"
    // Minimum window is "BANC".
    // https://discuss.leetcode.com/topic/3107/accepted-o-n-solution/4
    // https://discuss.leetcode.com/topic/30941/here-is-a-10-line-template-that-can-solve-most-substring-problems
    public String minWindow(String S, String T) {

        if (S.length()==0||T.length()==0||S.length()<T.length()) return "";

        int left=T.length(),start=-1,end=S.length();

        Deque<Integer> queue= new LinkedList<Integer>();

        Map<Character,Integer> map= new HashMap<Character,Integer>();

        for (int i=0;i<T.length();i++){
            char c= T.charAt(i);
            map.put(c,map.containsKey(c)?map.get(c)+1:1);
        }

        for (int i =0;i<S.length();i++){
            char c= S.charAt(i);
            if (!map.containsKey(c))
                continue;

            int n = map.get(c);
            map.put(c,n-1);
            queue.add(i);
            if (n>0) left--;

            char head = S.charAt(queue.peek());
            while(map.get(head)<0){
                queue.poll();
                map.put(head,map.get(head)+1);
                head=S.charAt(queue.peek());
            }

            if (left==0){
                int new_length=queue.peekLast()-queue.peek()+1;
                if (new_length<end-start) {
                    start=queue.peek();
                    end=queue.peekLast()+1;
                }
            }
        }
        if (left==0)  return S.substring(start,end);
        else return "";
    }
//    string minWindow(string s, string t) {
//        vector<int> map(128,0);
//        for(auto c: t) map[c]++;
//        int counter=t.size(), begin=0, end=0, d=INT_MAX, head=0;
//        while(end<s.size()){
//            if(map[s[end++]]-->0) counter--; //in t
//            while(counter==0){ //valid
//                if(end-begin<d)  d=end-(head=begin);
//                if(map[s[begin++]]++==0) counter++;  //make it invalid
//            }
//        }
//        return d==INT_MAX? "":s.substr(head, d);
//    }

    // LC: 49. Group Anagrams
    // Time: O(n), space: O(n)
    // https://discuss.leetcode.com/topic/24494/share-my-short-java-solution
    public List<List<String>> groupAnagrams(String[] strs) {
        if (strs == null || strs.length == 0) return new ArrayList<List<String>>();
        Map<String, List<String>> map = new HashMap<String, List<String>>();
        Arrays.sort(strs);
        for (String s : strs) {
            char[] ca = s.toCharArray();
            Arrays.sort(ca);
            String keyStr = String.valueOf(ca);
            if (!map.containsKey(keyStr)) map.put(keyStr, new ArrayList<String>());
            map.get(keyStr).add(s);
        }
        return new ArrayList<List<String>>(map.values());
    }

    // LC: 37. Sudoku Solver
    // https://discuss.leetcode.com/topic/11327/straight-forward-java-solution-using-backtracking
    public void solveSudoku(char[][] board) {
        if(board == null || board.length == 0)
            return;
        solve(board);
    }

    public boolean solve(char[][] board){
        for(int i = 0; i < board.length; i++){
            for(int j = 0; j < board[0].length; j++){
                if(board[i][j] == '.'){
                    for(char c = '1'; c <= '9'; c++){//trial. Try 1 through 9
                        if(isValid(board, i, j, c)){
                            board[i][j] = c; //Put c for this cell

                            if(solve(board))
                                return true; //If it's the solution return true
                            else
                                board[i][j] = '.'; //Otherwise go back
                        }
                    }

                    return false;
                }
            }
        }
        return true;
    }

    private boolean isValid(char[][] board, int row, int col, char c){
        for(int i = 0; i < 9; i++) {
            if(board[i][col] != '.' && board[i][col] == c) return false; //check row
            if(board[row][i] != '.' && board[row][i] == c) return false; //check column
            if(board[3 * (row / 3) + i / 3][ 3 * (col / 3) + i % 3] != '.' &&
                    board[3 * (row / 3) + i / 3][3 * (col / 3) + i % 3] == c) return false; //check 3*3 block
        }
        return true;
    }

    // LC: 36. Valid Sudoku
    // https://discuss.leetcode.com/topic/9748/shared-my-concise-java-code
    public boolean isValidSudoku(char[][] board) {
        for(int i = 0; i<9; i++){
            HashSet<Character> rows = new HashSet<Character>();
            HashSet<Character> columns = new HashSet<Character>();
            HashSet<Character> cube = new HashSet<Character>();
            for (int j = 0; j < 9;j++){
                if(board[i][j]!='.' && !rows.add(board[i][j]))
                    return false;
                if(board[j][i]!='.' && !columns.add(board[j][i]))
                    return false;
                int RowIndex = 3*(i/3);
                int ColIndex = 3*(i%3);
                if(board[RowIndex + j/3][ColIndex + j%3]!='.' && !cube.add(board[RowIndex + j/3][ColIndex + j%3]))
                    return false;
            }
        }
        return true;
    }



    // LC: 30. Substring with Concatenation of All Words
    // You are given a string, s, and a list of words, words, that are all of the same length. Find all starting
    // indices of substring(s) in s that is a concatenation of each word in words exactly once and without any
    // intervening characters.
    // For example, given:
    // s: "barfoothefoobarman"
    // words: ["foo", "bar"]
    // You should return the indices: [0,9].
    // https://discuss.leetcode.com/topic/35676/accepted-java-solution-12ms-with-explanation/2
    public List<Integer> findSubstring(String s, String[] words) {
        int N = s.length();
        List<Integer> indexes = new ArrayList<Integer>(s.length());
        if (words.length == 0) {
            return indexes;
        }
        int M = words[0].length();
        if (N < M * words.length) {
            return indexes;
        }
        int last = N - M + 1;

        //map each string in words array to some index and compute target counters
        Map<String, Integer> mapping = new HashMap<String, Integer>(words.length);
        int [][] table = new int[2][words.length];
        int failures = 0, index = 0;
        for (int i = 0; i < words.length; ++i) {
            Integer mapped = mapping.get(words[i]);
            if (mapped == null) {
                ++failures;
                mapping.put(words[i], index);
                mapped = index++;
            }
            ++table[0][mapped];
        }

        //find all occurrences at string S and map them to their current integer, -1 means no such string is in words array
        int [] smapping = new int[last];
        for (int i = 0; i < last; ++i) {
            String section = s.substring(i, i + M);
            Integer mapped = mapping.get(section);
            if (mapped == null) {
                smapping[i] = -1;
            } else {
                smapping[i] = mapped;
            }
        }

        //fix the number of linear scans
        for (int i = 0; i < M; ++i) {
            //reset scan variables
            int currentFailures = failures; //number of current mismatches
            int left = i, right = i;
            Arrays.fill(table[1], 0);
            //here, simple solve the minimum-window-substring problem
            while (right < last) {
                while (currentFailures > 0 && right < last) {
                    int target = smapping[right];
                    if (target != -1 && ++table[1][target] == table[0][target]) {
                        --currentFailures;
                    }
                    right += M;
                }
                while (currentFailures == 0 && left < right) {
                    int target = smapping[left];
                    if (target != -1 && --table[1][target] == table[0][target] - 1) {
                        int length = right - left;
                        //instead of checking every window, we know exactly the length we want
                        if ((length / M) ==  words.length) {
                            indexes.add(left);
                        }
                        ++currentFailures;
                    }
                    left += M;
                }
            }

        }
        return indexes;
    }

    // LC: 18. 4Sum
    // https://discuss.leetcode.com/topic/12368/clean-accepted-java-o-n-3-solution-based-on-3sum
    public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length < 3) { return result; }
        Arrays.sort(nums);
        int n = nums.length;
        for (int ix = 0; ix < nums.length - 3; ix++) {
            if (ix > 0 && nums[ix] == nums[ix - 1]) continue;
            if (nums[ix] + nums[ix + 1] + nums[ix + 2] + nums[ix + 3] > target) break;
            if (nums[ix] + nums[n - 1] + nums[n - 2] + nums[n - 3] < target) continue;
            for (int jx = ix + 1; jx < nums.length - 2; jx++) {
                if (jx > ix + 1 && nums[jx] == nums[jx - 1]) continue;
                if (nums[ix] + nums[jx] + nums[jx + 1] + nums[jx + 2] > target) break;
                if (nums[ix] + nums[jx] + nums[n - 1] + nums[n - 2] < target) continue;
                int left = jx + 1;
                int right = n - 1;
                while (left < right) {
                    int sum = nums[ix] + nums[jx] + nums[left] + nums[right];
                    if (sum < target) {
                        left++;
                    } else if (sum > target) {
                        right--;
                    } else {
                        result.add(Arrays.asList(nums[ix], nums[jx], nums[left], nums[right]));
                        while (left < right && nums[left] == nums[left + 1]) { left++; }
                        while (left < right && nums[right] == nums[right - 1]) { right--;}
                        left++; right--;
                    }
                }
            }
        }
        return result;
    }

    // LC: 3. Longest Substring Without Repeating Characters
    // Time: O(n), Space: O(n)
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
            max = Math.max(max, ix - start + 1);
            hm.put(schars[ix], ix);
        }
        return max;
    }

    // https://discuss.leetcode.com/topic/8232/11-line-simple-java-solution-o-n-with-explanation
    public int lengthOfLongestSubstring2(String s) {
        if (s.length()==0) return 0;
        HashMap<Character, Integer> map = new HashMap<Character, Integer>();
        int max=0;
        for (int i=0, j=0; i<s.length(); ++i){
            if (map.containsKey(s.charAt(i))){
                j = Math.max(j,map.get(s.charAt(i))+1);
            }
            map.put(s.charAt(i),i);
            max = Math.max(max,i-j+1);
        }
        return max;
    }

    // LC: 1. Two Sum
    // Time: O(n), Space: O(n)
    // https://discuss.leetcode.com/topic/2447/accepted-java-o-n-solution/2
    public int[] twoSum(int[] numbers, int target) {
        int[] result = new int[2];
        Map<Integer, Integer> map = new HashMap<Integer, Integer>();
        for (int i = 0; i < numbers.length; i++) {
            if (map.containsKey(target - numbers[i])) {
                result[1] = i;
                result[0] = map.get(target - numbers[i]);
                return result;
            }
            map.put(numbers[i], i);
        }
        return result;
    }
}
