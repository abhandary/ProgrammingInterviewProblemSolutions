package com.company;

import java.util.*;

class UndirectedGraphNode {
    int label;
    List<UndirectedGraphNode> neighbors;
    UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 };
/**
 * Created by akshayb on 2/27/17.
 */
public class DFS {

    // 200. Number of Islands
    // https://leetcode.com/problems/number-of-islands/?tab=Description
    // Time: O(m * n)??, Space: O(m + n) for the recursion stack
    // ==== test it ===
    private void coverIsland(char[][] grid, int ix, int jx) {
        if (grid[ix][jx] == '2' || grid[ix][jx] == '0') {
            return;
        }
        grid[ix][jx] = '2';
        int [][] next = {{0, -1}, {0, 1}, {-1, 0}, {0, -1}};
        for (int kx = 0; kx < next.length; kx++) {
            coverIsland(grid, ix + next[kx][0], jx + next[kx][1]);
        }
    }

    public int numIslands(char[][] grid) {
        int numIslands = 0;
        if (grid.length == 0) { return numIslands; }


        for (int ix = 0; ix < grid.length; ix++) {
            for (int jx = 0; jx < grid[0].length; jx++) {
                if (grid[ix][jx] == '1') {
                    numIslands++;
                    // cover all 1's on this island
                    coverIsland(grid, ix, jx);
                }
            }
        }
        return numIslands;
    }

    // 199. Binary Tree Right Side View
    // https://leetcode.com/problems/binary-tree-right-side-view/?tab=Description
    public List<Integer> rightSideView(TreeNode root) {
        Queue<TreeNode> q = new ArrayDeque<>();
        List<Integer> result = new ArrayList<>();
        if (root == null) { return result; }
        q.offer(root);
        int numInLevel = 1;
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            if (current.left != null) {
                q.offer(current.left);
            }
            if (current.right != null) {
                q.offer(current.right);
            }

            if (numInLevel == 1) {
                result.add(current.val);
            }
            numInLevel--;
            if (numInLevel == 0) {
                numInLevel = q.size();
            }
        }
        return result;
    }

    // 133. Clone Graph
    // Time: O(V * E)??, Space: O(n)
    //
    private void cloneGraphHelper(UndirectedGraphNode node, HashMap<UndirectedGraphNode, UndirectedGraphNode> hm) {
        if (hm.get(node) != null) {
            return;
        }
        UndirectedGraphNode cloneRoot = new UndirectedGraphNode(node.label);
        hm.put(node, cloneRoot);
        for (UndirectedGraphNode neighbor : node.neighbors) {
            if (hm.get(neighbor) == null) {
                cloneGraphHelper(neighbor, hm);
            }
            cloneRoot.neighbors.add(hm.get(neighbor));
        }
    }

    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        if (node == null) { return null; }
        HashMap<UndirectedGraphNode, UndirectedGraphNode> hm = new HashMap<>();
        cloneGraphHelper(node, hm);
        return hm.get(node);
    }

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

    // 103. Binary Tree Zigzag Level Order Traversal
    // https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/?tab=Description
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) { return result; }
        Queue<TreeNode> q = new ArrayDeque<TreeNode>();
        q.offer(root);
        boolean leftToRight = false;
        int numInLevel = q.size();
        List<Integer> level = new ArrayList<>();
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            level.add(current.val);
            numInLevel--;

            if (current.left != null) {
                q.offer(current.left);
            }
            if (current.right != null) {
                q.offer(current.right);
            }
            if (numInLevel == 0) {

                if (leftToRight) {
                    Collections.reverse(level);
                }
                result.add(level);
                level = new ArrayList<>();
                numInLevel = q.size();
                leftToRight = !leftToRight;
            }
        }

        return result;
    }
}
