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
    
    // LC:61. Rotate List
    /*
    ListNode* rotateRight(ListNode* head, int k) {
        if(!head) return head;
    
        int len=1; // number of nodes
        ListNode *newH, *tail;
        newH=tail=head;
    
        while(tail->next)  // get the number of nodes in the list
        {
            tail = tail->next;
            len++;
        }
        tail->next = head; // circle the link
    
        if(k %= len)
        {
            for(auto i=0; i<len-k; i++) tail = tail->next; // the tail node is the (len-k)-th node (1st node is head)
        }
        newH = tail->next;
        tail->next = NULL;
        return newH;
    }
    */
    
    // LC:82. Remove Duplicates from Sorted List II
    /*
    public ListNode deleteDuplicates(ListNode head) {
        if(head==null) return null;
        ListNode FakeHead=new ListNode(0);
        FakeHead.next=head;
        ListNode pre=FakeHead;
        ListNode cur=head;
    
        while(cur!=null){
            while(cur.next!=null&&cur.val==cur.next.val){
                cur=cur.next;
            }
            if(pre.next==cur){
                pre=pre.next;
            }
            else{
                pre.next=cur.next;
            }
            cur=cur.next;
        }
        return FakeHead.next;
    }
    */
    
    // LC:86. Partition List
    /*
    ListNode *partition(ListNode *head, int x) {
        ListNode node1(0), node2(0);
        ListNode *p1 = &node1, *p2 = &node2;
        while (head) {
            if (head->val < x)
                p1 = p1->next = head;
            else
                p2 = p2->next = head;
            head = head->next;
        }
        p2->next = NULL;
        p1->next = node2.next;
        return node1.next;
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
    
    // LC:92. Reverse Linked List II
    /*
    public ListNode reverseBetween(ListNode head, int m, int n) {
        if(head == null) return null;
        ListNode dummy = new ListNode(0); // create a dummy node to mark the head of this list
        dummy.next = head;
        ListNode pre = dummy; // make a pointer pre as a marker for the node before reversing
    
        for(int i = 0; i<m-1; i++) pre = pre.next;
    
            ListNode start = pre.next; // a pointer to the beginning of a sub-list that will be reversed
            ListNode then = start.next; // a pointer to a node that will be reversed
    
            // 1 - 2 -3 - 4 - 5 ; m=2; n =4 ---> pre = 1, start = 2, then = 3
            // dummy-> 1 -> 2 -> 3 -> 4 -> 5
    
            for(int i=0; i<n-m; i++)
            {
                start.next = then.next;
                then.next = pre.next;
                pre.next = then;
                then = start.next;
            }
    
            // first reversing : dummy->1 - 3 - 2 - 4 - 5; pre = 1, start = 2, then = 4
            // second reversing: dummy->1 - 4 - 3 - 2 - 5; pre = 1, start = 2, then = 5 (finish)
    
            return dummy.next;
    }
    */

    // LC:109. Convert Sorted List to Binary Search Tree
    func toBST(_ head : ListNode?, _ tail : ListNode?) -> TreeNode? {
        if head === tail { return nil }
        var slow = head
        var fast = head
        while fast !== tail && fast?.next !== tail {
            slow = slow?.next
            fast = fast?.next?.next
        }
        let root = TreeNode(x: slow!.val)
        root.left = toBST(head, slow)
        root.right = toBST(slow!.next, tail)
        return root
    }
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        if let head = head {
            return toBST(head, nil)
        }
        return nil
    }
    
    // LC:138. Copy List with Random Pointer
    /*
    public RandomListNode copyRandomList(RandomListNode head) {
        RandomListNode iter = head, next;
    
        // First round: make copy of each node,
        // and link them together side-by-side in a single list.
        while (iter != null) {
            next = iter.next;
    
            RandomListNode copy = new RandomListNode(iter.label);
            iter.next = copy;
            copy.next = next;
    
            iter = next;
        }
    
        // Second round: assign random pointers for the copy nodes.
        iter = head;
        while (iter != null) {
            if (iter.random != null) {
                iter.next.random = iter.random.next;
            }
            iter = iter.next.next;
        }
    
        // Third round: restore the original list, and extract the copy list.
        iter = head;
        RandomListNode pseudoHead = new RandomListNode(0);
        RandomListNode copy, copyIter = pseudoHead;
    
        while (iter != null) {
            next = iter.next.next;
    
            // extract the copy
            copy = iter.next;
            copyIter.next = copy;
            copyIter = copy;
    
            // restore the original list
            iter.next = next;
    
            iter = next;
        }
    
        return pseudoHead.next;
    }
    */
    
    // LC:141. Linked List Cycle
    // @see: TwoPointers
    
    // LC:142. Linked List Cycle II
    /*
    ListNode *detectCycle(ListNode *head) {
        if (head == NULL || head->next == NULL) return NULL;
    
        ListNode* firstp = head;
        ListNode* secondp = head;
        bool isCycle = false;
    
        while(firstp != NULL && secondp != NULL) {
            firstp = firstp->next;
            if (secondp->next == NULL) return NULL;
                secondp = secondp->next->next;
            if (firstp == secondp) { isCycle = true; break; }
        }
    
        if(!isCycle) return NULL;
        firstp = head;
        while( firstp != secondp) {
            firstp = firstp->next;
            secondp = secondp->next;
        }
    
        return firstp;
    }
    */
    
    // LC:143. Reorder Li
    /*
    public void reorderList(ListNode head) {
        if(head==null||head.next==null) return;
    
        //Find the middle of the list
        ListNode p1=head;
        ListNode p2=head;
        while(p2.next!=null&&p2.next.next!=null){
            p1=p1.next;
            p2=p2.next.next;
        }
    
        //Reverse the half after middle  1->2->3->4->5->6 to 1->2->3->6->5->4
        ListNode preMiddle=p1;
        ListNode preCurrent=p1.next;
        while(preCurrent.next!=null){
            ListNode current=preCurrent.next;
            preCurrent.next=current.next;
            current.next=preMiddle.next;
            preMiddle.next=current;
        }
    
        //Start reorder one by one  1->2->3->6->5->4 to 1->6->2->5->3->4
        p1=head;
        p2=preMiddle.next;
        while(p1!=preMiddle){
            preMiddle.next=p2.next;
            p2.next=p1.next;
            p1.next=p2;
            p1=p2.next;
            p2=preMiddle.next;
        }
    }
    */
    
    // LC:147. Insertion Sort List
    /*
    public ListNode insertionSortList(ListNode head) {
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
    */
    
    // LC:148. Sort List
    /*
    public ListNode sortList(ListNode head) {
        if (head == null || head.next == null)
            return head;
    
        // step 1. cut the list to two halves
        ListNode prev = null, slow = head, fast = head;
    
        while (fast != null && fast.next != null) {
            prev = slow;
            slow = slow.next;
            fast = fast.next.next;
        }
    
        prev.next = null;
    
        // step 2. sort each half
        ListNode l1 = sortList(head);
        ListNode l2 = sortList(slow);
    
        // step 3. merge l1 and l2
        return merge(l1, l2);
    }
    
    ListNode merge(ListNode l1, ListNode l2) {
        ListNode l = new ListNode(0), p = l;
    
        while (l1 != null && l2 != null) {
            if (l1.val < l2.val) {
                p.next = l1;
                l1 = l1.next;
            } else {
                p.next = l2;
                l2 = l2.next;
            }
            p = p.next;
        }
    
        if (l1 != null)
            p.next = l1;
    
        if (l2 != null)
            p.next = l2;
    
        return l.next;
    }
    */
 
    // LC:160. Intersection of Two Linked Lists
    /*
    public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        //boundary check
        if(headA == null || headB == null) return null;
    
        ListNode a = headA;
        ListNode b = headB;
    
        //if a & b have different len, then we will stop the loop after second iteration
        while( a != b){
            //for the end of first iteration, we just reset the pointer to the head of another linkedlist
            a = a == null? headB : a.next;
            b = b == null? headA : b.next;
        }
    
        return a;
    }
     
     public ListNode getIntersectionNode(ListNode headA, ListNode headB) {
        int lenA = length(headA), lenB = length(headB);
        // move headA and headB to the same start point
        while (lenA > lenB) {
            headA = headA.next;
            lenA--;
        }
        while (lenA < lenB) {
            headB = headB.next;
            lenB--;
        }
        // find the intersection until end
        while (headA != headB) {
            headA = headA.next;
            headB = headB.next;
        }
        return headA;
     }
     
     private int length(ListNode node) {
        int length = 0;
        while (node != null) {
            node = node.next;
            length++;
        }
        return length;
     }
    */
    
    
    /*
     public ListNode reverseList(ListNode head) {
        /* iterative solution */
        ListNode newHead = null;
        while (head != null) {
            ListNode next = head.next;
            head.next = newHead;
            newHead = head;
            head = next;
        }
        return newHead;
     }
     
     public ListNode reverseList(ListNode head) {
        /* recursive solution */
        return reverseListInt(head, null);
     }
     
     private ListNode reverseListInt(ListNode head, ListNode newHead) {
        if (head == null)
            return newHead;
        ListNode next = head.next;
        head.next = newHead;
        return reverseListInt(next, head);
     }
    */
    
    // LC:234. Palindrome Linked List
    /*
     bool isPalindrome(ListNode* head) {
        if(head==NULL||head->next==NULL)
            return true;
        ListNode* slow=head;
        ListNode* fast=head;
        while(fast->next!=NULL&&fast->next->next!=NULL){
            slow=slow->next;
            fast=fast->next->next;
        }
        slow->next=reverseList(slow->next);
        slow=slow->next;
        while(slow!=NULL){
            if(head->val!=slow->val)
                return false;
            head=head->next;
            slow=slow->next;
        }
        return true;
     }
     ListNode* reverseList(ListNode* head) {
        ListNode* pre=NULL;
        ListNode* next=NULL;
        while(head!=NULL){
            next=head->next;
            head->next=pre;
            pre=head;
            head=next;
        }
        return pre;
     }
     */
    
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
    
    // LC:
    /* LC:328. Odd Even Linked List
    public ListNode oddEvenList(ListNode head) {
        if (head != null) {
    
        ListNode odd = head, even = head.next, evenHead = even;
    
        while (even != null && even.next != null) {
            odd.next = odd.next.next;
            even.next = even.next.next;
            odd = odd.next;
            even = even.next;
        }
        odd.next = evenHead;
        }
        return head;
    }}
    */
    
    // LC:445. Add Two Numbers II
    /*
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        Stack<Integer> s1 = new Stack<Integer>();
        Stack<Integer> s2 = new Stack<Integer>();
    
        while(l1 != null) {
            s1.push(l1.val);
            l1 = l1.next;
        };
        while(l2 != null) {
            s2.push(l2.val);
            l2 = l2.next;
        }
    
        int sum = 0;
        ListNode list = new ListNode(0);
        while (!s1.empty() || !s2.empty()) {
            if (!s1.empty()) sum += s1.pop();
            if (!s2.empty()) sum += s2.pop();
            list.val = sum % 10;
            ListNode head = new ListNode(sum / 10);
            head.next = list;
            list = head;
            sum /= 10;
        }
    
        return list.val == 0 ? list.next : list;
    }
    */
}








