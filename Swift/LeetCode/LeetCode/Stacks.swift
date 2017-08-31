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
    
    // LC:385. Mini Parser
    func deserializeHelper(_ s : String, _ ix : inout Int) -> NestedInteger {
        var schars = Array(s.characters)
        var result = NestedInteger()
        
        if schars[ix] != "[" {
            var val = 0
            while ix < schars.count && schars[ix] != "," && schars[ix] != "]" {
                val = val * 10 + Int(String(schars[ix]))!
                ix += 1
            }
            if ix < schars.count { ix -= 1; // ',' & ']' }
                result.setInteger(elem: val)
                return result;
            } else if schars[ix] == "," {
                ix += 1
            }
        }
        else {
            ix += 1 // eat [
            repeat {
                if schars[ix] == "," { ix += 1 }
                let nestedInt = deserializeHelper(String(schars[ix..<schars.count]), &ix)
                // result.add(elem: nestedInt)
            } while schars[ix] == ","
            ix += 1 // eat ]
            
        }
        return result;
    }
    
    /* SP
     
     public NestedInteger deserialize(String s) {
        if (s.isEmpty())
            return null;
        if (s.charAt(0) != '[') // ERROR: special case
            return new NestedInteger(Integer.valueOf(s));
     
        Stack<NestedInteger> stack = new Stack<>();
        NestedInteger curr = null;
        int l = 0; // l shall point to the start of a number substring;
     
        // r shall point to the end+1 of a number substring
        for (int r = 0; r < s.length(); r++) {
            char ch = s.charAt(r);
            if (ch == '[') {
                if (curr != null) {
                    stack.push(curr);
                }
                curr = new NestedInteger();
                l = r+1;
            } else if (ch == ']') {
                String num = s.substring(l, r);
                if (!num.isEmpty())
                    curr.add(new NestedInteger(Integer.valueOf(num)));
                if (!stack.isEmpty()) {
                    NestedInteger pop = stack.pop();
                    pop.add(curr);
                    curr = pop;
                }
                l = r+1;
            } else if (ch == ',') {
                if (s.charAt(r-1) != ']') {
                    String num = s.substring(l, r);
                    curr.add(new NestedInteger(Integer.valueOf(num)));
                }
                l = r+1;
            }
        }
     
        return curr;
     }
     
     class Solution {
        public:
            NestedInteger deserialize(string s) {
            istringstream in(s);
            return deserialize(in);
        }
        private:
        NestedInteger deserialize(istringstream &in) {
            int number;
            if (in >> number)
                return NestedInteger(number);
            in.clear();
            in.get();
            NestedInteger list;
            while (in.peek() != ']') {
                list.add(deserialize(in));
                if (in.peek() == ',')
                    in.get();
            }
            in.get();
            return list;
        }
     };
     
     
 
    */
    
    func deserialize(_ s: String) -> NestedInteger {
        var ix = 0
        return deserializeHelper(s, &ix)
    }
    
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
    
    // LC:402. Remove K Digits
    /*
    public String removeKdigits(String num, int k) {
        int digits = num.length() - k;
        char[] stk = new char[num.length()];
        int top = 0;
        // k keeps track of how many characters we can remove
        // if the previous character in stk is larger than the current one
        // then removing it will get a smaller number
        // but we can only do so when k is larger than 0
        for (int i = 0; i < num.length(); ++i) {
            char c = num.charAt(i);
            while (top > 0 && stk[top-1] > c && k > 0) {
                top -= 1;
                k -= 1;
            }
            stk[top++] = c;
        }
        // find the index of first non-zero digit
        int idx = 0;
        while (idx < digits && stk[idx] == '0') idx++;
        return idx == digits? "0": new String(stk, idx, digits - idx);
    }
    */
    
    // LC:456. 132 Pattern
    // https://discuss.leetcode.com/topic/67881/single-pass-c-o-n-space-and-time-solution-8-lines-with-detailed-explanation/2
    /*
    bool find132pattern(vector<int>& nums) {
        int s3 = INT_MIN;
        stack<int> st;
        for( int i = nums.size()-1; i >= 0; i -- ){
            if( nums[i] < s3 ) return true;
            else while( !st.empty() && nums[i] > st.top() ){
                s3 = st.top(); st.pop();
            }
            st.push(nums[i]);
        }
        return false;
    }
     public boolean find132pattern(int[] nums) {
        Stack<Pair> stack = new Stack();
        for(int n: nums){
            if(stack.isEmpty() || n <stack.peek().min ) stack.push(new Pair(n,n));
            else if(n > stack.peek().min){
                Pair last = stack.pop();
                if(n < last.max) return true;
                else {
                    last.max = n;
                    while(!stack.isEmpty() && n >= stack.peek().max) stack.pop();
                    // At this time, n < stack.peek().max (if stack not empty)
                    if(!stack.isEmpty() && stack.peek().min < n) return true;
                    stack.push(last);
                }
     
            }
        }
        return false;
     }
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
    
    // LC:503. Next Greater Element II
    /*
     vector<int> nextGreaterElements(vector<int>& nums) {
        int n = nums.size();
        vector<int> next(n, -1);
        stack<int> s; // index stack
        for (int i = 0; i < n * 2; i++) {
            int num = nums[i % n];
            while (!s.empty() && nums[s.top()] < num) {
                next[s.top()] = num;
                s.pop();
            }
            if (i < n) s.push(i);
        }
        return next;
     }
     
     public int[] nextGreaterElements(int[] nums) {
        int max = Integer.MIN_VALUE;
        for (int num : nums) {
            max = Math.max(max, num);
        }
     
        int n = nums.length;
        int[] result = new int[n];
        int[] temp = new int[n * 2];
     
        for (int i = 0; i < n * 2; i++) {
            temp[i] = nums[i % n];
        }
     
        for (int i = 0; i < n; i++) {
            result[i] = -1;
            if (nums[i] == max) continue;
     
            for (int j = i + 1; j < n * 2; j++) {
                if (temp[j] > nums[i]) {
                    result[i] = temp[j];
                    break;
                }
            }
        }
     
        return result;
     }
     
     public int[] nextGreaterElements(int[] nums) {
        int n = nums.length;
        int[] result = new int[n];
     
        Stack<Integer> stack = new Stack<>();
        for (int i = n - 1; i >= 0; i--) {
            stack.push(i);
        }
     
        for (int i = n - 1; i >= 0; i--) {
            result[i] = -1;
            while (!stack.isEmpty() && nums[stack.peek()] <= nums[i]) {
                stack.pop();
            }
            if (!stack.isEmpty()){
                result[i] = nums[stack.peek()];
            }
            stack.add(i);
        }
     
        return result;
     }
     
    */
    
    // LC:636. Exclusive Time of Functions
    /*
    public int[] exclusiveTime(int n, List<String> logs) {
        int[] res = new int[n];
        Stack<Integer> stack = new Stack<>();
        int prevTime = 0;
        for (String log : logs) {
            String[] parts = log.split(":");
            if (!stack.isEmpty()) res[stack.peek()] +=  Integer.parseInt(parts[2]) - prevTime;
            prevTime = Integer.parseInt(parts[2]);
            if (parts[1].equals("start")) stack.push(Integer.parseInt(parts[0]));
            else {
                res[stack.pop()]++;
                prevTime++;
            }
        }
        return res;
    }
    */
    
}
