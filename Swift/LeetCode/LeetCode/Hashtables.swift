//
//  Hashtables.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/22/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//


class RandomListNode {
    var label : Int!;
    var next : RandomListNode?
    var random : RandomListNode?
    
    init(_ x : Int) { label = x; }
};

import Foundation

class Hashtables {

    // LC:632. Smallest Range
    
    // LC:624. Maximum Distance in Arrays
    
    // LC:609. Find Duplicate File in System
    
    // LC:599. Minimum Index Sum of Two Lists
    
    // LC:594. Longest Harmonious Subsequence
    
    // LC:575. Distribute Candies
    
    // LC:554. Brick Wall

    // LC:535. Encode and Decode TinyURL
    
    // LC:525. Contiguous Array
    
    // LC:508. Most Frequent Subtree Sum
    
    // LC:500. Keyboard Row
    
    // LC:463. Island Perimeter
    
    // LC:454. 4Sum II
    
    // LC:451. Sort Characters By Frequency
    
    // LC:447. Number of Boomerangs
    
    // LC:438. Find All Anagrams in a String
    
    // LC:409 Longest Palindrome
    func longestPalindrome(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let schars = Array(s.characters);
        var map = [Character : Int]();
        for c in schars {
            map[c] = map[c] == nil ? 1 : map[c]! + 1;
        }
        
        var maxLen = 0;
        var oddFound = false;
        for c in map.keys {
            if let stored = map[c] {
                if stored & 1 != 0 {
                    oddFound = true;
                    maxLen += (stored - 1);
                } else {
                    maxLen += stored;
                }
            }
        }
        return oddFound ? maxLen + 1 : maxLen;
        
    }
    
    func longestPalindrome2(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let schars = Array(s.characters);
        var set = Set<Character>();
        var count = 0;
        for c in schars {
            if set.contains(c) {
                count += 1;
                set.remove(c);
            } else {
                set.insert(c);
            }	 
        }
        return set.count > 0 ? count * 2 + 1 : count * 2;
        
        
    }

    // LC:389. Find the Difference
    
    // LC:381. Insert Delete GetRandom O(1) - Duplicates allowed
    
    // LC:380. Insert Delete GetRandom O(1)
    
    // LC:359. Logger Rate Limiter
    
    // LC:358. Rearrange String k Distance Apart
    
    // LC:356. Line Reflection
    
    // LC:355. Design Twitter
    
    // LC:350. Intersection of Two Arrays II
    func intersect(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map = [Int : Int]();
        for value in nums1 {
            map[value] = map[value] != nil ? map[value]! + 1 : 1;
        }
        
        var result = [Int]();
        for value in nums2 {
            if let stored = map[value] {
                result.append(value);
                map[value] = stored == 1 ? nil : map[value]! - 1;
            }
        } 
        return result;
        
    }
    
