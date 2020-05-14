//
//  main.swift
//  Swift5.1
//
//  Created by Akshay on 5/9/20.
//  Copyright © 2020 Akshay. All rights reserved.
//

import Foundation

public class TreeNode {
 public var val: Int
 public var left: TreeNode?
 public var right: TreeNode?
 public init() { self.val = 0; self.left = nil; self.right = nil; }
 public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
 public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
  self.val = val
  self.left = left
  self.right = right
 }
}

// LC:103. Binary Tree Zigzag Level Order Traversal
// O(N), O(L)
func zigzagLevelOrder(_ root: TreeNode?) -> [[Int]] {
  var result = [[Int]]()
  if let root = root {
    var queue = [TreeNode]()
    queue.append(root)
    var current = [Int]()
    var odd = false;
    var numInLevel = queue.count
    while queue.count > 0 {
      let top = queue.removeFirst()
      
      current.append(top.val)
      if let left = top.left {
        queue.append(left)
      }
      if let right = top.right {
        queue.append(right)
      }
      numInLevel -= 1
      
      if numInLevel == 0 {
        if odd == true { current = current.reversed() }
        result.append(current)
        current = [Int]()
        numInLevel = queue.count
        odd = !odd
      }
    }
  }
  return result;
}
// LC:102. Binary Tree Level Order Traversal
// O(N), O(L)
func levelOrder(_ root: TreeNode?) -> [[Int]] {
  var result = [[Int]]()
  if let root = root {
    var queue = [TreeNode]()
    queue.append(root)
    var current = [Int]()
    var numInLevel = queue.count
    while queue.count > 0 {
      let top = queue.removeFirst()
      current.append(top.val)
      if let left = top.left {
        queue.append(left)
      }
      if let right = top.right {
        queue.append(right)
      }
      numInLevel -= 1
      
      if numInLevel == 0 {
        result.append(current)
        current = [Int]()
        numInLevel = queue.count
      }
    }
  }
  return result
}

// LC:101. Symmetric Tree
// O(n), O(h)
func isSymmetricHelper(_ left: TreeNode?, _ right : TreeNode?) -> Bool {
     if left == nil && right == nil { return true; }
     if left == nil { return false; }
     if right == nil { return false; }
     return left!.val == right!.val && isSymmetricHelper(left!.right, right!.left) && isSymmetricHelper(left!.left, right!.right)
 }
 func isSymmetric(_ root: TreeNode?) -> Bool {
     if let root = root {
         return isSymmetricHelper(root.left, root.right);
     }
     return true
 }

// LC:100. Same Tree
// O(n), O(h)
func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
    if p == nil && q == nil { return true; }
    if p == nil { return false; }
    if q == nil { return false; }
    return p!.val == q!.val && isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right)
}

// LC:88. Merge Sorted Array
/*
 Input:
 nums1 = [1,2,3,0,0,0], m = 3
 nums2 = [2,5,6],       n = 3
 
 Output: [1,2,2,3,5,6]
 */
// O(m + n), O(1)
func merge(_ nums1: inout [Int], _ m: Int, _ nums2: [Int], _ n: Int) {
  var wx = m + n - 1, ix = m - 1, jx = n - 1
  while ix >= 0 && jx >= 0 {
    if nums2[jx] > nums1[ix] {
      nums1[wx] = nums2[jx]
      jx -= 1
    } else {
      nums1[wx] = nums1[ix]
      ix -= 1
    }
    wx -= 1
  }
  while jx >= 0 {
    nums1[wx] = nums2[jx]
    jx -= 1; wx -= 1;
  }
}

// LC:75. Sort Colors
// [2,0,2,1,1,0] -> [0,0,1,1,2,2]
// O(n), O(1)
func sortColors(_ nums: inout [Int]) {
  var left = -1, right = nums.count
  var ix = 0, yx = right - 1
  while ix < yx {
    while nums[ix] == 0 {
      left += 1
      nums.swapAt(left, ix)
      ix += 1
      
    }
    while nums[yx] == 2 {
      right -= 1
      nums.swapAt(right, yx)
      yx -= 1
    }
    ix += 1; yx -= 1
  }
}

