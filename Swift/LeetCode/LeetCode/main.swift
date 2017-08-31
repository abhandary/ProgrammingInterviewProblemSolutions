//
//  main.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 9/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation
fileprivate func < <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l < r
  case (nil, _?):
    return true
  default:
    return false
  }
}

fileprivate func >= <T : Comparable>(lhs: T?, rhs: T?) -> Bool {
  switch (lhs, rhs) {
  case let (l?, r?):
    return l >= r
  default:
    return !(lhs < rhs)
  }
}

public class ListNode {
    public var val: Int
    public var next: ListNode?
    public init(_ val: Int) {
        self.val = val
        self.next = nil
    }
}


func *(left: String, right: Int) -> String {
    var repeatedString = ""
    for _ in 0..<right {
        repeatedString += left
    }
    return repeatedString
}


class NestedInteger {
    
    var value : Int?
    var list  = [NestedInteger]()

    init() {
        
    }
    init(value : Int) {
        self.value = value
    }
    
    func setInteger(elem : Int) {
        value = elem
    }
    
    // @return true if this NestedInteger holds a single integer, rather than a nested list.
    func isInteger() -> Bool {
        if let _ = value {
            return true
        }
        return false
    }
}

class TreeNode {
    var val : Int;
    var left : TreeNode?;
    var right : TreeNode?;
    init(x : Int) { val = x }
    init(_ x : Int) { val = x }
};

class Solution {
    
    // MARK: - TODO - Fill up run times
    
