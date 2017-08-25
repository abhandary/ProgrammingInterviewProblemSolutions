
//
//  BitManipulation.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/23/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class Bits {

    // LC:405. Convert a Number to Hexadecimal
    func toHex(_ num: Int) -> String {
        var  result = ""
        guard num != 0 else {  return "0"; }
        
        let lookup = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k",
                      "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v",
                      "w", "x", "y", "z"
        ]
        var num = num

        for _ in 0..<8 {
            let val = Int(num & 0xF)
            if val > 9 {
                result = lookup[val - 10] + result
            } else {
                result = String(val) + result
            }
            num >>= 4
            if num == 0 { break; }
        }
        
        
        return result
    }
    
    // LC:476. Number Complement
    func findComplement(_ num: Int) -> Int {
        var mask : UInt32 = 0xFFFFFFFF
        while num & Int(mask) != 0 { mask <<= 1; }
        return Int(~mask) & ~num
    }
    
    // LC:461. Hamming Distance
    func hammingDistance(_ x: Int, _ y: Int) -> Int {
        var xor = x ^ y
        var count = 0
        while xor > 0 {
            xor &= (xor - 1)
            count += 1
        }
        return count
    }
    
    // LC:389. Find the Difference
    func findTheDifference(_ s: String, _ t: String) -> Character {
        
        
        let lookup : [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i",
                                    "j", "k", "l", "m", "n", "o", "p", "q", "r",
                                    "s", "t", "u", "v", "w", "x", "y", "z"]
        
        let schars = Array(s.characters)
        let tchars = Array(t.characters)
        
        guard schars.count > 0 else { return tchars[0]; }
        
        var sxor = lookup.index(of:schars[0])!
        for ix in 1..<schars.count {
            sxor ^= lookup.index(of: schars[ix])!
        }
        
        for ix in 0..<tchars.count {
            sxor ^= lookup.index(of: tchars[ix])!
        }
        
        return lookup[sxor]
    }
    
    // LC:371. Sum of Two Integers
    // @todo: no idea how this works, figure out when you have some time
    func getSum(_ a: Int, _ b: Int) -> Int {
        if a == 0 { return b; }
        if b == 0 { return a; }
        
        var b = b
        var a = a
        while b != 0 {
            let carry = a & b // simultaneously capturing the carry from all bits at once
            a = a ^ b        // this is simulatneously doing multiple additions
            b = carry << 1
        }
        return a
    }
    
    // LC:342. Power of Four
    func isPowerOfFour(_ num: Int) -> Bool {
        return num > 0 && (num & (num - 1) == 0) && (num & 0x55555555 != 0)
    }
    
    // LC:268. Missing Number
    // @see Arrays, Binary Search Too
    func missingNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        
        var res = nums.count
        for ix in 0..<nums.count {
            res ^= ix
            res ^= nums[ix]
        }
        return res
    }
    
    // LC:231. Power of Two
    func isPowerOfTwo(_ n: Int) -> Bool {
        if n == 0 { return false }
        return n == 1 || ((n & 1 == 0) && (n & (n - 1) == 0))
    }
    
    
    // LC:191. Number of 1 Bits
    /*
    int hammingWeight(uint32_t n) {
        int count = 0;
        while (n > 0) {
            n = n & (n - 1);
            count++;
        }
        return count;
    }
    */
    
    // LC:169. Majority Element
    /*
    public int majorityElement(int[] nums) {
        int[] bit = new int[32];
        for (int num: nums)
            for (int i=0; i<32; i++)
                if ((num>>(31-i) & 1) == 1)
                    bit[i]++;
            int ret=0;
            for (int i=0; i<32; i++) {
                bit[i]=bit[i]>nums.length/2?1:0;
                ret += bit[i]*(1<<(31-i));
            }
        return ret;
    }
    */
    
    // LC:136. Single Number
    func singleNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1; }
        
        var num = nums[0];
        for ix in 1..<nums.count {
            num ^= nums[ix]
        }
        return num
    }
    
    // LC:78. Subsets
    // @see Arrays & Backtracking
}
