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
    
    // LC:26. Remove Duplicates from Sorted Array
    // @see Arrays
    
    // LC:19. Remove Nth Node From End of List
    func removeNthFromEnd(_ head: ListNode?, _ n: Int) -> ListNode? {
        var dummyHead = ListNode(0);
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

    // LC:27. Remove Element
    // @see: see Arrays
    
    // LC:125. Valid Palindrome
    // @see: see Strings
    
    // LC:167. Two Sum II - Input array is sorted
    // @see Arrays
    
    // LC:283. Move Zeroes
    // @see Arrays
    
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

}
