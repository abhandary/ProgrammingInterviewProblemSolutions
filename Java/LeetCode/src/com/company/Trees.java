
package com.company;

import apple.laf.JRSUIUtils;

import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class TreeLinkNode {
    int val;
    TreeLinkNode left, right, next;
    TreeLinkNode(int x) { val = x; }
 }

/**
 * Created by akshayb on 2/22/17.
 */
public class Trees {

    // 404. Sum of Left Leaves
    // Time: O(n log n), Space: O( log n) for a balanced tree

    private int sumOfLeavesHelper(TreeNode root, boolean isLeftChild) {
        if (root == null) { return 0; }
        if (root.left == null && root.right == null ) {
            return isLeftChild == true ? root.val : 0;
        }
        return sumOfLeavesHelper(root.left, true) + sumOfLeavesHelper(root.right, false);
    }

    public int sumOfLeftLeaves(TreeNode root) {
        if (root == null) { return 0;}
        if (root.left == null && root.right == null) { return 0; }
        return sumOfLeavesHelper(root.left, true) + sumOfLeavesHelper(root.right, false);
    }

    // 257. Binary Tree Paths
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/binary-tree-paths/?tab=Description
    private void binaryTreePathsHelper(TreeNode root, String sub, ArrayList<String> result) {

        if (root.left == null && root.right == null) {
            result.add(sub + root.val);
            return;
        }
        if (root.left != null) {
            binaryTreePathsHelper(root.left, sub + root.val + "->", result);
        }
        if (root.right != null) {
            binaryTreePathsHelper(root.right, sub + root.val + "->", result);
        }
    }

    public List<String> binaryTreePaths(TreeNode root) {

        ArrayList<String> result = new ArrayList<String>();

        if (root != null) {
            binaryTreePathsHelper(root, "", result);
        }

        return result;
    }

    // 236. Lowest Common Ancestor of a Binary Tree
    // Time: O(n), Space: O(h) for a balanced tree.
    // https://leetcode.com/problems/lowest-common-ancestor-of-a-binary-tree/?tab=Solutions
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {

        if (root == p || root == q || root == null) {
            return root;
        }
        TreeNode left  = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        if (left != null && right != null) {
            return root;
        }
        return left != null ? left : right;
    }

    // 235. Lowest Common Ancestor of a Binary Search Tree
    // Time: O(h), Space: O(h) for a BST
    public TreeNode lowestCommonAncestorBST(TreeNode root, TreeNode p, TreeNode q) {
        if (p.val > q.val) {
            TreeNode temp = p;
            p = q;
            q = temp;
        }
        if (root == null || root == q || root == p) {
            return root;
        }
        if (p.val <= root.val && q.val >= root.val) {
            return root;
        }
        if (p.val < root.val && q.val < root.val) {
            return lowestCommonAncestorBST(root.left, p, q);
        }
        if (p.val > root.val && q.val > root.val) {
            return lowestCommonAncestorBST(root.right, p, q);
        }
        return null;
    }

    // 226. Invert Binary Tree
    // Time: O(n), Space: O(h)
    public TreeNode invertTree(TreeNode root) {
        if (root == null || (root.left ==null && root.right == null)) {
            return root;
        }
        TreeNode temp = root.left;
        root.left = root.right;
        root.right = temp;
        invertTree(root.left);
        invertTree(root.right);
        return root;
    }

    // 144. Binary Tree Preorder Traversal
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/binary-tree-preorder-traversal/?tab=Description
    private void preorderTraversalHelper(TreeNode root, List<Integer> list) {
        if (root == null) {
            return;
        }
        list.add(root.val);
        preorderTraversalHelper(root.left, list);
        preorderTraversalHelper(root.right, list);
    }
    public List<Integer> preorderTraversal(TreeNode root) {
        ArrayList<Integer> result = new ArrayList<>();
        preorderTraversalHelper(root, result);
        return result;
    }

    // 129. Sum Root to Leaf Numbers
    // Time: O(n), Space: O(h)
    private int sumNumbersHelper(TreeNode root, int num) {
        if (root == null) {
            return 0;
        }
        num *= 10;
        num += root.val;
        if (root.left == null && root.right == null) {
            return num;
        }
        return sumNumbersHelper(root.left, num) + sumNumbersHelper(root.right, num);
    }
    public int sumNumbers(TreeNode root) {
        return sumNumbersHelper(root, 0);
    }


    // 116. Populating Next Right Pointers in Each Node
    // Time: O(n), Space:O(h)
    // https://leetcode.com/problems/populating-next-right-pointers-in-each-node/?tab=Description
    public void connect(TreeLinkNode root) {
        if (root == null) { return; }
        if (root.left != null) {
            root.left.next = root.right;
        }
        if (root.right != null && root.next != null) {
            root.right.next = root.next.left;
        }
        connect(root.left);
        connect(root.right);
    }

    // 110. Balanced Binary Tree
    private int dfsHeight(TreeNode root) {
        if (root == null) {
            return 0;
        }
        int left = dfsHeight(root.left);
        if (left == -1) { return -1; }
        int right = dfsHeight(root.right);
        if (right == -1) { return -1; }
        if (Math.abs(left - right) > 1) { return -1; }
        return (Math.max(left, right) + 1);
    }
    public boolean isBalanced(TreeNode root) {
        return dfsHeight(root) != -1;
    }


    // 111. Minimum Depth of Binary Tree
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/minimum-depth-of-binary-tree/?tab=Solutions
    public int minDepth(TreeNode root) {
        if (root == null) { return 0; }
        if (root.left == null) { return 1 + minDepth(root.right); }
        if (root.right == null) { return 1 + minDepth(root.left); }

        return 1 + Math.min(minDepth(root.left), minDepth(root.right));
    }


    // 108: Convert Sorted Array to Binary Search Tree
    // Time: O(n), Space: O(log n) for the recursion
    private TreeNode sortedArrayToBSTHelper(int[] nums, int sx, int ex) {
        if (sx > ex) {
            return null;
        }
        int mid = sx + (ex - sx) / 2;
        TreeNode root = new TreeNode(nums[mid]);
        root.left = sortedArrayToBSTHelper(nums, sx, mid - 1);
        root.right = sortedArrayToBSTHelper(nums, mid + 1, ex);
        return root;
    }
    public TreeNode sortedArrayToBST(int[] nums) {
        return sortedArrayToBSTHelper(nums, 0, nums.length - 1);
    }

    // 102. Binary Tree Level Order Traversal
    // Time: O(n), Space: O(2eh)
    // https://leetcode.com/problems/binary-tree-level-order-traversal/?tab=Description
    public List<List<Integer>> levelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) { return result; }

        Queue<TreeNode> mq = new LinkedList<TreeNode>();
        mq.add(root);
        int numInLevel = 1;
        ArrayList<Integer> level = new ArrayList<Integer>();
        while (!mq.isEmpty()) {
            TreeNode current = mq.poll();
            level.add(current.val);
            if (current.left != null) { mq.add(current.left); }
            if (current.right != null) { mq.add(current.right); }

            numInLevel -= 1;
            if (numInLevel == 0) {
                result.add(level);
                level = new ArrayList<Integer>();
                numInLevel = mq.size();
            }
        }
        return result;
    }

    // 100. Same Tree
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/same-tree/?tab=Description
    public boolean isSameTree(TreeNode p, TreeNode q) {
        if (p == null && q == null) {
            return true;
        }
        if (p != null && q != null) {
            return (p.val == q.val) && isSameTree(p.left, q.left) && isSameTree(p.right, q.right);
        }
        return false;
    }

}
