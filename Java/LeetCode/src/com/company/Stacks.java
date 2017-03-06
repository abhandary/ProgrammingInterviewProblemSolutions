package com.company;

import java.util.*;

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


    // 94. Binary Tree Inorder Traversal
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/binary-tree-inorder-traversal/?tab=Description
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

    // 144. Binary Tree Preorder Traversal
    // Time: O(n), Space: O(h)
    // https://leetcode.com/problems/binary-tree-preorder-traversal/?tab=Description
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

    // 150. Evaluate Reverse Polish Notation
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


}

// 173. Binary Search Tree Iterator
// Time: O(c) on average, Space: O(h)
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