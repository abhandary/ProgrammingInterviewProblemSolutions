//
//  LinkedList.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/8/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class LinkedLists {
    
    // LC:2. Add Two Numbers
    func addTwoNumbers(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        var l1 = l1, l2 = l2
        let dummyHead = ListNode(0)
        var itr : ListNode? = dummyHead;
        var sum = 0
        while l1 != nil || l2 != nil {
            sum /= 10
            if let _ = l1 { sum += l1!.val; l1 = l1?.next; }
            if let _ = l2 { sum += l2!.val; l2 = l2?.next; }
            itr?.next = ListNode(sum % 10)
            itr = itr?.next
        }
        if (sum / 10) != 0 {
            itr?.next = ListNode(1)
        }
        return dummyHead.next
    }
    
    // LC:19. Remove Nth Node From End of List
    // @see TwoPointers
    

    // LC:21. Merge Two Sorted Lists
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var l1 = l1, l2 = l2
        var dummyHead = ListNode(0)
        var itr : ListNode? = dummyHead;
        
        while l1 != nil || l2 != nil {
            if l1 != nil && l2 != nil {
                if l1!.val < l2!.val {
                    itr?.next = l1
                    l1 = l1?.next
                } else {
                    itr?.next = l2
                    l2 = l2?.next
                }
            } else if l1 != nil {
                itr?.next = l1; l1 = l1?.next;
            } else {
                itr?.next = l2; l2 = l2?.next;
            }
            
            itr = itr?.next
        }
        return dummyHead.next
    }
    
    // LC:23. Merge k Sorted Lists
    /*
    public ListNode mergeKLists(List<ListNode> lists) {
        if (lists==null||lists.size()==0) return null;
    
        PriorityQueue<ListNode> queue= new PriorityQueue<ListNode>(lists.size(),new Comparator<ListNode>(){
            @Override
            public int compare(ListNode o1,ListNode o2){
                if (o1.val<o2.val)
                    return -1;
                else if (o1.val==o2.val)
                    return 0;
                else
                    return 1;
            }
        });
    
        ListNode dummy = new ListNode(0);
        ListNode tail=dummy;
    
        for (ListNode node:lists)
            if (node!=null)
                queue.add(node);
    
        while (!queue.isEmpty()){
            tail.next=queue.poll();
            tail=tail.next;
    
            if (tail.next!=null)
            queue.add(tail.next);
        }
        return dummy.next;
    }
    */
    
    
    // LC:24. Swap Nodes in Pairs
    
    /*
    public ListNode swapPairs(ListNode head) {
        if ((head == null)||(head.next == null))
            return head;
        ListNode n = head.next;
        head.next = swapPairs(head.next.next);
        n.next = head;
        return n;
    }
 
     ListNode* swapPairs(ListNode* head) {
        ListNode **pp = &head, *a, *b;
        while ((a = *pp) && (b = a->next)) {
            a->next = b->next;
            b->next = a;
            *pp = b;
            pp = &(a->next);
        }
        return head;
     }
     
     public ListNode swapPairs(ListNode head) {
        ListNode dummy = new ListNode(0);
        dummy.next = head;
        ListNode current = dummy;
        while (current.next != null && current.next.next != null) {
            ListNode first = current.next;
            ListNode second = current.next.next;
            first.next = second.next;
            current.next = second;
            current.next.next = first;
            current = current.next.next;
        }
        return dummy.next;
     }
     
    */
    
    // LC:83. Remove Duplicates from Sorted List
    func deleteDuplicates(_ head: ListNode?) -> ListNode? {
        guard head != nil && head?.next != nil else { return head; }
        
        var trail = head
        var itr : ListNode? = head?.next
        
        while itr != nil {
            while itr != nil && itr!.val == trail!.val {
                itr = itr?.next
            }
            trail?.next = itr
            trail = itr
            itr = itr?.next
        }
        trail?.next = nil
        return head
    }
    
    // LC:141. Linked List Cycle
    // @see: TwoPointers
    
    // LC:203. Remove Linked List Elements
    func removeElements(_ head: ListNode?, _ val: Int) -> ListNode? {
        
        guard head != nil else { return nil; }
        
        var dummyHead : ListNode? = ListNode(0)
        dummyHead?.next = head
        var trail = dummyHead
        var itr : ListNode? = head
        
        while itr != nil {
            while itr != nil && itr!.val == val {
                itr = itr?.next
            }
            trail?.next = itr
            trail = itr
            itr = itr?.next
        }
        
        return dummyHead?.next
    }
    
    // LC:237. Delete Node in a Linked List
    func deleteNode(_ node : ListNode?)  {
        guard node != nil && node?.next != nil else { return; }
        
        node!.val = node!.next!.val
        node?.next = node?.next?.next
    }
}








