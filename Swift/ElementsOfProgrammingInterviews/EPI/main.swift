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
    
    func parity1(_ x : UInt64) -> Int32 {
        var result : Int32 = 0
        var inter = x
        while x != 0 {
            result += Int32(inter & UInt64(1));
            inter >>= 1
        }
        return result % 2;
    }
    // O(n)
    
    func parity2(_ x : UInt64) -> Int32 {
        var result : Int32 = 0
        var mutableX = x
        while mutableX != 0 {
            result ^= 1
            mutableX &= (mutableX - 1)
        }
        return result
    }
    // O(k)
    
    func parity3(_ x : Int64) -> Int32 {
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
    
    func parity4(_ x : Int64) -> Int32 {
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
    func swapBits(_ x : Int, i : Int, j : Int) -> Int {
        
        if ((x >> i) & 1) ^ ((x >> j) & 1) != 0 {
            let mask = 1 << i | 1 << j;
            return x ^ mask
        }
        return x
    }
    // O(1)
    
    // MARK: - 5.3 Reverse Bits
    func reverseBits(_ x : Int) -> Int {
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
    func reverseDigits(_ x : Int) -> Int {
        var temp = x
        var result = 0
        
        while temp > 0 {
            result = (result * 10) + (temp % 10)
            temp /= 10
        }
        return result;
    }
    
    // MARK: - 5.9 Check if a decimal integer is a palindrome
    func isPalindrome(_ x : Int) -> Bool {
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


// MARK: - 6. Arrays

let arrays = Arrays()
print("plus one = \(arrays.plusOne([9, 9, 9, 9]))")
print("delete key from array = \(arrays.deleteKeyFromArray2([5, 3, 7, 11, 2, 3, 13, 5, 7], key: 7))")
var input = [2, 3, 5, 5, 7, 11, 11, 13]
arrays.deleteDuplicatesFromArray(&input)
print("dedupe sorted array = \(input))")

print("can reach end = \(arrays.canReachEnd([3, 3, 1, 0, 2, 0, 1]))")
var dutch = [2, 3, 5, 7, 9, 11, 13, 17]
// arrays.dutchFlagPartition(4, input : &dutch)
print("dutch flag partition = \(dutch)")

var matrix = [
     [1, 2, 3],
     [4, 5, 6],
     [7, 8, 9]
   ]

var matrix2 = [
    [1, 2, 3, 4],
    [5, 6, 7, 8],
    [9, 10, 11, 12],
    [13, 14, 15, 16]
]


print("spiral order = \(arrays.spiralOrdering(matrix, n: 3))")
print("spiral order = \(arrays.spiralOrdering(matrix2, n: 4))")

arrays.rotateMatrix(&matrix, n: 3)
arrays.rotateMatrix(&matrix2, n: 4)
print("rotate matrix = \(matrix)")
print("rotate matrix2 = \(matrix2)")

print("pascal triangle = \(arrays.generatePascalTriangle(4))")


// MARK: - 7. Strings
let strings = Strings()
print("palindromicity = \(strings.isPalindrome("A man, a plan, a canal, Panama"))")
print("reverse words in a sentence : \(strings.reverseWords("A man a plan a canal Panama"))")
print("string to int = \(strings.stringToInt("-1234f"))")
print("convert base = \(strings.convertBase("11011", b1: 2, b2:16))")
print("convert excel col = \(strings.SSColDecodeID("Z"))")
print("look and say = \(strings.lookAndSay(4))");

print("Roman to Decimal = \(strings.convertFromRomanToDecimal("LIX"))")
print("RLE = \(strings.encoding(s: "aaaaabccd"))");
print("RLE = \(strings.decoding(s: "5a1b2c1d"))");
print("RLE = \(strings.badDecoding(s: "5xa1b12xc1d2x372x"))");
print("Snake String = \(strings.snakeString(s:"Hello World!"))");


// MARK: - 9. Stacks
let stacks = Stacks();
let s = "()[]{()()}";
print("Is welformed = \(stacks.isWellFormed(s))");