    // MARK: - 405. Convert a Number to Hexadecimal
    func toHex(_ num: Int) -> String {
        var x = num;
        let map = ["0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "a", "b", "c", "d", "e", "f"];
        var result = "";
        result += map[x & 0xf];
        x >>= 4
        var ix = 0;
        while x != 0 && ix < 7  {
            result += map[x & 0xf];
            x >>= 4;
            ix += 1;
        }
        return String(result.characters.reversed());
    }
    
    // MARK: - 404. Sum of Left Leaves
    func sumOfLeftLeavesHelper(_ root : TreeNode?, _ isLeft : Bool) -> Int {
        if let root = root {
            if root.left == nil && root.right == nil {
                return isLeft ? root.val : 0;
            }
            return sumOfLeftLeavesHelper(root.left, true) + sumOfLeftLeavesHelper(root.right, false) ;
        }
        return 0;
    }
    func sumOfLeftLeaves(_ root: TreeNode?) -> Int {
        if let root = root {
            return sumOfLeftLeavesHelper(root.left, true) + sumOfLeftLeavesHelper(root.right, false);
        }
        return 0;
    }
    

    // MARK: - 401. Binary Watch
    func bitCount(_ n : Int) -> Int {
        var n = n
        var bitCount = 0;
        while n != 0 {
            bitCount += 1;
            n &= (n - 1)
        }
        return bitCount;
    }
    func readBinaryWatch(_ num: Int) -> [String] {
        var result = [String]();
        for h in 0..<12 {
            for m in 0..<60 {
                if bitCount(h) + bitCount(m) == num {
                    let str = String(format:"%d:%02d", h, m);
                    result.append(str);
                }
            }
        }
        return result;
    }

    //MARK: - 400. Nth Digit
    // https://discuss.leetcode.com/topic/59314/java-solution/2
    func findNthDigit(_ n: Int) -> Int {
        var n = n;
        var len = 1;
        var count = 9;
        var start = 1;
        
        while (n > (len * count)) {
            n -= len * count;
            len += 1;
            count *= 10;
            start *= 10;
        }
        
        start += (n - 1) / len;
        let s = String(start);
        let chars = Array(s.characters);
        return Int(String(chars[(n - 1) % len]))!;
    }
    
    
    // MARK: - 397. Integer Replacement
    // https://discuss.leetcode.com/topic/58454/0-ms-c-recursion-solution-with-explanation/2
    
    var res = 0;
    func integerReplacement(_ n: Int) -> Int {
        guard n > 1 else { return res }
        if n == 3 {
            res += 2; return res;
        }
        if n == Int.max {
            return 32;
        }
        res += 1;
        if n & 1 == 0 {
            integerReplacement(n / 2);
        } else {
            if (n + 1) % 4 == 0 {
                integerReplacement(n + 1);
            } else {
                integerReplacement(n - 1);
            }
        }
        return res;
    }
    
    // MARK: - 396. Rotate Function
    // https://discuss.leetcode.com/topic/58459/java-o-n-solution-with-explanation
    
    func maxRotateFunction(_ A: [Int]) -> Int {
        guard A.count > 0 else { return 0 }
        if A.count == 0 { return A[0] }
        
        var F = 0, allSum = 0;
        for (ix, element) in A.enumerated() {
            F += ix * element;
            allSum += element;
        }
        var maxSum = F;
        for ix in (1..<A.count).reversed() {
            F = F + allSum - A.count * A[ix];
            maxSum = max(maxSum, F);
        }
        return maxSum;
    }
    
    
    
    // MARK: - 395. Longest Substring with At Least K Repeating Characters
    // 1. in the first pass I record counts of every character in a hashmap
    // 2. in the second pass I locate the first character that appear less than k times in the string. this character is definitely not included in the result, and that separates the string into two parts.
    // 3. keep doing this recursively and the maximum of the left/right part is the answer.
    func longestSubstring(_ s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytes(using: String.Encoding.utf8)
        guard slen > 0 && slen >= k else {
            return 0
        }
        
        
        var map = [Character: Int]()
        
        for c in s.characters {
            map[c] = (map[c] ?? 0) + 1
        }
        var ix = 0
        let schars = Array(s.characters)
        while (ix < s.characters.count && map[schars[ix]] >= k) {
            ix += 1
        }
        
        if ix == s.characters.count {
            return s.characters.count
        }
        if ix == 0 {
            ix += 1
        }
        
        let left = longestSubstring(s.substring(to: s.characters.index(s.startIndex, offsetBy: ix)), k)
        let right = longestSubstring(s.substring(from: s.characters.index(s.startIndex, offsetBy: ix)), k)
        return max(left, right)
    }

    func longestSubstring2(_ s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytes(using: String.Encoding.utf8)
        guard slen > 0 && slen >= k else {
            return 0
        }
        
        var myMap = [Character: Int]()
        s.characters.forEach{ myMap[$0] = (myMap[$0] ?? 0) + 1  }
        
        let minElement = myMap.values.min()!
        if  minElement >= k {
            return s.characters.count
        }

        let minChar = myMap.filter{$0.1 ==  minElement}.map{return $0.0}.first
        let lines = s.components(separatedBy: String(describing: minChar))
        
        return lines.reduce(0) { max($0, longestSubstring($1, k))}
    }

    func longestSubstring3(_ s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytes(using: String.Encoding.utf8)
        guard slen > 0 && slen >= k else {
            return 0
        }
        
        var myMap = [Character: Int]()
        s.characters.forEach{ myMap[$0] = (myMap[$0] ?? 0) + 1  }
        
        let minElement = myMap.values.min()!
        if  minElement >= k {
            return s.characters.count
        }
        
        let minChar = myMap.filter() {$0.1 ==  minElement}.map() {return $0.0}.first
        let range = s.range(of: String(describing: minChar))

        
        let left = 0 // longestSubstring(s.substring(to: range!.first!), k)
        let right = 0 // longestSubstring(s.substring(from: range!.first!), k)
        return max(left, right)
    }
    

    
    
    // MARK: - 394. Decode String (Accepted)
    func decodeStringHelper( _ pos : inout Int, s : String) ->String {
        var num = ""
        var result = ""
        
        let schars = Array(s.characters)
        let slen = s.lengthOfBytes(using: String.Encoding.utf8)
        
        while pos < slen {
            let currentStr = String(schars[pos])
            switch schars[pos] {
            case "0"..."9":
                num += currentStr
            case "[":
                let decoded = decodeStringHelper(&pos, s: s)
                result += (decoded * (Int(num) ?? 0))
                num = ""
            case "]":
                return result
            default:
                result += currentStr
            }
            pos += 1
        }
        return result;
    }
    

    func decodeString(_ s: String) -> String {
        var pos = 0
        return decodeStringHelper(&pos, s: s);
    }
    
    // MARK: - 393. Validate UTF8 (Accepted)
    func validUtf8(_ data: [Int]) -> Bool {
        var count = 0;
        for c in data {
            if (count == 0) {
                if (c >> 5) == 0b110 {
                    count = 1
                }
                else if (c >> 4) == 0b1110 {
                    count = 2;
                }
                else if (c >> 3) == 0b11110 {
                    count = 3;
                }
                else if (c >> 7) != 0 {
                    return false;
                }
            } else {
                if (c >> 6) != 0b10 {
                    return false;
                }
                count -= 1;
            }
        }
        return count == 0;
    }
    
    // MARK: - 392. Is Subsequence
    /*
    bool isSubsequence(char* s, char* t) {
        while (*t)
            s += *s == *t++;
        return !*s;
    }
    */
    
    // MARK: - 391. Perfect Rectangle
    
    // MARK: 389. Find the Difference
    /*
    char findTheDifference(char* s, char* t) {
        char c = 0;
        while(*s) {
            c ^= *s;
            s++;
        }
        while (*t) {
            c ^= *t;
            t++;
        }
        return c;
    }
    */
    
    // MARK: - 388. Longest Absolute File Path (Accepted)
    func lengthLongestPath(_ input: String) -> Int {
        var pathLen = [0:0]
        var maxLen = 0
        let lines = input.components(separatedBy: "\n")
        for line in lines {
            let name = line.replacingOccurrences(of: "\t", with: "")
            let depth = line.characters.count - name.characters.count
            if name.contains(".") {
                maxLen = max(maxLen, pathLen[depth]! + name.characters.count)
            } else {
                pathLen[depth + 1] = pathLen[depth]! + name.characters.count + 1
            }
        }
        return maxLen
    }
    
    // MARK: - 387. First Unique Character in a String (Timed Out??)
    func firstUniqChar(_ s: String) -> Int {
        var myMap = [Character : Int]()

        s.characters.forEach { myMap[$0] = (myMap[$0] ?? 0) + 1}

        for (index,element) in s.characters.enumerated() {
            if myMap[element] == 1 {
                return index
            }
        }
        return -1
    }
    
    // MARK: - 386. Lexicographic Numbers
    func lexicalOrder(_ n : Int) -> [Int] {
        var list = [Int]();
        var curr = 1;
        for _ in 1...n {
            list.append(curr)
            if (curr * 10 <= n) {
                curr *= 10;
            } else if (curr % 10 != 9 && curr + 1 <= n) {
                curr += 1;
            } else {
                while ((curr / 10) % 10 == 9) {
                    curr /= 10;
                }
                curr = curr / 10 + 1;
            }
        }
        return list;
    }
    
    // MARK: - 385. Mini Parser
    func parseNumber(_ s : String, pos : inout Int) -> Int {

        var isPos = true
        if s[s.characters.index(s.startIndex, offsetBy: pos)] == "-" {
            isPos = false
            pos += 1
        }
        var num = 0
        while pos < s.characters.count,
            let value = Int(String(s[s.characters.index(s.startIndex, offsetBy: pos)]))  {
                
            num = num * 10 + value
            pos += 1
        }
        
        return isPos ? num : -num
    }
    
    func parseList(_ s : String, pos : inout Int) -> NestedInteger {
        let result = NestedInteger()
        pos += 1 // eat "["

        loop: while pos < s.characters.count {
            switch s[s.characters.index(s.startIndex, offsetBy: pos)] {
            case "[":
                let ni = parseList(s, pos: &pos)
                result.list.append(ni)
            case "0"..."9", "-":
                let number = parseNumber(s, pos: &pos)
                result.value = number
            case "]":
                pos += 1 // eat "]"
              break loop
            default:
                pos += 1 // eat "," and anything else
                break
            }
        }

        return result
    }
    
    func deserialize(_ s : String) -> NestedInteger? {
        guard s.characters.count > 0 else {
            return nil
        }
        var index = 0
        if s.characters.first == "[" {
            return parseList(s, pos: &index)
        }
        return NestedInteger(value: parseNumber(s, pos: &index));
    }
    
    // MARK: - 383. Ransom Note
    func canConstruct(_ ransomNote: String, _ magazine: String) -> Bool {
        var myMap = [Character : Int]()
        ransomNote.characters.forEach { myMap[$0] = (myMap[$0] ?? 0) + 1  }
        for element in magazine.characters {
            if let value = myMap[element] {
                myMap[element] = value - 1
                if value == 1 {
                    myMap.removeValue(forKey: element)
                    if myMap.count == 0 {
                        return true
                    }
                }
            }
        }
        return false
    }
    
    // MARK: - 382. Linked List Random Node
    /*
    int getRandom() {
        std::default_random_engine seed((random_device())());
        int currIx = 0;
        ListNode* result = NULL;
        for(ListNode* itr = _head; itr != NULL; itr = itr->next) {
            std::uniform_int_distribution<int> dis(0, currIx++);
            int evictIx = dis(seed);
            if (evictIx == 0) {
                result = itr;
            }
        }
        return result->val;
    }
    */
    
    // MARK: = 380. Insert Delete Get Random O(1)
    /*
    bool insert(int val) {
        if (map.count(val) > 0) {
            return false;
        }
        map[val] = nums.size();
        nums.push_back(val);
        return true;
    }
    
    /** Removes a value from the set. Returns true if the set contained the specified element. */
    bool remove(int val) {
        if (map.count(val) == 0) {
        return false;
        }
    
        int loc = map[val];
        if (loc != nums.size() - 1) {
            int lastone = nums[nums.size() - 1];
            nums[loc] = lastone;
            map[lastone] = loc;
        }
        nums.pop_back();
        map.erase(val);
        return true;
    }
    
    /** Get a random element from the set. */
    int getRandom() {
        std::default_random_engine seed((random_device())());
        std::uniform_int_distribution<int> dis(0, nums.size() - 1);
        return nums[dis(seed)];
    }
    */

    
    // MARK: - 378 Kth Smallest Element in a Sorted Matrix
    func helper( _ array : inout [Int], _ k : Int) -> Int {
        let pivotIx = array.count / 2;
        let pivot = array[pivotIx];
        
        swap(&array[0], &array[pivotIx]);
        var smaller = 1;
        for (index, element) in array.enumerated() {
            if element < pivot {
                swap(&array[smaller], &array[index]);
                smaller += 1;
            }
        }
        swap(&array[smaller], &array[0]);
        if smaller + 1 == k {
            return array[smaller];
        }
        return -1;
    }
    
    func kthSmallest(_ matrix: [[Int]], _ k: Int) -> Int {
        var array = [Int]();
        for row in matrix {
            for element in row {
                array.append(element);
            }
        }
        return helper(&array , k);
    }
    
    var dp = [Int : Int]()

    // MARK: - 377. Combination Sum IV
    func combinationSum4(_ nums: [Int], _ target: Int) -> Int {
        if target == 0 {
            return 1;
        }
        if let val = self.dp[target] {
            return val;
        }

        var total = 0;
        for num in nums {
            if target >= num {
                total += combinationSum4(nums, target - num);
            }
        }
        self.dp[target] = total;
        return total;
    }
    
    // MARK: - 376. Wiggle Subsequence
    func wiggleMaxLength(_ nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count;
        }
        var nums = nums;
        var k = 0;
        while k < nums.count - 1 && nums[k] == nums[k + 1] {
            k += 1;
        }
        if k == nums.count - 1 {
            return 1;
        }
        var smallReq = nums[k] < nums[k + 1];
        var result = 2;
        while k < nums.count - 1 {
            if smallReq && nums[k + 1] < nums[k] {
               // nums[result] = nums[k + 1];
                result += 1;
                smallReq = !smallReq;
            } else if !smallReq && nums[k + 1] > nums[k] {
                //nums[result] = nums[k + 1];
                result += 1;
                smallReq = !smallReq;
            }
            k += 1;
        }
        return result;
    }
    
