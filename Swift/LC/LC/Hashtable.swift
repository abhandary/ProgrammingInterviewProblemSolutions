//
//  Hashtable.swift
//  LC
//
//  Created by Akshay Bhandary on 6/22/16.
//  Copyright © 2016 AkshayBhandary. All rights reserved.
//

import Foundation


class HashTableSolution {
    //MARK: - 350. Intersection of Two Arrays
    // 1. What if the given array is already sorted, optimize
    // 2. What if num1's size is small compared to num2's size, Which algo is better
    // 3. What if element's of num2 are stored on disk, and the memory is limited such that you cannot load all elements into the memory at once.
    
    func intersection2(nums1: [Int], _ nums2: [Int]) -> [Int]
    {
        var result = [Int]()
        var n1Dict = Dictionary<Int, Int>()
        for val in nums1 {
            if let curr = n1Dict[val] {
                n1Dict[val] = curr + 1;
            } else {
                n1Dict[val] = 1
            }
        }
        
        return result;
    }
    
    // MARK: - 349. Intersection of Two Arrays
    func intersection(nums1: [Int], _ nums2: [Int]) -> [Int]
    {
        let set1 = Set(nums1)
        let set2 = Set(nums2)
        return set2.filter() { return set1.contains($0)}
    }
    
    // MARK: - 299. Bulls and Cows
    func getHint(secret: String, _ guess: String) -> String {
        var lookup = Array(count:10, repeatedValue:0)
        
        var bulls = 0
        var cows = 0
        
        for val in secret.characters {
            let str = String(val)
            lookup[Int(str)!]+=1;
        }
        
        for val in guess.characters {
            let str = String(val)
            if lookup[Int(str)!] > 0 {
                lookup[Int(str)!]-=1
                cows+=1
            }
        }
        
        let zipped = zip(guess.characters, secret.characters)
        for (g, s) in zipped {
            
            if g == s {
                lookup[Int(String(g))!] -= 1;
                cows-=1
                bulls+=1
            }
        }
        
        
        return String(bulls) + "A" + String(cows) + "B"
    }
    
    func getHint2(secret: String, _ guess: String) -> String {
        var lookup = Array(count:10, repeatedValue:0)
        
        var bulls = 0
        var cows = 0
        
        let zipped = zip(guess.characters, secret.characters)
        for (g, s) in zipped {
            
            let sval = Int(String(s))!
            let gval = Int(String(g))!
            
            if g == s {
                bulls+=1
            } else {
                if lookup[sval] < 0  {
                    cows+=1
                }
                if lookup[gval] > 0 {
                    cows+=1
                }
                lookup[sval]++
                lookup[gval]--
            }
        }
        
        return String(bulls) + "A" + String(cows) + "B"
    }
    
    
    // MARK: 219. Contains Duplicates 2. Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array such that nums[i] = nums[j] and the difference between i and j is at most k.
    func containsNearbyDuplicate(nums: [Int], _ k: Int) -> Bool {
        var myDict = Dictionary<Int, Int>()
        var ix = 0;
        for val in nums {
            if let sIx = myDict[val] where ix - sIx <= k {
                return true;
            }
            myDict[val] = ix;
            ix+=1
        }
        return false;
    }
    
    // MARK: - 290. Word Pattern
    /*
    func wordPattern(pattern: String, _ str: String) -> Bool {
    
    }

    
    // MARK: 217. Contains Duplicates. Given an array of integers, find if the array contains any duplicates. Your function should return true if any value appears at least twice in the array, and it should return false if every element is distinct.
    func containsDuplicate(nums: [Int]) -> Bool {
        var mySet = Set<Int>()
        for val in nums {
            if mySet.contains(val) {
                return true;
            }
            mySet.insert(val);
        }
        return false;
    }
    
    
    // MARK: 205. Isomorphic Strings. Given two strings s and t, determine if they are isomorphic.
    func isIsomorphic(s: String, _ t: String) -> Bool {
        var myDict = Dictionary<Character, Character>()
        // var tDict = Dictionary<Character, Character>()
        if s.characters.count != t.characters.count {
            return false;
        }
        let zipped = zip(s.characters, t.characters)
        for (sChar, tChar) in zipped {
            if let sMapped = myDict[sChar] where sMapped != tChar {
                return false
            }
            if let tMapped = myDict[tChar] where tMapped != sChar {
                return  false;
            }
            myDict[tChar] = sChar
            myDict[sChar] = tChar
        }
        return true;
    }
    
    /*
    
    // MARK: 204. Count the number of prime numbers less than a non-negative number, n.
    func countPrimes(n: Int) -> Int {
    
    }
    
    */

    
    // MARK: - 166. Fraction to Recurring Decimal
    func fractionToDecimal(numerator: Int, _ denominator: Int) -> String {
    
    }
    
    // MARK: - 136. Single Number
    func singleNumber(nums: [Int]) -> Int {
    
    }
    
    // MARK: - 94. Binary Tree inorder traversal
    func inorderTraversal(root: TreeNode?) -> [Int] {
    
    }
    */

}

