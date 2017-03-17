package com.company;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;
import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/6/17.
 */
public class BFS {

    // LC: 515. Find Largest Value in Each Tree Row
    // Time: O(n), Space: O(c)
    // SP: https://discuss.leetcode.com/topic/78991/python-bfs
    // https://discuss.leetcode.com/topic/79178/9ms-java-dfs-solution
    public List<Integer> largestValues(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) { return result; }
        ArrayDeque<TreeNode> q = new ArrayDeque<>();
        q.offer(root);
        int numInLevel = 1;
        int max = Integer.MIN_VALUE;
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            numInLevel--;

            if (current.left != null) q.offer(current.left);
            if (current.right != null) q.offer(current.right);

            max = Math.max(current.val, max);
            if (numInLevel == 0) {
                result.add(max);
                numInLevel = q.size();
                max = Integer.MIN_VALUE;
            }
        }
        return result;
    }

    // LC: 513. Find Bottom Left Tree Value
    // Given a binary tree, find the leftmost value in the last row of the tree.
    // Time: O(n), space: O(2 raise d)
    // https://leetcode.com/problems/find-bottom-left-tree-value/?tab=Description
    public int findBottomLeftValue(TreeNode root) {
        Queue<TreeNode> q = new ArrayDeque<>();
        q.offer(root);
        int leftMost = root.val;
        int numInLevel = 1;
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            numInLevel--;
            if (current.left != null) { q.offer(current.left); }
            if (current.right != null) { q.offer(current.right); }

            if (numInLevel == 0) {
                if (!q.isEmpty()) {
                    TreeNode head = q.peek();
                    leftMost = head.val;
                }
                numInLevel = q.size();
            }
        }
        return leftMost;
    }

    // SP:  https://discuss.leetcode.com/topic/78981/right-to-left-bfs-python-java
    public int findLeftMostNodeSP(TreeNode root) {
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            root = queue.poll();
            if (root.right != null)
                queue.add(root.right);
            if (root.left != null)
                queue.add(root.left);
        }
        return root.val;
    }
}
