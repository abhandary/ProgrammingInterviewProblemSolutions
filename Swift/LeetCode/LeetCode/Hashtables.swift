//
//  Hashtables.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/22/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Hashtables {
    
    // LC: 409 Longest Palindrome
    func longestPalindrome(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let schars = Array(s.characters);
        var map = [Character : Int]();
        for c in schars {
            map[c] = map[c] == nil ? 1 : map[c]! + 1;
        }
        
        var maxLen = 0;
        var oddFound = false;
        for c in map.keys {
            if let stored = map[c] {
                if stored & 1 != 0 {
                    oddFound = true;
                    maxLen += (stored - 1);
                } else {
                    maxLen += stored;
                }
            }
        }
        return oddFound ? maxLen + 1 : maxLen;
        
    }
    
    func longestPalindrome2(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let schars = Array(s.characters);
        var set = Set<Character>();
        var count = 0;
        for c in schars {
            if set.contains(c) {
                count += 1;
                set.remove(c);
            } else {
                set.insert(c);
            }	 
        }
        return set.count > 0 ? count * 2 + 1 : count * 2;
        
        
    }
    
    // LC: 350. Intersection of Two Arrays II
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map = [Int : Int]();
        for value in nums1 {
            map[value] = map[value] != nil ? map[value]! + 1 : 1;
        }
        
        var result = [Int]();
        for value in nums2 {
            if let stored = map[value] {
                result.append(value);
                map[value] = stored == 1 ? nil : map[value]! - 1;
            }
        } 
        return result;
        
    }
    
    // LC: 349. Intersection of Two Arrays
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let set1 = Set<Int>(nums1);
        let set2 = Set<Int>(nums2);
        return Array(set1.intersection(set2));
    }
    
    // LC: 242. Valid Anagram
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return s.characters.sorted() == t.characters.sorted()

    }
    
    
}

