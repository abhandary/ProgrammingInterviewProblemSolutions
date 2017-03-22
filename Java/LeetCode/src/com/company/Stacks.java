package com.company;

import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 2/28/17.
 */

// 155. Min Stack
// Time: O(c), Space: O(k)
// https://leetcode.com/problems/min-stack/?tab=Description
class MinStack {


    private Stack<Integer> stack;
    private Stack<Integer> minStack;

    /** initialize your data structure here. */
    public MinStack() {
        stack = new Stack<Integer>();
        minStack = new Stack<Integer>();
    }

    public void push(int x) {
        stack.push(x);
        if (minStack.empty()) {
            minStack.push(x);
        } else if (x <= minStack.peek()) {
            minStack.push(x);
        }
    }

    public void pop() {
        int top = stack.peek();
        stack.pop();
        if (top == minStack.peek()) {
            minStack.pop();
        }
    }

    public int top() {
        return stack.peek();
    }

    public int getMin() {
        return minStack.peek();
    }
}

// 232. Implement Queue using Stacks
// Time: O(c) - push, O(n) pop, O(n) peek, O(c) for empty
// https://leetcode.com/problems/implement-queue-using-stacks/?tab=Description
class MyQueue {

    Stack<Integer> tail;
    Stack<Integer> head;

    /** Initialize your data structure here. */
    public MyQueue() {
        tail = new Stack<Integer>();
        head = new Stack<>();
    }

    /** Push element x to the back of queue. */
    public void push(int x) {
        tail.push(x);
    }

    /** Removes the element from in front of queue and returns that element. */
    public int pop() {
        if (!head.empty()) { return head.pop(); }
        while (!tail.empty()) {
            head.push(tail.pop());
        }
        return head.pop();
    }

    /** Get the front element. */
    public int peek() {

        if (!head.empty()) { return head.peek(); }
        while (!tail.empty()) {
            head.push(tail.pop());
        }
        return head.peek();
    }

    /** Returns whether the queue is empty. */
    public boolean empty() {
        return head.empty() && tail.empty();
    }
}

public class Stacks {

