
package com.company;

import apple.laf.JRSUIUtils;

import java.util.*;
import java.lang.Math;

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

    // LC: 515. Find Largest Value in Each Tree Row
    // @see BFS

    // LC: 513. Find Bottom Left Tree Value
    // @see BFS

    // LC: 508. Most Frequent Subtree Sum
    // @see Hashtables

    // LC: 501. Find Mode in Binary Search Tree
    // Given a binary search tree (BST) with duplicates, find all the mode(s) (the most frequently occurred element) in the given BST.
    // Assume a BST is defined as follows:
    // The left subtree of a node contains only nodes with keys less than or equal to the node's key.
    // The right subtree of a node contains only nodes with keys greater than or equal to the node's key.
    // Both the left and right subtrees must also be binary search trees.
    // SP: https://discuss.leetcode.com/topic/77335/proper-o-1-space
    public int[] findMode(TreeNode root) {
        inorder(root);
        modes = new int[modeCount];
        modeCount = 0;
        currCount = 0;
        inorder(root);
        return modes;
    }

    private int currVal;
    private int currCount = 0;
    private int maxCount = 0;
    private int modeCount = 0;

    private int[] modes;

    private void handleValue(int val) {
        if (val != currVal) {
            currVal = val;
            currCount = 0;
        }
        currCount++;
        if (currCount > maxCount) {
            maxCount = currCount;
            modeCount = 1;
        } else if (currCount == maxCount) {
            if (modes != null)
                modes[modeCount] = currVal;
            modeCount++;
        }
    }

    private void inorder(TreeNode root) {
        if (root == null) return;
        inorder(root.left);
        handleValue(root.val);
        inorder(root.right);
    }

    // LC: 450. Delete Node in a BST
    // Time: O(h), Space: O(h) for the recursion stack
    // @todo: UNSOLVED
    // Given a root node reference of a BST and a key, delete the node with the given key in the BST. Return the root node reference (possibly updated) of the BST.
    // Basically, the deletion can be divided into two stages:
    // Search for a node to remove.
    // If the node is found, delete the node.
    // Note: Time complexity should be O(height of tree).
    // https://discuss.leetcode.com/topic/65792/recursive-easy-to-understand-java-solution
    public TreeNode deleteNode(TreeNode root, int key) {
        if (root == null) { return null; }
        if (key < root.val) {
            root.left = deleteNode(root.left, key);
        } else if (key > root.val) {
            root.right = deleteNode(root.right, key);
        } else {
            if (root.left == null) { return root.right; }
            if (root.right == null) { return root.left; }
            TreeNode minNode = findMin(root.right);
            root.val = minNode.val;
            root.right = deleteNode(root.right, root.val);
        }
        return root;
    }

    TreeNode findMin(TreeNode root) {
        while (root.left != null) {
            root = root.left;
        }
        return root;
    }

    // https://discuss.leetcode.com/topic/67962/iterative-solution-in-java-o-h-time-and-o-1-space
    private TreeNode deleteRootNode(TreeNode root) {
        if (root == null) {
            return null;
        }
        if (root.left == null) {
            return root.right;
        }
        if (root.right == null) {
            return root.left;
        }
        TreeNode next = root.right;
        TreeNode pre = null;
        for(; next.left != null; pre = next, next = next.left);
        next.left = root.left;
        if(root.right != next) {
            pre.left = next.right;
            next.right = root.right;
        }
        return next;
    }

    public TreeNode deleteNodeIterative(TreeNode root, int key) {
        TreeNode cur = root;
        TreeNode pre = null;
        while(cur != null && cur.val != key) {
            pre = cur;
            if (key < cur.val) {
                cur = cur.left;
            } else if (key > cur.val) {
                cur = cur.right;
            }
        }
        if (pre == null) {
            return deleteRootNode(cur);
        }
        if (pre.left == cur) {
            pre.left = deleteRootNode(cur);
        } else {
            pre.right = deleteRootNode(cur);
        }
        return root;
    }

    // LC: 449. Serialize and Deserialize BST
    // Serialization is the process of converting a data structure or object into a sequence of bits so that it can be
    // stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in
    // the same or another computer environment.
    // Design an algorithm to serialize and deserialize a binary search tree. There is no restriction on how your
    // serialization/deserialization algorithm should work. You just need to ensure that a binary search tree can be
    // serialized to a string and this string can be deserialized to the original tree structure.
    // The encoded string should be as compact as possible.
    // Note: Do not use class member/global/static variables to store states. Your serialize and deserialize
    // algorithms should be stateless.
    // https://discuss.leetcode.com/topic/66651/java-preorder-queue-solution
    // SP: https://discuss.leetcode.com/topic/66318/deserialize-from-preorder-and-computed-inorder-reusing-old-solution
    public String serialize2(TreeNode root) {
        if (root == null) {
            return "#!";
        }
        String res = root.val + "!";
        res += serialize(root.left);
        res += serialize(root.right);
        return res;
    }

    // Decodes your encoded data to tree.
    public TreeNode deserialize2(String data) {
        String[] strings = data.split("!");
        LinkedList<String> list = new LinkedList<>();
        for (String string:strings){
            list.add(string);
        }
        return reconPreOrder(list);
    }

    public TreeNode reconPreOrder(LinkedList<String> queue){
        String val = queue.poll();
        if (val.equals("#")) {
            return null;
        }
        TreeNode head = new TreeNode(Integer.valueOf(val));
        head.left = reconPreOrder(queue);
        head.right = reconPreOrder(queue);
        return head;
    }




    // LC: 437. Path Sum III
    // You are given a binary tree in which each node contains an integer value.
    // Find the number of paths that sum to a given value.
    // The path does not need to start or end at the root or a leaf, but it must go downwards (traveling only
    // from parent nodes to child nodes).
    // The tree has no more than 1,000 nodes and the values are in the range -1,000,000 to 1,000,000.
    // https://discuss.leetcode.com/topic/64526/17-ms-o-n-java-prefix-sum-method
    public int pathSum(TreeNode root, int sum) {
        HashMap<Integer, Integer> preSum = new HashMap();
        preSum.put(0,1);
        return helper(root, 0, sum, preSum);
    }

    public int helper(TreeNode root, int currSum, int target, HashMap<Integer, Integer> preSum) {
        if (root == null) {
            return 0;
        }

        currSum += root.val;
        int res = preSum.getOrDefault(currSum - target, 0);
        preSum.put(currSum, preSum.getOrDefault(currSum, 0) + 1);

        res += helper(root.left, currSum, target, preSum) + helper(root.right, currSum, target, preSum);
        preSum.put(currSum, preSum.get(currSum) - 1);
        return res;
    }



    // LC: 404. Sum of Left Leaves
    // Time: O(n log n), Space: O( log n) for a balanced tree
    private int sumOfLeavesHelper(TreeNode root, boolean isLeftChild) {
        if (root == null) { return 0; }
        if (root.left == null && root.right == null ) {
            return isLeftChild == true ? root.val : 0;
        }
        return sumOfLeavesHelper(root.left, true) + sumOfLeavesHelper(root.right, false);
    }

    // https://discuss.leetcode.com/topic/60403/java-iterative-and-recursive-solutions
    public int sumOfLeftLeaves(TreeNode root) {
        if (root == null) { return 0;}
        if (root.left == null && root.right == null) { return 0; }
        return sumOfLeavesHelper(root.left, true) + sumOfLeavesHelper(root.right, false);
    }

    public int sumOfLeftLeavesItr(TreeNode root) {
        if(root == null) return 0;
        int ans = 0;
        Stack<TreeNode> stack = new Stack<TreeNode>();
        stack.push(root);

        while(!stack.empty()) {
            TreeNode node = stack.pop();
            if(node.left != null) {
                if (node.left.left == null && node.left.right == null)
                    ans += node.left.val;
                else
                    stack.push(node.left);
            }
            if(node.right != null) {
                if (node.right.left != null || node.right.right != null)
                    stack.push(node.right);
            }
        }
        return ans;
    }

    // LC: 337. House Robber III
    // @todo: UNSOLVED
    // The thief has found himself a new place for his thievery again. There is only one entrance to this area,
    // called the "root." Besides the root, each house has one and only one parent house. After a tour, the smart thief
    // realized that "all houses in this place forms a binary tree". It will automatically contact the police if two
    // directly-linked houses were broken into on the same night.
    // Determine the maximum amount of money the thief can rob tonight without alerting the police.
    // https://discuss.leetcode.com/topic/39834/step-by-step-tackling-of-the-problem
    public int rob(TreeNode root) {
        int[] res = robSub(root);
        return Math.max(res[0], res[1]);
    }

    private int[] robSub(TreeNode root) {
        if (root == null) return new int[2];

        int[] left = robSub(root.left);
        int[] right = robSub(root.right);
        int[] res = new int[2];

        res[0] = Math.max(left[0], left[1]) + Math.max(right[0], right[1]);
        res[1] = root.val + left[0] + right[0];

        return res;
    }


    // LC: 297. Serialize and Deserialize Binary Tree
    // Serialization is the process of converting a data structure or object into a sequence of bits so that it can be
    // stored in a file or memory buffer, or transmitted across a network connection link to be reconstructed later in
    // the same or another computer environment.
    // Design an algorithm to serialize and deserialize a binary tree. There is no restriction on how your
    // serialization/deserialization algorithm should work. You just need to ensure that a binary tree can be
    // serialized to a string and this string can be deserialized to the original tree structure.
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/28029/easy-to-understand-java-solution
    // SP: https://discuss.leetcode.com/topic/28041/recursive-preorder-python-and-c-o-n
    private static final String spliter = ",";
    private static final String NN = "X";

    // Encodes a tree to a single string.
    public String serialize(TreeNode root) {
        StringBuilder sb = new StringBuilder();
        buildString(root, sb);
        return sb.toString();
    }

    private void buildString(TreeNode node, StringBuilder sb) {
        if (node == null) {
            sb.append(NN).append(spliter);
        } else {
            sb.append(node.val).append(spliter);
            buildString(node.left, sb);
            buildString(node.right,sb);
        }
    }
    // Decodes your encoded data to tree.
    public TreeNode deserialize(String data) {
        Deque<String> nodes = new LinkedList<>();
        nodes.addAll(Arrays.asList(data.split(spliter)));
        return buildTree(nodes);
    }

    private TreeNode buildTree(Deque<String> nodes) {
        String val = nodes.remove();
        if (val.equals(NN)) return null;
        else {
            TreeNode node = new TreeNode(Integer.valueOf(val));
            node.left = buildTree(nodes);
            node.right = buildTree(nodes);
            return node;
        }
    }

    // LC: 257. Binary Tree Paths
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

    // https://discuss.leetcode.com/topic/21474/accepted-java-simple-solution-in-8-lines
    // SP: https://discuss.leetcode.com/topic/21441/5-lines-recursive-python
    public List<String> binaryTreePaths2(TreeNode root) {
        List<String> answer = new ArrayList<String>();
        if (root != null) searchBT(root, "", answer);
        return answer;
    }
    private void searchBT(TreeNode root, String path, List<String> answer) {
        if (root.left == null && root.right == null) answer.add(path + root.val);
        if (root.left != null) searchBT(root.left, path + root.val + "->", answer);
        if (root.right != null) searchBT(root.right, path + root.val + "->", answer);
    }

    // LC: 236. Lowest Common Ancestor of a Binary Tree
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

    // SP: https://discuss.leetcode.com/topic/18561/4-lines-c-java-python-ruby
    public TreeNode lowestCommonAncestor2SP(TreeNode root, TreeNode p, TreeNode q) {
        if (root == null || root == p || root == q) return root;
        TreeNode left = lowestCommonAncestor(root.left, p, q);
        TreeNode right = lowestCommonAncestor(root.right, p, q);
        return left == null ? right : right == null ? left : root;
    }

    // LC: 235. Lowest Common Ancestor of a Binary Search Tree
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

    // SP: https://discuss.leetcode.com/topic/18387/3-lines-with-o-1-space-1-liners-alternatives
    public TreeNode lowestCommonAncestorSP(TreeNode root, TreeNode p, TreeNode q) {
        while ((root.val - p.val) * (root.val - q.val) > 0)
            root = p.val < root.val ? root.left : root.right;
        return root;
    }

    // LC: 230. Kth Smallest Element in a BST
    // Given a binary search tree, write a function kthSmallest to find the kth smallest element in it.
    // Note:
    // You may assume k is always valid, 1 ≤ k ≤ BST's total elements.
    // Follow up:
    // What if the BST is modified (insert/delete operations) often and you need to find the kth smallest frequently?
    // How would you optimize the kthSmallest routine?
    // https://discuss.leetcode.com/topic/17810/3-ways-implemented-in-java-python-binary-search-in-order-iterative-recursive
    // SP: https://discuss.leetcode.com/topic/17573/4-lines-in-c
    public int kthSmallest(TreeNode root, int k) {
        int count = countNodes(root.left);
        if (k <= count) {
            return kthSmallest(root.left, k);
        } else if (k > count + 1) {
            return kthSmallest(root.right, k-1-count); // 1 is counted as current node
        }

        return root.val;
    }

    public int countNodes(TreeNode n) {
        if (n == null) return 0;

        return 1 + countNodes(n.left) + countNodes(n.right);
    }

    // LC: 226. Invert Binary Tree
    // Time: O(n), Space: O(h)
    // SP: https://discuss.leetcode.com/topic/16062/3-4-lines-python
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

    // LC: 222. Count Complete Tree Nodes
    // Given a complete binary tree, count the number of nodes.
    // Definition of a complete binary tree from Wikipedia:
    // In a complete binary tree every level, except possibly the last, is completely filled, and all nodes in the
    // last level are as far left as possible. It can have between 1 and 2h nodes inclusive at the last level h.
    // Subscribe to see which companies asked this question.
    // SP: https://discuss.leetcode.com/topic/15533/concise-java-solutions-o-log-n-2
    // Time: O(log(n)^2)
    int height(TreeNode root) {
        return root == null ? -1 : 1 + height(root.left);
    }
    public int countNodes(TreeNode root) {
        int h = height(root);
        return h < 0 ? 0 :
                height(root.right) == h-1 ? (1 << h) + countNodes(root.right)
                        : (1 << h-1) + countNodes(root.left);
    }

    // https://discuss.leetcode.com/topic/21317/accepted-easy-understand-java-solution
    public int countNodes2(TreeNode root) {

        int leftDepth = leftDepth(root);
        int rightDepth = rightDepth(root);

        if (leftDepth == rightDepth)
            return (1 << leftDepth) - 1;
        else
            return 1+countNodes2(root.left) + countNodes2(root.right);

    }

    private int rightDepth(TreeNode root) {
        // TODO Auto-generated method stub
        int dep = 0;
        while (root != null) {
            root = root.right;
            dep++;
        }
        return dep;
    }

    private int leftDepth(TreeNode root) {
        // TODO Auto-generated method stub
        int dep = 0;
        while (root != null) {
            root = root.left;
            dep++;
        }
        return dep;
    }

    // LC: 199. Binary Tree Right Side View
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

    // https://discuss.leetcode.com/topic/11768/my-simple-accepted-solution-java/1
    public List<Integer> rightSideViewDFS(TreeNode root) {
        List<Integer> result = new ArrayList<Integer>();
        rightView(root, result, 0);
        return result;
    }

    public void rightView(TreeNode curr, List<Integer> result, int currDepth){
        if(curr == null){
            return;
        }
        if(currDepth == result.size()){
            result.add(curr.val);
        }

        rightView(curr.right, result, currDepth + 1);
        rightView(curr.left, result, currDepth + 1);

    }

    // https://discuss.leetcode.com/topic/11315/reverse-level-order-traversal-java
    public List<Integer> rightSideViewBFS(TreeNode root) {
        // reverse level traversal
        List<Integer> result = new ArrayList();
        Queue<TreeNode> queue = new LinkedList();
        if (root == null) return result;

        queue.offer(root);
        while (queue.size() != 0) {
            int size = queue.size();
            for (int i=0; i<size; i++) {
                TreeNode cur = queue.poll();
                if (i == 0) result.add(cur.val);
                if (cur.right != null) queue.offer(cur.right);
                if (cur.left != null) queue.offer(cur.left);
            }

        }
        return result;
    }

    // LC: 173. Binary Search Tree Iterator
    // @see Stacks

    // LC: 145. Binary Tree Postorder Traversal
    // @see Stacks

    // LC: 144. Binary Tree Preorder Traversal
    // @see Stacks


    // LC: 129. Sum Root to Leaf Numbers
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/6731/short-java-solution-recursion
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


    // LC: 124. Binary Tree Maximum Path Sum
    // Given a binary tree, find the maximum path sum.
    // For this problem, a path is defined as any sequence of nodes from some starting node to any node in the tree
    // along the parent-child connections. The path must contain at least one node and does not need to go through the
    // root.
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/17823/elegant-java-solution
    // https://discuss.leetcode.com/topic/4407/accepted-short-solution-in-java
    int max = Integer.MIN_VALUE;

    public int maxPathSum(TreeNode root) {
        helper(root);
        return max;
    }

    // helper returns the max branch
    // plus current node's value
    int helper(TreeNode root) {
        if (root == null) return 0;

        int left = Math.max(helper(root.left), 0);
        int right = Math.max(helper(root.right), 0);

        max = Math.max(max, root.val + left + right);

        return root.val + Math.max(left, right);
    }

    // LC: 117. Populating Next Right Pointers in Each Node II
    // Follow up for problem "Populating Next Right Pointers in Each Node".
    // What if the given tree could be any binary tree? Would your previous solution still work?
    // Note: You may only use constant extra space.
    // @todo: UNSOLVED
    public void connect2(TreeLinkNode root) {

        TreeLinkNode head = null; //head of the next level
        TreeLinkNode prev = null; //the leading node on the next level
        TreeLinkNode cur = root;  //current node of current level

        while (cur != null) {

            while (cur != null) { //iterate on the current level
                //left child
                if (cur.left != null) {
                    if (prev != null) {
                        prev.next = cur.left;
                    } else {
                        head = cur.left;
                    }
                    prev = cur.left;
                }
                //right child
                if (cur.right != null) {
                    if (prev != null) {
                        prev.next = cur.right;
                    } else {
                        head = cur.right;
                    }
                    prev = cur.right;
                }
                //move to next node
                cur = cur.next;
            }

            //move to next level
            cur = head;
            head = null;
            prev = null;
        }

    }

    // LC: 116. Populating Next Right Pointers in Each Node
    // Time: O(n), Space:O(h)
    // https://discuss.leetcode.com/topic/2202/a-simple-accepted-solution/2
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
    void connectItr(TreeLinkNode root) {
        if (root == null) return;
        TreeLinkNode pre = root;
        TreeLinkNode cur = null;
        while(pre.left != null) {
            cur = pre;
            while(cur != null) {
                cur.left.next = cur.right;
                if(cur.next != null) cur.right.next = cur.next.left;
                cur = cur.next;
            }
            pre = pre.left;
        }
    }

    // LC: 114. Flatten Binary Tree to Linked List
    // @see DFS

    // LC: 113. Path Sum II
    // @see DFS


    // LC: 112. Path Sum
    // @see DFS

    // LC: 111. Minimum Depth of Binary Tree
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/8723/my-4-line-java-solution
    public int minDepth(TreeNode root) {
        if (root == null) { return 0; }
        if (root.left == null) { return 1 + minDepth(root.right); }
        if (root.right == null) { return 1 + minDepth(root.left); }

        return 1 + Math.min(minDepth(root.left), minDepth(root.right));
    }

    public int minDepth2(TreeNode root) {
        if(root == null) return 0;
        int left = minDepth(root.left);
        int right = minDepth(root.right);
        return (left == 0 || right == 0) ? left + right + 1: Math.min(left,right) + 1;

    }

    // BFS https://discuss.leetcode.com/topic/25893/bfs-c-8ms-beats-99-94-submissions
    int minDepthBFS(TreeNode root) {
        if (root == null) return 0;
        Queue<TreeNode> Q = new LinkedList<>();

        Q.offer(root);
        int i = 0;
        while (!Q.isEmpty()) {
            i++;
            int k = Q.size();
            for (int j=0; j<k; j++) {
                TreeNode rt = Q.poll();
                if (rt.left != null) Q.offer(rt.left);
                if (rt.right != null) Q.offer(rt.right);

                if (rt.left==null && rt.right==null) return i;
            }
        }
        return -1; //For the compiler thing. The code never runs here.
    }

    // LC: 110. Balanced Binary Tree
    // Given a binary tree, determine if it is height-balanced.
    // For this problem, a height-balanced binary tree is defined as a binary tree in which the depth of the two
    // subtrees of every node never differ by more than 1.
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


    // LC: 108: Convert Sorted Array to Binary Search Tree
    // Time: O(n), Space: O(log n) for the recursion
    // https://discuss.leetcode.com/topic/3158/my-accepted-java-solution
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

    // LC: 107. Binary Tree Level Order Traversal II
    // Given a binary tree, return the bottom-up level order traversal of its nodes' values.
    // (ie, from left to right, level by level from leaf to root).
    public List<List<Integer>> levelOrderBottomBFS(TreeNode root) {
        Queue<TreeNode> queue = new LinkedList<TreeNode>();
        List<List<Integer>> wrapList = new LinkedList<List<Integer>>();

        if(root == null) return wrapList;

        queue.offer(root);
        while(!queue.isEmpty()){
            int levelNum = queue.size();
            List<Integer> subList = new LinkedList<Integer>();
            for(int i=0; i<levelNum; i++) {
                if(queue.peek().left != null) queue.offer(queue.peek().left);
                if(queue.peek().right != null) queue.offer(queue.peek().right);
                subList.add(queue.poll().val);
            }
            wrapList.add(0, subList);
        }
        return wrapList;
    }

    public List<List<Integer>> levelOrderBottomDFS(TreeNode root) {
        List<List<Integer>> wrapList = new LinkedList<List<Integer>>();
        levelMaker(wrapList, root, 0);
        return wrapList;
    }

    public void levelMaker(List<List<Integer>> list, TreeNode root, int level) {
        if(root == null) return;
        if(level >= list.size()) {
            list.add(0, new LinkedList<Integer>());
        }
        levelMaker(list, root.left, level+1);
        levelMaker(list, root.right, level+1);
        list.get(list.size()-level-1).add(root.val);
    }

    // LC: 106. Construct Binary Tree from Inorder and Postorder Traversal
    // @todo: UNSOLVED
    // @see Arrays

    // LC: 105. Construct Binary Tree from Preorder and Inorder Traversal
    // @see Arrays

    // LC: 104. Maximum Depth of Binary Tree
    // @see DFS

    // LC: 103. Binary Tree Zigzag Level Order Traversal
    // https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/?tab=Description
    // https://discuss.leetcode.com/topic/3413/my-accepted-java-solution
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

    public List<List<Integer>> zigzagLevelOrderDFS(TreeNode root)
    {
        List<List<Integer>> sol = new ArrayList<>();
        travel(root, sol, 0);
        return sol;
    }

    private void travel(TreeNode curr, List<List<Integer>> sol, int level)
    {
        if(curr == null) return;

        if(sol.size() <= level)
        {
            List<Integer> newLevel = new LinkedList<>();
            sol.add(newLevel);
        }

        List<Integer> collection  = sol.get(level);
        if(level % 2 == 0) collection.add(curr.val);
        else collection.add(0, curr.val);

        travel(curr.left, sol, level + 1);
        travel(curr.right, sol, level + 1);
    }


    // LC: 102. Binary Tree Level Order Traversal
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

    // LC: 101. Symmetric Tree
    // Time: O(n), space: O(h)
    // https://leetcode.com/problems/symmetric-tree/?tab=Description
    // @see DFS

    // LC: 100. Same Tree
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

    // LC: 99. Recover Binary Search Tree
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/3988/no-fancy-algorithm-just-simple-and-powerful-in-order-traversal/2
    TreeNode firstElement = null;
    TreeNode secondElement = null;
    // The reason for this initialization is to avoid null pointer exception in the first comparison when prevElement has not been initialized
    TreeNode prevElement = new TreeNode(Integer.MIN_VALUE);

    public void recoverTree(TreeNode root) {

        // In order traversal to find the two elements
        traverse(root);

        // Swap the values of the two nodes
        int temp = firstElement.val;
        firstElement.val = secondElement.val;
        secondElement.val = temp;
    }

    private void traverse(TreeNode root) {

        if (root == null)
            return;

        traverse(root.left);

        // Start of "do some business",
        // If first element has not been found, assign it to prevElement (refer to 6 in the example above)
        if (firstElement == null && prevElement.val >= root.val) {
            firstElement = prevElement;
        }

        // If first element is found, assign the second element to the root (refer to 2 in the example above)
        if (firstElement != null && prevElement.val >= root.val) {
            secondElement = root;
        }
        prevElement = root;

        // End of "do some business"

        traverse(root.right);
    }

    // LC: 98. Validate Binary Search Tree
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/validate-binary-search-tree/?tab=Solutions
    // @see DFS

    // LC: 96. Unique Binary Search Trees
    // @todo: Unsolved
    // Time: O(n!)?? Space: O(n)
    // https://discuss.leetcode.com/topic/8398/dp-solution-in-6-lines-with-explanation-f-i-n-g-i-1-g-n-i/2
    // @see Dynamic Programming


    // LC: 95. Unique Binary Search Trees II
    // @todo: UNSOLVED
    // Time: ?? Space: ??
    // https://discuss.leetcode.com/topic/8410/divide-and-conquer-f-i-g-i-1-g-n-i
    // @see Dynamic Programming


    // LC: 94. Binary Tree Inorder Traversal
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/6478/iterative-solution-in-java-simple-and-readable
    // @see Stacks

}