    // MARK:- 375. Guess Number Higher or Lower II
    var moneyDP : [[Int]]!;
    // To find out how much money I need to win the range lo..hi (the game starts with the range 1..n), I try each possible x in the range (except hi, which is pointless because hi-1 costs less and provides more information), calculate how much I need when using that x, and take the minimum of those amounts.
    // https://discuss.leetcode.com/topic/51353/simple-dp-solution-with-explanation
    func moneyHelper(_ s : Int, _ e : Int) -> Int {
        
        if s >= e { return 0; }
        
        if self.moneyDP[s][e] != Int.max {
            return self.moneyDP[s][e]
        }
        
        for ix in s...e {
            self.moneyDP[s][e] = min(self.moneyDP[s][e], ix +  max(moneyHelper(s, ix - 1), moneyHelper(ix + 1, e)));
        }
        return self.moneyDP[s][e];
    }
    
    func getMoneyAmount(_ n: Int) -> Int {
        self.moneyDP = [[Int]](repeating: [Int](repeating: Int.max, count: n + 1), count: n + 1);
        return moneyHelper(1, n);
    }
    
    
    

    // MARK:- 373. Find K Pairs with Smallest Sums
    /* https://discuss.leetcode.com/topic/50421/c-priority_queue-solution
       https://discuss.leetcode.com/topic/53380/o-k-solution StefanPochmann
     
    vector<pair<int, int>> kSmallestPairs(vector<int>& nums1, vector<int>& nums2, int k) {
        vector<pair<int, int>> res;
        priority_queue<pair<int,int>, vector<pair<int, int> >, mycompare> pq;
        for(int i = 0; i < min((int)nums1.size(), k); i++){
            for(int j = 0; j < min((int)nums2.size(), k); j++){
                if(pq.size() < k)
                    pq.emplace(nums1[i], nums2[j]);
                else if(nums1[i] + nums2[j] < pq.top().first + pq.top().second){
                    pq.emplace(nums1[i], nums2[j]);
                    pq.pop();
                }
            }
        }
        while(!pq.empty()){
            res.push_back(pq.top());
            pq.pop();
        }
        return res;
    }
    */
 
    // MARK: - 372. Super Pow
    // https://discuss.leetcode.com/topic/50489/c-clean-and-short-solution
    func power(_ a : Int, _ k : Int) -> Int  // 0 <= k <= 10
    {
        var result = 1;
        for _ in 0..<k {
            result = (result * a) % 1337;
        }
        return result;
    }
    func superPow(_ a: Int, _ b: [Int]) -> Int {
        if b.count == 0 {
            return 1;
        }
        var b = b;
        let last = b.removeLast();
        return  power(superPow(a, b), 10) * power(a, last) % 1337;
    }
    
    // MARK: - 371. Sum of Two Integers.
    func getSum(_ a: Int, _ b: Int) -> Int {
        return b==0 ? a : getSum(a^b, (a&b)<<1);
    }
    
    // MARK: - 368. Largest Divisible Subset
    /* https://discuss.leetcode.com/topic/49455/4-lines-in-python
     */
    //def largestDivisibleSubset(self, nums):
    //  S = {-1: set()}
    //  for x in sorted(nums):
    //  S[x] = max((S[d] for d in S if x % d == 0), key=len) | {x}
    //  return list(max(S.values(), key=len))
    
    
    
    // MARK: - 367. Valid Perfect Square
    func isPerfectSquare(_ x: Int) -> Bool {
        var r = x;
        while (r * r > x) {
            r = (r +  x / r) / 2;
        }
        return r * r == x;
    }
    
    func isPerfectSquare2(_ x: Int) -> Bool {
        var l = 1;
        var h = x;
        var mid = x;
        while (l < h) {
            if mid * mid > x {
                h = mid - 1;
            } else {
                l = mid + 1;
            }
            mid = l + (h - l) / 2
        }
        return mid * mid == x;
    }
    
