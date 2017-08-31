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


class Interval {
    public var start: Int
    public var end: Int
    public init(_ start: Int, _ end: Int) {
        self.start = start
        self.end = end
    }
}

class Arrays {

    
    
    // LC:643. Maximum Average Subarray I
    func findMaxAverage(_ nums: [Int], _ k: Int) -> Double {
        
        var sum = 0
        
        for ix in 0..<k {
            sum += nums[ix]
        }
        var maxVal = sum
        for ix in k..<nums.count {
            sum += nums[ix] - nums[ix - k]
            maxVal = max(maxVal, sum)
        }
        return Double(maxVal) / Double(k)
    }
    
    // LC:628. Maximum Product of Three Numbers
    func maximumProduct(_ nums: [Int]) -> Int {
        
        guard nums.count >= 3 else { return 0; }
        
        var min1 = Int.max
        var min2 = Int.max
        var max1 = Int.min
        var max2 = Int.min
        var max3 = Int.min
        for ix in 0..<nums.count {
            if nums[ix] > max1 {
                max3 = max2
                max2 = max1
                max1 = nums[ix]
            } else if nums[ix] > max2 {
                max3 = max2
                max2 = nums[ix]
            } else if nums[ix] > max3 {
                max3 = nums[ix]
            }
            if nums[ix] < min1 {
                min2 = min1
                min1 = nums[ix]
            } else if nums[ix] < min2 {
                min2 = nums[ix]
            }
        }
        
        return max(max1 * max2 * max3, max1 * min1 * min2)
    }
    
    
    // LC:621. Task Scheduler
    /*
    public int leastInterval(char[] tasks, int n) {
    
        int[] c = new int[26];
        for(char t : tasks){
            c[t - 'A']++;
        }
        Arrays.sort(c);
        int i = 25;
        while(i >= 0 && c[i] == c[25]) i--;
    
        return Math.max(tasks.length, (c[25] - 1) * (n + 1) + 25 - i);
    }
    */
    
    // LC:611. Valid Triangle Number
    func triangleNumber(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        
        let n = sorted.count
        var ix = n - 1
        var count = 0
        while ix >= 2 {
            var left = 0, right = ix - 1
            while left < right {
                if sorted[left] + sorted[right] > sorted[ix] {
                    count += (right - left)
                    // while left < right && sorted[left] == sorted[left + 1] { left += 1; count += 1; }
                    right -= 1;
                } else {
                    left += 1
                }
            }
            ix -= 1
        }
        return count
    }
    
    // LC:605. Can Place Flowers
    func canPlaceFlowers(_ flowerbed: [Int], _ n: Int) -> Bool {
        guard n > 0 else { return true }
        var placed = 0
        var flowerbed = flowerbed
        for ix in 0..<flowerbed.count {
            if flowerbed[ix] == 0 {
                let prev = (ix == 0 ? 0 : flowerbed[ix - 1])
                let next = ((ix == flowerbed.count - 1) ? 0 : flowerbed[ix + 1] )
                if next == 0 && prev == 0 {
                    flowerbed[ix] = 1
                    placed += 1
                    if placed == n { break; }
                }
            }
        }
        return placed == n
    }
    

