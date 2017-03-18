package com.company;

import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/3/17.
 */
public class DynamicProgramming {


    // 343. Integer Break
    // Time: O(n), space: O(c)
    // PRACITCE, UNDERSTAND WHY on a whiteboard!!
    // https://leetcode.com/problems/integer-break/#/solutions
    public int integerBreak(int n) {
        if(n==2) return 1;
        if(n==3) return 2;
        int product = 1;
        while(n>4){
            product*=3;
            n-=3;
        }
        product*=n;

        return product;
    }

    // 322. Coin Change
    // Time: O(amount), space: O(amount)
    // PRACTICE, UNDERSTAND WHY on a whiteboard!!
    // https://leetcode.com/problems/coin-change/#/description
    public int coinChange(int[] coins, int amount) {
        int[] dp = new int[amount + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for (int ix = 1; ix <= amount; ix++) {
            for (int jx = 0; jx < coins.length; jx++) {
                if (coins[jx] <= ix) {
                    dp[ix] = Math.min(dp[ix], dp[ix - coins[jx]] < Integer.MAX_VALUE ?  dp[ix - coins[jx]] + 1 : Integer.MAX_VALUE);
                }
            }
        }
        return dp[amount] > amount ? -1 : dp[amount];
    }

    // 300. Longest Increasing Subsequence
    // Time: O(n2), Space: O(n)
    // https://leetcode.com/problems/longest-increasing-subsequence/#/description
    public int lengthOfLIS(int[] nums) {

        if(nums.length <= 1)
            return nums.length;

        // This will be our array to track longest sequence length
        int T[] = new int[nums.length];
        int max = Integer.MIN_VALUE;
        // Mark one pointer at i. For each i, start from j=0.
        for(int i=0; i < nums.length; i++)
        {
            T[i] = 1;
            for(int j=0; j < i; j++)
            {
                // It means next number contributes to increasing sequence.
                if(nums[j] < nums[i])
                {
                    // But increase the value only if it results in a larger value of the sequence than T[i]
                    // It is possible that T[i] already has larger value from some previous j'th iteration
                    T[i] = Math.max(T[i], T[j] + 1);
                }
            }
            max = Math.max(max, T[i]);
        }

        return max;
    }

    // UNDERSTAND WHY
    // https://leetcode.com/problems/longest-increasing-subsequence/#/solutions
    public int lengthOfLISBinarySearch(int[] nums) {
        int[] dp = new int[nums.length];
        int len = 0;

        for(int x : nums) {
            int i = Arrays.binarySearch(dp, 0, len, x);
            if(i < 0) i = -(i + 1);
            dp[i] = x;
            if(i == len) len++;
        }

        return len;
    }

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

    // LC: 122. Best Time to Buy and Sell Stock II
    // Time: O(n)
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/726/is-this-question-a-joke/13
    public int maxProfit2(int[] prices) {
        int total = 0;
        for (int i=0; i< prices.length-1; i++) {
            if (prices[i+1]>prices[i]) total += prices[i+1]-prices[i];
        }

        return total;
    }

    // 121. Best Time to Buy and Sell Stock
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/19853/kadane-s-algorithm-since-no-one-has-mentioned-about-this-so-far-in-case-if-interviewer-twists-the-input
    public int maxProfit(int[] prices) {
        if (prices.length == 0) { return 0; }
        int minSoFar = prices[0];
        int max = 0;
        for (int ix = 1; ix < prices.length; ix++) {
            if (prices[ix] > minSoFar) {
                max = Math.max(max, prices[ix] - minSoFar);
            }
            minSoFar = Math.min(minSoFar, prices[ix]);
        }
        return max;
    }

    // 120. Triangle
    // Time: O(n2), Space: O(n)
    // Passes 31/43 test cases
    // https://leetcode.com/problems/triangle/?tab=Description
    public int minimumTotal(List<List<Integer>> triangle) {
        if (triangle.size() == 0) { return 0; }
        List<Integer> lastRow = new ArrayList<>(triangle.get(0));
        int min = lastRow.get(0);
        for (int ix = 1; ix < triangle.size(); ix++) {

            List<Integer> currentRow = new ArrayList<>(triangle.get(ix));
            int val = currentRow.get(0) + lastRow.get(0);
            currentRow.set(0, val);
            min = Math.min(min, val);
            val = currentRow.get(currentRow.size() - 1) + lastRow.get(lastRow.size() - 1);
            currentRow.set(currentRow.size() - 1, val);
            min = Math.min(min, val);
            for (int jx = 1; jx < currentRow.size() - 1; jx++) {
                val = triangle.get(ix).get(jx);
                int localMin = val + Math.min(lastRow.get(jx - 1), lastRow.get(jx));
                min = Math.min(min, localMin);
                currentRow.set(jx, localMin);
            }
            lastRow = currentRow;
        }
        return min;
    }

    public int minimumTotal2(List<List<Integer>> triangle) {
        for(int i = triangle.size() - 2; i >= 0; i--)
            for(int j = 0; j <= i; j++)
                triangle.get(i).set(j, triangle.get(i).get(j) + Math.min(triangle.get(i + 1).get(j), triangle.get(i + 1).get(j + 1)));
        return triangle.get(0).get(0);
    }

    // 96. Unique Binary Search Trees
    // PRACTICE, REVIEW
    // Time: O(n!)?? Space: O(n)
    // https://leetcode.com/problems/unique-binary-search-trees/#/solutions
    public int numTrees(int n) {
        int[] G = new int[n + 1];
        G[0] = G[1] = 1;
        for (int ix = 2; ix <= n; ix++) {
            for (int jx = 1; jx <= ix; jx++) {
                G[ix] += G[jx - 1] * G[ix - jx];
            }
        }
        return G[n];
    }

    // 95. Unique Binary Search Trees II
    // PRACTICE, REVIEW
    // Time: ?? Space: ??
    // https://discuss.leetcode.com/topic/8410/divide-and-conquer-f-i-g-i-1-g-n-i
    public List<TreeNode> generateTrees(int n) {
        if (n == 0) { return new ArrayList<>(); }
        return generateSubtrees(1, n);
    }

    private List<TreeNode> generateSubtrees(int s, int e) {
        List<TreeNode> res = new LinkedList<TreeNode>();

        if (s > e) {
            res.add(null); // empty tree
            return res;
        }

        for (int i = s; i <= e; ++i) {
            List<TreeNode> leftSubtrees = generateSubtrees(s, i - 1);
            List<TreeNode> rightSubtrees = generateSubtrees(i + 1, e);

            for (TreeNode left : leftSubtrees) {
                for (TreeNode right : rightSubtrees) {
                    TreeNode root = new TreeNode(i);
                    root.left = left;
                    root.right = right;
                    res.add(root);
                }
            }
        }
        return res;
    }

    // 91. Decode Ways
    // Time: O(n), Space: O(n)
    // PRACTICE, understand why??
    // https://leetcode.com/problems/decode-ways/?tab=Solutions
    public int numDecodings(String s) {
        int n = s.length();
        if (n == 0) { return 0; }
        int[] dp = new int[n + 1];
        dp[n] = 1; // WHY??
        dp[n - 1] = s.charAt(n - 1) == '0' ? 0 : 1;
        for (int ix = n - 2; ix >= 0; ix--) {
            if (s.charAt(ix) == '0') continue;
            dp[ix] = Integer.valueOf(s.substring(ix, ix + 2)) <= 26 ? dp[ix + 1] + dp[ix + 2] : dp[ix + 1];
        }
        return dp[0];
    }

    // Time: O(n) Space: O(c)
    // https://discuss.leetcode.com/topic/7025/a-concise-dp-solution
    int numDecodings2(String s) {
        if (s.length() == 0 || s.charAt(0) == '0') return 0;

        // r2: decode ways of s[i-2] , r1: decode ways of s[i-1]
        int r1 = 1, r2 = 1;

        for (int i = 1; i < s.length(); i++) {
            // zero voids ways of the last because zero cannot be used separately
            if (s.charAt(i) == '0') r1 = 0;

            // possible two-digit letter, so new r1 is sum of both while new r2 is the old r1
            if (s.charAt(i - 1) == '1' || s.charAt(i - 1) == '2' && s.charAt(i) <= '6') {
                r1 = r2 + r1;
                r2 = r1 - r2;
            }

            // one-digit letter, no new way added
            else {
                r2 = r1;
            }
        }

        return r1;
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


    // 64. Minimum Path Sum
    // Time: O(m * n), Space: O(m * n)
    // https://discuss.leetcode.com/topic/15269/10-lines-28ms-o-n-space-dp-solution-in-c-with-explanations
    public int minPathSum(int[][] grid) {
        if (grid.length == 0) {
            return 0;
        }
        int m = grid.length, n = grid[0].length;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                grid[ix][jx] += Math.min((ix > 0 ? grid[ix - 1][jx] : Integer.MAX_VALUE), (jx > 0 ? grid[ix][jx - 1] : Integer.MAX_VALUE));
            }
        }
        return grid[m - 1][n - 1];
    }
    // 63. Unique Paths II
    // Time: O(m * n), Space: O(m * n) outside of the input
    // https://leetcode.com/problems/unique-paths-ii/#/solutions
    // https://discuss.leetcode.com/topic/10974/short-java-solution
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        if (obstacleGrid.length == 0) return 0;
        if (obstacleGrid[0][0] == 1) return 0; // IMP edge case

