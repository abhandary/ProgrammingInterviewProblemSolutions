package com.company;

import java.util.*;

/**
 * Created by akshayb on 2/27/17.
 */
public class DivideAndConquer {

    // 241. Different Ways to Add Parentheses
    // Time: O(n log n), Space: O(log n) for the recursive stack
    // https://leetcode.com/problems/different-ways-to-add-parentheses/?tab=Description
    public List<Integer> diffWaysToCompute(String input) {

        List<Integer> result = new ArrayList<Integer>();
        for (int ix = 0; ix < input.length(); ix++) {
            if (input.charAt(ix) == '*' ||
                    input.charAt(ix) == '-' ||
                    input.charAt(ix) == '+') {
                String part1 = input.substring(0, ix);
                String part2 = input.substring(ix + 1);
                List<Integer> p1result = diffWaysToCompute(part1);
                List<Integer> p2result = diffWaysToCompute(part2);
                for (int p1 : p1result) {
                    for (int p2 : p2result) {
                        int c = 0;
                        switch (input.charAt(ix)) {
                            case '*':
                                c = p1 * p2;
                                break;
                            case '-':
                                c = p1 - p2;
                                break;
                            case '+':
                                c = p1 + p2;
                                break;

                        }
                        result.add(c);
                    }
                }

            }
        }
        if (result.size() == 0) {
            result.add(Integer.valueOf(input));
        }
        return result;
    }

    // 240. Search a 2D Matrix II
    // Time: O(m + n), Space: O(c)
    // https://leetcode.com/problems/search-a-2d-matrix-ii/?tab=Description
    public boolean searchMatrix(int[][] matrix, int target) {
        if (matrix.length == 0) { return false; }
        int ix = 0;
        int jx = matrix[0].length - 1;

        while (ix < matrix.length && jx >= 0) {
            if (matrix[ix][jx] == target) {
                return true;
            }
            if (matrix[ix][jx] < target) {
                ix++;
            } else {
                jx--;
            }
        }
        return false;
    }
}
