//
//  Math.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/18/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Math {
    
    // LC: 9. Palindrome Number
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
    
    // LC: 7. Reverse Integer
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
}
