//
//  Tree.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/8/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Tree {
    
    // LC: 98. Validate Binary Search Tree
    // @see: DFS
    
    // LC: 100. Same Tree
    // @see: DFS
    
    // LC:102. Binary Tree Level Order Traversal
    func levelOrderHelper(_ root: TreeNode?, _ result : inout [[Int]], _ level : Int) {
        guard root != nil else { return; }
        if result.count == level {
            result.append([Int]())
        }
        if let root = root {
            result[level].append(root.val)
            levelOrderHelper(root.left, &result, level + 1);
            levelOrderHelper(root.right, &result, level + 1);
        }
    }
    
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]();
        levelOrderHelper(root, &result, 0);
        return result
    }
    
    // LC: 104. Maximum Depth of Binary Tree
    // @see: DFS

    // LC:107. Binary Tree Level Order Traversal II
    // @see easy
    
    // LC:108. Convert Sorted Array to Binary Search Tree
    // @see DFS
    
    // LC:110. Balanced Binary Tree
    // @see DFS
    
    // LC:111. Minimum Depth of Binary Tree
    // @see BFS, DFS
    
    // LC:112. Path Sum
    // @see DFS
    
    // LC:113. Path Sum II
    // @see DFS
    
    
    // LC:116. Populating Next Right Pointers in Each Node
    /*
    public void connect(TreeLinkNode root) {
    
        while (root != null) {
            TreeLinkNode itr = root;
            do {
                if (itr.left != null) {
                    itr.left.next = itr.right;
                }
                if (itr.right != null && itr.next != null) {
                    itr.right.next = itr.next.left;
                }
                itr = itr.next;
            } while (itr != null);
            root = root.left;
        }
    }
    */
    
    // LC: 117. Populating Next Right Pointers in Each Node II
    /*
    public void connect(TreeLinkNode root) {
        TreeLinkNode head = null;
        while (root != null) {
            TreeLinkNode itr = root;
            TreeLinkNode prev = null;
            do {
                if (itr.left != null) {
                    if (prev != null) {
                        prev.next = itr.left;
                    } else {
                        head = itr.left;
                    }
                    prev = itr.left;
                }
                if (itr.right != null) {
                    if (prev != null) {
                        prev.next = itr.right;
                    } else {
                        head = itr.right;
                    }
                    prev = itr.right;
                }
                itr = itr.next;
            } while (itr != null);
            root = head;
            head = null;
        }
    }
    */
    
    // LC:129. Sum Root to Leaf Numbers
    // @see DFS
    
    // LC:199. Binary Tree Right Side View
    // @see BFS
    
    // LC:226. Invert Binary Tree
    func invertTree(_ root: TreeNode?) -> TreeNode? {
        if let root = root {
            let temp = root.left
            root.left = root.right
            root.right = temp
            invertTree(root.left)
            invertTree(root.right)
            return root
        }
        return nil
    }
    
    // LC:235. Lowest Common Ancestor of a Binary Search Tree
    /*
    public TreeNode lowestCommonAncestor(TreeNode root, TreeNode p, TreeNode q) {
    if (p.val > q.val) {
    return lowestCommonAncestorHelper(root, q, p);
    }
    return lowestCommonAncestorHelper(root, p, q);
    }
    
    public TreeNode lowestCommonAncestorHelper(TreeNode root, TreeNode p, TreeNode q) {
    if (root == null) { return null; }
    if (root.val >= p.val && root.val <= q.val) { return root; }
    if (root.val > p.val && root.val > q.val) { return lowestCommonAncestorHelper(root.left, p, q); }
    return lowestCommonAncestorHelper(root.right, p, q);
    }
    */
    
    // LC:257. Binary Tree Paths
    func binaryTreePathsHelper(_ root: TreeNode?, _ result : inout [String], _ partial : String){
        if let root = root {
            var partial = partial;
            partial += String(root.val);
            if root.left == nil && root.right == nil {
                result.append(partial);
                return;
            }
            if root.left != nil {
                binaryTreePathsHelper(root.left, &result, partial + "->");
            }
            if root.right != nil {
                binaryTreePathsHelper(root.right, &result, partial + "->");
            }
        }
    }
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var result = [String]();
        binaryTreePathsHelper(root, &result, "");
        return result;
    }
}
