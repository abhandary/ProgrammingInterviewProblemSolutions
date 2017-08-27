//
//  Stacks.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/8/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Stacks {
    
    // LC:20. Valid Parentheses
    // @see: Strings
    
    // LC:71. Simplify Path
    // @see: Strings
    
    // LC: 144. Binary Tree Preorder Traversal
    func preorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack = [TreeNode]()
        var result = [Int]()
        guard root != nil else { return result; }
        
        stack.append(root!)
        while stack.count > 0 {
            if let last = stack.popLast() {
                result.append(last.val)
                if let right = last.right {
                    stack.append(right)
                }
                if let left = last.left {
                    stack.append(left)
                }
            }
        }
        return result
    }
    
    // LC:145. Binary Tree Postorder Traversal
    func postorderTraversal(_ root: TreeNode?) -> [Int] {
        var stack = [TreeNode]()
        var result = [Int]()
        guard root != nil else { return result; }
        
        stack.append(root!)
        while stack.count > 0 {
            if let last = stack.popLast() {
                result.append(last.val)
                if let left = last.left {
                    stack.append(left)
                }
                if let right = last.right {
                    stack.append(right)
                }
                
            }
        }
        return result.reversed()
    }
    
    // LC:150. Evaluate Reverse Polish Notation
    func evalRPN(_ tokens: [String]) -> Int {
        var stack = [Int]()
        for token in tokens {
            if token == "+" || token == "-" || token == "/" || token == "*" {
                let second = stack.removeLast()
                let first = stack.removeLast()
                switch token {
                case "+": stack.append(first + second)
                case "-": stack.append(first - second)
                case "*": stack.append(first * second)
                case "/": stack.append(first / second)
                default: break;
                }
            } else {
                if let val = Int(token) {
                    stack.append(val)
                }
            }
        }
        return stack.removeLast()
    }
    
    // LC:155. Min Stack
    /*
    class MinStack {
        public:
        /** initialize your data structure here. */
        stack<int> mainStack;
        stack<int> minStack;
        
        MinStack() {
        
        }
        
        void push(int x) {
            mainStack.push(x);
            if (minStack.size() == 0 || x <= minStack.top()) {
                minStack.push(x);
            }
        }
        
        void pop() {
            int  top = mainStack.top();
            mainStack.pop();
            if (top == minStack.top()) {
                minStack.pop();
            }
        }
        
        int top() {
            return mainStack.top();
        }
        
        int getMin() {
            return minStack.top();
        }
    };
    */
    
    // LC:225. Implement Stack using Queues
    // @todo: wing it
    
    // LC:232. Implement Queue using Stacks
    // @todo: wing it    
    
    // LC:331. Verify Preorder Serialization of a Binary Tree
    func isValidSerialization(_ preorder: String) -> Bool {
        let nodes = preorder.characters.split{$0 == ","}.map(String.init)
        var diff = 1
        for node in nodes {
            diff -= 1
            if diff < 0 { return false; }
            if node != "#" { diff += 2; }
        }
        return diff == 0
    }

    /*
    public boolean isValidSerialization(String preorder) {
        // using a stack, scan left to right
        // case 1: we see a number, just push it to the stack
        // case 2: we see #, check if the top of stack is also #
        // if so, pop #, pop the number in a while loop, until top of stack is not #
        // if not, push it to stack
        // in the end, check if stack size is 1, and stack top is #
        if (preorder == null) {
            return false;
        }
        Stack<String> st = new Stack<>();
        String[] strs = preorder.split(",");
        for (int pos = 0; pos < strs.length; pos++) {
            String curr = strs[pos];
            while (curr.equals("#") && !st.isEmpty() && st.peek().equals(curr)) {
                st.pop();
                if (st.isEmpty()) {
                    return false;
                }
                st.pop();
            }
            st.push(curr);
        }
        return st.size() == 1 && st.peek().equals("#");
    }
    */
    
    // LC:341. Flatten Nested List Iterator
    /*
    class NestedIterator {
        public:
     
        stack<NestedInteger> nstack;
     
        NestedIterator(vector<NestedInteger> &nestedList) {
            for (int ix = nestedList.size() - 1; ix >= 0 ; ix--) {
                nstack.push(nestedList[ix]);
            }
        }
        
        int next() {
            int top = nstack.top().getInteger();
            nstack.pop();
            return top;
        }
        
        bool hasNext() {
            while (nstack.size() > 0) {
                NestedInteger top = nstack.top();
                if (top.isInteger()) {
                    return true;
                } else {
                    nstack.pop();
                    for (int ix = top.getList().size() - 1; ix >= 0; ix--) {
                        nstack.push(top.getList()[ix]);
                    }
                }
            }
        
            return false;
        }
    };
    */
    
    // LC:394. Decode String
    func decodeStringHelper(_ schars : [Character], _ pos : inout Int) -> String {
        
        var result = ""
        let digits = 0...9
        while pos < schars.count && schars[pos] != "]" {
            var num = 0
            if let val = Int(String(schars[pos])) {
                // nums
                while let val = Int(String(schars[pos])), digits.contains(val) {
                    num = num * 10 + val; pos += 1;
                }
                
                pos += 1 // [
                let decoded = decodeStringHelper(schars, &pos)
                pos += 1 // ]
                for ix in 0..<num { result += decoded; }
            } else {
                result += String(schars[pos])
                pos += 1
            }
        }
        return result;
    }
    
    func decodeString(_ s: String) -> String {
        var pos = 0
        return decodeStringHelper(Array(s.characters), &pos)
    }
    
    // LC: 496. Next Greater Element I
    // https://discuss.leetcode.com/topic/77916/java-10-lines-linear-time-complexity-o-n-with-explanation/2
    func nextGreaterElement(_ findNums: [Int], _ nums: [Int]) -> [Int] {
        var result = [Int](repeating: -1, count: findNums.count)
        
        var stack = [Int]()
        var hmap = [Int : Int]()
        
        for num in nums {
            while stack.count > 0 && stack.last! < num {
                hmap[stack.popLast()!] = num
            }
            stack.append(num);
        }
        
        for ix in 0..<findNums.count {
            if let found = hmap[findNums[ix]] {
                result[ix] = found
            }
        }
        return result
    }
}