    // MARK: - 365. Water and Jug Problem
    /* https://discuss.leetcode.com/topic/49238/math-solution-java-solution
     */
    func GCD(_ x : Int, _ y : Int) -> Int {
        var a = x, b = y;
        
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    func canMeasureWater(_ x: Int, _ y: Int, _ z: Int) -> Bool {
        if x + y < z {
            return false;
        }
        if x == z || y == z || x + y == z {
            return true;
        }
        return z % GCD(x, y) == 0;
    }
    
    // MARK: - 357. Count Numbers with Unique Digits
    // sequence counting problem
    // https://discuss.leetcode.com/topic/47983/java-dp-o-1-solution
    func countNumbersWithUniqueDigits(_ n: Int) -> Int {
        guard n > 0 else { return 1 }
        var availableDigits = 9;
        var uniqueDigits = 9;
        var result = 10;
        var n = n;
        while (n > 1 && availableDigits > 0) {
            uniqueDigits = uniqueDigits * availableDigits;
            result += uniqueDigits;
            availableDigits -= 1;
            n -= 1;
        }
        return result;
    }
    
    // MARK: - 350. Intersection of Two Arrays II
    func intersect2(_ nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map1 = [Int : Int]();
        nums1.forEach { map1[$0] = (map1[$0] ?? 0) + 1};
        
        return nums2.filter {
            if let num = map1[$0] , num > 0 {
                map1[$0] = num - 1;
                return true;
            }
            return false;
        }
    }
   
    // MARK: - 349. Intersection of Two Arrays.
    func intersection(_ nums1: [Int], _ nums2: [Int]) -> [Int]
    {
        let set1 = Set<Int>(nums1)
        let set2 = Set<Int>(nums2)
        return set2.filter() { return set1.contains($0)}
    }
    
    // MARK: - 345. Reverse Vowels of a String
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
    
    // MARK: - 344. Reverse String
    func reverseString(_ s: String) -> String {
        var chars = Array(s.characters);
        var left = 0, right = chars.count - 1;
        
        while left < right {
            swap(&chars[left], &chars[right]);
            left += 1; right -= 1;
        }
        return String(chars);
    }
    
    // MARK: - 342. Power of Four
    func isPowerOfFour(_ num: Int) -> Bool {
        let n = num;
        return n > 0 && (n & (n - 1)) == 0 && (n & 0x55555555) > 0;
    }
    
    // MARK: - 326. Power of Three
    // https://discuss.leetcode.com/category/406/power-of-three
    func isPowerOfThree(_ n: Int) -> Bool {
        return ( n > 0 &&  (1162261467 % n) == 0);
    }
    
    // MARK: - 303. Range Sum Query - Immutable
    /*
    class NumArray {
        vector<int> array;
        unordered_map<int, int> preComputed;
        public:
        NumArray(vector<int> &nums) {
        array = nums;
        preComputed[-1] = 0;
        int sum = 0;
        for (int ix = 0; ix < nums.size(); ix++) {
        sum += nums[ix];
        preComputed[ix] = sum;
        }
        }
        
        int sumRange(int i, int j) {
        if (i >= array.size() || j >= array.size() ) {
        return 0;
        }
        return preComputed[j] - preComputed[i - 1];
        }
    };
    */
    
    var preComputedRangeSum  = [Int : Int]();
    var array : [Int]!;
    
    func initWithNums(_ nums : [Int]) {
        preComputedRangeSum[-1] = 0;
        var sum = 0;
        array = nums;
        for (ix, element) in nums.enumerated() {
            sum += element;
            preComputedRangeSum[ix] = sum;
        }
    }
    
    func sumRange(i : Int, j : Int) -> Int {
        
        guard i <= array.count && j <= array.count else {return 0; };
        
        if let x = preComputedRangeSum[i - 1],
            let y = preComputedRangeSum[j] {
            
            return y - x;
        }
        return 0;
    }
    
    // MARK: - 257. Binary Tree Paths
    func bthelper(_ root : TreeNode, _ result : inout [String], _ partial : String) {
        if root.left == nil && root.right == nil {
            let final = partial + String(root.val);
            result.append(final)
            return;
        }
        
        if let left = root.left {
            bthelper(left, &result, partial + String(root.val) + "->");
        }
        
        if let right = root.right {
            bthelper(right, &result, partial + String(root.val) + "->");
        }

    }
    
    func binaryTreePaths(_ root : TreeNode?) -> [String] {
        var result = [String]();
        if let root = root {
            bthelper(root, &result, "");
        }
        return result;
    }

    // MARK: - 283. Move Zeroes
    func moveZeroes(_ nums:  inout [Int]) {
        guard nums.count > 0 else { return; }
        var wx = 0, rx = 0;

        while rx < nums.count {
            if nums[rx] != 0 {
                nums[wx] = nums[rx];
                wx += 1;
            }
            rx += 1;
        }
        while wx < nums.count {
            nums[wx] = 0;
            wx += 1;
        }
    }
    
    func moveZeroes2(_ nums:  inout [Int]) {
        
        guard nums.count > 0 else { return; }
        var zeroCount = 0;
        nums[0...2] = [1, 2, 3];
        nums = nums.filter() {
            if $0 == 0 {
                zeroCount += 1;
            }
            return $0 != 0;
        }
        nums.append(contentsOf: [Int](repeating: 0, count: zeroCount));
    }
    
    // MARK: - 242. Valid Anagram
    func isAnagram(_ s: String, _ t: String) -> Bool {
        let a1 = Array(s.characters);
        let a2 = Array(t.characters);
        return String(a1.sorted()) == String(a2.sorted());
    }
    
    // MARK: - 241. Different Ways to Add Parentheses
    // https://discuss.leetcode.com/topic/19901/a-recursive-java-solution-284-ms/7
    func diffWaysToCompute(_ input: String) -> [Int] {
        
        var result = [Int]();
        
        if !input.characters.contains("*") &&
            !input.characters.contains("-") &&
            !input.characters.contains("+") {
            if let num = Int(input) {
                result.append(num);
            }
            return result;
        }
        
        let chars = Array(input.characters);
        for (index, char) in input.characters.enumerated() {
            if ["*", "-", "+"].contains(char) {
                
                let left = diffWaysToCompute(String(chars[0..<index]));
                let right = diffWaysToCompute(String(chars[index+1..<chars.count]));
                
                for leftVal in left {
                    for rightVal in right {
                        switch  char {
                        case "*":
                            result.append(leftVal * rightVal);
                        case "-":
                            result.append(leftVal - rightVal);
                        case "+":
                            result.append(leftVal + rightVal);
                        default:
                            break;
                        }
                    }
                }
            }
        }
        return result;
    }
    
    // MARK: - 240. Search a 2D Matrix 2
    // https://leetcode.com/problems/search-a-2d-matrix-ii/
    func searchMatrix(_ matrix: [[Int]], _ target: Int) -> Bool {
        guard matrix.count > 0 && matrix[0].count > 0 else { return false; }
        
        var ix = 0;
        var jx = matrix[0].count - 1;
        while ix < matrix.count && jx >= 0 {
            if matrix[ix][jx] == target {
                return true;
            }
            if matrix[ix][jx] < target {
                ix += 1;
            } else {
                jx -= 1;
            }
        }
        return false;
    }
    
    // MARK: - 238. Product of Array Except Self
    // https://discuss.leetcode.com/topic/18864/simple-java-solution-in-o-n-without-extra-space
    func productExceptSelf(_ nums: [Int]) -> [Int] {
        var result = [Int](repeating: 1, count: nums.count)
        guard nums.count > 0 else { return result; }
        
        var ix = 1;
        while ix < nums.count {
            result[ix]  = nums[ix - 1] * result[ix - 1];
            ix += 1;
        }
        var right = 1;
        ix = nums.count - 1;
        while ix >= 0 {
            result[ix] *= right;
            right *= nums[ix];
            ix -= 1;
        }
        return result;
    }
    
    // MARK: 187. Write a function to find all the 10-letter-long sequences (substrings) that occur more than once in a DNA molecule.
    func findRepeatedDnaSequences(s: String) -> [String] {
        var result = [String]()
        var set = Set<String>()
        var multiOccurence = Set<String>()
        if s.characters.count > 10 {
            var ix = 0
            while ix + 10 < s.characters.count {
                /*
                let substr = s.startIndex.advancedBy(0 + ix)...s.startIndex.advancedBy(10 + ix - 1)
                if set.contains(substr) {
                    multiOccurence.insert(set)
                } else {
                    set.insert(substr)
                }
                ix+=1
                */
            }
        }
        
        return result
    }
    
    // MARK: - 78. Subsets
    func subsets(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]();
        guard nums.count > 0 else { return result; }
        
        for bits in 0..<(1 << nums.count) {
            var subset = [Int]()
            var bits = bits;
            while bits != 0 {
                let lowest = bits & ~(bits - 1);
                subset.append(nums[Int(log2(Double(lowest)))]);
                bits &= (bits - 1);
            }
            result.append(subset);
        }
        return result;
    }
    
