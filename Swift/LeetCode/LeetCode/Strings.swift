//
//  Strings.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/21/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Strings {

    // LC:151. Reverse Words in a String
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

    
    // LC:126. Word Ladder II
    
    
    // LC:125. Valid Palindrome
    func isalnum(_ c : Character) -> Bool {
        if let usc =  String(c).unicodeScalars.first,
            CharacterSet.alphanumerics.contains(usc) {
            return true
        }
        return false;
    }
    
    func tolower(_ c : Character) -> String {
        return String(c).lowercased()
    }
    
    func isPalindrome(_ s: String) -> Bool {
        let schars = Array(s.characters)
        guard schars.count > 0 else { return true; }
        var ix = 0, jx = schars.count - 1;
        while ix < jx {
            while ix < jx && !isalnum(schars[ix]) { ix += 1; }
            while ix < jx && !isalnum(schars[jx]) { jx -= 1; }
            if ix < jx && tolower(schars[ix]) != tolower(schars[jx]) {
                return false
            }
            ix += 1; jx -= 1;
        }
        return true;
    }

    // LC:115. Distinct Subsequences
    
    // LC:97. Interleaving String
    
    // LC:93. Restore IP Addresses

    // LC:91. Decode Ways
    
    // LC:87. Scramble String
    
    // LC:76. Minimum Window Substring
    
    // LC:72. Edit Distance
    
    // LC:71. Simplify Path
    // Time: O(N), Space: O(N) where N is the number of path components
    func simplifyPath(_ path: String) -> String {
        var stack = [String]();
        
        let components = path.characters.split(separator: "/").map(String.init)
        
        for dir in components {
            if (dir == ".." && stack.count > 0) { stack.removeLast(); }
            else if (dir != ".." && dir != "." && dir != "") { stack.append(dir); }
        }
        
        var result = ""
        for ix in (0..<stack.count).reversed() {
            result = "/" + stack[ix] + result;
        }
        
        return result.characters.count == 0 ? "/" : result;
    }
    // LC:68. Text Justification
    
    // LC:67. Add Binary
    
    // LC:65. Valid Number
    
    // LC:58. Length of Last Word
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
    
    // LC:49. Group Anagrams
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
    
    // LC:44. Wildcard Matching
    
    // LC:43. Multiply Strings
    
    // LC:38. Count and Say
    func countAndSay(_ n: Int) -> String {
        guard n > 0 else { return ""; }
        if n == 1 { return "1"; }
        var result = "1";
        
        for _ in 2...n {
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
        return result;
    }

    
    
    // LC:32. Longest Valid Parentheses
    
    // LC:30. Substring with Concatenation of All Words
    
    // LC:28. Implement strStr()
    
    
    // LC:22. Generate Parentheses
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
    
    // LC:20. Valid Parentheses
    // Time: O(N), space: O(N)
    func isMatch(_ x : Character, _ y : Character) -> Bool {
        switch x {
        case "{": return y == "}"
        case "[": return y == "]"
        case "(": return y == ")"
        default : return false
        }
        return false;
    }
    
    func isValid(_ s: String) -> Bool {
        var stack = [Character]()
        let schars = Array(s.characters)
        
        for char in schars {
            if ["(", "{", "["].contains(char) {
                stack.append(char);
            } else {
                if stack.count == 0 { return false; }
                let lastChar = stack.removeLast()
                if (!isMatch(lastChar, char)) { return false; }
            }
        }
        return stack.count == 0;
    }
    
    // LC:17. Letter Combinations of a Phone Numbe
    
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
    
    // LC:14. Longest Common Prefix
    func longestCommonPrefix(_ strs: [String]) -> String {
        guard strs.count > 0 else { return "" }
        var charsArrays = [[Character]]()
        for str in strs {
            let schars = Array(str.characters)
            charsArrays.append(schars)
        }
        var prefix = ""
        var currentCharIx = 0;
        var currentChar : Character = Character("a")
        while (true) {
            for ix in 0..<strs.count {
                if currentCharIx >= charsArrays[ix].count { return prefix; }
                if ix == 0 {
                    currentChar = charsArrays[ix][currentCharIx]
                } else {
                    if currentChar != charsArrays[ix][currentCharIx] { return prefix; }
                }
            }
            prefix += "\(currentChar)"
            currentCharIx += 1
        }
        return prefix;
    }
    
    func longestCommonPrefix2(_ strs: [String]) -> String {
        guard strs.count > 0 else { return ""; }
        let first = Array(strs[0].characters);
        for (index, char) in first.enumerated() {
            var ix = 1;
            while ix < strs.count {
                let current = Array(strs[ix].characters);
                if index >= current.count  || char != current[index] {
                    return String(first[0..<index]);
                }
                ix += 1;
            }
        }
        return strs[0];
    }

    
    // LC:13. Roman to Integer
    // Time: O(N), Space: O(1)
    func romanToInt(_ s: String) -> Int {
        let lookup : [Character : Int] = [
            "M" : 1000,
            "D" : 500,
            "C" : 100,
            "L" : 50,
            "X" : 10,
            "V" : 5,
            "I" : 1
        ]
        
        let schars = Array(s.characters)
        
        var maxSoFar = 1;
        var sum = 0;
        for ix in (0..<schars.count).reversed() {
            if let value = lookup[schars[ix]] {
                maxSoFar = max(maxSoFar, value);
                if value >= maxSoFar {
                    sum += value;
                } else {
                    sum -= value;
                }
            }
        }
        return sum;
    }
    
    // LC:12. Integer to Roman
    // Time: O(1), Space: O(1)
    public func intToRoman(_ num : Int) -> String {
        
        let M = ["", "M", "MM", "MMM"];
        let C = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        let X = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        let I = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
        
        return M[num/1000] + C[(num%1000)/100] + X[(num%100)/10] + I[num%10];
    }
    
    
    // LC:10. Regular Expression Matching
    
    // LC:8. String to Integer (atoi)
    func myAtoi(_ str: String) -> Int
    {
        var result = 0;
        var isNeg = false;
        let chars = Array(str.characters);
        for char in chars {
            if char == " " { continue }
            if char == "+" { continue }
            if char == "-" { isNeg = true; continue; }
            
            if  let digit = Int(String(char)) {
                result *= 10;
                result += digit;
            } else {
                break;
            }
        }
        return isNeg ? -result : result;
    }

    
    // LC:7. ZigZag Conversion
    
    // LC:5. Longest Palindromic Substring
    func longestPalindromeHelper(_ s: String, left: Int, right : Int) -> (Int, Int, Int) {
        
        var left = left, right = right;
        let chars = Array(s.characters);
        var maxLen = 1;
        
        while left >= 0 && right < chars.count && chars[left] == chars[right] {
            maxLen = max(maxLen, right - left + 1);
            left -= 1;
            right += 1;
        }
        return (maxLen, left + 1, right - 1);
    }
    
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s.characters);
        var maxLen = 1, maxLeft = 0, maxRight = 0;
        
        for (index, _) in chars.enumerated() {
            var (newLen, newLeft, newRight) = longestPalindromeHelper(s, left: index, right : index);
            if newLen > maxLen {
                maxLen = newLen;
                maxLeft = newLeft; maxRight = newRight;
            }
            (newLen, newLeft, newRight) = longestPalindromeHelper(s, left: index, right : index + 1);
            if newLen > maxLen {
                maxLen = newLen;
                maxLeft = newLeft; maxRight = newRight;
            }
        }
        return String(chars[maxLeft...maxRight]);
    }
    
    func longestPalindrome2(_ s: String) -> String
    {
        guard (s.characters.count > 1) else { return s; }
        
        var min_start = 0, max_len = 1, max_end = 0;
        var i = 0;
        let chars = Array(s.characters);
        while i < chars.count {
            if (chars.count - i <= max_len / 2) { break; }
            
            var j = i, k = i;
            while (k < chars.count - 1 && chars[k+1] == chars[k]) {
                k += 1; // Skip duplicate characters.
            }
            
            i = k+1;
            while (k < chars.count - 1 && j > 0 && chars[k + 1] == chars[j - 1]) {
                k += 1; // Expand.
                j -= 1;
            }
            let new_len = k - j + 1;
            if (new_len > max_len) {
                min_start = j; max_len = new_len; max_end = k;
            }
        }
        return String(chars[min_start...max_end]);
    }
    
    func longestPalindrome3(_ s: String) -> String {
        let schars = Array(s.characters)
        guard schars.count > 1 else { return s; }
        
        var low = 0, high = 0;
        for ix in 0..<schars.count {
            let (oddLow, oddHigh) = extend(schars, ix, ix)
            let (evenLow, evenHigh) = extend(schars, ix, ix + 1)
            if evenHigh > evenLow && evenHigh - evenLow > high - low {
                low = evenLow; high = evenHigh;
            }
            if oddHigh > oddLow && oddHigh - oddLow > high - low {
                low = oddLow; high = oddHigh;
            }
        }
        return String(schars[low...high])
    }
    
    func extend(_ schars : [Character], _ s : Int, _ e : Int) -> (Int, Int) {
        var s = s, e = e
        while s >= 0 && e < schars.count && schars[s] == schars[e] { s -= 1; e += 1; }
        return (s + 1, e - 1)
    }
    
    
    // LC:3. Longest Substring Without Repeating Characters
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
