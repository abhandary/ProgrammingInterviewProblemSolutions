package com.company;

import java.util.*;
import java.lang.Math;

class UndirectedGraphNode {
    int label;
    List<UndirectedGraphNode> neighbors;
    UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 };
/**
 * Created by akshayb on 2/27/17.
 */
public class DFS {


    int[][] cache;

    static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};



    // 329. Longest Increasing Path in a Matrix
    // Time: ??, Time: O(c)
    int dfs(int[][] matrix, int ix, int jx, int m, int n) {

        if (cache[ix][jx] != 0) { return cache[ix][jx]; }



        int max = 1;
        for(int[] dir: dirs) {
            int x = ix + dir[0], y = jx + dir[1];
            if (x < 0 || y < 0 || x >= m || y >= n || matrix[x][y] <= matrix[ix][jx]) {
                continue;
            }
            int len = 1 + dfs(matrix, x, y, m, n);
            max = Math.max(max, len);
        }
        cache[ix][jx] = max;
        return max;
    }

    public int longestIncreasingPath(int[][] matrix) {
        int max = 1;
        if (matrix.length == 0) { return 0; }
        int m = matrix.length, n = matrix[0].length;
        cache = new int[m][n];
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                max = Math.max(max, dfs(matrix, ix, jx, m, n));
            }
        }
        return max;
    }

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
    // @see Trees

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

    // 114. Flatten Binary Tree to Linked List
    // Time: O(n), Space: O(h) for the recursion
    // https://discuss.leetcode.com/topic/11444/my-short-post-order-traversal-java-solution-for-share/2
    public void flatten(TreeNode root) {
        if (root == null) { return; }
        flatten(root.right);
        flatten(root.left);
        root.right = prev;
        root.left  = null;
        prev = root;
    }

    //https://discuss.leetcode.com/topic/3995/share-my-simple-non-recursive-solution-o-1-space-complexity
    void flattenItr(TreeNode root) {
        TreeNode now = root;
        while (now != null)
        {
            if(now.left != null)
            {
                //Find current node's prenode that links to current node's right subtree
                TreeNode pre = now.left;
                while(pre.right != null)
                {
                    pre = pre.right;
                }
                pre.right = now.right;
                //Use current node's left subtree to replace its right subtree(original right
                //subtree is already linked by current node's prenode
                now.right = now.left;
                now.left = null;
            }
            now = now.right;
        }
    }


    // 113. Path Sum II
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/5414/dfs-with-one-linkedlist-accepted-java-solution
    void pathSumHelper(TreeNode root, int sum, List<Integer> partial, List<List<Integer>> result) {
        if (root == null) { return; }
        sum -= root.val;
        partial.add(root.val);
        if (root.left == null && root.right == null) {
            if (sum == 0) {
                result.add(new ArrayList(partial));
            }
        } else {
            pathSumHelper(root.left, sum, partial, result);
            pathSumHelper(root.right, sum, partial, result);
        }

        // IMP to remove in both cases!!
        partial.remove(partial.size() - 1);
    }

    public List<List<Integer>> pathSum(TreeNode root, int sum) {
        List<List<Integer>> result = new ArrayList<>();
        pathSumHelper(root, sum, new ArrayList<>(), result);
        return result;
    }

    // 112. Path Sum
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/3149/accepted-my-recursive-solution-in-java
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

    public boolean hasPathSum2(TreeNode root, int sum) {
        if(root == null) return false;

        if(root.left == null && root.right == null && sum - root.val == 0) return true;

        return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val);
    }


    // 109. Convert Sorted List to Binary Search Tree
    // Time: O(n log n), space: O(log n)
    // https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/?tab=Description
    public TreeNode sortedListToBST(ListNode head) {

        if (head == null) { return null; }
        if (head.next == null) { return new TreeNode(head.val); }

        int len = 0;
        for (ListNode itr = head; itr != null; itr = itr.next) { len++; }

        ListNode itr = head;
        for (int ix = 0; ix < (len / 2) - 1; ix++) {
            itr = itr.next;
        }

        TreeNode newRoot = new TreeNode(itr.next.val);
        newRoot.right = sortedListToBST(itr.next.next);
        itr.next = null;
        newRoot.left = sortedListToBST(head);
        return newRoot;
    }

    // 103. Binary Tree Zigzag Level Order Traversal
    // https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/?tab=Description
    // @see Trees

    // 101. Symmetric Tree
    // Time: O(n), space: O(h)
    // https://leetcode.com/problems/symmetric-tree/?tab=Description
    boolean isSymmetricHelper(TreeNode left, TreeNode right) {
        if (left == null && right == null) { return true; }
        if (left == null) { return false; }
        if (right == null) { return false; }

        return left.val == right.val && isSymmetricHelper(left.right, right.left) && isSymmetricHelper(left.left, right.right);
    }

    public boolean isSymmetric(TreeNode root) {
        if (root == null) { return true; }

        return isSymmetricHelper(root.left, root.right);
    }

    // 98. Validate Binary Search Tree
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/validate-binary-search-tree/?tab=Solutions
    public boolean isValidBST(TreeNode root) {
        return isValidBST(root, Long.MIN_VALUE, Long.MAX_VALUE);
    }

    public boolean isValidBST(TreeNode root, long minVal, long maxVal) {
        if (root == null) return true;
        if (root.val >= maxVal || root.val <= minVal) return false;
        return isValidBST(root.left, minVal, root.val) && isValidBST(root.right, root.val, maxVal);
    }

    TreeNode prev;

    public boolean isValidBST2(TreeNode root) {
        TreeNode prev = null;
        return validate(root);
    }

    boolean validate(TreeNode node) {
        if (node == null) return true;
        if (!validate(node.left)) return false;
        if (prev != null && prev.val >= node.val) return false;
        prev = node;
        return validate(node.right);
    }
}
