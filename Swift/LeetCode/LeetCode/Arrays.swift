//
//  Arrays.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/18/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class SetInteger : Hashable {
    var ix : Int = 0;
    var jx : Int = 0;
    var zx : Int = 0;
    
    func SetInteger(_ a : Int, _ b : Int, _ c : Int) {
        ix = a; jx = b; zx = c;
    }
    var hashValue: Int { return ix + jx + zx; }
}

func == (lhs: SetInteger, rhs: SetInteger) -> Bool {
    return lhs.ix == rhs.ix && lhs.jx == rhs.jx && lhs.zx == rhs.zx;
}


class Arrays {
    
    
    // LC: 485. Max Consecutive Ones
    func findMaxConsecutiveOnes(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        var maxOnes = 0;
        var ix = 0;
        while ix < nums.count {
            var count = 0;
            while ix < nums.count && nums[ix] == 1 { count += 1; ix += 1; }
            maxOnes = max(maxOnes, count);
            ix += 1;
        }
        return maxOnes;
    }
    
    func findMaxConsecutiveOnes2(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        var maxOnes = 0;
        var count = 0;
        for value in nums {
            if value == 1 { count += 1; }
            else { count = 0; }
            maxOnes = max(maxOnes, count)
        }
        return maxOnes;
    }
    
    // LC: 448. Find All Numbers Disappeared in an Array
    func findDisappearedNumbers(_ nums: [Int]) -> [Int] {
        guard nums.count > 0 else { return [] }
        
        var nums = nums;
        var result = [Int]();
        for value in nums {
            if nums[value - 1] > 0 {
                nums[value - 1] = -nums[value - 1];
            }
        }
        for (index, value) in nums.enumerated() {
            if value > 0 {
                result.append(index + 1);
            }
        }
        return result;
        
    }
    
    // LC: 414. Third Maximum Number
    
    
    // LC: 283. Move Zeroes
    func moveZeroes(_ nums: inout [Int]) {
        guard nums.count > 0 else { return; }
        
        var wx = 0;
        for (index, value) in nums.enumerated() {
            if value != 0 {
                nums[wx] = value; wx += 1;
            }
        }
        while wx < nums.count {
            nums[wx] = 0; wx += 1;
        }
        
    }
    
    // LC: 268. Missing Number
    func missingNumberAS(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        let n = nums.count;
        
        var expectedSum =  (n) * (n + 1) / 2;
        var sum = 0;
        for value in nums {
            sum += value;
        }
        return expectedSum - sum;
    }
    
