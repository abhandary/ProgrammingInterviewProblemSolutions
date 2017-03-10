package com.company;

import java.util.Comparator;
import java.util.*;

class ListNode {
    int val;
    ListNode next;
    ListNode(int x) { val = x; }
}

/**
 * Created by akshayb on 2/24/17.
 */
public class Sort {

    // 242. Valid Anagram
    // Time: O((s + t) log (s + t)), Space: O(c)
    // https://leetcode.com/problems/valid-anagram/?tab=Description
    public boolean isAnagram(String s, String t) {
        char[] schars = s.toCharArray();
        char[] tchars = t.toCharArray();
        Arrays.sort(schars);
        Arrays.sort(tchars);
        String sortedS = new String(schars);
        String sortedT = new String(tchars);
        return sortedS.equals(sortedT);
    }

    public boolean isAnagram2(String s, String t) {
        char[] schars = s.toCharArray();
        char[] tchars = t.toCharArray();

        HashMap<Character, Integer> shm = new HashMap<>();

        for (int ix = 0; ix < schars.length; ix++) {
            if (shm.get(schars[ix]) == null) {
                shm.put(schars[ix], 1);
            } else {
                shm.put(schars[ix], shm.get(schars[ix]) + 1);
            }
        }

        for (int ix = 0; ix < tchars.length; ix++) {
            if (shm.get(tchars[ix]) == null) { return false; }
            if (shm.get(tchars[ix]) == 1) {
                shm.remove(tchars[ix]);
            }
            else {
                shm.put(tchars[ix], shm.get(tchars[ix]) - 1);
            }
        }
        return shm.size() == 0;
    }

    // 147. Insertion Sort List
    // Time: O(n2), Space: O(n)
    // https://leetcode.com/problems/insertion-sort-list/?tab=Description
    public ListNode insertionSortList(ListNode head) {

        // === OR: copy values into an array and sort the array ===

        if (head == null || head.next == null) { return head; }
        ListNode newHead = insertionSortList(head.next);

        if (head.val <= newHead.val) { head.next = newHead; return head; }

        ListNode prev = newHead;
        ListNode itr = null;
        for (itr = newHead; itr != null; itr = itr.next) {
            if (head.val <= itr.val) {

                break;
            }
            prev = itr;
        }
        prev.next = head;
        head.next = itr;
        return newHead;
    }

    public ListNode insertionSortList2(ListNode head) {
        if( head == null ){
            return head;
        }

        ListNode helper = new ListNode(0); //new starter of the sorted list
        ListNode cur = head; //the node will be inserted
        ListNode pre = helper; //insert node between pre and pre.next
        ListNode next = null; //the next node will be inserted
        //not the end of input list
        while( cur != null ){
            next = cur.next;
            //find the right place to insert
            while( pre.next != null && pre.next.val < cur.val ){
                pre = pre.next;
            }
            //insert between pre and pre.next
            cur.next = pre.next;
            pre.next = cur;
            pre = helper;
            cur = next;
        }

        return helper.next;
    }

    public String largestNumber(int[] nums) {
        String[] snums = new String[nums.length];

        for (int ix = 0; ix < nums.length; ix++) {
            snums[ix] = String.valueOf(nums[ix]);
        }
        Comparator<String> comp = new Comparator<String>() {
            @Override
            public int compare(String lhs, String rhs) {
                String s1 = lhs + rhs;
                String s2 = rhs + lhs;
                return s1.compareTo(s2);
            }
        };


        Arrays.sort(snums, comp);
        if (snums[0].charAt(0) == '0') {
            return "0";
        }

        StringBuilder sb = new StringBuilder();
        for (String snum : snums) {
            sb.append(snum);
        }
        return sb.toString();
    }

    // 75. Sort Colors
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/sort-colors/?tab=Description
    public void sortColors(int[] nums) {
        int numRed = 0, numWhite = 0, numBlue = 0;

        for (int num : nums) {
            if (num == 0) { numRed++; }
            if (num == 1) { numWhite++; }
            if (num == 2) { numBlue++; }
        }
        int ix = 0;
        for (; ix < numRed; ix++) {
            nums[ix] = 0;
        }
        for (int jx = 0; jx < numWhite; jx++) {
            nums[ix++] = 1;
        }
        for (int jx = 0; jx < numBlue; jx++) {
            nums[ix++] = 2;
        }
    }
}
