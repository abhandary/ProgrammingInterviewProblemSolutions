//
//  StacksAndQueues.swift
//  EPI
//
//  Created by Akshay Bhandary on 9/15/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation

class Stacks {
    // 9.1 Implement a stack with max API.
    var stack = [Int]();
    var maxStack = [Int]();
    
    func push(x : Int) {
        stack.append(x);
        if let last = maxStack.last,
            x >= last {
            maxStack.append(x)
        }
    }
    func pop() -> Int {
        let last = stack.removeLast();
        
        if let maxStackLast = maxStack.last,
            last == maxStackLast {
            maxStack.removeLast()
        }
        return last;
    }
    
    func max() -> Int {
        return maxStack.last ?? Int.min;
    }
    
    
    // 9.2 Evaluate RPN expressions.
    func evaluateRPN(_ s : String) -> Int {
        var stack = [String]();
        let chars = Array(s.characters);
        for c in chars {
            switch  c {
            case "0"..."9":
                stack.append(String(c));
            default:
                let first = stack.removeLast();
                let second = stack.removeLast();
                if c == "-" {
                    stack.append(String(Int(second)! - Int(first)!));
                } else if c == "+" {
                    stack.append(String(Int(second)! + Int(first)!));
                } else if c == "/" {
                    stack.append(String(Int(second)! / Int(first)!));
                } else if c == "*" {
                    stack.append(String(Int(second)! * Int(first)!));
                }
            }
        }
        return Int(stack.removeLast())!
    }
    
    // 9.3 Test a string over "{,},(,),[,]" for well-formedness
    func matches(_ l : Character, _ r : Character) -> Bool {
        if ((l == "[" && r != "]") ||
           (l == "{" && r != "}") ||
           (l == "(" && r != ")")) {
            return false
        }
        return true;
    }
    
    func isWellFormed(_ s : String) -> Bool {
        var stack = [Character]();
        
        let chars = Array(s.characters);
        for c in chars {
            switch  c {
            case "{", "[", "(":
                stack.append(c)
            case "}", "]", ")":
                if stack.count == 0 {
                    return false;
                }
                let last = stack.removeLast();
                if (!matches(last, c)) {
                    return false;
                }
            default:
                break;
            }
        }
        return true;
    }
    
    // 9.4 Normalize Path names
    func shortestEquivalentPath(s : String) -> String {
        
        guard s.characters.count > 0 else { return "" }
        
        let parts = s.components(separatedBy: "/");
        var stack = [String]();
        if s.characters.first! == "/" {
            stack.append("/")
        }
        for part in parts {
            if part == ".." {
                if stack.count == 0 || stack.last! == ".." {
                    stack.append(part)
                } else {
                    if stack.last! == "/" {
                        return ""
                    }
                    stack.removeLast()
                }
            } else if part != "." && part != "" {
                stack.append(part)
            }
        }
        
        var result = "";
        let first = stack.removeFirst();

        if first != "/" {
            result = "/" + first;
        }
        
        stack.forEach { result += "/" +  $0;  }
        
        return result;
    }
}
