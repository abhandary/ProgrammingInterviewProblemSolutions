//
//  DynamicProgramming.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/26/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class DynamicProgramming {

    // LC:152. Maximum Product Subarray
    
    // LC:120. Triangle
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        guard triangle.count > 0 && triangle[0].count > 0 else { return 0; }
        
        var triangle = triangle
        for rx in (0..<triangle.count-1).reversed() {
            for ix in 0..<triangle[rx].count {
                triangle[rx][ix] += min(triangle[rx + 1][ix], triangle[rx + 1][ix + 1])
            }
        }
        return triangle[0][0]
    }

    
    // LC:96. Unique Binary Search Trees
    // @see Tree
    
    // LC:95. Unique Binary Search Trees II
    // @see Tree


    // LC:91. Decode Ways
    var hmap = [String : Int]()
    
    func numDecodings(_ s: String) -> Int {
        
        let schars = Array(s.characters)
        var dp = [Int](repeating: 0, count: schars.count + 1)
        dp[0] = 1
        if schars.count <= 0 { return 0; }
        dp[1] = schars[0] != "0" ? 1 : 0
        if schars.count == 1 { return dp[1]; }
        for ix in 2...schars.count {
            let first = String(schars[ix-1..<ix])
            let second = String(schars[ix-2..<ix])
            
            if let firstVal = Int(first), firstVal >= 1 && firstVal <= 9 {
                dp[ix] += dp[ix - 1]
            }
            if let secondVal = Int(second), secondVal >= 10 && secondVal <= 26 {
                dp[ix] += dp[ix - 2]
            }
        }
        
        return dp[schars.count]
    }
    
    // LC:72. Edit Distance
    func minDistance(_ word1: String, _ word2: String) -> Int {
        let w1Len = word1.characters.count
        let w2Len = word2.characters.count
        
        let w1chars = Array(word1.characters)
        let w2chars = Array(word2.characters)
        
        var matrix = [[Int]](repeating: [Int](repeating: 0, count: w2Len + 1), count: w1Len + 1)
        
        for ix in 0...w1Len {
            matrix[ix][0] = ix
        }
        
        for jx in 0...w2Len {
            matrix[0][jx] = jx
        }
        if w1Len < 1 || w2Len < 1 { return matrix[w1Len][w2Len] }
        for ix in 1...w1Len {
            for jx in 1...w2Len {
                if w1chars[ix - 1] != w2chars[jx - 1] {
                    let min1 = min(matrix[ix][jx - 1], matrix[ix - 1][jx])
                    matrix[ix][jx] = 1 + min(min1, matrix[ix - 1][jx - 1])
                } else {
                    matrix[ix][jx] = matrix[ix - 1][jx - 1]
                }
            }
        }
        return matrix[w1Len][w2Len]
    }
    
    
    // LC:63. Unique Paths II
    // @see Arrays
    
    
    // LC:62. Unique Paths
    // @see Arrays
    
    
    // LC:53. Maximum Subarray
    func maxSubArray(_ nums: [Int]) -> Int {
        
        var dp = [Int](repeating: 0, count: nums.count)
        dp[0] = nums[0];
        
        var maxValue = dp[0];
        for ix in 1..<nums.count {
            dp[ix] = nums[ix] + (dp[ix - 1] > 0 ? dp[ix - 1] : 0);
            maxValue = max(maxValue, dp[ix]);
        }
        return maxValue;
    }
    
    func maxSubArray2(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        var maxEndingHere = nums[0]
        var maxSoFar = nums[0]
        for ix in 1..<nums.count {
            maxEndingHere = max(maxEndingHere + nums[ix], nums[ix])
            maxSoFar = max(maxSoFar, maxEndingHere);
        }
        return maxSoFar
    }
    
    var hmap2 = [String : Int]()
    
    // LC:64. Minimum Path Sum
    func minPathSumHelper(_ grid: [[Int]], _ ix : Int, _ jx : Int) -> Int {
        
        let lookupStr = "\(ix),\(jx)"
        
        if let stored = hmap2[lookupStr] {
            return stored;
        }
        var val = 0;
        if ix > 0 && jx > 0 {
            val = min(minPathSumHelper(grid, ix - 1, jx),  minPathSumHelper(grid, ix, jx - 1)) + grid[ix][jx]
        } else if ix <= 0 && jx <= 0 {
            val = grid[ix][jx]
        } else if ix <= 0 {
            val = minPathSumHelper(grid, ix, jx - 1) + grid[ix][jx]
        } else {
            val = minPathSumHelper(grid, ix - 1, jx) + grid[ix][jx]
        }
        
        hmap2[lookupStr] = val
        return val;
    }
    
    // LC:70. Climbing Stairs
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else { return 0; }
        return minPathSumHelper(grid, grid.count - 1, grid[0].count - 1);
    }
    
    var hmap3 = [Int : Int]()
    
    func climbStairs(_ n: Int) -> Int {
        if n <= 3  { return n; }
        
        if let stored = hmap3[n] {
            return stored
        }
        
        let val = climbStairs(n - 1) + climbStairs(n - 2);
        hmap3[n] = val;
        return val;
    }
    
    // LC:121. Best Time to Buy and Sell Stock
    func maxProfit(_ prices: [Int]) -> Int {
        guard prices.count > 0 else { return 0; }
        
        var minSoFar = prices[0];
        var maxSoFar = 0;
        for ix in 1..<prices.count {
            maxSoFar = max(maxSoFar, prices[ix] - minSoFar);
            minSoFar = min(minSoFar, prices[ix]);
        }
        return maxSoFar;
        
    }
    
    // LC:198. House Robber
    func rob(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        var dp = [Int](repeating: 0, count: nums.count)
        var maxSoFar = Int.min
        for ix in 0..<nums.count {
            dp[ix] = max(ix >= 2 ? dp[ix - 2] : 0, ix >= 3 ? dp[ix - 3] : 0) + nums[ix]
            maxSoFar = max(maxSoFar, dp[ix])
        }
        return maxSoFar
    }
    
    // LC:303. Range Sum Query - Immutable
    /*
    int[] nums;
    
    public NumArray(int[] nums) {
        for(int i = 1; i < nums.length; i++)
            nums[i] += nums[i - 1];
    
        this.nums = nums;
    }
    
    public int sumRange(int i, int j) {
        if(i == 0)
            return nums[j];
    
        return nums[j] - nums[i - 1];
    }
    */
}