    // LC:349. Intersection of Two Arrays
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        let set1 = Set<Int>(nums1);
        let set2 = Set<Int>(nums2);
        return Array(set1.intersection(set2));
    }

    // LC:347. Top K Frequent Elements
    
    
    // LC:340. Longest Substring with At Most K Distinct Characters
    // @locked
    
    // LC:336. Palindrome Pairs
    
    // LC:325. Maximum Size Subarray Sum Equals k
    
    // LC:314. Binary Tree Vertical Order Traversal
    
    // LC:311. Sparse Matrix Multiplication
    
    // LC:299. Bulls and Cows
    
    // LC:290. Word Pattern
    
    // LC:288. Unique Word Abbreviation
    
    // LC:274. H-Index
    
    // LC:266. Palindrome Permutation
    
    // LC:249. Group Shifted Strings
    
    // LC:246. Strobogrammatic Number
    
    // LC:244. Shortest Word Distance II
    
    // LC:242. Valid Anagram
    // Time: O(n log n), Space: O(1) outside of the string
    func isAnagram(_ s: String, _ t: String) -> Bool {
        return s.characters.sorted() == t.characters.sorted()

    }
    
    // Time: O(n), Space: O(n)
    func isAnagram2(_ s: String, _ t: String) -> Bool {
        
        var sht = [Character : Int]()
        
        let sarray = Array(s.characters)
        let tarray = Array(t.characters)
        
        guard sarray.count == tarray.count else { return false; }
        
        for schar in sarray {
            if let count = sht[schar] {
                sht[schar] = count + 1;
            } else {
                sht[schar] = 1
            }
        }
        
        for tchar in tarray {
            if let count = sht[tchar], count >= 1 {
                sht[tchar] = count - 1
            } else {
                return false;
            }
        }
        
        return true;
    }
    
    
    // LC:219. Contains Duplicate II
    func containsNearbyDuplicate(_ nums: [Int], _ k: Int) -> Bool {
        guard nums.count > 0 else { return false; }
        
        var map = [Int:Int]();
        for (index, value) in nums.enumerated() {
            if let stored = map[value], index - stored <= k {
                return true;
            }
            map[value] = index;
        }
        return false;
    }
    
    
    // LC:217. Contains Duplicate
    func containsDuplicate(_ nums: [Int]) -> Bool {
        guard nums.count > 0 else { return false; }
        
        var set = Set<Int>();
        for value in nums {
            
            if set.contains(value) { return true; }
            set.insert(value);
        }
        return false;
    }
    
    // LC:205. Isomorphic Strings
    func isIsomorphic(_ s: String, _ t: String) -> Bool {
        let schars = Array(s.characters)
        let tchars = Array(t.characters)
        
        if (schars.count != tchars.count) { return false; };
        
        var hm1 = [Character : Character]()
        var hm2 = [Character : Character]()
        
        for ix in 0..<schars.count {
            if hm1[schars[ix]] == nil && hm2[tchars[ix]] == nil {
                hm1[schars[ix]] = tchars[ix]
                hm2[tchars[ix]] = schars[ix]
            } else if let hm1char = hm1[schars[ix]],
                let hm2char = hm2[tchars[ix]] {
                if (hm1char != tchars[ix] || hm2char != schars[ix]) { return false }
                
            } else {
                return false;
            }
        }
        return true;
    }
    
    // LC:204. Count Primes
    // Time: O(n2)??, Space: O(N)
    func countPrimes(_ n: Int) -> Int {
        
        guard n >= 3 else { return 0; }
        var isPrime = [Bool](repeating: true, count: n);
        
        var count = 0;
        for ix in 2..<n {
            if isPrime[ix] == true {
                count += 1;
                var jx = 2;
                while ix*jx < n {
                    isPrime[ix*jx] = false;
                    jx += 1
                }
            }
        }
        
        return count;
    }
    
    // LC:202. 	Happy Number
    
    // LC:187. Repeated DNA Sequences
    //
    
    // LC:170. Two Sum III - Data structure design
    // @locked
    
    // LC:166. Fraction to Recurring Decimal
    // Time: O(Num decimals prior to recurrence)??, Space: O(Num decimals prior to recurrence)??
    // @todo: NP, Neesd Practice
    func fractionToDecimal(_ numerator: Int, _ denominator: Int) -> String {
        if numerator == 0 { return "0"; }
        
        var result = ""
        
        result = ((numerator < 0) || (denominator < 0)) ? "-" : "";
        result = ((numerator < 0) && (denominator < 0)) ? "" : result;
        
        var num = abs(numerator)
        let den = abs(denominator)
        
        // integral part
        
        result += "\(num / den)"
        num %= denominator;
        
        if (num == 0) { return result; }
        
        result += "."
        
        var htable = [Int : Int]()
        htable[num] = result.characters.count
        var rarray = Array(result.characters);
        while num != 0 {
            num *= 10
            rarray.append("\(num / den)".characters.first!)
            num %= den;
            if let index = htable[num] {
                rarray.insert("(", at: index);
                rarray.append(")")
                break
            } else {
                htable[num] = rarray.count;
            }
        }
        return String(rarray)
    }
    
    
    // LC:159. Longest Substring with At Most Two Distinct Characters
    // @locked
    
    // LC:149. Max Points on a Line
    
    // LC:138. Copy List with Random Pointer
    func copyRandomList(_ head : RandomListNode?) -> RandomListNode?  {
        guard head != nil else { return nil; }
        

        // copy the singly linked list, interleaving the copy between the original list
        var itr = head;
        while itr != nil {
            let copy = RandomListNode(itr!.label)
            copy.next = itr!.next
            itr!.next = copy;
            itr = copy.next;
        }
        
        // copy the random pointers
        itr = head;
        while itr != nil {
            let copy = itr?.next
            copy?.random = itr?.random?.next
            itr = copy?.next
        }

        // restore the original list and extract the copy
        itr = head;
        let newHead = itr?.next
        while itr != nil {
            let copy = itr?.next
            itr?.next = copy?.next
            copy?.next = copy?.next?.next
        }

        
        return newHead;
    }
    
    // LC:136. Single Number
    // Time: O(N), Space: O(1)
    func singleNumber(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return -1; }
        
        var num = nums[0];
        for ix in 1..<nums.count {
            num ^= nums[ix]
        }
        return num
    }
    
    
    // LC:94. Binary Tree Inorder Traversal
    // incorrect tag? 
    // This solutions is wrong, but gives an idea of how to proceed with this
    func inorderTraversal(_ root: TreeNode?) -> [Int] {
        var result = [Int]()
        guard root != nil else { return result; }
        
        var set = Set<TreeNode>()
        var deque = [TreeNode]()
        
        deque.insert(root!, at: 0)
        
        while(deque.count > 0){
            
            let current=deque.removeLast()
            
            if(set.contains(current)) {
                result.append(current.val);
            }
            else{
                if let right = current.right {
                    deque.insert(right, at: 0);
                }
                if let left = current.left {
                    set.insert(current);
                    deque.insert(current, at: 0);
                    deque.insert(left, at: 0);
                } else {
                    result.append(current.val);
                }
            }
        }
        
        return result;
        
    }
    
    // LC:85. Maximal Rectangle
    
    // LC:76. Minimum Window Substring
    
    // LC:49. Group Anagrams
    func groupAnagrams(_ strs: [String]) -> [[String]] {
        var result = [[String]]();
        guard strs.count > 0 else { return result; }
        var map = [String : [String]]();
        for s in strs {
            let ssorted = String(s.characters.sorted());
            if var array = map[ssorted] {
                array.append(s);
                map[ssorted] = array;
            } else {
                map[ssorted] = [s];
            } 	
        }	
        for key in map.keys {
            result.append(map[key]!);
        }
        return result;
        
    }
    
    
    // LC:37. Sudoku Solver
    
    
    
    // LC:36. Valid Sudoku
    // Time: O(K) for a 9x9 board, Space: O(k) for a 9x9 board
    // There's also the EPI technique
    func isValidSudoku(_ board: [[Character]]) -> Bool {
        
        for i in 0..<9 {
            
            var rows = Set<Character>();
            var columns = Set<Character>();
            var cube = Set<Character>();
            
            for j in 0..<9 {
                if (board[i][j] != "." && !rows.insert(board[i][j]).inserted) { return false; }
                if(board[j][i] != "." && !columns.insert(board[j][i]).inserted) { return false; }
                
                let RowIndex = 3*(i/3);
                let ColIndex = 3*(i%3);
                
                if(board[RowIndex + j/3][ColIndex + j%3] != "." && !cube.insert(board[RowIndex + j/3][ColIndex + j%3]).inserted) {
                    return false;
                }
            }
        }
        return true;

    }
    
    // LC:30. Substring with Concatenation of All Words
    
    // LC:18. 4Sum
    // Time: O(n3)
    // https://discuss.leetcode.com/topic/12368/clean-accepted-java-o-n-3-solution-based-on-3sum
    // O(n2) Hastable solution: http://www.lifeincode.net/programming/leetcode-two-sum-3-sum-3-sum-closest-and-4-sum-java/
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        
        var result = [[Int]]();
        
        guard nums.count >= 3 else { return result; }
        
        let nums = nums.sorted()
        let n = nums.count;
        
        for ix in 0..<nums.count-3 {
            
            if (ix > 0 && nums[ix] == nums[ix - 1]) { continue; }
            if (nums[ix] + nums[ix + 1] + nums[ix + 2] + nums[ix + 3] > target) { break; }
            if (nums[ix] + nums[n - 1] + nums[n - 2] + nums[n - 3] < target) { continue; }
            
            for jx in ix+1..<nums.count-2 {
                
                if (jx > ix + 1 && nums[jx] == nums[jx - 1]) { continue; }
                if (nums[ix] + nums[jx] + nums[jx + 1] + nums[jx + 2] > target) { break; }
                if (nums[ix] + nums[jx] + nums[n - 1] + nums[n - 2] < target) { continue; }
                
                var left = jx + 1;
                var right = n - 1;
                
                while (left < right) {
                    let sum = nums[ix] + nums[jx] + nums[left] + nums[right];
                    if (sum < target) {
                        left += 1;
                    } else if (sum > target) {
                        right -= 1;
                    } else {
                        result.append([nums[ix], nums[jx], nums[left], nums[right]]);
                        while (left < right && nums[left] == nums[left + 1]) { left += 1; }
                        while (left < right && nums[right] == nums[right - 1]) { right -= 1;}
                        left += 1; right -= 1;
                    }
                }
            }
        }
        return result;
    }
    
    // LC:3. Longest Substring Without Repeating Characters
    // Time: O(n), Space: O(n)
    // https://discuss.leetcode.com/topic/8232/11-line-simple-java-solution-o-n-with-explanation
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        var map = [Character : Int]();
        var maxSoFar = Int.min;
        var startIx = 0;
        for (index, value) in s.characters.enumerated() {
            if let stored = map[value], stored >= startIx {
                startIx = stored + 1;
            }
            maxSoFar = max(maxSoFar, index - startIx + 1);
            map[value] = index;
        }
        return maxSoFar;
    }

    
    
    // LC:1. Two Sum
    // @see Arrays
    
}

