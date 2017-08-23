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
}
