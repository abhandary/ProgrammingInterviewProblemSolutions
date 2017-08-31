//
//  TwoPointers.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/7/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation


class TwoPointers {

    // LC:3. Longest Substring Without Repeating Characters
    // @see Arrays, Strings
    
    // LC:11. Container With Most Water
    // @see Arrays
    
    // LC:15 3Sum
    // @see Arrays

    // LC:18. 4Sum
    // @see Hashtables
    
    // LC:19. Remove Nth Node From End of List
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        let dummyHead = ListNode(0);
        dummyHead.next = head;
        var itr : ListNode? = dummyHead;
        var ix = 0;
        while ix < n {
            itr = itr!.next;
            ix += 1;
        }
        var trail : ListNode? = dummyHead;
        while itr!.next != nil {
            trail = trail!.next;
            itr = itr!.next;
        }
        trail!.next = trail!.next!.next;
        return dummyHead.next;
    }

    // LC:26. Remove Duplicates from Sorted Array
    // @see Arrays

    
    // LC:27. Remove Element
    // @see: Arrays
    
    // LC:28. Implement strStr()
    func strStr(_ haystack: String, _ needle: String) -> Int {
        guard haystack.characters.count >= needle.characters.count else { return -1 }
        
        let hchars = Array(haystack.characters)
        let nchars = Array(needle.characters)
        if nchars.count == 0 { return 0; }
        for ix in 0..<hchars.count {
            var jx = 0
            while jx < nchars.count && ix + jx < hchars.count {
                if hchars[ix + jx] != nchars[jx] { break; }
                jx += 1
            }
            if jx == nchars.count { return ix;  }
        }
        return -1;
    }
    
    // Rabin-Karp matcher, something along these lines
    func lookup(_ x : Character) -> Int {
        return 0
    }
    
    func strStr2(_ haystack: String, _ needle: String) -> Int {
        guard haystack.characters.count >= needle.characters.count else { return -1 }
        
        let hchars = Array(haystack.characters)
        let nchars = Array(needle.characters)
        if nchars.count == 0 { return 0; }
        
        var nhash = 0
        var hhash = 0
        var ix = 0
        
        let kLimit = 16357
        
        var baseMult = 1
        while ix < nchars.count {
            baseMult *=  (ix == 0 ? 1 : 101)
            nhash = (nhash * 101 + lookup(nchars[ix])) % kLimit
            hhash = (hhash * 101 + lookup(hchars[ix])) % kLimit
            ix += 1
        }
        if nhash == hhash && String(nchars) == String(hchars[0..<nchars.count]) { return 0 }
        while ix < hchars.count - nchars.count {
            hhash -= (baseMult * lookup(hchars[ix - hchars.count])) * 101 + lookup(nchars[ix])
            if nhash == hhash && String(nchars) == String(hchars[ix..<nchars.count+ix]) { return ix }
            ix += 1
        }
        return -1
    }
    
    // LC:61. Rotate List
    // @see Linked Lists
    
    // LC:75. Sort Colors
    // @see Arrays
    
    // LC:80. Remove Duplicates from Sorted Array II
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        if nums.count == 1 { return 1; }
        
        var wx = 0;
        for index in 0..<nums.count {
            if index + 2 < nums.count && nums[index] == nums[index + 2] { continue; }
            nums[wx] = nums[index]
            wx += 1;
        }
        
        return wx;
    }
    
    // LC:86. Partition List
    // @see Linked Lists
    
    // LC:88. Merge Sorted Array
    // @see Arrays
    
    // LC:125. Valid Palindrome
    // @see: Strings
    
    // 141. Linked List Cycle
    func hasCycle(_ head : ListNode?) -> Bool {
        guard head != nil else { return false; }
        
        var slow = head, fast = head;
        if fast != nil { fast = fast?.next; }
        
        while slow !== fast {
            slow = slow?.next
            fast = fast?.next
            if fast != nil { fast = fast?.next; }
        }
        if slow == nil || fast == nil { return false; }
        
        return true;
    }
    
    // 142. Linked List Cycle II
    // @see Linked Lists
    
    // LC:167. Two Sum II - Input array is sorted
    // @see: Arrays
    
    // LC:209. Minimum Size Subarray Sum
    // @see: Arrays

    // LC:234. Palindrome Linked List
    // @see Linked Lists
    
    // LC:283. Move Zeroes
    // @see: Arrays
    
    // 287. Find the Duplicate Number
    func findDuplicate(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1; }
        
        var slow = nums[0];
        var fast = nums[nums[0]]
        
        while slow != fast {
            slow = nums[slow];
            fast = nums[nums[fast]]
        }
        
        fast = 0
        while slow != fast {
            slow = nums[slow]
            fast = nums[fast]
        }
        return slow
    }
    
    
    
    // LC: 344. Reverse String
    func reverseString(_ s: String) -> String {
        var chars = Array(s.characters);
        var left = 0, right = chars.count - 1;
        
        while left < right {
            swap(&chars[left], &chars[right]);
            left += 1; right -= 1;
        }
        return String(chars);
    }

    
    // LC:345. Reverse Vowels of a String
    func isVowel(_ c : Character) -> Bool {
        if ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"].contains(c) {
            return true;
        }
        return false;
    }
    
    func reverseVowels(_ s: String) -> String
    {
        var chars = Array(s.characters);
        var left = 0, right = chars.count - 1;
        while left < right {
            while (!isVowel(chars[left]) && left < right) {
                left += 1;
            }
            while (!isVowel(chars[right]) && left < right) {
                right -= 1;
            }
            if (left < right) {
                swap(&chars[left], &chars[right]);
            }
            left += 1; right -= 1;
        }
        return String(chars);
    }
    
    // LC:349. Intersection of Two Arrays
    // @todo: sort both arrays and use two pointers
    
    // LC:350. Intersection of Two Arrays II
    // @todo: needs a two pointer solution
    
    // LC:524. Longest Word in Dictionary through Deleting
    /*
    public String findLongestWord(String s, List<String> d) {
        Collections.sort(d, (a,b) -> a.length() != b.length() ? -Integer.compare(a.length(), b.length()) :  a.compareTo(b));
        for (String dictWord : d) {
            int i = 0;
            for (char c : s.toCharArray())
                if (i < dictWord.length() && c == dictWord.charAt(i)) i++;
            if (i == dictWord.length()) return dictWord;
        }
        return "";
    }
    */
    

    /*
    public String findLongestWord(String s, List<String> d) {
        String longest = "";
        for (String dictWord : d) {
            int i = 0;
            for (char c : s.toCharArray())
                if (i < dictWord.length() && c == dictWord.charAt(i)) i++;
    
            if (i == dictWord.length() && dictWord.length() >= longest.length())
                if (dictWord.length() > longest.length() || dictWord.compareTo(longest) < 0)
                    longest = dictWord;
        }
        return longest;
    }
    */
    
    
}
