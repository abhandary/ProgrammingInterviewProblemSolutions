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
