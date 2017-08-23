//
//  BFS.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/14/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class BFS {
    
    // LC:515. Find Largest Value in Each Tree Row
    func largestValues(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        if let root = root {
            var queue = [TreeNode]()
            queue.append(root)
            var numInLevel = 1
            var maxInLevel = Int.min
            
            while queue.count > 0 {
                let first = queue.removeFirst()
                numInLevel -= 1
                maxInLevel = max(maxInLevel, first.val)
                if let left = first.left {
                    queue.append(left)
                }
                if let right = first.right {
                    queue.append(right)
                }
                if numInLevel == 0 {
                    numInLevel = queue.count
                    result.append(maxInLevel)
                    maxInLevel = Int.min
                }
            }
        }
        return result
    }
    
    // LC:513. Find Bottom Left Tree Value
    func findBottomLeftValue(_ root: TreeNode?) -> Int {
        var result = 0
        if let root = root {
            var queue = [TreeNode]()
            queue.append(root)
            var numInLevel = 1
            result = root.val
            while queue.count > 0 {
                let first = queue.removeFirst()
                numInLevel -= 1
                if let left = first.left {
                    queue.append(left)
                }
                if let right = first.right {
                    queue.append(right)
                }
                if numInLevel == 0 {
                    numInLevel = queue.count
                    if let first = queue.first {
                        result = first.val
                    }
                }
            }
        }
        return result
    }
    
    
    // LC:199. Binary Tree Right Side View
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard root != nil else { return []; }
        
        var result = [Int]();
        var queue = [TreeNode]();
        queue.append(root!);
        var numInLevel = 1;
        var lastSeen = 0
        while(queue.count > 0) {
            let current = queue.removeFirst();
            
            if let left = current.left { queue.append(left); }
            if let right = current.right { queue.append(right); }
            
            lastSeen = current.val
            
            numInLevel -= 1;
            if (numInLevel == 0) {
                result.append(lastSeen);
                numInLevel = queue.count;
            }
        }
        return result;
    }
    
    // LC:111. Minimum Depth of Binary Tree
    func minDepth(_ root: TreeNode?) -> Int {
        if let root = root {
            var queue = [TreeNode]()
            var numInLevel = 1
            var depth = 1
            queue.append(root)
            
            while queue.count > 0 {
                let first = queue.removeFirst()
                if first.left == nil && first.right == nil { return depth }
                numInLevel -= 1
                if let left = first.left {
                    queue.append(left)
                }
                if let right = first.right {
                    queue.append(right)
                }
                
                if numInLevel == 0 {
                    numInLevel = queue.count
                    depth += 1
                }
            }
        }
        return 0
    }
    
    // LC:104. Binary Tree Zigzag Level Order Traversal II
    // @see 103, just reverse the result
    
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
    
    // LC:102. Binary Tree Level Order Traversal
    func levelOrder(_ root: TreeNode?) -> [[Int]] {
        var result = [[Int]]();
        
        if let root = root {
            var queue = [TreeNode]();
            var numInLevel = 1
            var level = [Int]()
            queue.append(root)
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
                    result.append(level)
                    level = [Int]()
                }
            }
        }
        return result
    }
    
    // LC:101. Symmetric Tree
    func isSymmetricHelper(_ left : TreeNode?, _ right : TreeNode?) -> Bool {
        if left == nil && right == nil { return true; }
        if left == nil || right == nil || left!.val != right!.val { return false;}
        return isSymmetricHelper(left!.right, right!.left) && isSymmetricHelper(left!.left, right!.right);
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil { return true; }
        return isSymmetricHelper(root!.left, root!.right);
    }

}