// LC:66. Plus One
// [8] -> [9]
// [1, 9] -> [2, 0]
// [1, 2, 3] -> [1, 2, 4]
// [9, 9, 9] -> [1, 0, 0, 0]
func plusOne(_ digits: [Int]) -> [Int] {
  var digits = digits
  var ix = digits.count - 1
  digits[ix] += 1
  while digits[ix] == 10 && ix > 0 {
    digits[ix] = 0
    ix -= 1
    digits[ix] += 1
  }
  if digits[0] == 10 {
    digits = Array(repeating: 0, count: digits.count + 1)
    digits[0] = 1
  }
  return digits
}

// LC:49. Group Anagrams
// Input: ["eat", "tea", "tan", "ate", "nat", "bat"],
/*
 Output:
 [
  ["ate","eat","tea"],
  ["nat","tan"],
  ["bat"]
 ]
 */
// O(n), O(n)
func groupAnagrams(_ strs: [String]) -> [[String]] {
  var hmap = [String : [String]]()
  for str in strs {
    let sortedStr = String(str.sorted())
    if var stored = hmap[sortedStr] {
      stored.append(str)
      hmap[sortedStr] = stored
    } else {
      hmap[sortedStr] = [str]
    }
  }
  return Array(hmap.values)
}

// LC:38. Count and Say
func lengthOfLastWord(_ s: String) -> Int {
     let sarray = Array(s)
     guard sarray.count > 0 else { return 0 }
     var ix = sarray.count - 1
     var count = 0
     while ix >= 0 && sarray[ix] == " " { ix -= 1; }
     while ix >= 0 && sarray[ix] != " " {
       ix -= 1; count += 1;
     }
     return count
 }

// LC:38. Count and Say
// 1. 1
// 2. 11
// 3. 21
// 4. 1211
// 5. 111221
// O(??), O(??)
// Practice
func next(_ input : String) -> String {
      let inarray = Array(input)
      var count = 1
      var rx = 1
      var current = 0
      var result = ""
      while rx < inarray.count {
          if inarray[rx] == inarray[current] {
              count += 1
          } else {
              result += String(count) + String(inarray[current])
              count = 1
              current = rx
          }
          rx += 1
      }
      result += String(count) + String(inarray[current])
      return result
  }
  func countAndSay(_ n: Int) -> String {
      guard n > 0 else { return ""; }
      var result = "1"
      for _ in 1..<n {
          result = next(result)
      }
      return result
  }

// LC:27. Remove Element
// []
// [3, 2, 2, 3], val 3 -> [2, 2]
// O(n), O(1)
func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
  var rx = 0, wx = -1;
  while rx < nums.count {
    if nums[rx] != val {
      wx += 1
      nums[wx] = nums[rx]
    }
    rx += 1
  }
  return wx + 1
}

// LC:26. Remove Duplicates from Sorted Array
// [] -> 0
// [1] -> 1
// [1, 1, 2] -> 2
// [1, 2, 3] -> 3
// [1, 2, 3, 3, 4, 5, 6, 6] -> 6
// O(n), O(1)
func removeDuplicates(_ nums: inout [Int]) -> Int {
  guard nums.count > 0 else { return 0; }
  var rx = 1, wx = 0
  while rx < nums.count {
    if nums[rx] != nums[wx] {
      wx += 1
      nums[wx] = nums[rx]
    }
    rx += 1
  }
  return wx + 1
}

