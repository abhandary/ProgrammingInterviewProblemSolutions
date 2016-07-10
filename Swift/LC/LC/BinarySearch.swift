//
//  BinarySearch.swift
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 AkshayBhandary. All rights reserved.
//

import Foundation

class BinarySearch {
    
    // MARK: - 153. Find Minimum in Rotated Sorted Array
    func findMin(nums: [Int]) -> Int {
        var left = 0, right = nums.count - 1
        var mid = -1
        
        while left < right {
            mid = left + ((right - left) / 2);
            if nums[mid] <= nums[right] {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return nums[left]
    }
    
    func searchMatrix(matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count == 0 {
            return false
        }
        var left = 0, right = matrix[0].count - 1
        var top = 0, bottom = matrix.count - 1
        while left <= right && top <= bottom {
            let cornerValue = matrix[top][right]
            if cornerValue == target {
                return true
            }
            if cornerValue < target {
                top+=1
            } else {
                right-=1
            }
        }
        return false
    }
    
}
