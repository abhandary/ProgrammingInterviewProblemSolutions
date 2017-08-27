//
//  BinarySearch.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/8/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class BinarySearch {
    
    
    // LC:33. Search in Rotated Sorted Array
    // @see: Arrays

    // LC:34. Search for a Range
    // @see: Arrays
    
    // LC:35. Search Insert Position
    // @see: Arrays
    
    // LC:69. Sqrt(x)
    // doesn't work, but same idea
    func mySqrt(_ x: Int) -> Int {
        var low = 0
        var high = x
        while low < high {
            let mid = high - (low - high)/2
            if mid * mid == x { return mid }
            if mid * mid < x {
                low = mid + 1
            } else {
                high = mid - 1
            }
        }
        return low
    }
    
    // works
    func mySqrt2(_ x: Int) -> Int {
        var val = x
        while val * val > x {
            val = (val + x/val) / 2
        }
        return val
    }
    
    // @LC:74. Search a 2D Matrix
    // @see: Arrays
    
    // LC:167. Two Sum II - Input array is sorted
    // @see Arrays
    
    // LC:268. Missing Number
    func missingNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        let nums = nums.sorted()
        var left = 0
        var right = nums.count
        while left < right {
            let mid = (left + right) / 2
            if nums[mid] > mid {
                right = mid
            } else {
                left = mid + 1
            }
        }
        return left
    }
    
    // 287. Find the Duplicate Number
    func findDuplicate(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1; }
        var l = 1, h = nums.count - 1
        
        while l <= h {
            let mid = (h - ((h - l)/2))
            
            var count = 0
            for num in nums {
                if num <= mid { count += 1; }
            }
            if count <= mid {
                l = mid + 1
            } else {
                h = mid - 1
            }
        }
        return l
    }
    
    // LC:349. Intersection of Two Arrays
    //
    /*
    public int[] intersection(int[] nums1, int[] nums2) {
        Set<Integer> set = new HashSet<>();
        Arrays.sort(nums2);
        for (Integer num : nums1) {
            if (binarySearch(nums2, num)) {
                set.add(num);
            }
        }
        int i = 0;
        int[] result = new int[set.size()];
        for (Integer num : set) {
            result[i++] = num;
        }
        return result;
    }
    
    public boolean binarySearch(int[] nums, int target) {
        int low = 0;
        int high = nums.length - 1;
        while (low <= high) {
            int mid = low + (high - low) / 2;
            if (nums[mid] == target) {
            return true;
        }
        if (nums[mid] > target) {
            high = mid - 1;
        } else {
            low = mid + 1;
        }
        }
        return false;
    }
    */
    
    // LC:367. Valid Perfect Square
    // @see: Math
    
    // LC:374. Guess Number Higher or Lower
    func guess(_ num : Int) -> Int {
        return 0;
    }
    
    func guessNumber(_ num : Int) -> Int {
        
        var low = 0;
        var high = 0;
        var mid = num >> 1;
        var nextGuess = 0;
        
        while guess(mid) != 0 {
            nextGuess = guess(mid)
            if nextGuess < 0 {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
            mid = low + (high - low) / 2;
        }
        return mid;
    }

    // LC:441. Arranging Coins
    func arrangeCoins(_ n: Int) -> Int {
        
        var left = 0, right = n;
        var candidate = 0;
        while left <= right {
            let mid = Double((left + right) / 2);
            // IMP to work with Doubles here to satisfy the equation correctly
            if (mid * mid)  * 0.5 + mid * 0.5 <= Double(n) {
                candidate = Int(mid)
                left = Int(mid) + 1
            } else {
                right = Int(mid) - 1
            }
        }
        return candidate
    }
    
    // LC:475. Heaters
    func findRadius(_ houses: [Int], _ heaters: [Int]) -> Int {
        let shouses = houses.sorted()
        let sheaters = heaters.sorted()
        var maxVal = Int.min
        var currentVal = Int.min
        for ix in 0..<shouses.count {
            var jx = 0
            while jx < sheaters.count - 1 && abs(sheaters[jx] - shouses[ix]) >= abs(sheaters[jx + 1] - shouses[ix])  {
                jx += 1
            }
            maxVal = max(maxVal, abs(sheaters[jx] - shouses[ix]))
        }
        return maxVal
    }
    
    /*
    public int findRadius(int[] houses, int[] heaters) {
        Arrays.sort(heaters);
        int result = Integer.MIN_VALUE;
    
        for (int house : houses) {
            int index = Arrays.binarySearch(heaters, house);
            if (index < 0) {
                index = -(index + 1);
            }
            int dist1 = index - 1 >= 0 ? house - heaters[index - 1] : Integer.MAX_VALUE;
            int dist2 = index < heaters.length ? heaters[index] - house : Integer.MAX_VALUE;
    
            result = Math.max(result, Math.min(dist1, dist2));
        }
    
        return result;
    }
    */
    
}