    // MARK: - 75. Sort Colors
    func sortColors(_ nums: inout [Int]) {
        var nZeroes = 0, nOnes = 0, nTwos = 0;
        for num in nums {
            if (num == 0) { nZeroes += 1; }
            if (num == 1) { nOnes += 1; }
            if (num == 2) { nTwos += 1; }
        }
        
        var ix = 0;
        while nZeroes > 0 || nOnes > 0 || nTwos > 0 {
            if nZeroes > 0 { nums[ix] = 0; nZeroes -= 1; }
            else if nOnes > 0 { nums[ix] = 1; nOnes -= 1; }
            else { nums[ix] = 2; nTwos -= 1; }
            ix += 1;
        }
    }
    
    // MARK: - 74. Search a 2D Matrix
    func searchMatrix2(_ matrix: [[Int]], _ target: Int) -> Bool {
        if matrix.count == 0 {
            return false
        }
        var left = 0, right = matrix[0].count - 1
        var top = 0, bottom = matrix.count - 1
        while left <= right && top <= bottom {
            let cornerValue = matrix[top][right]
            if cornerValue == target {
                return true
            }
            if cornerValue < target {
                top+=1
            } else {
                right-=1
            }
        }
        return false
    }
    
    // MARK: - 73. Set Matrix Zeroes
    func setZeroes(_ matrix: inout [[Int]]) {
        guard matrix.count > 0 && matrix[0].count > 0 else { return; }
        
        let m = matrix.count, n = matrix[0].count;
        var rows = Set<Int>();
        var cols = Set<Int>();
        
        for ix in 0..<m {
            for jx in 0..<n {
                if matrix[ix][jx] == 0 {
                    rows.insert(ix);
                    cols.insert(jx)
                }
            }
        }
        for ix in 0..<m {
            for jx in 0..<n {
                if (rows.contains(ix) || cols.contains(jx)) {
                    matrix[ix][jx] = 0;
                }
            }
        }
    }
    
    // MARK: - 67. Add Binary
    func addBinary(_ a: String, _ b: String) -> String
    {
        guard a != "" else { return b; }
        guard b != "" else { return a; }
        
        var result = "";
        let aChars = Array(a.characters);
        let bChars = Array(b.characters);
        
        var ix = aChars.count - 1, jx = bChars.count - 1;
        var c = 0;
        while ix >= 0 || jx >= 0 {
            let aBit = (ix >= 0) ? Int(String(aChars[ix]))! : 0;
            let bBit = (jx >= 0) ? Int(String(bChars[jx]))! : 0;
            result += String(aBit ^ bBit ^ c);
            c = (c + aBit + bBit >= 2) ? 1 : 0
            ix -= 1; jx -= 1;
        }
        if c > 0 {
            result += "1";
        }
        return String(result.characters.reversed());
    }
    
    // MARK: - 66. Plus One
    func plusOne(_ digits: [Int]) -> [Int] {
        var result = digits;
        guard digits.count > 0 else { return result; }
        var current = digits.count - 1;
        result[current] += 1;
        while result[current] == 10 && current > 0 {
            result[current] = 0;
            result[current - 1] += 1;
            current -= 1;
        }
        if result[0] == 10 {
            result[0] = 0;
            result.insert(1, at: 0);
        }
        return result;
    }
    
    // MARK: - 64. Minimum Path Sum
    func minPathSum(_ grid: [[Int]]) -> Int {
        guard grid.count > 0 && grid[0].count > 0 else { return 0; }
        
        var inter = grid;
        let m = grid.count;
        let n = grid[0].count;
        for ix in 0..<m {
            for jx in 0..<n {
                if ix > 0 && jx > 0 {
                    inter[ix][jx] += min(inter[ix - 1][jx], inter[ix][jx - 1]);
                } else if ix > 0 {
                    inter[ix][jx] += inter[ix - 1][jx];
                } else if jx > 0 {
                    inter[ix][jx] += inter[ix][jx - 1];
                } else {
                    // no change.
                }
                
            }
        }
        return inter[m - 1][n - 1]
    }
    
    // MARK: - 62. Unique Paths
    func getVal(_ board : [[Int]], _ rx : Int, _ cx : Int) -> Int {
        guard rx >= 0 && cx >= 0 else { return 0; }
        return board[rx][cx];
    }

    func uniquePaths(_ m: Int, _ n: Int) -> Int {
        guard m > 0 && n > 0 else { return 0; }
        var set = Set<Int>()
        
        var array = [Int](repeatElement(0, count: n));
        var board = [[Int]](repeatElement(array, count: m));
        board[0][0] = 1;
        for ix in 0..<m {
            for jx in 0..<n {
                if ix == 0 && jx == 0 { continue; }
                board[ix][jx] = getVal(board, ix - 1, jx) + getVal(board, ix, jx - 1);
            }
        }
        return board[m - 1][n - 1];
    }
    
    // MARK: - 58. Length of Last Word
    func lengthOfLastWord(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        
        let chars = Array(s.characters);
        var ix = chars.count - 1;
        while ix >= 0 && chars[ix] == " "  { ix -= 1; }
        var end = ix;
        while ix >= 0 && chars[ix] != " " {
            ix -= 1;
        }
        return end - ix;
    }
    
    // MARK: - 55. Jump Game
    func canJump(_ nums: [Int]) -> Bool {
        guard nums.count > 0 else { return false; }
        var maxVal = nums[0];
        var ix = 0;
        while ix < nums.count && maxVal >= ix {
            maxVal = max(maxVal, ix + nums[ix]);
            ix += 1;
        }
        return maxVal >= nums.count - 1;
    }
    
