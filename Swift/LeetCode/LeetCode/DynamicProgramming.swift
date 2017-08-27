//
//  DynamicProgramming.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/26/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class DynamicProgramming {
    
    // LC:63. Unique Paths II
    
    
    // LC:62. Unique Paths
    
    
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
    
    var hmap = [String : Int]()
    
    // LC:64. Minimum Path Sum
    func minPathSumHelper(_ grid: [[Int]], _ ix : Int, _ jx : Int) -> Int {
        
        let lookupStr = "\(ix),\(jx)"
        
        if let stored = hmap[lookupStr] {
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
        
        hmap[lookupStr] = val
        return val;
    }
    
    // LC:70. Climbing Stairs
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 else { return 0; }
        return minPathSumHelper(grid, grid.count - 1, grid[0].count - 1);
    }
    
    var hmap2 = [Int : Int]()
    func climbStairs(_ n: Int) -> Int {
        if n <= 3  { return n; }
        
        if let stored = hmap2[n] {
            return stored
        }
        
        let val = climbStairs(n - 1) + climbStairs(n - 2);
        hmap2[n] = val;
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
