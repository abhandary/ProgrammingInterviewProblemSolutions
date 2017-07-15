//
//  Strings.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/21/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Strings {
    
    func reverseWords(_ s : String) -> String {
        
        
        let sarray = Array(s.characters.split(separator: " "));
        var result = "";
        var ix = sarray.count - 1;
        while ix > 0 {
            result += "\(sarray[ix])" + " ";
            ix -= 1;
        }
        result += "\(sarray[0])";
        return result;
    }
    
    
    // LC: 125. Valid Palindrome
 
    
    // LC: 58. Length of Last Word
    func lengthOfLastWord(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let s = s.trimmingCharacters(in: [" "])
        let chars = Array(s.characters);
        var jx = chars.count - 1;
        while jx >= 0 {
            if chars[jx] == " " { break; }
            jx -= 1;
        }        
        return chars.count - 1 - jx;
        
    }
    
    // LC: 49. Group Anagrams
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var result = [[String]]();
        guard strs.count > 0 else { return result; }
        var map = [String : [String]]();
        for s in strs {
            let ssorted = String(s.characters.sorted());
            if var array = map[ssorted] {
                array.append(s);
                map[ssorted] = array;
            } else {
                map[ssorted] = [s];
            }
        }	
        for key in map.keys {
            result.append(map[key]!);
        }
        return result;
        
    }
    
    // LC: 38. Count and Say
    func countAndSay(_ n: Int) -> String {
        guard n > 0 else { return ""; }
        
        var map = ["1" : "1", "2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"];
        
        var result = "1";
        for _ in 1..<n {
            var new = "";
            var count = 1;
            
            let chars = Array(result.characters);
            
            for ix in 1..<chars.count {
                if chars[ix] == chars[ix - 1] { count += 1; }
                else {
                    new += "\(count)\(chars[ix - 1])"
                    count = 1;
                }
            }
            new += "\(count)\(chars[chars.count - 1])";
            result = new;
        }
        result.trimmingCharacters(in: [" "])
        return result;
        
    }
    
    // LC: 22. Generate Parentheses
    func generateParenthesisHelper(_ left : Int, _ right : Int, _ result : inout [String], _ partial : String) {
        if right == 0 {
            result.append(partial);
            return;
        }

        
        
        if left > 0 {
            generateParenthesisHelper(left - 1, right, &result, partial + "(");
        }
        if left < right {
            generateParenthesisHelper(left, right - 1, &result, partial + ")");
        }
    }
    
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]();
        guard n > 0 else { return result; }
        generateParenthesisHelper(n , n, &result, "");     
        return result;
    }
    
    
    // LC: 17. Letter Combinations of a Phone Numbe
    
    let map : [Character : String] = ["1" : "1", "2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"];
    
    func letterCombinationsHelper(_ chars : [Character], _ ix : Int, _ partial : String, _ result : inout [String]) {
        if partial.characters.count == chars.count {
            result.append(partial);
            return;
        }
        
        if let value = map[chars[ix]] {
            for c in value.characters {
                letterCombinationsHelper(chars, ix + 1, partial + "\(c)", &result);
            }
        }
    }
    
    func letterCombinations(_ digits: String) -> [String] {
        var result = [String]()
        guard digits.characters.count > 0 else { return result; }
        
        let chars = Array(digits.characters);
        
        letterCombinationsHelper(chars, 0, "", &result);
        return result;
    }
    
    
    // a, b, c, b, e
    // b, b, b, b
    // LC: 3. Longest Substring Without Repeating Characters
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        var map = [Character : Int]();
        var maxSoFar = Int.min;
        var startIx = 0;
        for (index, value) in s.characters.enumerated() {
            if let stored = map[value], stored >= startIx {
                startIx = stored + 1;
            }
            maxSoFar = max(maxSoFar, index - startIx + 1);
            map[value] = index;
        }
        return maxSoFar;
    }

}