    // MARK: - 54. Spiral Matrix
    func spiralOrder(_ matrix: [[Int]]) -> [Int] {
        var result = [Int]()
        if matrix.count == 0 {
            return result
        }
        
        var top = 0, bottom = matrix.count - 1
        var left = 0, right = matrix[0].count - 1
        
        while left <= right && top <= bottom {
            
            for col in left...right {
                result.append(matrix[top][col])
            }
            top += 1
            
            for row in top...bottom {
                result.append(matrix[row][right])
            }
            right -= 1
            
            if left <= right {
                for col in (left...right).reversed() {
                    result.append(matrix[bottom][col])
                }
                bottom -= 1
            }
            if top <= bottom {
                for row in (top...bottom).reversed() {
                    result.append(matrix[row][left])
                }
                left += 1;
            }
        }
        return result
    }
    
    // MARK: - 53. Maximum Subarray
    // https://discuss.leetcode.com/topic/6413/dp-solution-some-thoughts/2
    
    func maxSubArrayHelper2(_ nums : [Int], _ lastIx : Int) -> Int {
        guard lastIx >= 0 else { return 0; }
        if lastIx == 0 { return nums[0]; }
        
        let maxVal = maxSubArrayHelper(nums, lastIx - 1);
        return max(nums[lastIx] + maxVal, nums[lastIx]);
    }
    
    func maxSubArrayHelper(_ nums : [Int], _ lastIx : Int) -> Int {
        guard lastIx >= 0 else { return 0; }
        if lastIx == 0 { return nums[0]; }
        
        let maxVal = maxSubArrayHelper(nums, lastIx - 1);
        let total = nums[lastIx] + (maxVal > 0 ? maxVal : 0)
        return max(total, maxVal);
    }
    func maxSubArray2(_ nums : [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        return maxSubArrayHelper(nums, nums.count - 1);
    }
    
    func maxSubArray(_ nums: [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        var dp = [Int](repeatElement(0, count: nums.count));
        dp[0] = nums[0];
        var maxVal = dp[0];
        
        for ix in 1..<nums.count {
            dp[ix] = nums[ix] + ((dp[ix - 1] > 0 ) ? dp[ix - 1] : 0);
            maxVal = max(maxVal, dp[ix]);
        }
        return maxVal;
    }
    
    // MARK: - 50. Pow(x, n)
    // Other solutions: https://discuss.leetcode.com/topic/21837/5-different-choices-when-talk-with-interviewers/2
    func myPow(_ x: Double, _ n: Int) -> Double {
        if n == 0 { return 1; }
        if x == 0 { return 0; }
        
        var n = n;
        var x = x;
        if n < 0 {
            n = -n;
            x = 1 / x;
        }
        return n % 2 == 0 ? myPow(x * x, n / 2) : x * myPow(x * x, n / 2);
    }
    
    
    
    // MARK: - 49. Group Anagrams
    func groupAnagrams(input : [String]) -> [[String]] {
        var result = [[String]]()
        var map = [String : [String]]()
        
        for str in input {
            let sorted = String(str.characters.sorted())

            if var val = map[sorted] {
                val.append(str);
                map[sorted] = val;
            } else {
                map[sorted] = [str];
            }
        }
        
        for key in map.keys {
            result.append(map[key]!)
        }
        return result;
    }
    
    // MARK: - TODO 48. Rotate Image
    func rotateImage(_ image : [[Int]]) {
        guard image.count > 0 else { return; }
        let n = image.count;
        for rx in 0..<n/2 {
            for ix in rx..<(n - rx) {
                
            }
        }
    }
    
    // MARK: - TODO 47. Permutations II
    func permHelper2(_ input : [Int], _ pos : Int, _ len : Int, _ result : inout [[Int]])
    {
        var input = input;
        if pos == len - 1 {
            result.append(input);
            return;
        }
        
        for ix in pos..<len {
            if (ix > pos && input[ix] == input[ix - 1]) { continue; }
            if pos != ix {
                input.insert(input[ix], at: pos);
                input.remove(at: pos + 1);
            }
            permHelper(input, pos + 1, len, &result);
            if pos != ix {
                input.insert(input[pos], at: ix + 1);
                input.remove(at: pos);
            }
        }
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        guard nums.count > 0 else { return result; }
        var sorted = nums.sorted();
        permHelper2(sorted, 0, sorted.count, &result);
        return result
    }
    
    
    // MARK: - 46. Permutations
    func permHelper(_ input : [Int], _ pos : Int, _ len : Int, _ result : inout [[Int]])
    {
        var input = input;
        if pos == len {
            result.append(input);
            return;
        }
        
        for ix in pos..<len {
            if pos != ix {
                swap(&input[ix], &input[pos])
            }
            permHelper(input, pos + 1, len, &result);
        }
    }
    
    func permutations(_ input : [Int]) -> [[Int]]
    {
        var result = [[Int]]()
        guard input.count > 0 else { return result; }
        permHelper(input, 0, input.count, &result);
        return result
    }
    
    // MARK: - 38 Count and Say
    
    func countAndSayHelper(_ str : String) -> String
    {
        var result = "";
        let chars = Array(str.characters);
        var count = 1;
        var ix = 1;
        
        while ix < chars.count {
            
            if chars[ix] == chars[ix - 1] {
                count += 1;
            } else {
                result += String(count) + String(chars[ix - 1]);
                count = 1;
            }
            ix += 1;
        }
        result += String(count) + String(chars[ix - 1]);
        return result;
    }
    
    func countAndSay(x : Int) -> String
    {
        var result = "1"
        for _ in 1..<x {
            result = countAndSayHelper(result);
        }
        return result;
    }
    
    // MARK: - 36. Valid Sudoku
    
    func hasDuplicates(_ board : [[Int]], _ rowStart : Int, _ rowEnd : Int, _ colStart : Int, _ colEnd : Int) -> Bool {
        var mySet = Set<Int>();
        
        for ix in rowStart..<rowEnd {
            for jx in colStart..<colEnd {
                if mySet.contains(board[ix][jx]) {
                    return true;
                }
                mySet.insert(board[ix][jx]);
            }
        }
        return false;
    }
    
    func isValidSudoku(_ board : [[Int]]) -> Bool {
        let n = board.count;
        let quad = Int(sqrt(Double(n)));
        
        // check rows
        for ix in 0..<n {
            if hasDuplicates(board, 0, n, ix, ix + 1) {
                return false;
            }
        }
        
        // check columsn
        for jx in 0..<n {
            if hasDuplicates(board, jx, jx + 1, 0, n) {
                return false;
            }
        }
        
        // check quads
        for IX in 0..<quad {
            for JX in 0..<quad {
                if hasDuplicates(board, quad * IX, quad * (IX + 1), quad * JX, quad * (JX + 1)) {
                    return false;
                }
            }
        }
        return true;
    }
    
    // MARK: - 27. Remove Element
    func removeElement(_ nums: inout [Int], _ val: Int) -> Int {
        var pos = 0;
        var ix = 0
        while ix < nums.count {
            if nums[ix] != val {
                nums[pos] = nums[ix];
                pos += 1;
            }
            ix += 1;
        }
        return pos;
    }
    
    // MARK: - 26. Remove Duplicates from Sorted Array
    func removeDuplicates(_ nums: inout [Int]) -> Int {
        guard nums.count > 0 else { return 0; }
        var ix = 1;
        var next = 1;
        while ix < nums.count {
            if nums[ix] != nums[ix - 1] {
                nums[next] = nums[ix];
                next += 1;
            }
            ix += 1;
        }
        return next;
    }
    
    // MARK: - TODO 25. Reverse Nodes in k-Group (HARD)
    func reverseKGroup(_ head: ListNode?, _ k: Int) -> ListNode? {
        var result : ListNode? = nil;
        return result;
    }
    
    // MARK: - 24. Swap Nodes in Pairs
    func swapPairs(_ head: ListNode?) -> ListNode? {
        guard head != nil else { return head; }
        let dummyHead  = ListNode(0);
        dummyHead.next = head;
        var current : ListNode? = dummyHead;
        
        while current!.next != nil && current!.next!.next != nil {
            let first = current!.next;
            let second = current!.next!.next;
            current!.next = second;
            first!.next  = second!.next;
            second!.next = first;
            current = current!.next!.next;
        }
        return dummyHead.next;
    }
    
    // MARK: - TODO 23. Merge k Sorted Lists (HARD)
    
    
    // MARK: - 22. Generate Parentheses
    func generateParenthesisHelper(_ n: Int, _ leftCount : Int, _ rightCount : Int, _ partial : String, _ result : inout [String]) {
        
        var leftCount = leftCount, rightCount = rightCount;
        if leftCount == 0 && rightCount == 0 {
            result.append(partial);
            return;
        }
        
        if leftCount < rightCount {
            generateParenthesisHelper(n, leftCount, rightCount - 1, partial + ")", &result);
        }
        
        if leftCount > 0 {
            generateParenthesisHelper(n, leftCount - 1, rightCount, partial + "(", &result);
            
        }
    }
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]();
        generateParenthesisHelper(n, n, n, "", &result);
        return result;
    }
    
