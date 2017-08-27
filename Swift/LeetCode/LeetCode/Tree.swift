//
//  Tree.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/8/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Tree {
    
    // LC:99. Recover Binary Search Tree
    var first : TreeNode?
    var second : TreeNode?
    var prev  : TreeNode?
    
    func traverse(_ root : TreeNode?) {
        if let root = root {
            traverse(root.left)
            
            if first == nil && prev != nil && prev!.val >= root.val {
                first = prev
            }
            if first != nil && first!.val >= root.val {
                second = root
            }
            prev = root;
            
            traverse(root.right)
        }
    }
    
    func recoverTree(_ root: TreeNode?) {
        traverse(root);
        if var first = first, var second = second {
            let temp = first.val;
            first.val = second.val;
            second.val = temp
        }
    }
    
    // LC:95. Unique Binary Search Trees II
    func genTrees(_ start : Int, _ end : Int) -> [TreeNode?] {
        var result = [TreeNode?]()
        if start > end {
            return result;
        }
        if start == end {
            let temp = TreeNode(start);
            result.append(temp)
            return result;
        }
        
        for ix in start...end {
            let left = genTrees(start, ix - 1)
            let right = genTrees(ix + 1, end)
            
            if left.count != 0 && right.count != 0 {
                
                for lnode in left {
                    for rnode in right {
                        let root = TreeNode(ix)
                        root.left = lnode
                        root.right = rnode
                        result.append(root)
                    }
                }
            } else if left.count == 0 && right.count != 0 {
                for rnode in right {
                    let root = TreeNode(ix)
                    root.right = rnode
                    result.append(root)
                }
            } else if right.count == 0 && left.count != 0 {
                for lnode in left {
                    let root = TreeNode(ix)
                    root.left = lnode
                    result.append(root)
                }
            }
            else {
                let root = TreeNode(ix)
                result.append(root)
            }
        }
        return result
    }
    
    func generateTrees(_ n: Int) -> [TreeNode?] {
        return genTrees(1, n);
    }
    
    // LC:96. Unique Binary Search Trees
    // Hard
    // G(n): the number of unique BST for a sequence of length n.
    // F(i, n), 1 <= i <= n: the number of unique BST, where the number i is the root of BST, and the sequence ranges from 1 to n.
    // G(n) = F(1, n) + F(2, n) + ... + F(n, n). 
    // G(0)=1, G(1)=1. 
    // F(i, n) = G(i-1) * G(n-i)	1 <= i <= n 
    // combining the two:
    // G(n) = G(0) * G(n-1) + G(1) * G(n-2) + … + G(n-1) * G(0)
    // https://discuss.leetcode.com/topic/8398/dp-solution-in-6-lines-with-explanation-f-i-n-g-i-1-g-n-i
    func numTrees(_ n: Int) -> Int {
        var G = [Int](repeating: 0, count: n + 1);
        G[0] = 1; G[1] = 1;
        if n >= 2 {
            
            
            for ix in 2...n {
                for jx in 1...ix {
                    G[ix] += G[jx - 1] * G[ix - jx]
                }
            }
        }
        return G[n]
    }
    
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
    
    // LC:103. Binary Tree Zigzag Level Order Traversal
    func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]()
        if let root = root {
            var queue = [TreeNode]()
            var level = [Int]()
            var isOdd = true
            queue.append(root)
            var numInLevel = 1
            
            while queue.count > 0 {
                let first = queue.removeFirst()
                numInLevel -= 1
                level.append(first.val)
                if let left = first.left {
                    queue.append(left)
                }
                if let right = first.right {
                    queue.append(right)
                }
                if numInLevel == 0 {
                    numInLevel = queue.count
                    if isOdd == false {
                        isOdd = true
                        result.append(level.reversed())
                    } else {
                        isOdd = false
                        result.append(level)
                    }
                    level = [Int]()
                }
            }
        }
        return result
    }
    
    // LC: 104. Maximum Depth of Binary Tree
    // @see: DFS

    // LC:105. Construct Binary Tree from Preorder and Inorder Traversal
    // @see: Arrays
    
    // LC:106. Construct Binary Tree from Inorder and Postorder Traversal
    // @see: Arrays
    
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
    
    // LC:124. Binary Tree Maximum Path Sum
    // @todo: didn't pass all test cases
    var maxSoFar = Int.min
    
    func maxPathSumHelper(_ root: TreeNode?) -> Int {
        if let root = root {
            let left = maxPathSum(root.left)
            let right = maxPathSum(root.right)
            maxSoFar = max(left + right + root.val, maxSoFar)
            return max(left, right) + root.val
        }
        return 0;
    }
    
    func maxPathSum(_ root: TreeNode?) -> Int {
        maxPathSumHelper(root);
        return maxSoFar
    }
    
    // LC:129. Sum Root to Leaf Numbers
    // @see DFS
    
    // LC:144. Binary Tree Preorder Traversal
    // @see Stacks
    
    // LC:173. Binary Search Tree Iterator
    /*
     class BSTIterator {
            stack<TreeNode*> st;
        public:
     
            void save(TreeNode* root) {
                while (root) {
                    st.push(root);
                    root = root->left;
                }
            }
     
            BSTIterator(TreeNode *root) {
                save(root);
            }
     
            /** @return whether we have a next smallest number */
            bool hasNext() {
                return st.size() > 0;
            }
     
            /** @return the next smallest number */
            int next() {
                TreeNode* top = st.top();
                st.pop();
                save(top->right);
                return top->val;
            }
     };
     */

    
    // LC:199. Binary Tree Right Side View
    // @see BFS
    
    
    // LC:222. Count Complete Tree Nodes
    /*
    int countNodes(TreeNode* root) {
    
        if (!root) return 0;
    
        int hl=0, hr=0;
    
        TreeNode *l=root, *r=root;
    
        while (l) {hl++;l=l->left;}
    
        while (r) {hr++;r=r->right;}
    
        if (hl==hr) return (1 << hl) - 1;
    
        return 1+countNodes(root->left)+countNodes(root->right);
    
    }
    */
    
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
    
    // LC:230. Kth Smallest Element in a BST
    /*
    int kthSmallest(TreeNode* root, int& k) {
        if (root) {
            int x = kthSmallest(root->left, k);
            return !k ? x : !--k ? root->val : kthSmallest(root->right, k);
        }
    }
    */
    
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
    
    //LC:404. Sum of Left Leaves
    func sumOfLeftLeavesHelper(_ root : TreeNode?, _ isLeft : Bool) -> Int {
        if let root = root {
            if root.left == nil && root.right == nil {
                return isLeft ? root.val : 0
            }
            
            return sumOfLeftLeavesHelper(root.left, true) + sumOfLeftLeavesHelper(root.right, false)
        }
        return 0
    }
    
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        return sumOfLeftLeavesHelper(root, false)
    }
    
    // LC:450. Delete Node in a BST
    func findMin(_ root : TreeNode?) -> TreeNode? {
        if let root = root {
            var root = root
            while root.left != nil {
                root = root.left!
            }
            return root
        }
        return nil
    }
    
    func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
        if let root = root {
            if key < root.val {
                root.left = deleteNode(root.left, key)
                return root
            } else if key > root.val {
                root.right = deleteNode(root.right, key)
                return root
            } else {
                if root.left == nil && root.right == nil {
                    return nil
                }
                if root.left == nil {
                    return root.right
                }
                if root.right == nil {
                    return root.left
                }
                let minNode = findMin(root.right)
                if let minNode = minNode {
                    root.val = minNode.val
                    root.right = deleteNode(root.right, minNode.val)
                }
                return root
            }
        }
        return nil
    }
    
    // LC:501. Find Mode in Binary Search Tree
    var prev : Int?
    var count = 1
    var maxCount = 1
    var modes : [Int]?
    
    func findMode(_ root: TreeNode?) -> [Int] {
        
        var result = [Int]()
        traverse(root, &result)
        return result
    }
    
    func traverse(_ root : TreeNode?, _ result : inout [Int]) {
        if let root = root {
            traverse(root.left, &result)
            
            if let prev = prev {
                if prev == root.val {
                    count += 1
                } else {
                    count = 1
                }
            }
            
            if count > maxCount {
                result.removeAll(keepingCapacity: false)
                result.append(root.val)
                maxCount = count
            } else if count == maxCount {
                result.append(root.val);
            }
            prev = root.val
            traverse(root.right, &result)
        }
    }
    
    // LC:513. Find Bottom Left Tree Value
    // @see: BFS
    
    // LC:515. Find Largest Value in Each Tree Row
    // @see: BFS
    
    
    // LC:538. Convert BST to Greater Tree
    var sum = 0
    
    func convertBST(_ root: TreeNode?) -> TreeNode? {
        if let root = root {
            _ = convertBST(root.right)
            root.val += sum
            sum = root.val
            _ = convertBST(root.left)
            return root
        }
        return nil
    }
    
    // LC:543. Diameter of Binary Tree
    var maxVal = 0
    
    func maxDepth(_ root : TreeNode?) -> Int {
        if let root = root {
            let left = maxDepth(root.left)
            let right = maxDepth(root.right)
            maxVal = max(maxVal, left + right)
            return max(left, right) + 1
        }
        return 0
    }
    
    func diameterOfBinaryTree(_ root: TreeNode?) -> Int {
        if let root = root {
            maxDepth(root)
            return maxVal
        }
        return 0;
    }
    
    // LC:563. Binary Tree Tilt
    var totalTilt = 0
    
    func postOrder(_ root : TreeNode?) -> Int {
        if let root = root {
            let left = postOrder(root.left)
            let right = postOrder(root.right)
            
            totalTilt += abs(left - right)
            return left + right + root.val
        }
        return 0
    }
    
    func findTilt(_ root: TreeNode?) -> Int {
        postOrder(root)
        return totalTilt
    }
    
    // LC:572. Subtree of Another Tree
    func isSame(_ s : TreeNode?, _ t : TreeNode?) -> Bool {
        if s == nil && t == nil { return true; }
        if s == nil || t == nil { return false; }
        if s!.val != t!.val { return false }
        
        return isSame(s!.left, t!.left) && isSame(s!.right, t!.right)
    }
    
    func isSubtree(_ s: TreeNode?, _ t: TreeNode?) -> Bool {
        if let s = s {
            if isSame(s, t) { return true }
            return isSubtree(s.left, t) || isSubtree(s.right, t)
        }
        return false
    }
    
    // LC:617. Merge Two Binary Trees
    func mergeTrees(_ t1: TreeNode?, _ t2: TreeNode?) -> TreeNode? {
        if t1 == nil && t2 == nil { return nil; }
        if t1 == nil {  return t2  }
        if t2 == nil { return t1  }
        let newNode = TreeNode(x: t1!.val + t2!.val)
        newNode.left = mergeTrees(t1!.left, t2!.left)
        newNode.right = mergeTrees(t1!.right, t2!.right)
        return newNode
    }
    
    // LC:637. Average of Levels in Binary Tree
    // @todo: just use BFS
    
    
    // LC:653. Two Sum IV - Input is a BST
    var set = Set<Int>()
    
    
    func findTarget(_ root: TreeNode?, _ k: Int) -> Bool {
        if let root = root {
            if set.contains(k - root.val) { return true }
            set.insert(root.val)
            return findTarget(root.left, k) || findTarget(root.right, k)
        }
        return false;
    }
}