    // LC:581. Shortest Unsorted Continuous Subarray
    func findUnsortedSubarray2(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0 }
        let n = nums.count
        var beg = -1, end = -2, maxVal = nums[0], minVal = nums[n - 1]
        for ix in 0..<n {
            maxVal = max(maxVal, nums[ix])
            minVal = min(minVal, nums[n - 1 - ix])
            if nums[ix] < maxVal { end = ix; }
            if nums[n - 1 - ix] > minVal { beg = n - 1 - ix; }
        }
        return end - beg + 1
    }
    
    func findUnsortedSubarray(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        var start = 0
        while start < nums.count && sorted[start] == nums[start] { start += 1 }
        var end = nums.count - 1
        while end > start && sorted[end] == nums[end] { end -= 1 }
        return end - start + 1
    }
    
    // LC:566. Reshape the Matrix
    func matrixReshape(_ nums: [[Int]], _ r: Int, _ c: Int) -> [[Int]] {
        
        let n = nums.count, m = nums[0].count
        if n*m != r*c { return nums; }
        
        var result = [[Int]](repeating:[Int](repeating: 0, count: c), count: r )
        for ix in 0..<r*c {
            result[ix/c][ix%c] = nums[ix/m][ix%m]
        }
        return result
    }

    // LC:565. Array Nesting
    // The idea is to, start from every number, find circles in those index-pointer-chains, every time 
    // you find a set (a circle) mark every number as visited (-1) so that next time you won't step on it again.
    func arrayNesting(_ nums: [Int]) -> Int {
        
        var maxsize = 0
        var nums = nums
        for ix in 0..<nums.count {
            var size = 0
            var kx = ix
            while kx >= 0 && nums[kx] >= 0 {
                let ak = nums[kx]
                nums[kx] = -1
                kx = ak
                size += 1
            }
            maxsize = max(maxsize, size)
        }
        return maxsize
    }
    
    
    // @todo:562. Longest Line of Consecutive One in Matrix
    
    // LC:561. Array Partition I
    func arrayPairSum(_ nums: [Int]) -> Int {
        let sorted = nums.sorted()
        var sum = 0
        var ix = sorted.count - 2
        while ix >= 0 {
            sum += sorted[ix]
            ix -= 2
        }
        return sum
    }
    
    // LC:560. Subarray Sum Equals K
    // Solution 1. Brute force. We just need two loops (i, j) and test if SUM[i, j] = k. Time complexity O(n^2), Space complexity O(1). I bet this solution will TLE.
    // Solution 2. From solution 1, we know the key to solve this problem is SUM[i, j]. So if we know SUM[0, i - 1] and SUM[0, j], then we can easily get SUM[i, j]. To achieve this, we just need to go through the array, calculate the current sum and save number of all seen PreSum to a HashMap. Time complexity O(n), Space complexity O(n).
    func subarraySum(_ nums: [Int], _ k: Int) -> Int {
        var sum = 0
        var hmap = [Int : Int]()
        hmap[0] = 1
        var result = 0
        for num in nums {
            sum += num
            if let val = hmap[sum - k] {
                result += val
            }
            hmap[sum] = hmap[sum] == nil ? 1 : hmap[sum]! + 1
        }
        return result
    }
    
    // @todo:548. Split Array with Equal Sum
    
    // @todo:533. Lonely Pixel II

    // LC:532. K-diff Pairs in an Array
    func findPairs(_ nums: [Int], _ k: Int) -> Int {
        var htable = [Int : Int]()
        for (ix, num) in nums.enumerated() {
            htable[num] = htable[num] == nil ? 1 : htable[num]! + 1
        }
        
        var count = 0
        for key in htable.keys {
            if k == 0 {
                if htable[key]! >= 2 {
                    count += 1
                }
            } else {
                if let _ = htable[key + k] {
                    count += 1
                }
            }
        }
        return count
    }
    
    // @todo:531. Lonely Pixel I
    
    // @todo:495. Teemo Attacking.
    func findPoisonedDuration(_ timeSeries: [Int], _ duration: Int) -> Int {
        guard timeSeries.count > 0 && duration > 0 else { return 0; }
        
        var start = timeSeries[0], result = 0, end = timeSeries[0] + duration
        
        for ix in 1..<timeSeries.count {
            if timeSeries[ix] > end {
                result += end - start
                start = timeSeries[ix]
            }
            end = timeSeries[ix] + duration
        }
        result += end - start
        
        return result
    }
    
    // LC:485. Max Consecutive Ones
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
    
    // LC:448. Find All Numbers Disappeared in an Array
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
    
    // @LC:442. Find All Duplicates in an Array.
    func findDuplicates(_ nums: [Int]) -> [Int] {
        var result = [Int]()
        var nums = nums
        
        for (ix, num) in nums.enumerated() {
            if num >= 0 && nums[num - 1] > 0 { nums[num - 1] = -nums[num - 1]; }
            else {
                result.append(abs(num))
            }
        }
        return result
    }
    
    // @todo:414. Third Maximum Number
    func thirdMax(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0;}
        
        if nums.count == 1 { return nums[0]; }
        if nums.count == 2 { return max(nums[0], nums[1]); }
        
        var minValue = Int.max;
        for value in nums {
            minValue = min(minValue, value);
        }
        var firstMax = minValue, secondMax = minValue, thirdMax = minValue;
        
        for ix in 1..<nums.count {
            if nums[ix] > firstMax {
                thirdMax = secondMax;
                secondMax = firstMax;
                firstMax  = nums[ix];
            }	else if nums[ix] > secondMax {
                thirdMax = secondMax;
                secondMax = nums[ix];
            } else if nums[ix] > thirdMax {
                thirdMax = nums[ix];
            }
        }
        return  thirdMax == secondMax ? firstMax : thirdMax;
    }
    
    // @todo:380. Insert Delete GetRandom O(1)
    
    // LC:289. Game of Life.
    func gameOfLife(_ board: inout [[Int]]) {
        
        guard board.count > 0 else { return; }
        
        let m = board.count, n = board[0].count
        for ix in 0..<m {
            for jx in 0..<n {
                var count = 0
                for I in max(ix - 1, 0)...min(ix + 1, m - 1) {
                    for J in max(jx - 1, 0)...min(jx + 1, n - 1) {
                        count += board[I][J] & 1 != 0 ? 1 : 0
                    }
                }
                if count == 3 || count - board[ix][jx] == 3 {
                    board[ix][jx] |= 2
                }
            }
        }
        for ix in 0..<m {
            for jx in 0..<n {
                board[ix][jx] >>= 1
            }
        }
    }
    
    // LC:287. Find the Duplicate Number
    // @see BinarySearch, TwoPointers
    
    // LC:283. Move Zeroes
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
    
    func moveZeroes2(_ nums: inout [Int]) {
       	var wx = 0
        for rx in 0..<nums.count {
            if nums[rx] == 0 { continue; }
            nums[wx] = nums[rx];
            wx += 1;
        }
        while wx < nums.count {
            nums[wx] = 0; wx += 1;
        }
        
    }
    
    // LC:268. Missing Number
    // @see BitManipulation, Binary Search too
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

    
    // LC:238. Product of Array Except Self
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = [Int](repeating: 1, count: nums.count)
        guard nums.count > 0 else { return result; }
        
        var ix = 1
        while ix < nums.count {
            result[ix] = result[ix - 1] * nums[ix - 1]
            ix += 1
        }
        var right = 1
        var jx = nums.count - 1
        while jx >= 0 {
            result[jx] *= right
            right *= nums[jx]
            jx -= 1
        }
        return result
    }
    
    // LC:228. Summary Ranges
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
    
    
    
    // LC:219. Contains Duplicate II
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
    
    // LC:217. Contains Duplicate
    func containsDuplicate(_ nums: [Int]) -> Bool {
        
        guard nums.count > 0 else { return false; }
        
        var set = Set<Int>();
        for value in nums {
            
            if set.contains(value) { return true; }
            set.insert(value);
        }
        return false;
    }
    
    // LC:216. Combination Sum III
    // @todo: passes 8/18
    func combinationSum3Helper(_ k : Int, _ n : Int, _ sum : Int, _ start : Int,
                               _ partial : [Int], _ result : inout [[Int]]) {
        
        if partial.count > k {
            return
        }
        if partial.count == k {
            if sum == n {
                result.append(partial)
            }
            return
        }
        var partial = partial
        for val in start...9 {
            
            partial.append(val)
            combinationSum3Helper(k, n, sum + val, start + 1, partial, &result)
            partial.removeLast()
        }
    }
    
    func combinationSum3(_ k: Int, _ n: Int) -> [[Int]] {
        
        
        var result = [[Int]]()
        combinationSum3Helper(k, n, 0, 1, [], &result)
        return result;
    }
    
    // LC:209. Minimum Size Subarray Sum
    func minSubArrayLen(_ s: Int, _ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        var sum = 0
        var jx = 0
        var minVal = Int.max
        var ix = 0
        
        while jx < nums.count {
            sum += nums[jx]
            jx += 1
            while sum >= s {
                minVal = min(minVal, jx - ix)
                sum -= nums[ix];
                ix += 1
            }
        }
        return minVal == Int.max ? 0 : minVal
    }
    
    // LC:189. Rotate Array
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
    
    // LC:169. Majority Element
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

    // LC:167. Two Sum II - Input array is sorted
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
    
    // LC:162. Find Peak Element
    func findPeakElement(_ nums: [Int]) -> Int {
        var peakIndex = 0
        for ix in 0..<nums.count {
            if ix == 0 {
                // head
                if ix < nums.count - 1 && nums[ix] > nums[ix + 1] {
                    peakIndex = ix;
                }
            } else if ix == nums.count - 1{
                // tail
                if ix - 1 >= 0 && nums[ix] > nums[ix - 1] {
                    peakIndex = ix
                }
            } else {
                // everything else
                if nums[ix] > nums[ix - 1] && nums[ix] > nums[ix + 1] {
                    peakIndex = ix
                }
            }
        }
        return peakIndex
    }
    
    // @todo:154. Find Minimum in Rotated Sorted Array II
    
    // LC:153. Find Minimum in Rotated Sorted Array
    func findMin(_ nums: [Int]) -> Int {
        var left = 0, right = nums.count - 1
        
        var candidate = 0
        while left < right {
            
            if nums[left] < nums[right] { return nums[left] }
            
            let mid = (left + right) / 2
            if nums[mid] >= nums[left]  {
                left = mid + 1 // the invariant is satisfied here that nums[left] can't possibly be the smallest element.
            } else {
                right = mid
            }
        }
        return nums[left]
    }
    
    // LC:152. Maximum Product Subarray
    func maxProduct(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        var result = nums[0], localMin = nums[0], localMax = nums[0]
        
        for ix in 1..<nums.count {
            let num = nums[ix]
            let tempMax = localMax
            localMax = max(max(num * localMin, num * localMax), num)
            localMin = min(min(num * localMin, num * tempMax), num)
            result = max(result, localMax)
        }
        return result
    }
    
    // @todo:128. Longest Consecutive Sequence
    
    // @todo:126. Word Ladder II
    
    // @todo:123. Best Time to Buy and Sell Stock III
    
    // LC:122. Best Time to Buy and Sell Stock II
    func maxProfit2(_ prices: [Int]) -> Int {
        var profit = 0
        var ix = 0
        while ix < prices.count {
            let min = prices[ix]
            while ix < prices.count - 1 && prices[ix] <= prices[ix + 1] { ix += 1 }
            profit += ix < prices.count ? prices[ix] - min : 0
            ix += 1
        }
        return profit
    }

    
    
    // LC:121. Best Time to Buy and Sell Stock
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
    
    
    // LC:120. Triange
    // @todo: compile time exceeded
    func minimumTotal(_ triangle: [[Int]]) -> Int {
        var triangle = triangle
        guard triangle.count > 0 else { return 0; }
        var minVal = triangle[0][0]
        for rx in 1..<triangle.count {
            var row = triangle[rx]
            
            row[0] += triangle[rx - 1][0]
            row[row.count - 1] += triangle[rx - 1][triangle[rx - 1].count - 1]
            minVal = min(row[0], row[row.count - 1])
            for ix in 1..<row.count - 1 {
                row[ix] += min(triangle[rx - 1][ix - 1], triangle[rx - 1][ix])
                minVal = min(minVal, row[ix])
            }
            triangle[rx] = row
        }
        return minVal
    }
    
    // LC:119. Pascal's Triangle II 
    func getRow(_ rowIndex: Int) -> [Int] {
        var lastRow = [1]
        if rowIndex == 0 { return lastRow }
        var currentRow : [Int]!
        for rx in 1...rowIndex {
            currentRow = [Int](repeating : 1, count : rx + 1)
            if  (currentRow.count - 1) <= 1 { lastRow = currentRow; continue; }
            for jx in 1..<(currentRow.count - 1) {
                currentRow[jx] = lastRow[jx - 1] + lastRow[jx]
            }
            lastRow = currentRow
        }
        return currentRow;
    }
    
    // LC:118. Pascal's Triangle
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
    
    // @LC:106. Construct Binary Tree from Inorder and Postorder Traversal
    func buildTreeHelper(_ postorder : [Int], _ inorder : [Int], _ pstart : Int, _ pend : Int, _ istart : Int, _ iend : Int) -> TreeNode? {
        guard pstart <= pend && istart <= iend else { return nil; }
        
        let root = TreeNode(postorder[pend])
        
        if let ix = treeMap[root.val] {
            let pLeftLen = ix - istart
            let pRightLen = iend - ix
            root.left = buildTreeHelper(postorder, inorder, pstart, pstart + pLeftLen - 1, istart, ix - 1)
            root.right = buildTreeHelper(postorder, inorder, pstart + pLeftLen, pend - 1, ix + 1, iend)
        }
        return root
    }
    
    
    func buildTree(_ inorder: [Int], _ postorder: [Int]) -> TreeNode? {
        guard postorder.count > 0 else { return nil; }
        for (ix, val) in inorder.enumerated() {
            treeMap[val] = ix
        }
        return buildTreeHelper(postorder, inorder, 0, postorder.count - 1, 0, inorder.count - 1)
    }
    
    // @LC:105. Construct Binary Tree from Preorder and Inorder Traversal
    // Time: O(n), Space: O(h)
    var treeMap = [Int : Int]()
    
    func buildTreeHelper2(_ preorder : [Int], _ inorder : [Int], _ pstart : Int, _ pend : Int, _ istart : Int, _ iend : Int) -> TreeNode? {
        guard pstart <= pend && istart <= iend else { return nil; }
        let root = TreeNode(x: preorder[pstart])
        
        if let ix = treeMap[root.val] {
            let pLeftLen = ix - istart
            let pRightLen = iend - ix
            root.left = buildTreeHelper(preorder, inorder, pstart + 1, pstart + pLeftLen, istart, ix - 1)
            root.right = buildTreeHelper(preorder, inorder, pstart + pLeftLen + 1, pend, ix + 1, iend)
        }
        return root
    }
    
    func buildTree2(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
        guard preorder.count > 0 && inorder.count > 0 else { return nil; }
        
        for (ix, val) in inorder.enumerated() {
            treeMap[val] = ix
        }
        
        return buildTreeHelper(preorder, inorder, 0, preorder.count - 1, 0, inorder.count - 1)
    }
    
    // @todo:90. Subsets 2
    
    // LC:88. Merge Sorted Array
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
    
    // @todo:85. Maximal Rectangle
    
    // @todo:84. Largest Rectangle in Histogram
    
    // LC:81. Search in Rotated Sorted Array II
    func search(_ nums: [Int], _ target: Int) -> Bool {
        var left = 0, right = nums.count - 1
        while left <= right {
            
            let mid = (left + right) / 2
            
            if nums[mid] == target { return true; }
            
            if nums[left] == nums[mid] && nums[right] == nums[mid] { left += 1; right -= 1; }
            else if nums[left] <= nums[mid] {
                if target < nums[mid] && target >= nums[left] {
                    right = mid - 1;
                } else {
                    left = mid + 1
                }
            } else {
                // nums[mid] <= nums[right]
                if target > nums[mid] && target <= nums[right] {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }
            
        }
        return false
    }

    
    // LC:80. Remove Duplicates from Sorted Array II
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
    
    // LC:79. Word Search
    // @todo: optimize to use a hashmap 
    // Space: O(m + n) Time O(m * n * L)
    func existHelper(_ board : inout [[Character]], _ word : [Character], _ wx : Int, _ ix : Int, _ jx : Int) -> Bool {
        
        
        if wx == word.count { return true; }
        guard ix >= 0 && jx >= 0 && ix < board.count && jx < board[0].count else { return false; }
        
        
        if word[wx] != board[ix][jx] { return false; }
        let temp = board[ix][jx]
        board[ix][jx] = "$"
        let shifts = [[0, -1], [0, 1], [1, 0], [-1, 0]]
        for shift in shifts {
            if existHelper(&board, word, wx + 1, ix + shift[0], jx + shift[1]) == true {
                return true;
            }
        }
        board[ix][jx] = temp
        return false;
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0 else { return false; }
        
        var board = board
        let wchars = Array(word.characters)
        for ix in 0..<board.count {
            for jx in 0..<board[0].count {
                if existHelper(&board, wchars, 0, ix, jx)  == true { return true; }
            }
        }
        return false;
    }
    
    // @LC:78. Subsets
    func subsets(_ nums: [Int]) -> [[Int]] {
        let n = nums.count;
        var result = [[Int]]();
        
        for ix in 0..<(1 << n) {
            var partial = [Int]();
            var num = ix;
            while num > 0 {
                let bitSet = Double(num & ~(num - 1));
                partial.append(nums[Int(log(bitSet) / log(2))]);
                num &= (num - 1);
            }
            result.append(partial);
        }
        return result;
    }
    
    // LC:75. Sort Colors
    func sortColors(_ nums: inout [Int]) {
        var numRed = 0;    // 0
        var numWhite = 0;  // 1
        var numBlue = 0;   // 2
        
        for num in nums {
            if num == 0 { numRed += 1; }
            else if num == 1 { numWhite += 1; }
            else { numBlue += 1; }
        }
        
        var ix = 0
        while numRed > 0 {
            nums[ix] = 0; numRed -= 1;
            ix += 1;
        }
        while numWhite > 0 {
            nums[ix] = 1; numWhite -= 1;
            ix += 1;
        }
        while numBlue > 0 {
            nums[ix] = 2; numBlue -= 1;
            ix += 1;
        }
    }
    
    // @LC:74. Search a 2D Matrix
    /*
    [
     [1,   3,  5,  7],
     [10, 11, 16, 20],
     [23, 30, 34, 50]
    ]
     
     */
    
    // m = 4
    // n = 3
    //
    // 1. l = 0, h = 11, mid = 5, ix = 1, jx = 1
    // 2. l = 0, h = 4, mid = 2, ix = 2, jx = 0
    // 3. l = 0, h = 1, mid = 1, ix = 0, jx = 1
    
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 else { return false; }
        
        let n = matrix.count
        let m = matrix[0].count
        var l = 0, h = m * n - 1;
        
        while l <= h {
            let mid = h - ((h - l) / 2)
            if matrix[mid / m][mid % m] == target { return true; }
            if matrix[mid / m][mid % m] < target {
                l = mid + 1
            } else {
                h = mid - 1;
            }
        }
        return false;
    }
    
    // LC:73. Set Matrix Zeroes
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
    
    
    // LC:66. Plus One
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = digits;
        guard digits.count > 0 else { return result; }
        
        var ix = result.count - 1;
        result[ix] = result[ix] + 1
        
        while result[ix] == 10 && ix > 0 {
            result[ix] = 0;
            ix -= 1;
            result[ix] = result[ix] + 1;
        }
        if ix == 0 && result[ix] == 10 {
            result[0] = 0;
            result.insert(1, at: 0);
        }
        return result;
    }

    // LC:64. Minimum Path Sum
    // @see Dynamic Programming
    
    
    // @LC:63. Unique Paths 2
    func uniquePathsWithObstaclesHelper(_ obstacleGrid: [[Int]], _ ix : Int, _ jx : Int) -> Int {
        guard ix >= 0 && jx >= 0 else { return 0; }
        
        if obstacleGrid[ix][jx] == 1 { return 0; }
        
        if ix == 0 && jx == 0 { return 1; }
        
        let lookupStr = "\(ix),\(jx)"
        if let result = hmap[lookupStr] {
            return result;
        }
        
        let result = uniquePathsWithObstaclesHelper(obstacleGrid, ix - 1, jx) +
            uniquePathsWithObstaclesHelper(obstacleGrid, ix, jx - 1);
        hmap[lookupStr] = result;
        return result;
    }
    
    func uniquePathsWithObstacles(_ obstacleGrid: [[Int]]) -> Int {
        
        guard obstacleGrid.count > 0 else { return 0; }
        return uniquePathsWithObstaclesHelper(obstacleGrid, obstacleGrid.count - 1, obstacleGrid[0].count - 1);
    }
    
    
    
    // @LC:62. Unique Paths
    var hmap = [String : Int]()
    
    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        if (m == 1 ||  n == 1) { return 1; }
        
        let lookupStr = "\(m),\(n)"
        if let result = hmap[lookupStr] {
            return result;
        }
        let paths = uniquePaths(m - 1, n) + uniquePaths(m, n - 1);
        hmap[lookupStr] = paths;
        return paths;
    }
    
    
    // @LC:59. Spiral Matrix 2
    // Discussion: https://discuss.leetcode.com/topic/4362/my-super-simple-solution-can-be-used-for-both-spiral-matrix-i-and-ii
    // Time: O(m x n)
    func generateMatrix(_ n: Int) -> [[Int]] {
        
        // Declaration
        let row = [Int](repeating: 0, count: n)
        var matrix = [[Int]](repeating: row, count: n);
        
        // Edge Case
        guard n > 0 else { return matrix; }
        
        // Normal Case
        var rowStart = 0;
        var rowEnd = n-1;
        var colStart = 0;
        var colEnd = n-1;
        var num = 1;
        
        while (rowStart <= rowEnd && colStart <= colEnd) {
            for ix in colStart...colEnd {
                matrix[rowStart][ix] = num; num += 1;
            }
            rowStart += 1
            if rowStart > rowEnd { break; }
            for ix in rowStart...rowEnd {
                matrix[ix][colEnd] = num; num += 1;
            }
            colEnd -= 1
            if colStart > colEnd { break; }
            for ix in (colStart...colEnd).reversed() {
                matrix[rowEnd][ix] = num;  num += 1;
            }
            rowEnd -= 1
            if rowStart > rowEnd { break; }
            for ix in (rowStart...rowEnd).reversed() {
                matrix[ix][colStart] = num; num += 1
            }
            colStart += 1
        }
        
        return matrix;
        
    }
    
    
    // @LC:57. Insert Interval
    // Discussion: https://discuss.leetcode.com/topic/7808/short-and-straight-forward-java-solution/1
    // Time: O(n), Space: O(1)
    func insert(_ intervals: [Interval], _ newInterval: Interval) -> [Interval] {
        guard intervals.count > 0 else { return [newInterval]; }
        
        var result = [Interval]()
        let mergedInterval = newInterval;
        var ix = 0;
        while ix < intervals.count {
            if intervals[ix].end < mergedInterval.start {
                result.append(intervals[ix]);
            } else if intervals[ix].start <= mergedInterval.end  {
                mergedInterval.start = min(intervals[ix].start, mergedInterval.start);
                mergedInterval.end   = max(intervals[ix].end, mergedInterval.end);
            } else {
                break;
            }
            ix += 1;
        }
        result.append(mergedInterval)
        while ix < intervals.count { result.append(intervals[ix]); ix += 1; }
        
        return result;
        
    }
    
    func insert2(_ intervals: [Interval], _ newInterval: Interval) -> [Interval] {
        guard intervals.count > 0 else { return [newInterval]; }
        
        let mergedInterval = newInterval
        var result = [Interval]()
        var ix = 0;
        
        while ix < intervals.count && intervals[ix].end < mergedInterval.start{
            result.append(intervals[ix]); ix += 1
        }
        
        while ix < intervals.count && intervals[ix].start <= mergedInterval.end{
            mergedInterval.start = min(mergedInterval.start, intervals[ix].start);
            mergedInterval.end = max(mergedInterval.end, intervals[ix].end)
            ix += 1
        }
        
        result.append(mergedInterval)
        
        while ix < intervals.count {
            result.append(intervals[ix]); ix += 1;
        }
        
        return result;
    }
    
    
    // @LC:56. Merge Intervals
    // Time: O(n), Space: O(1)
    // Discussion: https://discuss.leetcode.com/topic/4319/a-simple-java-solution
    func merge(_ intervals: [Interval]) -> [Interval] {
        guard intervals.count > 0 else { return intervals; }
        
        let sortedIntervals = intervals.sorted { $0.start < $1.start }
        
        var start = sortedIntervals[0].start
        var end   = sortedIntervals[0].end
        var result = [Interval]();
        for interval in sortedIntervals {
            if interval.start <= end {
                end = max(end, interval.end)
            } else {
                result.append(Interval(start, end));
                start = interval.start; end = interval.end
            }
        }
        result.append(Interval(start, end))
        return result;
    }
    
    
    // LC:55. Jump Game
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
    
    // LC:54. Spiral Matrix
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
    
    
    // @LC:53. Maximum subarray
    // Time: O(n), space: O(1)
    // Discussion: https://discuss.leetcode.com/topic/5000/accepted-o-n-solution-in-java/2
    // https://discuss.leetcode.com/topic/6413/dp-solution-some-thoughts
    func maxSubArray(_ nums: [Int]) -> Int {
        
        if nums.count == 0 { return Int.min; }
        
        var maxTillHere = nums[0];
        var maxValue = nums[0];
        
        for ix in 1..<nums.count {
            maxTillHere = max(nums[ix], maxTillHere + nums[ix]);
            maxValue = max(maxValue, maxTillHere);
        }
        
        return maxValue;
    }
    
    func maxSubArrayDP(_ nums: [Int]) -> Int {
        
        var dp = [Int](repeating: 0, count: nums.count)
        dp[0] = nums[0];
        
        var maxValue = dp[0];
        for ix in 1..<nums.count {
            dp[ix] = nums[ix] + (dp[ix - 1] > 0 ? dp[ix - 1] : 0);
            maxValue = max(maxValue, dp[ix]);
        }
        return maxValue;
    }
    
    
    // @LC:48. Rotate Image
    // Time: O(M x N), Space: O(1)
    // Discussion:
    // https://discuss.leetcode.com/topic/6796/a-common-method-to-rotate-the-image
    // https://discuss.leetcode.com/topic/9744/ac-java-in-place-solution-with-explanation-easy-to-understand/2
    // @todo: NP, work out with some examples, work out the time complexity and space complexity
    func rotate(_ matrix: inout [[Int]]) {
        guard matrix.count > 0 else { return; }
        
        for ix in 0..<matrix.count {
            for jx in ix..<matrix[0].count {
                if ix != jx {
                    swap(&matrix[ix][jx], &matrix[jx][ix])
                }
            }
        }
        
        for ix in 0..<matrix.count {
            for jx in 0..<matrix.count/2 {
                swap(&matrix[ix][jx], &matrix[ix][matrix.count-1-jx]);
            }
        }
    }
    
    // @LC:45. Jump Game 2
    // Time: O(N), Space: O(1)
    // Discussion: https://discuss.leetcode.com/topic/11408/single-loop-simple-java-solution
    // https://discuss.leetcode.com/topic/3191/o-n-bfs-solution
    // @todo: NP, work out with some examples, work out the time complexity and space complexity
    func jump(_ nums: [Int]) -> Int {
        var step_count = 0, last_jump_max = 0, current_jump_max = 0;
        for ix in 0..<nums.count-1 {
            current_jump_max = max(current_jump_max, ix + nums[ix])
            if ix == last_jump_max {
                step_count += 1;
                last_jump_max = current_jump_max;
            }
        }
        
        return step_count;
    }
    
    // @LC:42. Trapping Rain Water
    // Time: ??, Space: ??
    // Discussion: https://discuss.leetcode.com/topic/3016/share-my-short-solution
    // https://discuss.leetcode.com/topic/18731/7-lines-c-c/2
    // https://discuss.leetcode.com/topic/5125/sharing-my-simple-c-code-o-n-time-o-1-space/2
    // @todo: NP, work out with some examples, work out the time complexity and space complexity
    func trap(_ height: [Int]) -> Int {
        var l = 0, r = height.count-1, level = 0, water = 0;
        while l < r {
            var hix = 0
            if height[l] < height[r] { hix = l; l += 1; }
            else { hix = r; r -= 1; }
            let lower = height[hix];
            level = max(level, lower);
            water += level - lower;
        }
        return water;
    }
    
    // @LC:41. First Missing Positive
    // Time: O(N)??, Space: O(1) if input is mutable, otherwise O(N)
    // Discussion: https://discuss.leetcode.com/topic/8293/my-short-c-solution-o-1-space-and-o-n-time/2
    // @todo: NP, work out with some examples, work out the time complexity
    func firstMissingPositive(_ nums: [Int]) -> Int {
        var nums = nums;
        for ix in 0..<nums.count {
            while nums[ix] > 0 && nums[ix] <= nums.count &&
                nums[ix] != nums[nums[ix] - 1] {
                    // e.g. swap 5 into nums[4]
                    swap(&nums[ix], &nums[nums[ix] - 1])
            }
        }
        
        // return the first index where nums[ix] != ix + 1
        for ix in 0..<nums.count {
            if nums[ix] != ix + 1 {
                return ix + 1
            }
        }
        
        return nums.count + 1;
    }
    
    // Alt Soln
    // Time: O(N), Space: O(1) if input is mutable, otherwise O(N)
    // Discussion: https://discuss.leetcode.com/topic/2633/share-my-o-n-time-o-1-space-solution
    func firstMissingPositive2(_ A: [Int]) -> Int {
        var A = A;
        let n = A.count;
        
        guard n > 0 else { return 1; }
        
        let k = partition(&A) + 1;
        var temp = 0;
        var first_missing_Index = k;
        
        for ix in 0..<k {
            temp=abs(A[ix]);
            if temp <= k {
                A[temp - 1] = A[temp - 1] < 0 ? A[temp - 1] : -A[temp - 1];
            }
            
        }
        for ix in 0..<k {
            if A[ix] > 0 {
                first_missing_Index = ix;
                break;
            }
        }
        return first_missing_Index + 1;
    }
    
    func partition(_ A : inout [Int]) -> Int {
        let n = A.count;
        var q = -1;
        
        for ix in 0..<n {
            if A[ix] > 0 {
                q += 1;
                if (q != ix) {
                    swap(&A[q],&A[ix]);
                }
            }
        }
        return q;
    }
    
    // LC:40. Combination Sum 2
    // @todo: NP
    // Time: ??, Space: ??
    // Discussion: https://discuss.leetcode.com/topic/19845/java-solution-using-dfs-easy-understand/1
    func combinationSum2Helper(_ candidates: [Int], _ target: Int, _ result : inout [[Int]], _  partial : [Int], _ begin : Int) {
        
        guard target >= 0 else { return; }
        if target == 0 {
            result.append(partial);
            return;
        }
        
        
        var partial = partial;
        for ix in begin..<candidates.count {
            if ix > begin && candidates[ix] == candidates[ix - 1] { continue; }
            let newTarget = target - candidates[ix]
            if (newTarget >= 0) {
                partial.append(candidates[ix]);
                combinationSum2Helper(candidates, newTarget, &result, partial, ix + 1);
                partial.removeLast();
            }
        }
        
    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let  sortedCandidates = candidates.sorted();
        var result = [[Int]]()
        var partial = [Int]()
        combinationSum2Helper(sortedCandidates, target, &result, partial, 0)
        return result;
    }
    
    // LC:39. Combination Sum
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
    
    // LC:35. Search Insert Position
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
    
    // LC:34. Search for a Range
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

    // LC:33. Search in Rotated Sorted Array
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
    
    // LC:31. Next Permutation
    func reverse2(_ nums : inout [Int], _ left : Int, _ right : Int) {
        var ix = left, jx = right;
        guard left >= 0 && right < nums.count else { return; }
        while ix < jx {
            let temp = nums[ix]
            nums[ix] = nums[jx]
            nums[jx] = temp
            ix += 1; jx -= 1
        }
    }
    
    func nextPermutation(_ nums: inout [Int]) {
        guard nums.count > 1 else { return; }
        
        var ix = nums.count - 2
        
        while ix >= 0 {
            if nums[ix] < nums[ix + 1] { break; }
            ix -= 1
        }
        
        if ix < 0 {  reverse(&nums, 0, nums.count - 1);  return; }
        
        var jx = nums.count - 1
        while jx >= ix {
            if nums[jx] > nums[ix] { break; }
            jx -= 1
        }
        
        swap(&nums[ix], &nums[jx])
        
        reverse(&nums, ix + 1, nums.count - 1)
    }
    

    // LC:27. Remove Element
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
    
    func removeElement2(_ nums: inout [Int], _ val: Int) -> Int {
        var wx = -1
        for rx in 0..<nums.count {
            if nums[rx] == val { continue; }
            wx += 1;
            nums[wx] = nums[rx]
        }
        return wx + 1;
    }
    
    // LC:26. Remove Duplicates from Sorted Array
    // https://leetcode.com/problems/remove-duplicates-from-sorted-array/#/description
    func removeDuplicates(_ nums: inout [Int]) -> Int {

        // IMP to check nums.count against 0, for empty input array
        guard nums.count > 0 else { return nums.count; }
        var wx = 1;
        
        for rx in 1..<nums.count {
            if nums[rx] == nums[rx - 1] { continue; }
            nums[wx] = nums[rx];
            wx += 1;
        }
        return wx;
    }
    
    

    // LC:18. 4Sum
    // @see: Hashtables
    
    // LC:16. 3Sum Closest
    func threeSumClosest(_ nums: [Int], _ target: Int) -> Int {
        let snums = nums.sorted();
        var minDiffSoFar = Int.max;
        guard snums.count >= 3 else { return minDiffSoFar; }
        var minSum = 0;
        for ix in 0..<nums.count - 2 {
            var jx = ix + 1;
            var kx = nums.count - 1;
            
            if ix > 0 && snums[ix] == snums[ix - 1] { continue; }
            
            while jx < kx {
                let sum = snums[ix] + snums[jx] + snums[kx];
                if sum == target {
                    return target;
                } else if sum > target {
                    kx -= 1;
                    if sum - target < minDiffSoFar { minDiffSoFar = sum - target; minSum = sum; }
                } else {
                    jx += 1;
                    if target - sum < minDiffSoFar { minDiffSoFar = target - sum; minSum = sum; }
                }
            }
        }
        return minSum;
        
    }
    
    // LC:15. 3Sum
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
    
    
    // LC:11. Container With Most Water
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
    
    
    
    // LC:1. Two Sum
    // https://leetcode.com/problems/two-sum/#/description
    func twoSum2(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [Int]();
        var hmap = [Int : Int]();
        for (index, num) in  nums.enumerated() {
            if let storedIx = hmap[target - num] {
                result.append(storedIx);
                result.append(index);
                return result;
            }
            hmap[num] = index;
        }
        return result;
    }
    
    // MARK: - G4G / pramp
    func sortKMessedArrayHelper(_ arr : inout [Int], _ ix : Int, _ jx : Int) {
        var ix = ix, jx = jx
        if ix < 0 { ix = 0; }
        if jx > arr.count - 1 { jx = arr.count - 1; }
        if ix > jx { return; }
        
        let sortedSub = arr[ix...jx].sorted()
        var sx = 0
        for kx in ix...jx {
            arr[kx] = sortedSub[sx]
            sx += 1
        }
    }
    
    func sortKMessedArray(arr: [Int], k: Int) -> [Int] {
        var result = arr
        guard arr.count > 1 else { return result; }
        
        for ix in 0..<arr.count {
            sortKMessedArrayHelper(&result, ix - k - 1, ix + k + 1)
        }
        return result
    }
    
}
