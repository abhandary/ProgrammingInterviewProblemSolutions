//
//  DFS.swift
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 AkshayBhandary. All rights reserved.
//

import Foundation

class DFS {
    
    // MARK: - 112. Path Sum
    func hasPathSumHelper(root: TreeNode?, _ sum: Int, _ partial:Int) ->Bool {
        guard let root = root else {return false}
        let partialSum = partial + root.val
        if root.left == nil && root.right == nil && partialSum == sum {
            return true
        }
        return hasPathSumHelper(root.left, sum, partialSum) || hasPathSumHelper(root.right, sum, partialSum)
    }
    func hasPathSum(root: TreeNode?, _ sum: Int) -> Bool {
        return hasPathSumHelper(root, sum, 0);
    }
    
    // MARK: - 104. Maximum Depth of Binary Tree
    func maxDepth(root: TreeNode?) -> Int {
        if root == nil {
            return 0
        }
        return max(maxDepth(root?.left), maxDepth(root?.right)) + 1
    }
    
    // MARK: - 199. Binary Tree Right Side View
    func rightSideView(root: TreeNode?) -> [Int] {
        var queue = [TreeNode]()
        var result = [Int]()
        
        guard let root = root else {return result}
        
        result.append(root.val)
        queue.append(root)
        
        var numNodesInLevel = 1
        
        while queue.count > 0 {
            let current = queue[0]
            if let left = current.left {
                queue.append(left)
            }
            if let right = current.right {
                queue.append(right)
            }
            queue.removeAtIndex(0)
            numNodesInLevel--
            if numNodesInLevel == 0 {
                if let val = queue.last?.val {
                    result.append(val)
                }
                numNodesInLevel = queue.count
            }
        }
        return result
    }
}