// convert to Swift someday
/*
static class Trie{
        int size=0 ;
        Trie[] map ;
        public Trie(){
            
            map = new Trie[26];
        }
    }
     
     Trie root = new Trie();
     
   public String longestCommonPrefix(String[] arr) {
       //use trie instead
       
       if (arr.length == 0) return "";
       StringBuilder output = new StringBuilder();
       
       for(String s  : arr )insert(s);

       return search(arr[0] , arr.length);
        

   }
     
     //search prefix logic
     String search(String smallestWord , int size ){
         
         System.out.println(smallestWord);
          Trie node = root;
      // System.out.println(node.map[5].map[11].map[14].size);
         StringBuilder sb = new StringBuilder();
         
           for(int i = 0 ; i < smallestWord.length();i++){
               
            char ch = smallestWord.charAt(i);
               if(node.map[ch-'a']==null || size!=node.map[ch-'a'].size )  break;
                sb.append(ch);
               node = node.map[ch-'a'];
           }
         
         return sb.toString();
     }
     
     //insertion logic
    void  insert(String input ){
        // System.out.println("adding " + input);
         Trie node = root;
       
        for(int i = 0 ; i < input.length();i++){
            char ch = input.charAt(i);
            if(node.map[ch-'a'] == null ) node.map[ch-'a']= new Trie();
            
            node = node.map[ch-'a'];
                         node.size++;
             // System.out.println("*** " + ch+" " + (node.size));

        }
        
        
     }
*/

// LC:13. Roman to Integer
let lookup = [
  "I" : 1,
  "V" : 5,
  "X" : 10,
  "L" : 50,
  "C" : 100,
  "D" : 500,
  "M" : 1000,
]
// VIII -> 8
// IX   -> 9
// XXX  -> 30
// C -> 100
// O(n), O(n)
func romanToInt(_ s: String) -> Int {
  var result = 0
  var lastHighest = 0
  let sarray = Array(s)
  for ix in (0..<sarray.count).reversed() {
    if let current = lookup[String(sarray[ix])] {
      lastHighest = current > lastHighest ? current : lastHighest
      if current < lastHighest {
        result -= current
      } else {
        result += current
      }
    }
  }
  return result
}

// LC:9. Palindrome Number
// 121 -> true
// 1234 -> false
// 1221 -> true
// 1 -> true
// 22
// 21
// other solution is to reverse and compare to reversed value which is prone to overflows
// this solution is overflow safe.
func digitCount(_ x : Int) -> Int {
  guard x > 0 else { return 1; }
  var count = 0, x = x;
  while x > 0 { x /= 10; count += 1; }
  return count
}
func isPalindrome(_ x: Int) -> Bool {
  guard x > 0 else { return false; }
  let count = digitCount(x)
  var x = x
  var multiplier = Int(NSDecimalNumber(decimal: pow(Decimal(10), count - 1)))
  for _ in 0..<count / 2 {
    if x % 10 != x / multiplier { return false; }
    x %= multiplier
    x /= 10
    multiplier /= 10
  }
  return true
}


// LC:7. Reverse Integer
// 123  -> 321
// -123  -> -321
// 0  -> 0
// 120 -> 21
// 1534236469 -> 0
// O(n), O(1)
func reverse(_ x: Int) -> Int {
  let isNegative = x < 0 ? true : false;
  var xNonNegative = isNegative ? -x : x;
  var result = 0
  while xNonNegative > 0 {
    let digit =  xNonNegative % 10
    result = result * 10 + digit
    xNonNegative /= 10
  }
  if result > Int32.max { return 0; }
  return isNegative ? -result : result;
}


// LC:1. Two Sum
// test case: [0, 0] 0
// test case: [0, -1] -1
// test case: [-1, -1]  -2
// test case: [5, 7, 3, 8]  15
// O(n), O(n)
func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
  var hmap = [Int : Int]();
  for (ix, num) in nums.enumerated() {
    let diff = target - num
    if let stored = hmap[diff] {
      return [stored, ix]
    }
    hmap[num] = ix;
  }
  return [-1, -1]
}


print("Hello, World!")
