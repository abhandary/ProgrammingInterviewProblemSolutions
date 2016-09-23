//
//  7_Strings.swift
//  EPI
//
//  Created by Akshay Bhandary on 9/12/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation

extension String {
    func charAt(_ ix : Int) -> Character {
        return self[self.characters.index(self.startIndex, offsetBy: ix)]
    }
}

class Strings {
    
    // MARK: - 7.1 Interconvert Strings and Ints
    func intToString(_ x : Int) -> String {
        var result = ""
        
        let isPos = x < 0 ? true : false;
        var x = isPos ? x : -x;
        
        while x > 0 {
            result += String(x % 10)
            x /= 10
        }
        if !isPos {
            result += "-"
        }
        return String(result.characters.reversed())
    }
    
    func stringToInt(_ s : String) -> Int {
        guard s.characters.count > 0 else {return 0}
        var isPos = true
        var pos = 0
        var result = 0
        if s.charAt(0) == "-" {
            isPos = false
            pos += 1
        }
        
        while pos < s.characters.count {
            switch  s.charAt(pos) {
            case "0"..."9":
                result = (result * 10) + Int(String(s.charAt(pos)))!
            default:
                return isPos ? result : -result
            }
            pos += 1
        }
        return  isPos ? result : -result
    }
    
    // MARK: - 7.2 Convert Base
    func convertBase(_ s : String, b1 : Int, b2 : Int) -> String {
        guard s.characters.count > 0 else {return ""}
        
        var inter = 0
        for c in s.characters {
            switch c {
            case "0"..."9":
                inter = inter * b1 + Int(String(c))!
            case "a"..."z":
                let value = String(c) as NSString
                let a = "a" as NSString
                inter = (inter * b1) + Int(value.character(at: 0)) + 10 - Int(a.character(at: 0))
            case "A"..."Z":
                let value = String(c) as NSString
                let a = "A" as NSString
                inter = (inter * b1) + Int(value.character(at: 0)) + 10 - Int(a.character(at: 0))

            default:
                break
            }
        }
        var result = ""
        while inter > 0 {
            let digit = inter % b2
            switch digit {
            case 0...9:
                result += String(digit)
            default:
                result += String(format: "%x", digit)
            }

            inter /= b2
        }
        return String(result.characters.reversed())
    }
    
    // MARK: - 7.3 Compute the spread sheet column encoding
    func SSColDecodeID(_ s : String) -> Int {
        var result = 0
        for c in s.characters {
            let value = String(c) as NSString
            let a = "A" as NSString
            let newVal = Int(value.character(at: 0)) - Int(a.character(at: 0)) + 1
            result = result * 26 + newVal
        }
        return result
    }
    
    // MARK: - 7.4 Replace each 'a' by two 'd', delte each entry containing a 'b'
    func replaceAndRemove(_ s : String) -> String {
        var result = ""
        for c in s.characters {
            switch c {
            case "a":
                result += "dd"
            case "b":
                break
            default:
                result.append(c)
            }
        }
        return result
    }


    func replaceAndRemove2(_ s : inout String) {
        
        _ = "value" as NSString
        
        
        var inter = Array(s.characters)
        var rx = 0, wx = 0
        var aCount = 0
        while rx < inter.count {
            if inter[rx] != "b" {
                inter[wx] = inter[rx]
                wx += 1;
            }
            if inter[rx] == "a" {
                aCount += 1
            }
            rx += 1
        }
        inter.removeSubrange((wx ..< s.characters.count))
        _ = wx + aCount;
        while wx < aCount {
            inter.append("0")
            wx += 1
        }
        rx = aCount - 1
        wx = aCount - 1
        while wx >= 0 {
            
        }
    }

    
    // MARK: - 7.5 Test Palindromicity
    func isAlphaNum(_ c : Character) -> Bool {
        switch c {
        case "0"..."9", "a"..."z", "A"..."Z":
            return true
        default:
            return false
        }
    }
    
    func toLower(_ c : Character) -> String {
        return String(c).lowercased()
    }
    
    func isPalindrome(_ s : String) -> Bool {
        guard s.characters.count > 0 else {return true}
        var left = 0
        var right = s.characters.count - 1
        while left < right {
            while left < right && !isAlphaNum(s[s.characters.index(s.startIndex, offsetBy: left)]) {
                left += 1
            }
            while left < right && !isAlphaNum(s[s.characters.index(s.startIndex, offsetBy: right)]) {
                right -= 1
            }
            
            if toLower(s.charAt(left)) != toLower(s.charAt(right)) {
                return false
            }
            left += 1;
            right -= 1;
        }
        return true
    }
    
    // MARK: - 7.6 Reverse all words in a sentence
    func reverseWords(_ s : String) -> String {
        
        let temp = String(s.characters.reversed())
        var result = ""
        for word in temp.components(separatedBy: " ") {
            result = result + " " + String(word.characters.reversed())
        }
        return result
    }
    
