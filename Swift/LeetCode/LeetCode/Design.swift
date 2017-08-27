//
//  Design.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/26/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

// LC:155. Min Stack

// LC:173. Binary Search Tree Iterator

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

class Design {
    
}
