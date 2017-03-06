package com.company;

/**
 * Created by akshayb on 3/3/17.
 */
public class DynamicProgramming {

    // 198. House Robber
    // Time: O(n), Space: O(c) outside of the input array
    // https://leetcode.com/problems/house-robber/?tab=Description
    public int rob(int[] nums) {

        if (nums.length == 0) { return 0; }
        int maxSoFar = Integer.MIN_VALUE;

        for (int ix = 0; ix < nums.length; ix++) {
            int prev = ix - 2;
            int lastToPrev = ix - 3;
            nums[ix] += Math.max(prev >= 0 ? nums[prev] : 0, lastToPrev >= 0 ? nums[lastToPrev] : 0);
            maxSoFar = Math.max(maxSoFar, nums[ix]);
        }
        return maxSoFar;
    }

    // 70. Climbing Stairs
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/climbing-stairs/?tab=Solutions
    public int climbStairs(int n) {
        // base cases
        if(n <= 0) return 0;
        if(n == 1) return 1;
        if(n == 2) return 2;

        int one_step_before = 2;
        int two_steps_before = 1;
        int all_ways = 0;

        for(int ix = 3; ix <= n; ix++){
            all_ways = one_step_before + two_steps_before;
            two_steps_before = one_step_before;
            one_step_before = all_ways;
        }
        return all_ways;
    }
}