    // LC: 503. Next Greater Element II
    // Given a circular array (the next element of the last element is the first element of the array), print the Next
    // Greater Number for every element. The Next Greater Number of a number x is the first greater number to its
    // traversing-order next in the array, which means you could search circularly to find its next greater number.
    // If it doesn't exist, output -1 for this number.
    // https://discuss.leetcode.com/topic/77923/java-10-lines-and-c-12-lines-linear-time-complexity-o-n-with-explanation
    // https://discuss.leetcode.com/topic/77881/typical-ways-to-solve-circular-array-problems-java-solution
    public int[] nextGreaterElements2(int[] nums) {
        int n = nums.length, next[] = new int[n];
        Arrays.fill(next, -1);
        Stack<Integer> stack = new Stack<>(); // index stack
        for (int i = 0; i < n * 2; i++) {
            int num = nums[i % n];
            while (!stack.isEmpty() && nums[stack.peek()] < num)
                next[stack.pop()] = num;
            if (i < n) stack.push(i);
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

    // LC: 496. Next Greater Element I
    // You are given two arrays (without duplicates) nums1 and nums2 where nums1’s elements are subset of nums2.
    // Find all the next greater numbers for nums1's elements in the corresponding places of nums2.
    // The Next Greater Number of a number x in nums1 is the first greater number to its right in nums2.
    // If it does not exist, output -1 for this number.
    // Input: nums1 = [4,1,2], nums2 = [1,3,4,2].
    // Output: [-1,3,-1]
    // Explanation:
    // For number 4 in the first array, you cannot find the next greater number for it in the second array, so output -1.
    // For number 1 in the first array, the next greater number for it in the second array is 3.
    // For number 2 in the first array, there is no next greater number for it in the second array, so output -1.
    public int[] nextGreaterElement(int[] findNums, int[] nums) {
        Map<Integer, Integer> map = new HashMap<>(); // map from x to next greater element of x
        Stack<Integer> stack = new Stack<>();
        for (int num : nums) {
            while (!stack.isEmpty() && stack.peek() < num)
                map.put(stack.pop(), num);
            stack.push(num);
        }
        for (int i = 0; i < findNums.length; i++)
            findNums[i] = map.getOrDefault(findNums[i], -1);
        return findNums;
    }

    // LC: 456. 132 Pattern
    // https://discuss.leetcode.com/topic/68193/java-o-n-solution-using-stack-in-detail-explanation
    class Pair{
        int min, max;
        public Pair(int min, int max){
            this.min = min;
            this.max = max;
        }
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

    // LC: 402. Remove K Digits
    // Given a non-negative integer num represented as a string, remove k digits from the number so that the new number is the smallest possible.
    // Note:
    // The length of num is less than 10002 and will be ≥ k.
    // The given num does not contain any leading zero.
    // Input: num = "1432219", k = 3
    // Output: "1219"
    // Explanation: Remove the three digits 4, 3, and 2 to form the new number 1219 which is the smallest.
    // SP: https://discuss.leetcode.com/topic/59380/short-python-one-o-n-and-one-regex
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

    // LC: 394. Decode String
    // Given an encoded string, return it's decoded string.
    // The encoding rule is: k[encoded_string], where the encoded_string inside the square brackets is being
    // repeated exactly k times. Note that k is guaranteed to be a positive integer.
    // You may assume that the input string is always valid; No extra white spaces, square brackets are well-formed, etc.
    // Furthermore, you may assume that the original data does not contain any digits and that digits are only for
    // those repeat numbers, k. For example, there won't be input like 3a or 2[4].
    // https://discuss.leetcode.com/topic/57159/simple-java-solution-using-stack
    // https://discuss.leetcode.com/topic/57228/0ms-simple-c-solution
    // https://discuss.leetcode.com/topic/57250/java-short-and-easy-understanding-solution-using-stack
    // SP: https://discuss.leetcode.com/topic/57145/3-lines-python-2-lines-ruby-regular-expression
    public String decodeString(String s) {

        String res = "";
        Stack<Integer> countStack = new Stack<>();
        Stack<String> resStack = new Stack<>();
        int idx = 0;
        while (idx < s.length()) {
            if (Character.isDigit(s.charAt(idx))) {
                int count = 0;
                while (Character.isDigit(s.charAt(idx))) {
                    count = 10 * count + (s.charAt(idx) - '0');
                    idx++;
                }
                countStack.push(count);
            }
            else if (s.charAt(idx) == '[') {
                resStack.push(res);
                res = "";
                idx++;
            }
            else if (s.charAt(idx) == ']') {
                StringBuilder temp = new StringBuilder (resStack.pop());
                int repeatTimes = countStack.pop();
                for (int i = 0; i < repeatTimes; i++) {
                    temp.append(res);
                }
                res = temp.toString();
                idx++;
            }
            else {
                res += s.charAt(idx++);
            }
        }
        return res;
    }

    // LC: 385. Mini Parser
    // Given a nested list of integers represented as a string, implement a parser to deserialize it.
    // Each element is either an integer, or a list -- whose elements may also be integers or other lists.
    // Note: You may assume that the string is well-formed:
    // String is non-empty.
    // String does not contain white spaces.
    // String contains only digits 0-9, [, - ,, ].
    // SP: https://discuss.leetcode.com/topic/54258/python-c-solutions
    // https://discuss.leetcode.com/topic/54270/an-java-iterative-solution
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

    // LC: 341. Flatten Nested List Iterator
    // @see NestedIterator

    // LC: 331. Verify Preorder Serialization of a Binary Tree
    // One way to serialize a binary tree is to use pre-order traversal. When we encounter a non-null node, we record
    // the node's value. If it is a null node, we record using a sentinel value such as #.
    // For example, the above binary tree can be serialized to the string "9,3,4,#,#,1,#,#,2,#,6,#,#",
    // where # represents a null node.
    // Given a string of comma separated values, verify whether it is a correct preorder traversal serialization of a
    // binary tree. Find an algorithm without reconstructing the tree.
    // Each comma separated value in the string must be either an integer or a character '#' representing null pointer.
    // You may assume that the input format is always valid, for example it could never contain two consecutive commas
    // such as "1,,3".
    // https://discuss.leetcode.com/topic/35976/7-lines-easy-java-solution
    public boolean isValidSerialization(String preorder) {
        String[] nodes = preorder.split(",");
        int diff = 1;
        for (String node: nodes) {
            if (--diff < 0) return false;
            if (!node.equals("#")) diff += 2;
        }
        return diff == 0;
    }

    // LC: 316. Remove Duplicate Letters
    // Given a string which contains only lowercase letters, remove duplicate letters so that every letter appear once and only once. You must make sure your result is the smallest in lexicographical order among all possible results.
    // Example:
    // Given "bcabc"
    // Return "abc"
    // https://discuss.leetcode.com/topic/31404/a-short-o-n-recursive-greedy-solution

    // LC: 232. Implement Queue using Stacks
    // @see MyQueue

    // LC: 225. Implement Stack using Queues
    // @see MyStack

    // LC: 224. Basic Calculator
    // @todo UNSOLVED, HARD
    // https://discuss.leetcode.com/topic/15816/iterative-java-solution-with-stack
    public int calculate(String s) {
        Stack<Integer> stack = new Stack<Integer>();
        int result = 0;
        int number = 0;
        int sign = 1;
        for(int i = 0; i < s.length(); i++){
            char c = s.charAt(i);
            if(Character.isDigit(c)){
                number = 10 * number + (int)(c - '0');
            }else if(c == '+'){
                result += sign * number;
                number = 0;
                sign = 1;
            }else if(c == '-'){
                result += sign * number;
                number = 0;
                sign = -1;
            }else if(c == '('){
                //we push the result first, then sign;
                stack.push(result);
                stack.push(sign);
                //reset the sign and result for the value in the parenthesis
                sign = 1;
                result = 0;
            }else if(c == ')'){
                result += sign * number;
                number = 0;
                result *= stack.pop();    //stack.pop() is the sign before the parenthesis
                result += stack.pop();   //stack.pop() now is the result calculated before the parenthesis

            }
        }
        if(number != 0) result += sign * number;
        return result;
    }

    public int calculate2(String s) {
        if(s == null)
            return 0;
        s = reform(s);
        int result = 0, num = 0, base = 1;
        for(char c: s.toCharArray())
            switch(c){
                case '+': result += num; num = 0; base = 1; break;
                case '-': result -= num; num = 0; base = 1; break;
                default: num += (c - '0') * base; base *= 10;
            }
        return result;
    }

    private String reform(String s) {
        StringBuilder sb = new StringBuilder();
        Stack<Boolean> stack = new Stack<>();
        stack.push(true);
        boolean add = true;
        for(char c: s.toCharArray())
            switch(c){
                case ' ': break;
                case '(': stack.push(add); break;
                case ')': stack.pop(); break;
                case '+':
                    add = stack.peek();
                    sb.append(stack.peek() ? '+' : '-');
                    break;
                case '-':
                    add = !stack.peek();
                    sb.append(stack.peek() ? '-' : '+');
                    break;
                default: sb.append(c);
            }
        if(sb.charAt(0) != '+' || sb.charAt(0) != '-')
            sb.insert(0, '+');
        return sb.reverse().toString();
    }

    // LC: 173. Binary Search Tree Iterator
    // @see below

    // LC: 155. Min Stack
    // Time: O(c), Space: O(k)
    // https://leetcode.com/problems/min-stack/?tab=Description
    // @see up top

    // LC: 150. Evaluate Reverse Polish Notation
    // Time: O(n), space: O(n)
    // https://leetcode.com/problems/evaluate-reverse-polish-notation/?tab=Description
    public int evalRPN(String[] tokens) {
        Stack<Integer> stack = new Stack<>();
        for (int ix = 0; ix < tokens.length; ix++) {
            String token = tokens[ix];
            if (token.equals("*")) {
                int v1 = stack.pop();
                int v2 = stack.pop();
                stack.push(v1 * v2);
            } else if (token.equals("+")) {
                int v1 = stack.pop();
                int v2 = stack.pop();
                stack.push(v1 + v2);
            }
            else if (token.equals("/")) {
                int v1 = stack.pop();
                int v2 = stack.pop();
                stack.push(v2 / v1);
            }
            else if (token.equals("-")) {
                int v1 = stack.pop();
                int v2 = stack.pop();
                stack.push(v2 - v1);
            } else {
                stack.push(Integer.valueOf(token));
            }
        }
        return stack.pop();
    }

    // LC: 145. Binary Tree Postorder Traversal
    // https://discuss.leetcode.com/topic/30632/preorder-inorder-and-postorder-iteratively-summarization/2
    public List<Integer> postorderTraversal(TreeNode root) {
        LinkedList<Integer> result = new LinkedList<>();
        Deque<TreeNode> stack = new ArrayDeque<>();
        TreeNode p = root;
        while(!stack.isEmpty() || p != null) {
            if(p != null) {
                stack.push(p);
                result.addFirst(p.val);  // Reverse the process of preorder
                p = p.right;             // Reverse the process of preorder
            } else {
                TreeNode node = stack.pop();
                p = node.left;           // Reverse the process of preorder
            }
        }
        return result;
    }

    // LC: 144. Binary Tree Preorder Traversal
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/6493/accepted-iterative-solution-in-java-using-stack
    public List<Integer> preorderTraversal(TreeNode root) {
        ArrayList<Integer> result = new ArrayList<>();
        if (root == null) { return result; }
        Stack<TreeNode> stack = new Stack<>();
        stack.push(root);
        do {
            TreeNode current = stack.peek();
            stack.pop();
            result.add(current.val);

            if (current.right != null) {
                stack.push(current.right);
            }

            if (current.left != null) {
                stack.push(current.left);
            }
        } while(!stack.empty());
        return result;
    }
    private void preorderTraversalHelper(TreeNode root, List<Integer> list) {
        if (root == null) {
            return;
        }
        list.add(root.val);
        preorderTraversalHelper(root.left, list);
        preorderTraversalHelper(root.right, list);
    }
    public List<Integer> preorderTraversalRecursive(TreeNode root) {
        ArrayList<Integer> result = new ArrayList<>();
        preorderTraversalHelper(root, result);
        return result;
    }


    // LC: 103. Binary Tree Zigzag Level Order Traversal
    // Given a binary tree, return the zigzag level order traversal of its nodes' values. (ie, from left to right, then right to left for the next level and alternate between).
    // For example:
    // Given binary tree [3,9,20,null,null,15,7],
    public List<List<Integer>> zigzagLevelOrder(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) { return result; }
        Queue<TreeNode> q = new ArrayDeque<TreeNode>();
        q.offer(root);
        boolean leftToRight = false;
        int numInLevel = q.size();
        List<Integer> level = new ArrayList<>();
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            level.add(current.val);
            numInLevel--;

            if (current.left != null) {
                q.offer(current.left);
            }
            if (current.right != null) {
                q.offer(current.right);
            }
            if (numInLevel == 0) {

                if (leftToRight) {
                    Collections.reverse(level);
                }
                result.add(level);
                level = new ArrayList<>();
                numInLevel = q.size();
                leftToRight = !leftToRight;
            }
        }

        return result;
    }

    // LC: 94. Binary Tree Inorder Traversal
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/6478/iterative-solution-in-java-simple-and-readable
    public List<Integer> inorderTraversal(TreeNode root) {
        ArrayList<Integer> result = new ArrayList<>();
        if (root == null) { return result; }
        Stack<TreeNode> stack = new Stack<>();
        stack.push(root);
        TreeNode current = root;
        while (!stack.empty()) {
            while (current != null && current.left != null) {
                current = current.left;
                stack.push(current);
            }
            current = stack.peek();
            stack.pop();
            result.add(current.val);
            current = current.right;
            if (current != null) {
                stack.push(current);
            }
        }
        return result;
    }



    // LC: 85. Maximal Rectangle
    // @todo: UNSOLVED
    // https://leetcode.com/problems/maximal-rectangle/#/solutions
    // @see arrays

    // LC: 84. Largest Rectangle in Histogram
    // https://discuss.leetcode.com/topic/7599/o-n-stack-based-java-solution
    // @todo: UNSOLVED, didn't pass all tests
    // @see arrays

    // LC: 71. Simplify Path
    // Given an absolute path for a file (Unix-style), simplify it.
    // For example,
    //  path = "/home/", => "/home"
    //  path = "/a/./b/../../c/", => "/c"
    // https://discuss.leetcode.com/topic/7675/java-10-lines-solution-with-stack
    public String simplifyPath(String path) {
        String[] tokens = path.split("/");
        if (tokens.length == 0) { return "/"; }
        Stack<String> stack = new Stack<>();
        for (int ix = 0; ix < tokens.length; ix++) {
            if (tokens[ix].length() == 0) continue;
            if (tokens[ix].equals(".")) continue;
            if (tokens[ix].equals("..")) { if (!stack.empty()) stack.pop(); }
            else {
                stack.push(tokens[ix]);
            }
        }
        if (stack.empty()) { return "/"; }
        StringBuilder result = new StringBuilder();
        while (!stack.empty()) {
            result.append(new StringBuilder(stack.pop()).reverse().toString());
            result.append("/");
        }
        return result.reverse().toString();
    }

    // LC: 42. Trapping Rain Water
    // @todo: UNSOLVED, HARD
    // https://discuss.leetcode.com/topic/3016/share-my-short-solution
    // @see arrays

    // LC: 20. Valid Parentheses
    // Given a string containing just the characters '(', ')', '{', '}', '[' and ']', determine if the input string is
    // valid. The brackets must close in the correct order, "()" and "()[]{}" are all valid but "(]" and "([)]" are not.
    // Subscribe to see which companies asked this question.
    // https://discuss.leetcode.com/topic/27572/short-java-solution
    public boolean isValid(String s) {
        Stack<Character> stack = new Stack<Character>();
        for (char c : s.toCharArray()) {
            if (c == '(')
                stack.push(')');
            else if (c == '{')
                stack.push('}');
            else if (c == '[')
                stack.push(']');
            else if (stack.isEmpty() || stack.pop() != c)
                return false;
        }
        return stack.isEmpty();
    }
}

// 173. Binary Search Tree Iterator
// Time: O(c) on average, Space: O(h)
// @todo: UNSOLVED
// https://leetcode.com/problems/binary-search-tree-iterator/?tab=Solutions
class BSTIterator {
    private Stack<TreeNode> stack = new Stack<TreeNode>();

