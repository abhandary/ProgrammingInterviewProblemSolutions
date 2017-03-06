package com.company;

/**
 * Created by akshayb on 3/2/17.
 */
public class BSTs {

    // @todo: didn't pass all test cases
    // 530. Minimum Absolute Difference in BST
    Integer minDiff = Integer.MAX_VALUE;
    public int getMinimumDifference(TreeNode root) {
        if (root == null) { return Integer.MAX_VALUE; }
        if (root.left != null) {
            minDiff = Math.min(minDiff, root.val - root.left.val);
            getMinimumDifference(root.left);
        }
        if (root.right != null) {
            minDiff = Math.min(minDiff, root.right.val - root.val);
            getMinimumDifference(root.right);
        }
        return minDiff;
    }
}
