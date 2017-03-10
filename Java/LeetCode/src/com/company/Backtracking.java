package com.company;

import java.lang.reflect.Array;
import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/2/17.
 */
public class Backtracking {


   // 79. Word Search
    // https://leetcode.com/problems/word-search/?tab=Description
    // Time: O(m * n), Space: O(k) for the recursion stack
    boolean visit(char[][] board, String word, int wx, int ix, int jx) {
        int[][] next = {{0, -1}, {0, 1}, {1, 0}, {-1, 0}};

        if (ix < 0 || ix >= board.length) { return  false; }
        if (jx < 0 || jx >= board[0].length) { return false; }

        char current = board[ix][jx];
        if (current == ' ') { return false; }
        if (current != word.charAt(wx)) { return false; }

        if (wx == word.length() - 1) { return true; }

        board[ix][jx] = ' ';
        for (int nx = 0; nx < next.length; nx++) {
            if (visit(board, word, wx + 1, ix + next[nx][0], jx + next[nx][1])) {
                return true;
            }
        }
        board[ix][jx] = current;
        return false;
    }

    public boolean exist(char[][] board, String word) {
        if (word.length() == 0) { return false; }
        for (int ix = 0; ix < board.length; ix++) {
            for (int jx = 0; jx < board[0].length; jx++) {
                char current = board[ix][jx];
                boolean exists = false;
                if (current == word.charAt(0)) {
                    exists = visit(board, word, 0, ix, jx);
                }
                if (exists == true) { return true; }
            }
        }
        return false;
    }

    // 78. Subsets
    // https://leetcode.com/problems/subsets/?tab=Description
    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length == 0) { return  result; }

        for (int ix = 0; ix < 1 << nums.length; ix++) {
            int bits = ix;
            List<Integer> set = new ArrayList<>();
            while (bits > 0) {
                int next = bits & ~(bits - 1);
                int val = (int) (Math.log(next)/Math.log(2));
                set.add(nums[val]);
                bits &= (bits - 1);
            }
            result.add(set);
        }

        return result;
    }

    // 77. Combinations
    // https://leetcode.com/problems/combinations/?tab=Description
    // Time: O(n C k), Space: O(k)
    private void combineHelper(int n, int k, int start, List<Integer> partial, List<List<Integer>> result) {
        if (partial.size() == k) {
            result.add(new ArrayList<Integer>(partial));
            return;
        }
        for (int ix = start; ix <= n; ix++) {

            partial.add(ix);
            combineHelper(n, k, ix + 1, partial, result);
            partial.remove(partial.size() - 1);
        }
    }

    public List<List<Integer>> combine(int n, int k) {
        List<List<Integer>> result = new ArrayList<>();

        combineHelper(n, k, 1, new ArrayList<Integer>(), result);
        return result;
    }

    // 47. Permutations II
    // Time:
    // https://leetcode.com/problems/permutations-ii/?tab=Description
    private void permuteUniqueHelper(int[] nums, List<Integer> partial, List<List<Integer>> result, boolean[] used) {
        if (partial.size() == nums.length) {
            result.add(new ArrayList<Integer>(partial));
            return;
        }
        for (int ix = 0; ix < nums.length; ix++) {
            if (used[ix] || (ix > 0 && nums[ix] == nums[ix - 1] && used[ix - 1])) {
                continue;
            }
            used[ix] = true;
            partial.add(nums[ix]);
            permuteUniqueHelper(nums, partial, result, used);
            partial.remove(partial.size() - 1);
            used[ix] = false;
        }
    }

    public List<List<Integer>> permuteUnique(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        Arrays.sort(nums);
        permuteUniqueHelper(nums, new ArrayList<>(), result, new boolean[nums.length]);
        return result;
    }

    // 46. Permutations
    // Time: O(n!)
    // https://leetcode.com/problems/permutations/?tab=Description

    void permuteHelper(int[] nums, List<Integer> partial, List<List<Integer>> result) {
        if (partial.size() == nums.length) {
            result.add(new ArrayList<>(partial));
            return;
        }

        for (int ix = 0; ix < nums.length; ix++) {
            if (partial.contains(nums[ix])) { continue; }
            partial.add(nums[ix]);
            permuteHelper(nums, partial, result);
            partial.remove(partial.size() - 1);
        }
    }

    public List<List<Integer>> permute(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        List<Integer> partial = new ArrayList<>();
        permuteHelper(nums, partial, result);
        return result;
    }


    // 22. Generate Parentheses
    // Time: ??, Space: ??
    // https://leetcode.com/problems/generate-parentheses/?tab=Description
    private void genHelper(int nLeft, int nRight, List<String> result, String partial) {
        if (nRight == 0) {
            result.add(partial);
            return;
        }

        if (nLeft > 0) {
            genHelper(nLeft - 1, nRight, result, partial + '(');

        }
        if (nRight > nLeft) {
            genHelper(nLeft, nRight - 1, result, partial + ')');
        }
    }

    public List<String> generateParenthesis(int n) {
        List<String> result = new ArrayList<>();
        genHelper(n, n, result, "");
        return result;
    }

    // 17. Letter Combinations of a Phone Number
    // https://leetcode.com/problems/letter-combinations-of-a-phone-number/?tab=Description
    String[] table = {"0", "1", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};


    private void letterCombinationsHelper(String digits, int index, String partial, List<String> result) {
        if (index == digits.length()) {
            result.add(partial);
            return;
        }
        int digit = Integer.valueOf(digits.charAt(index));
        for (char c : table[digit].toCharArray()) {
            letterCombinationsHelper(digits, ++index, partial + c, result);
        }
    }

    public List<String> letterCombinations(String digits) {
        List<String> result = new ArrayList<>();
        letterCombinationsHelper(digits, 0, "", result);
        return result;
    }
}
