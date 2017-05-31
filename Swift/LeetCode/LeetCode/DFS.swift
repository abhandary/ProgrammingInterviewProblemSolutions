//
//  DFS.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/22/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

//class TreeNode {
//    public var val: Int
//    public var left: TreeNode?
//    public var right: TreeNode?
//    public init(_ val: Int) {
//        self.val = val
//        self.left = nil
//        self.right = nil
//    }
//}

class DFS {
    
    var cache : [[Int]]!;
    func longestIncreasingPathHelper(_ matrix: inout [[Int]], _ ix : Int, _ jx : Int)  -> Int {
        
        if cache[ix][jx] != 0 { return cache[ix][jx]; }
        
        let dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        
        var maxVal = 1;
        for dx in 0..<dirs.count {
            let x = ix + dirs[dx][0], y = jx + dirs[dx][1];
            
            if x < 0 || x >= matrix.count || y < 0 || y >= matrix[0].count || matrix[x][y] <= matrix[ix][jx] { continue; }
            
            let len = 1 + longestIncreasingPathHelper(&matrix, x, y);
            maxVal = max(maxVal, len);
            
        }
        cache[ix][jx] = maxVal;
        return maxVal;
    }
    
    
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        
        guard matrix.count > 0 else { return 0; }
        cache = [[Int]](repeating: [Int](repeating: 0, count: matrix[0].count), count: matrix.count);
        var matrix = matrix;
        var maxVal = 1;
        for ix in 0..<matrix.count {
            for jx in 0..<matrix[0].count {
                maxVal = max(longestIncreasingPathHelper(&matrix, ix, jx), maxVal);
            }
        }
        return maxVal;
    }
    
    
    
    // LC: 257. Binary Tree Paths
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
    
    // LC: 200. Number of Islands
    func cover(_ grid : inout [[Character]], _ ix : Int, _ jx : Int) {
        
        if ix < 0 || ix >= grid.count || jx < 0 || jx >= grid[0].count { return; }
        if grid[ix][jx] == "0" { return; }
        
        let dir = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        
        grid[ix][jx] = "X";
        for dx in 0..<dir.count {
            cover(&grid, ix + dir[dx][0], jx + dir[dx][1]);
        }
        
    }
    
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0 else { return 0; }
        var gridCopy = grid;
        var count = 0;
        for ix in 0..<grid.count {
            for jx in 0..<grid[0].count {
                if grid[ix][jx] == "1" {
                    count += 1;
                    cover(&gridCopy, ix, jx);
                }
            }
        }
        return count;
    }
    
    // LC: 199. Binary Tree Right Side View
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard root != nil else { return []; }
        
        var result = [Int]();
        var queue = [TreeNode]();
        queue.append(root!);
        var numInLevel = 1;
        var level = [Int]();
        while(queue.count > 0) {
            let current = queue.removeFirst();
            
            if let left = current.left { queue.append(left); }
            if let right = current.right { queue.append(right); }
            
            level.append(current.val);
            numInLevel -= 1;
            if (numInLevel == 0) {
                result.append(level.last!);
                level = [Int]();
                numInLevel = queue.count;
            }
        }
        return result;
        
    }
    
    // LC: 129. Sum Root to Leaf Numbers
    func sumNumbersHelper(_ root : TreeNode?, _ partial : Int, _ result : inout Int) {
        if let root = root {
            var partial = partial;
            partial *= 10;
            partial += root.val;
            if root.left == nil && root.right == nil {
                result += partial;
            }
            sumNumbersHelper(root.left, partial, &result);
            sumNumbersHelper(root.right, partial, &result);
        }
    }
    
    func sumNumbers(_ root: TreeNode?) -> Int {
        if root == nil { return 0; }
        var result = 0;
        sumNumbersHelper(root, 0, &result);
        return result;
    }
    
    // 110. Balanced Binary Tree
    func isBalancedHelper(_ root : TreeNode?) -> (Bool, Int) {
        
        if let root = root {
            var leftResult : (Bool, Int) = (false, 0);
            if let left = root.left {
                leftResult = isBalancedHelper(left);
                if leftResult.0 == false { return (false, -1); }
            }
            var rightResult : (Bool, Int) = (false, 0);
            if let right = root.right {
                rightResult = isBalancedHelper(right);
                if rightResult.0 == false { return (false, -1); }
            }
            return (abs(leftResult.1 - rightResult.1) <= 1, max(leftResult.1, rightResult.1) + 1);
        }
        return (true, 0);
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        let result =  isBalancedHelper(root);
        return result.0;      
    }

    
    // 108. Convert Sorted Array to Binary Search Tree
    func sortedArrayToBSTHelper(_ nums: [Int], _ left : Int, _ right : Int) -> TreeNode? {
        if left > right { return nil; }
        let mid = left + (right - left) / 2;
        var root = TreeNode(x: nums[mid]);
        root.left = sortedArrayToBSTHelper(nums, left, mid - 1);
        root.right = sortedArrayToBSTHelper(nums, mid + 1, right);
        return root;
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else { return nil; }
        
        return   sortedArrayToBSTHelper(nums, 0, nums.count - 1);
    }
    
    
    
    // LC: 104. Maximum Depth of Binary Tree
    func maxDepth(_ root: TreeNode?) -> Int {
        if let root = root {
            return 1 + max(maxDepth(root.left), maxDepth(root.right));
        }
        return 0;
    }
    
    // LC: 101. Symmetric Tree
    func isSymmetricHelper(_ left : TreeNode?, _ right : TreeNode?) -> Bool {
        if left == nil && right == nil { return true; }
        if left == nil || right == nil || left!.val != right!.val { return false;}
        return isSymmetricHelper(left!.right, right!.left) && isSymmetricHelper(left!.left, right!.right);
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil { return true; }
        return isSymmetricHelper(root!.left, root!.right);
    }
    
    
    
    // LC: 100. Same Tree
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil { return true; }
        if p == nil || q == nil || p!.val != q!.val { return false; }
        
        return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right);
        
    }
    
    // LC: 98. Validate Binary Search Tree
    func isValidBSTHelper(_ root : TreeNode?, _ left : Int, _ right : Int) -> Bool {
        if let root = root {
            if root.val < left || root.val > right { return false; }
            var leftValid = true;
            if (root.left != nil) {
                leftValid = isValidBSTHelper(root.left, left, root.val - 1);
            }
            var rightValid = true;
            if (root.right != nil) {
                rightValid = isValidBSTHelper(root.right, root.val + 1, right);
            }
            return leftValid && rightValid;
        }
        return true;
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        if root == nil { return true; }
        return isValidBSTHelper(root, Int.min, Int.max);
    }
}