    // MARK: - 7.7 Compute all Mnemonics for a phone number
    let dict : [Character : String] = [
        "0" : "0",
        "1" : "1",
        "2" : "ABC",
        "3" : "DEF",
        "4" : "GHI",
        "5" : "JKL",
        "6" : "MNO",
        "7" : "PQRS",
        "8" : "TUV",
        "9" : "WXYZ"
    ];
    
    func phoneMnemonicHelper(_ s : String, pos : Int, partial : String, result : inout [String]) {
        
        if pos == s.characters.count {
            result.append(partial);
            return;
        }

        if let val = dict[s[s.characters.index(s.startIndex, offsetBy: pos)]] {
            phoneMnemonicHelper(s, pos: pos + 1, partial : partial + val, result: &result);
        }
    }
    
    func phoneMnemonic(_ s : String) -> [String] {
        
        var result = [String]()
        phoneMnemonicHelper(s, pos: 0, partial: "", result: &result)
        return result;
    }
    
    // MARK: - 7.8 The Look-And-Say Problem
    func lookAndSay(_ k : Int) -> String {
        var num = "1"
        for _ in 1..<k {
            num = nextNum(num)
        }
        return num
    }
    
    func nextNum(_ input : String) -> String {
        var result = ""
        var count = 1;
        var ix = 1
        let chars = Array(input.characters)
        while ix < input.characters.count  {
            if (chars[ix - 1] == chars[ix]) {
                count += 1;
            } else {
                result += String(count) + String(chars[ix - 1])
                count = 1
            }
            ix += 1;
        }
        
        result += String(count) + String(chars[ix - 1])
        
        return result;
    }
    
    // MARK: - 7.9 Convert from Roman to Decimal
    func  convertFromRomanToDecimal (_ s : String) -> Int {
        
        let lookup : [Character : Int] = [
            "M" : 1000,
            "D" : 500,
            "C" : 100,
            "L" : 50,
            "X" : 10,
            "V" : 5,
            "I" : 1
        ]
        
        var sum = lookup[s.characters.last!]!;
        let chars = Array(s.characters);
        
        for ix in (0..<chars.count-1).reversed() {
            let val = lookup[chars[ix]]!;
            if val < lookup[chars[ix + 1]]! {
                sum -= val;
            } else {
                sum += val;
            }
        }
        return sum;
    }
    
    // MAR:: - 7.11 Write a string sinusoidally
    func snakeString(s : String) -> String {
        var result = [String](repeating:"", count : 3);
        let chars = Array(s.characters);
        for ix in stride(from: 1, to: chars.count, by: 4) {
            result[0] += String(chars[ix]);
        }
        for ix in stride(from: 0, to: chars.count, by: 2) {
            result[1] += String(chars[ix]);
        }
        for ix in stride(from: 3, to: chars.count, by: 4) {
            result[1] += String(chars[ix]);
        }
        
        var final = "";
        for ix in 0..<result.count {
            final += result[ix];
        }
        return final;
    }
    // O(n)
    
    // MARK: - 7.12 Implement Run Length Encoding
    func encoding(s : String) -> String {
        
        let chars = Array(s.characters);
        var count = 1;
        var result = "";
        for ix in (1..<chars.count) {
            if chars[ix - 1] == chars[ix] {
                count += 1;
            } else {
                result += String(count) + String(chars[ix - 1])
                count = 1;
            }
        }
        result += String(count) + String(chars[chars.count - 1]);
        return result;
    }
    
    func decoding(s : String) -> String {
        
        let chars = Array(s.characters)
        var result = ""
        var count = 0;
        for ix in 0..<chars.count {
            switch  chars[ix] {
            case "0"..."9":
                count = count * 10 + Int(String(chars[ix]))!
            default:
                count = count == 0 ? 1 : count;
                result += String(repeating: String(chars[ix]), count: count);
                count = 0;
            }
        }
        return result;
    }
    
    func badDecoding(s : String) -> String {
        
        let chars = Array(s.characters)
        var result = ""
        var number = ""
        var count = 0;
        for ix in 0..<chars.count {
            switch  chars[ix] {
            case "0"..."9":
                if count > 0 {
                    result += String(repeating: String(chars[ix]), count: count);
                }
                else {
                    number += String(chars[ix]);
                }
                count = 0;
            case "x":
                if ix == chars.count - 1 {
                    result += number + "x";
                }
                else if number.characters.count > 0 {
                    count = Int(number)!
                }
                number = ""
            default:
                count = count == 0 ? 1 : count;
                result += number + String(repeating: String(chars[ix]), count: count);
                number = ""
                count = 0;
            }
        }
        
        
    
        return result;
    }
}
