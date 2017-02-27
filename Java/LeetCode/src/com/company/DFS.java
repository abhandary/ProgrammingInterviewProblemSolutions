package com.company;

/**
 * Created by akshayb on 2/27/17.
 */
public class DFS {

    // 112. Path Sum
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/path-sum/?tab=Description
    public boolean hasPathSum(TreeNode root, int sum) {

        if (root == null) { return false; }

        sum -= root.val;
        if (root.left == null && root.right == null) {
            return sum == 0;
        }
        boolean leftResult = hasPathSum(root.left, sum);
        if (leftResult) {
            return true;
        }

        boolean rightResult = hasPathSum(root.right, sum);
        if (rightResult) {
            return true;
        }
        return false;
    }
}
