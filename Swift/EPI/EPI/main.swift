//
//  main.swift
//  EPI
//
//  Created by Akshay Bhandary on 9/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation


let parityLookup : [Int64 : Int32] = [
    0x0000 : 0,
    ];

let preComputedReverse : [Int : Int] = [
    0x0000 : 0x0000,
];

class EPI {
    // MARK: - 5.1 Compute the Parity of a word
    
    func parity1(x : UInt64) -> Int32 {
        var result : Int32 = 0
        var inter = x
        while x != 0 {
            result += Int32(inter & UInt64(1));
            inter >>= 1
        }
        return result % 2;
    }
    // O(n)
    
    func parity2(x : UInt64) -> Int32 {
        var result : Int32 = 0
        var mutableX = x
        while mutableX != 0 {
            result ^= 1
            mutableX &= (mutableX - 1)
        }
        return result
    }
    // O(k)
    
    func parity3(x : Int64) -> Int32 {
        var result : Int32 = 0
        let mask : Int64 = 0xFFFF
        let kWordSize : Int64 = 8
        
        result = parityLookup[x & mask]! ^
            parityLookup[(x >> kWordSize) & mask]! ^
            parityLookup[(x >> 2 * kWordSize) & mask]! ^
            parityLookup[(x >> 3 * kWordSize) & mask]!;
        return result;
    }
    // O(n / L)
    
    func parity4(x : Int64) -> Int32 {
        var x = x
        x ^= x >> 32
        x ^= x >> 16
        x ^= x >> 8
        x ^= x >> 4
        x ^= x >> 2
        x ^= x >> 1
        return Int32(x & 0x1)
    }
    // O(log n)
    
    // MARK: - 5.2 Swap bits
    func swapBits(x : Int, i : Int, j : Int) -> Int {
        
        if ((x >> i) & 1) ^ ((x >> j) & 1) != 0 {
            let mask = 1 << i | 1 << j;
            return x ^ mask
        }
        return x
    }
    // O(1)
    
    // MARK: - 5.3 Reverse Bits
    func reverseBits(x : Int) -> Int {
        let kWordSize = 8
        let mask = 0xFFFF
        return preComputedReverse[x & mask]! << 3 * kWordSize |
               preComputedReverse[(x >> kWordSize) & mask]! << 2 * kWordSize |
               preComputedReverse[(x >> 2 * kWordSize) & mask]! << kWordSize |
               preComputedReverse[(x >> 3 * kWordSize) & mask]!;
    }
    // O(n / L)
    
    // MARK: - 5.4 Closest Integer with the same weight
    
    // MARK: - 5.8 Reverse Digits
    func reverseDigits(x : Int) -> Int {
        var temp = x
        var result = 0
        
        while temp > 0 {
            result = (result * 10) + (temp % 10)
            temp /= 10
        }
        return result;
    }
    
    // MARK: - 5.9 Check if a decimal integer is a palindrome
    func isPalindrome(x : Int) -> Bool {
        let digitCount = Int(log10(Double(x))) + 1

        var power10 = Int(pow(10.0, Double(digitCount - 1)));
        var xLow  = x
        var xHigh = x
        for _ in 0..<(digitCount / 2) {
            let xMSD = xHigh / power10
            let xLSD = xLow % 10
            if xMSD != xLSD {
                return false
            }

            xHigh %= power10
            power10 /= 10
            xLow /= 10
        }
        return true;
    }
    
    // MARK: - 6. Arrays
    
    // MARK: - 6.1 Increment an arbitrary-precision integer
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
    
    // MARK: 6.5 Delete a key from an array
    
}

let epi = EPI()
print("Hello, World!")
let num = 134134
var str = String(format: "%x", num)
print("\(num) in binary = \(str)")
let swapped = epi.swapBits(num, i : 0, j : 7)
str = String(format: "%x", swapped)
print("\(num) reversed in binary = \(str)")
print("reverse digits 1234 = \(epi.reverseDigits(1201))")
print("is palindrome = \(epi.isPalindrome(212))")
print("plus one = \(epi.plusOne([9, 9, 9, 9]))")


