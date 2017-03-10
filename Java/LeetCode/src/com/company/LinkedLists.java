package com.company;

/**
 * Created by akshayb on 3/8/17.
 */
public class LinkedLists {

    // 203. Remove Linked List Elements
    // Time: O(n), Space: O(n)
    // https://leetcode.com/problems/remove-linked-list-elements/?tab=Description
    public ListNode removeElements(ListNode head, int val) {
        if (head == null) return null;
        head.next = removeElements(head.next, val);
        return head.val == val ? head.next : head;
    }

    public ListNode removeElements2(ListNode head, int val) {
        ListNode fakeNode = new ListNode(-1);
        fakeNode.next = head;
        ListNode prev = fakeNode;
        while (head != null) {
            if (head.val == val) {
                prev.next = head.next;
            } else {
                prev = head;
            }
            head = head.next;
        }
        return fakeNode.next;
    }
}