    func missingNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        var res = nums[0] ^ 0;
        var ix = 1;
        while ix < nums.count {
            
            res ^= ix;
            res ^= nums[ix];
            ix += 1
        }
        return res ^ ix;
    }
    
    // LC: 228. Summary Ranges
    func summaryRanges(_ nums: [Int]) -> [String] {
        guard nums.count > 0 else { return []; }
        
        var result = [String]();
        var ix = 0;
        while ix < nums.count {
            let curr = nums[ix];
            while ix < nums.count - 1 && (nums[ix + 1] - nums[ix]) == 1 {
                ix += 1;
            }
            if curr == nums[ix] {
                result.append("\(nums[ix])");
            } else {
                result.append("\(curr)->\(nums[ix])");
            } 
            
            ix += 1;
        }
        return result;        
    }
    
    
    
    // LC: 219. Contains Duplicate II
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        guard nums.count > 0 else { return false; }
        
        var map = [Int:Int]();
        for (index, value) in nums.enumerated() {
            if let stored = map[value], index - stored <= k {
                return true;
            }
            map[value] = index;
        }
        return false;
        
        
    }
    
    // LC: 217. Contains Duplicate
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        guard nums.count > 0 else { return false; }
        
        var set = Set<Int>();
        for value in nums {
            
            if set.contains(value) { return true; }
            set.insert(value);
        }
        return false;
    }
    
    // LC: 189. Rotate Array
    func reverse(_ nums: inout[Int], _ left : Int, _ right : Int) {
        var left = left, right = right
        while left < right {
            swap(&nums[left], &nums[right]);
            left += 1; right -= 1;
        }
    }
    
    
    func rotate(_ nums: inout [Int], _ k: Int) {
        guard nums.count > 0 else { return; }
        
        let k = k % nums.count;
        reverse(&nums, nums.count - k, nums.count - 1);
        reverse(&nums, 0, nums.count - k - 1);
        reverse(&nums, 0, nums.count - 1);
    }
    
    // LC: 169. Majority Element
    func majorityElement(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1; }
        
        var majorityElement = nums[0];
        var vote = 1;
        for ix in 1..<nums.count {
            if nums[ix] == majorityElement {
                vote += 1;
            } else {
                vote -= 1;
                if vote == 0 {
                    majorityElement = nums[ix]; 
                    vote = 1;
                }	
            }
        }
        return majorityElement;
    }

    // LC: 167. Two Sum II - Input array is sorted
    func twoSum(_ numbers : [Int], _ target : Int) -> [Int] {
        guard numbers.count > 1 else { return [-1, -1]; }
        
        var left = 0;
        var right = numbers.count - 1;
        
        while left < right {
            let sum = numbers[left] + numbers[right]
            if sum == target { return [left + 1, right + 1]; }
            if sum < target { left += 1; }
            else { right -= 1; }
        }
        return [-1, -1]
    }

    // LC: 121. Best Time to Buy and Sell Stock
    func maxProfit(_ prices : [Int]) -> Int {
        guard prices.count > 0 else { return 0; }
        
        var minSoFar = prices[0];
        var maxSoFar = 0;
        for ix in 1..<prices.count {
            maxSoFar = max(maxSoFar, prices[ix] - minSoFar);
            minSoFar = min(minSoFar, prices[ix]);
        }
        return maxSoFar;
    }
    
    // LC: 118. Pascal's Triangle
    func generate(_ numRows: Int) -> [[Int]] {
        
        
        
        var result = [[Int]]();
        guard numRows > 0 else { return result; }
        for nx in 1...numRows {
            
            var row = [Int](repeating: 1, count: nx);
            var ix = 1
            while ix < nx-1 {
                row[ix] = result[nx - 2][ix - 1] + result[nx - 2][ix];
                ix += 1;
            }
            result.append(row);
        }
        return result;
        
    }
    
    // LC: 88. Merge Sorted Array
    func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
        var ix = m - 1;
        var jx = n - 1;
        var wx = m + n - 1;
        
        // 1. merge in nums1 and nums2
        while ix >= 0 && jx >= 0 {
            if nums1[ix] > nums2[jx] {
                nums1[wx] = nums1[ix];
                ix -= 1;
            } else {
                nums1[wx] = nums2[jx];
                jx -= 1;
            }
            wx -= 1;
        }
        
        // 2. merge in rest of nums2
        while jx >= 0 {
            nums1[wx] = nums2[jx]
            wx -= 1; jx -= 1;
        }
        
    }
    
    // 80. Remove Duplicates from Sorted Array II
    func removeDuplicates2(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        if nums.count == 1 { return 1; }
        
        var wx = 0;
        for index in 0..<nums.count {
            
            if index + 2 < nums.count && nums[index] == nums[index + 2] { continue; }
            nums[wx] = nums[index]
            wx += 1;
        }
        
        return wx;
        
    }
    
    // LC: 73. Set Matrix Zeroes
    func setZeroes(_ matrix: inout [[Int]]) {
        guard matrix.count > 0 else { return; }
        let m = matrix.count, n = matrix[0].count;
        var col0 = 1;
        for ix in 0..<m {
            if matrix[ix][0] == 0 { col0 = 0; }
            for jx in 1..<n {
                if matrix[ix][jx] == 0 {
                    matrix[0][jx] = 0;
                    matrix[ix][0] = 0;
                }
            }
        }
        for ix in (0..<m).reversed() {
            for jx in (1..<n).reversed() {
                if matrix[0][jx] == 0 || matrix[ix][0] == 0 {
                    matrix[ix][jx] = 0;
                }
            }
            if col0 == 0 { matrix[ix][0] = 0; }
        }
    }
    
    
    // LC: 66 Plus One
    func plusOne(_ digits : [Int]) -> [Int]? {
        guard digits.count > 0 else { return nil; }
        
        

        var result = digits;
        result[result.count - 1] += 1;
        var ix = result.count - 1;
        while result[ix] == 10 && ix > 0 {
            result[ix] = 0;
            result[ix - 1] += 1;
            ix -= 1;  // IMP
        }
        if result[0] == 10 {
            result[0] = 0;
            result.insert(1, at: 0);
        }
        return result;
    }

    // LC: 55. Jump Game
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 0 else { return false; }
        var maxSoFar = nums[0];
        var ix = 1;
        while ix < nums.count && maxSoFar >= ix {
            maxSoFar = max(maxSoFar, nums[ix] + ix);
            ix += 1
        }
        
        // IMP: compare to nums.count - 1 and not ix
        return maxSoFar >= nums.count - 1;
    }
    
    // LC: 54. Spiral Matrix
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result  = [Int]();
        guard matrix.count > 0 else { return result; }
        
        var startRow = 0;
        var endRow  = matrix.count - 1;
        var startCol = 0;
        var endCol = matrix[0].count - 1;
        
        while startRow <= endRow && startCol <= endCol  {
            
            for jx in startCol...endCol {
                result.append(matrix[startRow][jx]);
            }
            startRow += 1;
            if startRow > endRow { break; }
            for ix in startRow...endRow {
                result.append(matrix[ix][endCol]);
            }
            
            endCol -= 1;
            if startCol > endCol { break; }
            for jx in (startCol...endCol).reversed() {
                result.append(matrix[endRow][jx]);
            }
            
            endRow -= 1;
            if startRow > endRow { break; }
            for ix in (startRow...endRow).reversed() {
                result.append(matrix[ix][startCol]);
            }
            startCol += 1
        } 
        return result;
    }
    
    // LC: 40 Combination Sum 2
    
    // 39. Combination Sum
    var result : [[Int]]!
    
    func combinationSumHelper(_ candidates: [Int], _ ix: Int, _ partial: inout [Int], _ target: Int) {
        
        if target == 0 {
            result.append([Int](partial));
            return
        }
        
        var jx = ix;
        while jx < candidates.count  {
            let value = candidates[jx]
            if target - value >= 0 {
                partial.append(value)
                combinationSumHelper(candidates, jx, &partial, target - value);
                partial.removeLast();
            }
            jx += 1;
        }
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        result = [[Int]]();
        var partial = [Int]();
        combinationSumHelper(candidates, 0, &partial, target);
        return result;
    }
    
    // LC: 35. Search Insert Position
    func searchInsert(_ nums: [Int], _ target: Int) -> Int {
        guard nums.count > 0 else { return -1; }
        var low = 0;
        var high = nums.count - 1;
        while low <= high {
            
            let mid = low + (high - low) / 2;
            if target == nums[mid] { return mid; }
            if nums[mid] < target {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        return low;
    }
    
    // LC: 34 Search for a Range
    func searchRange(_ nums: [Int], _ target: Int) -> [Int] {
        var startIx = -1;
        var endIx = -1;
        var low = 0;
        var high = nums.count - 1;
        while low <= high {
            
            let mid = low + (high - low) / 2;
            if nums[mid] == target {
                high = mid - 1;
                startIx = mid;
            } else if nums[mid] > target {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        if startIx == -1 { return [-1, -1]; }
        low = 0; high = nums.count - 1;
        
        while low <= high {
            
            let mid = low + (high - low) / 2;
            if nums[mid] == target {
                low = mid + 1;
                endIx = mid;
            } else if nums[mid] > target {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }
        return [startIx, endIx];
    }

    // LC: @todo 31 Next Permutation
    
    // LC: 33 Search in Rotated Sorted Array
    func search(_ nums : [Int], _ target : Int) -> Int {
        guard nums.count > 0 else { return -1; }
        
        var low = 0, high = nums.count - 1;
        var mid = 0;
        
        while low <= high {
            mid = low + (high - low) / 2;
            if nums[mid] == target { return mid; }
            if nums[low] <= nums[mid] {
                if target >= nums[low] && target < nums[mid] {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            } else {
                if target > nums[mid] && target <= nums[high] {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
                
            }
        }	
        return -1;
    }
    
    
    
    // 27. Remove Element
    // https://leetcode.com/problems/remove-element/#/description
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        guard nums.count > 0 else { return 0; }
        var wx = 0;
        for current in nums {
            if current != val {
                nums[wx] = current;
                wx += 1;
            }
        }
        return wx;
    }
    
    // 26. Remove Duplicates from Sorted Array
    // https://leetcode.com/problems/remove-duplicates-from-sorted-array/#/description
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        
        guard nums.count > 0 else { return 0; }
        
        var wx = 1;
        var rx = 1;
        while rx < nums.count {
            if nums[rx] != nums[rx - 1] {
                nums[wx] = nums[rx];
                wx += 1;
            }
            rx += 1;
        }
        return wx;
    }
    
    

    // LC: @todo 4 Sum
    
    // LC: @todo 16. Three Sum Closest
    
    // 15. 3Sum
    // https://leetcode.com/problems/3sum/#/description
    func threeSum(_ nums: [Int]) -> [[Int]] {
        var inter = nums.sorted();
        var result = [[Int]]();
        
        for (ix, _) in inter.enumerated() {
            if ix > 0 && inter[ix] == inter[ix - 1] { continue; }
            var jx = ix + 1;
            var zx = inter.count - 1;
            while jx < zx {
                let sum = inter[ix] + inter[jx] + inter[zx]
                if sum == 0 {
                    result.append([inter[ix], inter[jx], inter[zx]]);
                    
                    // TRICKY: Remmber this!!
                    while jx < zx && inter[jx] == inter[jx + 1] { jx += 1; }
                    while jx < zx && inter[zx - 1] == inter[zx] { zx -= 1; }
                    jx += 1; zx -= 1;
                } else if sum > 0 {
                    zx -= 1;
                } else {
                    jx += 1;
                }
            }
        }
        return result;
    }
    
    
    // 11. Container With Most Water
    // https://leetcode.com/problems/container-with-most-water/#/description
    func maxArea(_ height: [Int]) -> Int {
        var ix = 0;
        var jx = height.count - 1;
        var maxA = 0;
        
        while ix < jx {
            let h = min(height[ix], height[jx]);
            maxA = max(maxA, h * (jx - ix));
            
            while ix < jx && height[ix] <= h { ix += 1; }
            while ix < jx && height[jx] <= h { jx -= 1; }
        }
        return maxA;
    }
    
    
    
    // 1. Two Sum
    // https://leetcode.com/problems/two-sum/#/description
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {

        var map = [Int : Int]();

        for (index, value) in nums.enumerated() {
            map[value] = index;
        }
        for (index, value) in nums.enumerated() {
            
            if let stored = map[target - value], index != stored {
                return [index, stored];
            }
        }
        return [Int]();
    }
    
    
}