        int m = obstacleGrid.length, n = obstacleGrid[0].length;
        int[][] grid = new int[m][n];
        grid[0][0] = 1;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                if (obstacleGrid[ix][jx] == 1) continue; // IMP to edge cases like [[0, 1]]
                if (ix > 0 && obstacleGrid[ix - 1][jx] != 1) {
                    grid[ix][jx] += grid[ix - 1][jx];
                }
                if (jx > 0 && obstacleGrid[ix][jx - 1] != 1) {
                    grid[ix][jx] += grid[ix][jx - 1];
                }
            }
        }
        return grid[m - 1][n - 1];
    }

    // 62. Unique Paths
    // Time: O(m * n), Space: O(m + n)
    // https://leetcode.com/problems/unique-paths/?tab=Description
    public int uniquePaths(int m, int n) {
        int[][] grid = new int[m][n];
        grid[0][0] = 1;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                grid[ix][jx] = (ix > 0 ? grid[ix - 1][jx] : 0) + (jx > 0 ? grid[ix][jx - 1] : 0);
            }
        }
        return grid[m - 1][n - 1];
    }

    // 53. Maximum Subarray
    // Time: O(n), space : O(c)
    // PRACTICE, what's the intuition behind this??
    public int maxSubArray(int[] nums) {
        if (nums.length == 0) { return -1; }
        int maxTillHere = nums[0];
        int max = nums[0];
        for (int ix = 1; ix < nums.length; ix++) {
            maxTillHere = Math.max(nums[ix], maxTillHere + nums[ix]);
            max = Math.max(max, maxTillHere);
        }
        return max;
    }
}