    // MARK: - 21. Merge Two Sorted Lists
    func mergeTwoLists(_ l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        
        if l1 == nil { return l2; }
        if l2 == nil { return l1; }
        
        var l1 = l1;
        var l2 = l2;
        var result : ListNode? = nil;
        var itr : ListNode? = nil;
        
        while l1 != nil && l2 != nil {
            var next : ListNode? = nil;
            if l1!.val < l2!.val {
                next = l1; l1 = l1!.next;
            } else {
                next = l2; l2 = l2!.next;
            }
            result = (result == nil) ? next : result;
            itr = (itr == nil) ? result : itr;
            itr!.next = next;
            itr = next;
        }
        itr!.next = (l1 == nil) ? l2 : l1;
        return result;
    }
    
    // MARK: - 20. Valid Parentheses
    func isMatch(_ lhs : Character, _ rhs : Character) -> Bool {
        if lhs == "{" && rhs == "}" { return true; }
        if lhs == "(" && rhs == ")" { return true; }
        if lhs == "[" && rhs == "]" { return true; }
        
        return false;
    }
    func isValid(_ s: String) -> Bool {
        let chars = Array(s.characters);
        var stack = [Character]()
        for char in chars {
            if ["(", "{", "["].contains(char) {
                stack.append(char);
            } else{
                if stack.count == 0 || !isMatch(stack.last!, char) {
                    return false;
                }
                stack.removeLast()
            }
        }
        return stack.count == 0;
    }
    
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
    
    // MARK: - TODO 18. 4Sum
    func fourSum(_ nums: [Int], _ target: Int) -> [[Int]] {
        var result =  [[Int]]()
        return result;
    }
 
    
    // MARK: - 17. Letter Combinations of a Phone Number
    func letterCombinationsHelper(_ digits: String, _ partial : String, _ pos : Int, _ map : [Character : String], _ result : inout [String])
    {
        if pos == digits.characters.count {
            result.append(partial);
            return;
        }
        let chars = Array(digits.characters);
        let mappedChars = Array(map[chars[pos]]!.characters)
        for char in mappedChars {
            letterCombinationsHelper(digits, partial + String(char), pos + 1, map, &result);
        }
    }
    func letterCombinations(_ digits: String) -> [String]
    {
        var result = [String]()
        guard digits.characters.count > 0 else { return result; }
        let map : [Character : String] = ["0" : "0", "1" : "1", "2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"];
        letterCombinationsHelper(digits, "", 0, map, &result);
        return result;
    }
    
    // MARK: - 16. 3Sum Closest
    
    
    // MARK: - 15. 3Sum
    func threeSum(_ nums: [Int]) -> [[Int]] {
        let sorted = nums.sorted();
        var result = [[Int]]()
        var index = 0;
        while index < sorted.count {
            
            var left = index + 1, right = sorted.count - 1;
            while left < right {
                
                let sum = sorted[index] + sorted[left] + sorted[right];
                if  sum == 0 {
                    result.append([sorted[index], sorted[left], sorted[right]]);
                    while left < right && sorted[left] == sorted[left + 1] { left += 1; }
                    while left < right && sorted[right] == sorted[right - 1] { right -= 1; }
                    left += 1; right -= 1;
                } else if sum > 0 {
                    right -= 1;
                } else {
                    left += 1;
                }
            }
            index += 1;
            while index < sorted.count && sorted[index] == sorted[index - 1] { index += 1; }
        }
        return result;
    }
    
    // MARK: - 14. Longest Common Prefix (EASY)
    
    // MARK: - 13. Roman to Integer
    func romanToInt(_ s: String) -> Int
    {
        let map : [Character : Int] = ["M" : 1000, "C" : 100, "D" : 500, "L" : 50, "X" : 10, "V" : 5, "I" : 1];
        
        var sum = 0;
        var lastHighest = 0;
        let chars = Array(s.characters);
        for char in chars.reversed()
        {
            let val = map[char]!;
            if val < lastHighest
            {
                sum -= val;
            }
            else
            {
                sum += val;
            }
            lastHighest = max(lastHighest, val);
        }
        return sum;
    }
 
    func romanToInt2(_ s: String) -> Int
    {
        let map : [Character : Int] = ["M" : 1000, "C" : 100, "D" : 500, "L" : 50, "X" : 10, "V" : 5, "I" : 1];
        
        
        var sum = 0;
        let chars = Array(s.characters);
        var ix = chars.count - 1;
        
        sum = map[chars[ix]]!;
        ix -= 1;
        while ix >= 0
        {
            let val = map[chars[ix]]!;
            if val < map[chars[ix + 1]]!
            {
                sum -= val;
            }
            else
            {
                sum += val;
            }
            ix -= 1
        }
        return sum;
    }
    
