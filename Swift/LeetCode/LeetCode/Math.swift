//
//  Math.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/18/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Math {
    
    // LC:628. Maximum Product of Three Numbers
    // @see Arrays
    
    // LC:415. Add Strings
    func addStrings(_ num1: String, _ num2: String) -> String {
        let n1 = Array(num1.characters)
        let n2 = Array(num2.characters)
        
        var len1 = n1.count - 1
        var len2 = n2.count - 1
        var carry = 0, sum = 0
        var result = ""
        while len1 >= 0 || len2 >= 0 || carry > 0 {
            var val1 = 0, val2 = 0
            if len1 >= 0, let v1 = Int(String(n1[len1])) { val1 = v1; len1 -= 1 }
            if len2 >= 0, let v2 = Int(String(n2[len2])) { val2 = v2; len2 -= 1 }
            let sum = val1 + val2 + carry
            carry = sum / 10
            result = "\(sum % 10)" + result
        }
        return result
    }
    
    // LC:367. Valid Perfect Square
    func isPerfectSquare(_ num: Int) -> Bool {
        var x = num
        while x * x > num {
            x = (x + num / x) >> 1
        }
        return x * x == num
    }
    
    func isPerfectSquare2(_ num: Int) -> Bool {
        var left = 0
        var right = num
        while left <= right {
            let mid = (left + right) / 2
            if mid * mid == num { return true }
            if mid * mid < num { left = mid + 1 }
            else { right = mid - 1; }
        }
        return false
    }
    
    // LC:326. Power of Three
    func isPowerOfThree(_ n: Int) -> Bool {
        // 1162261467 is 3^19,  3^20 is bigger than int
        return ( n>0 &&  1162261467%n == 0);
    }

    // LC:268. Missing Number
    // @see: Binary Search, Arrays, BitManipulation
    
    
    // LC:263. Ugly Number
    func isUgly(_ num: Int) -> Bool {
        if num == 1 { return true; }
        if num == 0 { return false; }
        var num = num
        while num % 2 == 0 { num >>= 1; }
        while num % 3 == 0 { num /= 3; }
        while num % 5 == 0 { num /= 5; }
        
        return num == 1
    }

    // 258. Add Digits
    //    For base b (decimal case b = 10), the digit root of an integer is:
    //
    //    dr(n) = 0 if n == 0
    //    dr(n) = (b-1) if n != 0 and n % (b-1) == 0
    //    dr(n) = n mod (b-1) if n % (b-1) != 0
    //      or
    //    dr(n) = 1 + (n - 1) % 9
    func addDigits(_ num: Int) -> Int {
        return 1 + (num - 1) % 9;
    }
    
    
    // LC:231. Power of Two
    // @see BitManipulation
    
    // LC:204. Count Primes
    // @see Hashtables
    
    // LC:202. Happy Number
    func digitSquareSum(_ n : Int) -> Int {
        var sum = 0
        var n = n
        while n != 0 {
            let temp = n % 10
            sum += temp * temp
            n /= 10
        }
        return sum
    }
    
    func isHappy(_ n: Int) -> Bool {
        
        var slow = n
        var fast = n
        repeat {
            slow = digitSquareSum(slow)
            fast = digitSquareSum(fast)
            fast = digitSquareSum(fast)
        } while slow != fast
        
        return slow == 1
    }
    
    // LC:172. Factorial Trailing Zeroes
    // The ZERO comes from 10.
    // The 10 comes from 2 x 5
    // And we need to account for all the products of 5 and 2. likes 4×5 = 20 ...
    // So, if we take all the numbers with 5 as a factor, we'll have way more than enough even numbers to pair with them to get factors of 10
    func trailingZeroes(_ n: Int) -> Int {
        return n == 0 ? 0 : n / 5 + trailingZeroes(n / 5);
    }
    
    func trailingZeroes2(_ n: Int) -> Int {
        var result = 0
        var n = n
        while n > 0 {
            result += n / 5
            n /= 5
        }
        return result
    }

    // LC:171. Excel Sheet Column Number
    func titleToNumber(_ s: String) -> Int {
        let lookup : [Character : Int] = ["A" : 1, "B" : 2, "C" : 3, "D" : 4, "E" : 5, "F" : 6, "G" : 7, "H" : 8,
                                          "I" : 9, "J" : 10, "K" : 11, "L" : 12, "M" : 13, "N" : 14, "O" : 15, "P" : 16,
                                          "Q" : 17, "R" : 18, "S" : 19, "T" : 20, "U" : 21, "V" : 22, "W" : 23, "X" : 24, "Y" : 25, "Z" : 26
        ]
        
        let schars = Array(s.characters)
        var result = 0
        for ix in 0..<schars.count {
            if let val = lookup[schars[ix]] {
                result *= 26
                result += val
            }
        }
        return result
    }
    
    // LC:168. Excel Sheet Column Title
    func convertToTitle(_ n: Int) -> String {
        var n = n
        var result = ""
        let lookup = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "V", "V", "W", "X", "Y", "Z"]
        while n > 0 {
            let val = (n - 1) % 26
            result = lookup[val] + result
            n = (n - 1) / 26
        }
        return result
    }
    
    // LC:69. Sqrt(x)
    // @see Binary Search
    
    // LC:67. Add Binary
    // @see Strings
    
    // LC:66. Plus One
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = digits;
        guard digits.count > 0 else { return result; }
        
        var ix = result.count - 1;
        result[ix] = result[ix] + 1
        
        while result[ix] == 10 && ix > 0 {
            result[ix] = 0;
            ix -= 1;
            result[ix] = result[ix] + 1;
        }
        if ix == 0 && result[ix] == 10 {
            result[0] = 0;
            result.insert(1, at: 0);
        }
        return result;
    }
    
    // LC:29. Divide Two Integers
    // @todo: passed 740 / 988
    func divide(_ dividend: Int, _ divisor: Int) -> Int {
        guard dividend > 0 else { return 0; }
        var isNeg = false
        var dividend  = dividend
        var divisor = divisor
        var result = 0
        if dividend < 0 { isNeg = !isNeg; dividend = -dividend }
        if divisor < 0 { isNeg = !isNeg; divisor = -divisor }
        
        while dividend >= divisor {
            var num  = divisor
            var mult = 1
            while (dividend >= (num << 1)) {
                num <<= 1
                mult <<= 1
            }
            result += mult
            dividend -= num
        }
        return isNeg ? -result : result
    }
    
    // LC:13. Roman to Integer
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
    public func intToRoman(_ num : Int) -> String {
        
        let M = ["", "M", "MM", "MMM"];
        let C = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        let X = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        let I = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
        
        return M[num/1000] + C[(num%1000)/100] + X[(num%100)/10] + I[num%10];
    }
    
    // LC:9. Palindrome Number
    // https://discuss.leetcode.com/topic/8090/9-line-accepted-java-code-without-the-need-of-handling-overflow
    func isPalindrome2(_ x : Int) -> Bool {
        if x < 0 || x != 0 && x % 10 == 0 { return false; }
        var xVar = x;
        var rev = 0;
        while xVar > rev {
            rev = rev * 10 + xVar % 10;
            xVar /= 10;
        }   
        return xVar == rev || xVar == rev / 10;
    }
    
    
    func myPower(_ x : Int, _ y : Int) -> Int {
        guard y > 0 else { return 1; }
        var result = 10;
        for _ in 0..<y-1 {
            result *= x;
        }
        return result;
    }
    
    func isPalindrome(_ x: Int) -> Bool {
        guard x >= 0 else { return false; }
        var numDigits = 0;
        var val = x;
        while val > 0 {
            numDigits += 1;
            val /= 10;
        }
        var xLSD = x;
        var xMSD = x;
        
        var pow10 = myPower(10, (numDigits - 1));
        
        for _ in 0..<(numDigits / 2) {
            if xLSD % 10 != xMSD / pow10 { return false; }
            xLSD /= 10;
            xMSD %= pow10;
            pow10 /= 10;
        }
        return true;
        
        
    }
    
    // LC:8. String to Integer (atoi)
    // @todo: didn't pass test cases, wing it and adapt it
    func myAtoi(_ str: String) -> Int {
        let schars = Array(str.characters)
        guard schars.count > 0 else { return 0; }
        var result = 0
        var ix = 0
        while schars[ix] == " " { ix += 1; }
        var isNeg = false
        if ix < schars.count && schars[ix] == "-"  { isNeg = true; ix += 1; }
        if ix < schars.count && schars[ix] == "+" { ix += 1; }
        
        while ix < schars.count {
            result *= 10
            if let val = Int(String(schars[ix])) {
                result += val
            }
            ix += 1
        }
        // if result > Int(Int32.max) { return 0 }
        return isNeg ? -result : result;
    }
    
    // LC:7. Reverse Integer
    func reverse(_ x: Int) -> Int {
        var result = 0;
        var xVar = x;
        while xVar != 0 {
            let tail = xVar % 10;
            let newResult = result * 10 + tail;
            if (newResult - tail ) / 10  != result  { return 0; }
            result = newResult;
            xVar /= 10;
        }
        return result;
        
    }
    
    // LC:2. Add Two Numbers
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var l1 = l1, l2 = l2
        let dummyHead = ListNode(0)
        var itr : ListNode? = dummyHead;
        var sum = 0
        while l1 != nil || l2 != nil {
            sum /= 10
            if let _ = l1 { sum += l1!.val; l1 = l1?.next; }
            if let _ = l2 { sum += l2!.val; l2 = l2?.next; }
            itr?.next = ListNode(sum % 10)
            itr = itr?.next
        }
        if (sum / 10) != 0 {
            itr?.next = ListNode(1)
        }
        return dummyHead.next
    }
    
}
