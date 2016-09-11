//
//  6_Arrays.swift
//  EPI
//
//  Created by Akshay Bhandary on 9/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation

class Arrays {
    
    // MARK: - 6.1 Dutch Flag Partition
    func dutchFlagPartition(pivotIndex : Int, inout input : [Int]) {
        let pivot = input[pivotIndex]
        var smaller = 0, equal = 0, greater = input.count
        while equal < greater {
            if input[equal]  == pivot {
                equal++
            } else if input[equal] > pivot {
                swap(&input[--greater], &input[equal]);
            } else { // input[equal] < pivot
                swap(&input[smaller++], &input[equal++])
            }
        }
    }
    // O(n), O(1)
    
    // MARK: - 6.2 Increment an arbitrary-precision integer
    func plusOne(x : [Int]) -> [Int] {
        guard x.count > 0 else {
            return x
        }
        var result = x
        var ix = result.count - 1
        result[ix] += 1
        while ix > 0 && result[ix] == 10 {
            result[ix--] = 0
            result[ix] += 1
        }
        if result[0] == 10 {
            result[0] = 0
            result.insert(1, atIndex: 0)
        }
        return result;
    }
    // O(n)
    
    // MARK: - 6.4 Advancing through an array
    func canReachEnd(input : [Int]) -> Bool {
        var maxVal = 0
        for (index, element) in input.enumerate()
            where maxVal >= index {
            maxVal = max(maxVal, element + index)
        }
        return maxVal >= input.count - 1
    }
    // O(n), O(1)
    
    // MARK: - 6.5 Delete a key from an array
    func deleteKeyFromArray(inout input : [Int], val : Int) -> Int {
        var rx = 0, wx = 0
        while rx < input.count {
            if input[rx] != val {
                input[wx++] = input[rx]
            }
            rx++
        }
        return wx;
    }
    
    func deleteKeyFromArray2(input : [Int], key : Int) -> [Int] {
        return input.filter{ return $0 != key }
    }
    // O(n)
    
    // MARK: - 6.6 Delete duplicates from a sorted array
    func deleteDuplicatesFromArray(inout input : [Int]) -> Int {
        var rx = 1, wx = 1
        while rx < input.count {
            if input[rx] != input[wx - 1] {
                input[wx++] = input[rx]
            }
            rx++
        }

        input = input.enumerate().map { (index, element) in
            if index >= wx { return 0 };
            return element
        }
        return wx
    }
    
    // O(n)
    
    
    // MARK: - 6.9 Enumerate all primes to n
    func generatePrimes(n : Int) -> [Int] {
        var primes = [Int]()
        var isPrime = [Bool](count : n + 1, repeatedValue: true)
        for ix in 1...n {
            if isPrime[ix] {
                primes.append(ix)

                var next = 2
                var jx = ix * next
                while jx <= n {
                    isPrime[jx] = false
                    jx = ix * ++next
                }
            }
        }
        return primes
    }
    // O(n)
    
    // MARK: - 6.12 Sample offline data
    func randomSampling(inout input : [Int], k : Int) {
        for ix in 0..<k {
            let rx = arc4random_uniform(UInt32(input.count - ix))
            // swap(&input[ix], &input[ix + rx])
        }
    }

    // MARK: - 6.17 Sudoku Checker Problem
    
    func hasDuplicate(matrix : [[Int]], rstart : Int, rend : Int, cstart : Int, cend : Int) -> Bool {
        var mySet = Set<Int>()
        for ix in rstart..<rend {
            for jx in cend..<cend {
                if mySet.contains(matrix[ix][jx]) {
                    return true
                }
                mySet.insert(matrix[ix][jx])
            }
        }
        return false
    }
    
    
    func isValidSudoku(matrix : [[Int]]) -> Bool {
        // check rows
        for rx in 0..<matrix.count {
            if hasDuplicate(matrix, rstart: rx, rend: rx+1, cstart: 0, cend: matrix.count) {
                return false
            }
        }

        // check columns
        for cx in 0..<matrix.count {
            if hasDuplicate(matrix, rstart: 0, rend: matrix.count, cstart: cx, cend: cx+1) {
                return false
            }
        }
        // O(n)

        // check quadrants
        let qsize = Int(sqrt(Double(matrix.count / 2)))
        for I in 0..<qsize {
            for J in 0..<qsize {
                if hasDuplicate(matrix, rstart: I * qsize, rend: (I + 1)*qsize, cstart: J * qsize, cend: (J + 1)*qsize) {
                    return false
                }
            }
        }
        return true
    }
    
    // MARK: - 6.18 Spiral ordering of a 2D array
    func spiralOrdering(input : [[Int]], n : Int) -> [Int] {
        var result = [Int]()
        for start in 0..<n/2 {
            for jx in start..<(n - start - 1) {
                result.append(input[start][jx])
            }
            for ix in start..<(n - start - 1) {
                result.append(input[ix][n - start - 1])
            }
            for ix in (start + 1..<(n - start)).reverse() {
                result.append(input[n - start - 1][ix])
            }
            for ix in (start + 1..<(n - start)).reverse() {
                result.append(input[ix][start])
            }
        }
        if n % 2 == 1 {
            result.append(input[n/2][n/2])
        }
        return result
    }

    
    // MARK: - 6.19 Rotate a 2D Array
    func rotateMatrix(inout input : [[Int]], n : Int) {
        for start in 0..<n/2 {
            for jx in start..<(n - start - 1) {
                let temp = input[start][jx]
                input[start][jx] = input[n - start - 1 - jx][start]
                input[n - start - 1 - jx][start] = input[n - start - 1][n - start - 1 - jx]
                input[n - start - 1][n - start - 1 - jx] = input[jx][n - start - 1]
                input[jx][n - start - 1] = temp
            }
        }
    }
    
    // MARK: - 6.20 Compute rows in Pascal's Triangle
    func generatePascalTriangle(numRows : Int) -> [[Int]] {
        var result = [[Int]]()
        guard numRows > 0 else {
            return result
        }
        
        result.append([1])
        
        for rx in 1..<numRows {
            var row = [Int](count: rx + 1, repeatedValue: 1)

            for ix in 1..<rx {
                row[ix] = result[rx - 1][ix - 1] + result[rx - 1][ix]
            }
            result.append(row)
        }
        return result
    }
    
    // O(n2)
}