    // MARK: - 12. Integer to Roman
    func intToRoman(_ num: Int) -> String
    {
        let M = ["", "M", "MM", "MMM"];
        let C = ["", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"];
        let X = ["", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"];
        let I = ["", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"];
        
        return "\(M[num/1000])\(C[(num%1000)/100])\(X[(num%100)/10])\(I[num%10])"
    }
    
    // MARK: - 11 Container With Most Water (MEDIUM)
    func maxArea(_ height: [Int]) -> Int {
        guard height.count > 0 else { return 0; }
        var maxVal = 0;
        var i = 0, j = height.count-1;
        
        while (i < j) {
            maxVal = max(maxVal, (j-i) *  min(height[i], height[j]));
            
            if (height[i] < height[j]) {  // should move i
                var k = i + 1; while k < j && height[k] <= height[i] { k += 1; }
                i = k;
            } else {  // should move j
                var k = j - 1; while k > i && height[k] <= height[j]  { k -= 1; }
                j = k;
            }
        }
        return maxVal;
    }
    
    // MARK: - TODO 10. Regular Expression Matching (HARD)
    
    
    // MARK: - 9. String to Integer (atoi)
    func isPalindrome(_ x: Int) -> Bool
    {
        guard x >= 0 else { return false; }
        let numDigits =  x == 0 ? 1 : Int(log10(Double(x))) + 1;
        var x = x;
        var pow10 = Int(pow(10.0, Double(numDigits - 1)));
        
        while x != 0
        {
            let msd = x / pow10;
            let lsd = x % 10;
            if msd != lsd {
                return false;
            }
            x %= pow10;
            x /= 10;
            pow10 /= 100;
        }
        return true;
    }
    
    // MARK: - 8. String to Integer (atoi)
    
    // MARK: - 7. Reverse Integer
    func reverse(_ x: Int) -> Int {
        var x = x;
        let isNeg = x < 0 ? true : false;
        x = isNeg ? -x : x;
        var reversed = 0;
        
        while x != 0 {
            reversed *= 10;
            reversed += (x % 10);
            x /= 10;
        }
        if reversed > Int(Int32.max) { return 0 }
        
        return isNeg ? -reversed : reversed;
    }
    
    // MARK: - TODO 6. ZigZag Conversion (MEDIUM)
    
    
    // MARK: - 5. Longest Palindromic Substring
    func longestPalindromeHelper(_ s: String, left: Int, right : Int) -> (Int, Int, Int) {
        
        var left = left, right = right;
        let chars = Array(s.characters);
        var maxLen = 1;
        
        while left >= 0 && right < chars.count && chars[left] == chars[right] {
            maxLen = max(maxLen, right - left + 1);
            left -= 1;
            right += 1;
        }
        return (maxLen, left + 1, right - 1);
    }
    
    func longestPalindrome(_ s: String) -> String {
        let chars = Array(s.characters);
        var maxLen = 1, maxLeft = 0, maxRight = 0;
        
        for (index, _) in chars.enumerated() {
            var (newLen, newLeft, newRight) = longestPalindromeHelper(s, left: index, right : index);
            if newLen > maxLen {
                maxLen = newLen;
                maxLeft = newLeft; maxRight = newRight;
            }
            (newLen, newLeft, newRight) = longestPalindromeHelper(s, left: index, right : index + 1);
            if newLen > maxLen {
                maxLen = newLen;
                maxLeft = newLeft; maxRight = newRight;
            }
        }
        return String(chars[maxLeft...maxRight]);
    }

    func longestPalindrome2(_ s: String) -> String
    {
        guard (s.characters.count > 1) else { return s; }
        
        var min_start = 0, max_len = 1, max_end = 0;
        var i = 0;
        let chars = Array(s.characters);
        while i < chars.count {
            if (chars.count - i <= max_len / 2) { break; }
            
            var j = i, k = i;
            while (k < chars.count - 1 && chars[k+1] == chars[k]) {
                k += 1; // Skip duplicate characters.
            }
            
            i = k+1;
            while (k < chars.count - 1 && j > 0 && chars[k + 1] == chars[j - 1]) {
                k += 1; // Expand.
                j -= 1;
            }
            let new_len = k - j + 1;
            if (new_len > max_len) {
                min_start = j; max_len = new_len; max_end = k;
            }
        }
        return String(chars[min_start...max_end]);
    }
    
    // MARK: - TODO 4. Median of Two Sorted Arrays (HARD)
    func findMedianSortedArrays(_ nums1: [Int], _ nums2: [Int]) -> Double {
        var d = 0.0;
        return d;
    }
    
    // MARK: - 3. Longest Substring Without Repeating Characters
    func lengthOfLongestSubstring(_ s: String) -> Int {
        guard s.characters.count > 0 else { return 0; }
        var lastOccurence = [Character : Int]();
        
        var startOfLongest = 0;
        var maxLen = 1;
        let chars = Array(s.characters);
        
        lastOccurence[chars[0]] = 0;
        for (index, char) in chars.enumerated() {
            if index == 0 { continue; }
            
            maxLen = max(maxLen, index - startOfLongest);
            
            if let value = lastOccurence[char] {
                // IMP: only update startOfLongest if lastOccurence of this char
                // is after startOfLongest
                startOfLongest = max(startOfLongest, value + 1);
            }
            lastOccurence[char] = index
            
        }
        maxLen = max(maxLen, chars.count - startOfLongest);
        return maxLen;
    }
    
    // MARK: - 2. Add Two Numbers represented as Linked Lists
    /*
    func addTwoNumbers(l1: ListNode?, _ l2: ListNode?) -> ListNode? {
        var result:ListNode? = ListNode(0);
        let dummyHead = result;
        
        var itr1 = l1
        var itr2 = l2
        var carry = 0
        while (itr1 != nil || itr2 != nil) {
            let sum = (itr1?.val ?? 0) +  (itr2?.val ?? 0) + carry
            result?.next = ListNode(sum % 10);
            carry = sum / 10
            result = result?.next
            itr1 = itr1?.next;
            itr2 = itr2?.next;
        }
        
        if carry != 0 {
            result?.next = ListNode(carry)
        }
        
        return dummyHead?.next
    }
    */
    
    // MARK: - 1. Two Sum
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var result = [Int]();
        var map = [Int : Int]();
        
        for (index, value) in nums.enumerated() {
            map[value] = index;
        }
        
        for (index, value) in nums.enumerated() {
            
            let diff  = target - value;
            if let stored = map[diff],
                stored != index {
                result.append(index)
                result.append(stored)
                return result;
            }
        }
        
        return result;
    }
}


// MARK: - ========= Tests ===============

//let parser = Parser();
//let result = parser.decode("bce12xac10x1e5xgf11x");
//print(result);

/*
let dfs = DFS();

let count = dfs.numIslands([["1", "1", "1", "1", "0"],
                ["1", "1", "0", "1", "0"],
                ["1", "1", "0", "0", "0"],
                ["0", "0", "0", "0", "0"]]
);
print(count);
*/

// let str = Strings()
//let simplified = str.simplifyPath("/abc/...")
// print(simplified)

//let ht = Hashtables()
// print(ht.findWords2(["Hello","Alaska","Dad","Peace"]))

let arrays = Arrays()
print(arrays.maxProduct([6,-5,-1,5,1,6,-5,-1,2,4,-2,-6,0,2,1,-6,1,6,-6,-3,4,1,1,0,6,2,0,1,-4,0,-1,1,5,-1,2,4,1,1,5,0,2,-6,2,0,-2,5,4,1,5,2]));