    public BSTIterator(TreeNode root) {
        pushAll(root);
    }

    /** @return whether we have a next smallest number */
    public boolean hasNext() {
        return !stack.isEmpty();
    }

    /** @return the next smallest number */
    public int next() {
        TreeNode tmpNode = stack.pop();
        pushAll(tmpNode.right);
        return tmpNode.val;
    }

    private void pushAll(TreeNode node) {
        for (; node != null; stack.push(node), node = node.left);
    }
}


// 225. Implement Stack using Queues
//
class MyStack {
    //using two queue. The push is inefficient.
    private Queue<Integer> q1 = new LinkedList<Integer>();
    private Queue<Integer> q2 = new LinkedList<Integer>();
    public void push(int x) {
        if(q1.isEmpty()) {
            q1.add(x);
            for(int i = 0; i < q2.size(); i ++)
                q1.add(q2.poll());
        }else {
            q2.add(x);
            for(int i = 0; i < q1.size(); i++)
                q2.add(q1.poll());
        }
    }

    public void pop() {
        if(!q1.isEmpty())
            q1.poll();
        else
            q2.poll();
    }
    public int top() {
        return q1.isEmpty() ? q2.peek() : q1.peek();
    }
    public boolean empty() {
        return q1.isEmpty() && q2.isEmpty();
    }
}

class MyStack2 {

