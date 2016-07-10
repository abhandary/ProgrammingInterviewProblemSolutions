//
//  Array.swift
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 AkshayBhandary. All rights reserved.
//

import Foundation


class Array {
    func containsNearbyDuplicate(nums: [Int], _ k: Int) -> Bool {
        var lookup = Dictionary<Int,Int>()
        
        for (var ix = 0; ix < nums.count; ix++) {
            if let num = lookup[nums[ix]]
                where ix - num <= k {
                    return true
            }
            lookup[nums[ix]] = ix
        }
        return false
    }
    
    // MARK: - 54. Spiral Matrix
    func spiralOrder(matrix: [[Int]]) -> [Int] {
        var result = [Int]()
        if matrix.count == 0 {
            return result
        }
        
        var top = 0, bottom = matrix.count - 1
        var left = 0, right = matrix[0].count - 1
        
        while left <= right && top <= bottom {
            for (var col = left; col <= right; col++) {
                result.append(matrix[top][col])
            }
            top++
            for (var row = top; row <= bottom; row++) {
                result.append(matrix[row][right])
            }
            right--;
            if top <= bottom {
                for (var col = right; col >= left; col--) {
                    result.append(matrix[bottom][col])
                }
                bottom--
            }
            if left <= right {
                for (var row = bottom; row >= top; row--) {
                    result.append(matrix[row][left])
                }
                left++
            }
        }
        return result
    }
}
