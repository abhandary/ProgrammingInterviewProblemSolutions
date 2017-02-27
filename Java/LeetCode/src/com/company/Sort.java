package com.company;

import java.util.Comparator;
import java.util.*;

/**
 * Created by akshayb on 2/24/17.
 */
public class Sort {

    public String largestNumber(int[] nums) {
        String[] snums = new String[nums.length];

        for (int ix = 0; ix < nums.length; ix++) {
            snums[ix] = String.valueOf(nums[ix]);
        }
        Comparator<String> comp = new Comparator<String>() {
            @Override
            public int compare(String lhs, String rhs) {
                String s1 = lhs + rhs;
                String s2 = rhs + lhs;
                return s1.compareTo(s2);
            }
        };


        Arrays.sort(snums, comp);
        if (snums[0].charAt(0) == '0') {
            return "0";
        }

        StringBuilder sb = new StringBuilder();
        for (String snum : snums) {
            sb.append(snum);
        }
        return sb.toString();
    }

    // 75. Sort Colors
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/sort-colors/?tab=Description
    public void sortColors(int[] nums) {
        int numRed = 0, numWhite = 0, numBlue = 0;

        for (int num : nums) {
            if (num == 0) { numRed++; }
            if (num == 1) { numWhite++; }
            if (num == 2) { numBlue++; }
        }
        int ix = 0;
        for (; ix < numRed; ix++) {
            nums[ix] = 0;
        }
        for (int jx = 0; jx < numWhite; jx++) {
            nums[ix++] = 1;
        }
        for (int jx = 0; jx < numBlue; jx++) {
            nums[ix++] = 2;
        }
    }
}