    //one Queue solution
    private Queue<Integer> q = new LinkedList<Integer>();

    // Push element x onto stack.
    public void push(int x) {
        q.add(x);
        for(int i = 1; i < q.size(); i ++) { //rotate the queue to make the tail be the head
            q.add(q.poll());
        }
    }

    // Removes the element on top of the stack.
    public void pop() {
        q.poll();
    }

    // Get the top element.
    public int top() {
        return q.peek();
    }

    // Return whether the stack is empty.
    public boolean empty() {
        return q.isEmpty();
    }
}

class MyStack3 {
    //using two queue. The pop and top are inefficient.
    private Queue<Integer> q1 = new LinkedList<Integer>();
    private Queue<Integer> q2 = new LinkedList<Integer>();
    public void push(int x) {
        if(!q1.isEmpty())
            q1.add(x);
        else
            q2.add(x);
    }
    public void pop() {
        if(q1.isEmpty()) {
            int size = q2.size();
            for(int i = 1; i < size; i ++) {
                q1.add(q2.poll());
            }
            q2.poll();
        }else {
            int size = q1.size();
            for(int i = 1; i < size; i ++) {
                q2.add(q1.poll());
            }
            q1.poll();
        }
    }
    public int top() {
        int res;
        if(q1.isEmpty()) {
            int size = q2.size();
            for(int i = 1; i < size; i ++) {
                q1.add(q2.poll());
            }
            res = q2.poll();
            q1.add(res);
        }else {
            int size = q1.size();
            for(int i = 1; i < size; i ++) {
                q2.add(q1.poll());
            }
            res = q1.poll();
            q2.add(res);
        }
        return res;
    }
    public boolean empty() {
        return q1.isEmpty() && q2.isEmpty();
    }
}

