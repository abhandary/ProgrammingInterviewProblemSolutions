//
//  main.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 9/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

import Foundation


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
};

class Solution {
    
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
    
    // MARK: - 397. Integer Replacement
    // https://discuss.leetcode.com/topic/58454/0-ms-c-recursion-solution-with-explanation/2
    
    var res = 0;
    func integerReplacement(n: Int) -> Int {
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
    
    func maxRotateFunction(A: [Int]) -> Int {
        guard A.count > 0 else { return 0 }
        if A.count == 0 { return A[0] }
        
        var F = 0, allSum = 0;
        for (ix, element) in A.enumerate() {
            F += ix * element;
            allSum += element;
        }
        var maxSum = F;
        for ix in (1..<A.count).reverse() {
            F = F + allSum - A.count * A[ix];
            maxSum = max(maxSum, F);
        }
        return maxSum;
    }
    
    
    
    // MARK: - 395. Longest Substring with At Least K Repeating Characters
    // 1. in the first pass I record counts of every character in a hashmap
    // 2. in the second pass I locate the first character that appear less than k times in the string. this character is definitely not included in the result, and that separates the string into two parts.
    // 3. keep doing this recursively and the maximum of the left/right part is the answer.
    func longestSubstring(s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
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
        
        let left = longestSubstring(s.substringToIndex(s.startIndex.advancedBy(ix)), k)
        let right = longestSubstring(s.substringFromIndex(s.startIndex.advancedBy(ix)), k)
        return max(left, right)
    }

    func longestSubstring2(s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        guard slen > 0 && slen >= k else {
            return 0
        }
        
        var myMap = [Character: Int]()
        s.characters.forEach{ myMap[$0] = (myMap[$0] ?? 0) + 1  }
        
        let minElement = myMap.values.minElement()!
        if  minElement >= k {
            return s.characters.count
        }

        let minChar = myMap.filter{$0.1 ==  minElement}.map{return $0.0}.first
        let lines = s.componentsSeparatedByString(String(minChar))
        
        return lines.reduce(0) { max($0, longestSubstring($1, k))}
    }

    func longestSubstring3(s: String, _ k: Int) -> Int {
        
        let slen = s.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        guard slen > 0 && slen >= k else {
            return 0
        }
        
        var myMap = [Character: Int]()
        s.characters.forEach{ myMap[$0] = (myMap[$0] ?? 0) + 1  }
        
        let minElement = myMap.values.minElement()!
        if  minElement >= k {
            return s.characters.count
        }
        
        let minChar = myMap.filter() {$0.1 ==  minElement}.map() {return $0.0}.first
        let range = s.rangeOfString(String(minChar))

        
        let left = longestSubstring(s.substringToIndex(range!.first!), k)
        let right = longestSubstring(s.substringFromIndex(range!.first!), k)
        return max(left, right)
    }
    

    
    
    // MARK: - 394. Decode String (Accepted)
    func decodeStringHelper( inout pos : Int, s : String) ->String {
        var num = ""
        var result = ""
        
        let schars = Array(s.characters)
        let slen = s.lengthOfBytesUsingEncoding(NSUTF8StringEncoding)
        
        while pos < slen {
            let currentStr = String(schars[pos])
            switch schars[pos++] {
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
        }
        return result;
    }
    

    func decodeString(s: String) -> String {
        var pos = 0
        return decodeStringHelper(&pos, s: s);
    }
    
    // MARK: - 393. Validate UTF8 (Accepted)
    func validUtf8(data: [Int]) -> Bool {
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
                count--;
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
    func lengthLongestPath(input: String) -> Int {
        var pathLen = [0:0]
        var maxLen = 0
        let lines = input.componentsSeparatedByString("\n")
        for line in lines {
            let name = line.stringByReplacingOccurrencesOfString("\t", withString: "")
            let depth = line.characters.count - name.characters.count
            if name.containsString(".") {
                maxLen = max(maxLen, pathLen[depth]! + name.characters.count)
            } else {
                pathLen[depth + 1] = pathLen[depth]! + name.characters.count + 1
            }
        }
        return maxLen
    }
    
    // MARK: - 387. First Unique Character in a String (Timed Out??)
    func firstUniqChar(s: String) -> Int {
        var myMap = [Character : Int]()

        s.characters.forEach { myMap[$0] = (myMap[$0] ?? 0) + 1}

        for (index,element) in s.characters.enumerate() {
            if myMap[element] == 1 {
                return index
            }
        }
        return -1
    }
    
    // MARK: - 386. Lexicographic Numbers
    func lexicalOrder(n : Int) -> [Int] {
        var list = [Int]();
        var curr = 1;
        for _ in 1...n {
            list.append(curr)
            if (curr * 10 <= n) {
                curr *= 10;
            } else if (curr % 10 != 9 && curr + 1 <= n) {
                curr++;
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
    func parseNumber(s : String, inout pos : Int) -> Int {

        var isPos = true
        if s[s.startIndex.advancedBy(pos)] == "-" {
            isPos = false
            pos++
        }
        var num = 0
        while pos < s.characters.count,
            let value = Int(String(s[s.startIndex.advancedBy(pos)]))  {
                
            num = num * 10 + value
            pos++
        }
        
        return isPos ? num : -num
    }
    
    func parseList(s : String, inout pos : Int) -> NestedInteger {
        let result = NestedInteger()
        pos++ // eat "["

        loop: while pos < s.characters.count {
            switch s[s.startIndex.advancedBy(pos)] {
            case "[":
                let ni = parseList(s, pos: &pos)
                result.list.append(ni)
            case "0"..."9", "-":
                let number = parseNumber(s, pos: &pos)
                result.value = number
            case "]":
                pos++ // eat "]"
              break loop
            default:
                pos++ // eat "," and anything else
                break
            }
        }

        return result
    }
    
    func deserialize(s : String) -> NestedInteger? {
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
    func canConstruct(ransomNote: String, _ magazine: String) -> Bool {
        var myMap = [Character : Int]()
        ransomNote.characters.forEach { myMap[$0] = (myMap[$0] ?? 0) + 1  }
        for element in magazine.characters {
            if let value = myMap[element] {
                myMap[element] = value - 1
                if value == 1 {
                    myMap.removeValueForKey(element)
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
    func helper( inout array : [Int], _ k : Int) -> Int {
        let pivotIx = array.count / 2;
        let pivot = array[pivotIx];
        
        swap(&array[0], &array[pivotIx]);
        var smaller = 1;
        for (index, element) in array.enumerate() {
            if element < pivot {
                swap(&array[smaller++], &array[index]);
            }
        }
        swap(&array[smaller], &array[0]);
        if smaller + 1 == k {
            return array[smaller];
        }
        return -1;
    }
    
    func kthSmallest(matrix: [[Int]], _ k: Int) -> Int {
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
    func combinationSum4(nums: [Int], _ target: Int) -> Int {
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
    func wiggleMaxLength(nums: [Int]) -> Int {
        if nums.count <= 1 {
            return nums.count;
        }
        var nums = nums;
        var k = 0;
        while k < nums.count - 1 && nums[k] == nums[k + 1] {
            k++;
        }
        if k == nums.count - 1 {
            return 1;
        }
        var smallReq = nums[k] < nums[k + 1];
        var result = 2;
        while k < nums.count - 1 {
            if smallReq && nums[k + 1] < nums[k] {
               // nums[result] = nums[k + 1];
                result++;
                smallReq = !smallReq;
            } else if !smallReq && nums[k + 1] > nums[k] {
                //nums[result] = nums[k + 1];
                result++;
                smallReq = !smallReq;
            }
            k += 1;
        }
        return result;
    }
    
    // MARK: - 375. Guess Number Higher or Lower II
    var moneyDP : [[Int]]!;
    // To find out how much money I need to win the range lo..hi (the game starts with the range 1..n), I try each possible x in the range (except hi, which is pointless because hi-1 costs less and provides more information), calculate how much I need when using that x, and take the minimum of those amounts.
    // https://discuss.leetcode.com/topic/51353/simple-dp-solution-with-explanation
    func moneyHelper(s : Int, _ e : Int) -> Int {
        
        if s >= e { return 0; }
        
        if self.moneyDP[s][e] != Int.max {
            return self.moneyDP[s][e]
        }
        
        for ix in s...e {
            self.moneyDP[s][e] = min(self.moneyDP[s][e], ix +  max(moneyHelper(s, ix - 1), moneyHelper(ix + 1, e)));
        }
        return self.moneyDP[s][e];
    }
    
    func getMoneyAmount(n: Int) -> Int {
        self.moneyDP = [[Int]](count : n + 1, repeatedValue : [Int](count : n + 1, repeatedValue : Int.max));
        return moneyHelper(1, n);
    }
    
    
    // MARK: - 374. Guess Number Higher or Lower
    func guess(num : Int) -> Int {
        return 0;
    }
    
    func guessNumber(num : Int) -> Int {
        
        var low = 0;
        var high = 0;
        var mid = num >> 1;
        var nextGuess = 0;
        
        while guess(mid) != 0 {
            nextGuess = guess(mid)
            if nextGuess < 0 {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
            mid = low + (high - low) / 2;
        }
        return mid;
    }
    

    // 373. Find K Pairs with Smallest Sums
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
 
    // 372. Super Pow
    // https://discuss.leetcode.com/topic/50489/c-clean-and-short-solution
    func power(a : Int, _ k : Int) -> Int  // 0 <= k <= 10
    {
        var result = 1;
        for _ in 0..<k {
            result = (result * a) % 1337;
        }
        return result;
    }
    func superPow(a: Int, _ b: [Int]) -> Int {
        if b.count == 0 {
            return 1;
        }
        var b = b;
        let last = b.removeLast();
        return  power(superPow(a, b), 10) * power(a, last) % 1337;
    }
    
    // 371. Sum of Two Integers.
    func getSum(a: Int, _ b: Int) -> Int {
        return b==0 ? a : getSum(a^b, (a&b)<<1);
    }
    
    // 368. Largest Divisible Subset
    /* https://discuss.leetcode.com/topic/49455/4-lines-in-python
     */
    //def largestDivisibleSubset(self, nums):
    //  S = {-1: set()}
    //  for x in sorted(nums):
    //  S[x] = max((S[d] for d in S if x % d == 0), key=len) | {x}
    //  return list(max(S.values(), key=len))
    
    
    
    // 367. Valid Perfect Square
    func isPerfectSquare(x: Int) -> Bool {
        var r = x;
        while (r * r > x) {
            r = (r +  x / r) / 2;
        }
        return r * r == x;
    }
    
    func isPerfectSquare2(x: Int) -> Bool {
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
    
    // 365. Water and Jug Problem
    /* https://discuss.leetcode.com/topic/49238/math-solution-java-solution
     */
    func GCD(x : Int, _ y : Int) -> Int {
        var a = x, b = y;
        
        while b != 0 {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
    func canMeasureWater(x: Int, _ y: Int, _ z: Int) -> Bool {
        if x + y < z {
            return false;
        }
        if x == z || y == z || x + y == z {
            return true;
        }
        return z % GCD(x, y) == 0;
    }
    
    // 357. Count Numbers with Unique Digits
    // sequence counting problem
    // https://discuss.leetcode.com/topic/47983/java-dp-o-1-solution
    func countNumbersWithUniqueDigits(n: Int) -> Int {
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
    
    // 350. Intersection of Two Arrays II
    func intersect2(nums1: [Int], _ nums2: [Int]) -> [Int] {
        var map1 = [Int : Int]();
        nums1.forEach { map1[$0] = (map1[$0] ?? 0) + 1};
        
        return nums2.filter {
            if let num = map1[$0] where num > 0 {
                map1[$0] = num - 1;
                return true;
            }
            return false;
        }
    }
   
    // 349. Intersection of Two Arrays.
    func intersection(nums1: [Int], _ nums2: [Int]) -> [Int]
    {
        let set1 = Set<Int>(nums1)
        let set2 = Set<Int>(nums2)
        return set2.filter() { return set1.contains($0)}
    }
    
    // 345. Reverse Vowels of a String
    func isVowel(_ c : Character) -> Bool {
        if ["a", "e", "i", "o", "u", "A", "E", "I", "O", "U"].contains(c) {
            return true;
        }
        return false;
    }
    
    func reverseVowels(s: String) -> String
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
    
    // 344. Reverse String
    func reverseString(s: String) -> String {
        var chars = Array(s.characters);
        var left = 0, right = chars.count - 1;
        
        while left < right {
            swap(&chars[left], &chars[right]);
            left += 1; right -= 1;
        }
        return String(chars);
    }
    
    // 342. Power of Four
    func isPowerOfFour(_ num: Int) -> Bool {
        let n = num;
        return n > 0 && (n & (n - 1)) == 0 && (n & 0x55555555) > 0;
    }
    
    // 326. Power of Three
    // https://discuss.leetcode.com/category/406/power-of-three
    func isPowerOfThree(_ n: Int) -> Bool {
        return ( n > 0 &&  (1162261467 % n) == 0);
    }
    
    // 303. Range Sum Query - Immutable
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
    
    func initWithNums(nums : [Int]) {
        preComputedRangeSum[-1] = 0;
        var sum = 0;
        array = nums;
        for (ix, element) in nums.enumerate() {
            sum += element;
            preComputedRangeSum[ix] = sum;
        }
    }
    
    func sumRange(i i : Int, j : Int) -> Int {
        
        guard i <= array.count && j <= array.count else {return 0; };
        
        if let x = preComputedRangeSum[i - 1],
            y = preComputedRangeSum[j] {
            
            return y - x;
        }
        return 0;
    }
    
    // 257. Binary Tree Paths
    func bthelper(root : TreeNode, inout _ result : [String], _ partial : String) {
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
    
    func binaryTreePaths(root : TreeNode?) -> [String] {
        var result = [String]();
        if let root = root {
            bthelper(root, &result, "");
        }
        return result;
    }

    // 283. Move Zeroes
    func moveZeroes(inout nums:  [Int]) {
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
    
    func moveZeroes2(inout nums:  [Int]) {
        
        guard nums.count > 0 else { return; }
        var zeroCount = 0;
        nums[0...2] = [1, 2, 3];
        nums = nums.filter() {
            if $0 == 0 {
                zeroCount += 1;
            }
            return $0 != 0;
        }
        nums.appendContentsOf([Int](count: zeroCount, repeatedValue: 0));
    }
    
    // 242. Valid Anagram
    func isAnagram(s: String, _ t: String) -> Bool {
        let a1 = Array(s.characters);
        let a2 = Array(t.characters);
        return String(a1.sort()) == String(a2.sort());
    }
    
    // 241. Different Ways to Add Parentheses
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
        
        for (index, char) in input.characters.enumerate() {
            if ["*", "-", "+"].contains(char) {
                let left = diffWaysToCompute(input.substringToIndex(input.startIndex.advancedBy(index)));
                let right = diffWaysToCompute(input.substringFromIndex(input.startIndex.advancedBy(index + 1)));
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
    
    // 240. Search a 2D Matrix 2
    // https://leetcode.com/problems/search-a-2d-matrix-ii/
    func searchMatrix(matrix: [[Int]], _ target: Int) -> Bool {
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
    
    // 238. Product of Array Except Self
    // https://discuss.leetcode.com/topic/18864/simple-java-solution-in-o-n-without-extra-space
    func productExceptSelf(nums: [Int]) -> [Int] {
        var result = [Int](count:nums.count, repeatedValue: 1)
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
    
    
}


let soln = Solution()
// MARK: - 395 Tests
let longStr = "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
    
print("Longest Substring: \(soln.longestSubstring2("aaabb", 3))")
print("Longest Substring: \(soln.longestSubstring2("ababbc", 2))")
print("Longest Substring: \(soln.longestSubstring2("weitong", 2))")
// print("Longest Substring: \(soln.longestSubstring(longStr, 1))")

// MARK: - 394 Decode String
print("Decoded String for 3[a]2[bc] : \(soln.decodeString("3[a]2[bc]"))")
print("Decoded String for 3[a2[c]] : \(soln.decodeString("3[a2[c]]"))")
print("Decoded String for 2[abc]3[cd]ef : \(soln.decodeString("2[abc]3[cd]ef"))")

let longStr2 = "dsmdcvqhdcdqbajaaeckaodnaitdfvakuplkumriardkdhruunttvwqbgfkaxorrgxxhwxmqjfumwefbggvguomxmtvagslokskcngthnomwcixpgoclopxajcfnixophbslmkvmvvmhwcgvtvicdijegsqfqisvodrjqkjaajnadcrffdrssjsdsmpjmkaxwiogeoruxdfkqrkvgreuecdmghljfxoxiriiwguokrgconigtxarqmkbrdkfcwvdenriglcgqfodnjlqxtpgxwrqerwnlxombmqwoudwsghmecdsahawqqocpiwisdhsawnbtcxehnimlkivwcliutlpjacxvbsnamadpuwcqjamticccvatcgwosrrsebgmcvrcsciwvkreuujpegpqmbrbeunriecjfcixmefqvrkmnhoetibphftgmqfeaaqssrostdwsivtdhqptpaeqvrdonwbcwqxiqubskobspwmdbanssqjconlrnnjvxjxdqdkbpfxkcmvkufbtshbhkbcomfntnfissvknlrrqiihjirjexnkfhgaxtgwnalsxvchhnrnnsjaiumxnsdvfitnscjskaevqsslxgfvqppbwamjakqdhlrriqvsudhjgigmvfoitidcfwdrmqmtcawvrosxruegriemitdfmvemdlboimqmqjnpftbptrlfrrxrsxmgenlnjseinvtahdliuirmpdvmvmmnrcccdqopxbogtenoijcrfukuajjmpjnxwemrbipavagksaggdarijavbndhgvpbhrustgknckavljkhiadapaejjfdiaiprvjsuajbrmxjbjkkpeoiqmspowrhtmaimbiidqlskgfkfudpxcphajhrfpchaautklutoteiahrlgfvrocbjiewtvmfuqgnhddwoojebujgowchbeengipavwnnnsvmvirgxjttfetlqeetpbalnjrvpqcimofhnawegbxqwlvhuamxcwxsplkfhudiguogoeqpmoofrwilalqvdcpudmcqajilnfqtqsiabobaqhchemjlcnbxcorfqabcbadveehiudwctvedblacniweeaxoiahukghtsstuovhccqopxberhsmlqsebpjqdgoeobsgxgsdcejrkfnekwdvtonqhvdnnqqsokopqfejqbhlfmhklluawpalxmppewejknffgstlfksnjlivvfmfcdewtrmevrdkejiskwvarplitlpvavdlibhprhkglaudkgwnmbeqmhbdgdecekseqctqleclftpvvfxoesxtwdmnrehuqvhpkfqpxicnkenrfgufkkxbocvadwrlgnvufduwnenllrvgcqtsvqccfvtdvajxutrtkmjdhiafbshtumxvovsgllggxtqatxfmchpiddftjiekcjfofapvanpbjwmodqqxlvuudgdngstcfixnkkaiedmuccprlhcvnfshnillokedfbudncffwuihugrsfdmusqqassmntfhmctuwnrwoqjasnlbhxvnfqnpjbuwtdvfhmgahmhujirovgjxksmgravwjunrvhcflslxhidwipfjapplbgjvgtpnijnwtoeqancjekwebeujdpnngcmmwoumhbomgcrfpgchirphgjpxhafgiqmcxuemumflejmmgceicxhovuvcsqmowgbitlweikveonlvgmqmbcwbqopcgintsnufbfdfdctovtgjpdnexmtigxnqjighdvfbbakvwgkbxophcgthlcoehpodfixrjgmftveohmiogfdxvgtvnhqetwldahjsuhpahtaqavferhncklvofsrrklljuglbecjkvmpbhbclincppfqddsqsepxeqoxgbfqlfwjdgxxmcavogdftxjgpjkheuecblruexkfnmrlwbfeqgxlhbfkqcukkadxlcoxmtalaqfhreppewxlvrgnwvnamekdthlwerqnlueknlmpcqefaaghadmsnaqbjacmkjkiwxgnlwoekloineuxwfsqcuwxohjoievpcjdicftnnxmmoopfbbpbvqenrkbhwqcqwkcsdbmdcealchicabdgvesectcnkprdskuluianssacrvxgdtoocriecquqopkjgjsuptjuebnuusertrqsnffeqlgjcknklprfudvqakhgsugrpcqsfbknmtbquxrvafmfcwgaglgllnhrpvxvsoagxhfuofpsnrcfjwrepnbbxefpeefdvkuqarsoxwqdtekvjbjwcbsahbjtnokonpbkpiivqbbgrxvmsjvlxfpbcedwclndkeonempcqovlpilcfmegptjejnsiltqnnasringuxvdtojeicupurbpatmaqrwjkfnofsdwefoknfqaoxqxqfrdwiblhtmrksckklphslrtsehwlwqbamcdnammeswigepwhspbfqgwsmvpqomqmvlrwuntiukggmebnpudgfgleecleamdfaotbtepddbsjrrvtsghejxrjmncilardwsrvwkkmpevhewikegdamckanaulxitnfxfsdnsuorxsmddkusibgqesvkqwmujeqvvkupqkkcipbaockmwqaxixgeibdvdpuetsrweotvarlgqkplnnbrwgzmkttjihlevvqmgchmpoltlucgmhrevhslxnurjmenmidxfeqgmwaifndxegikhderhgpoxvpipwsbtefciskoxikfgehsckgwjplwqkftantbgtxslkctbkiqpggmpdrlwhilunfxffqhpbvffnpjdgepsxdxghmwhxhtvlpfxqadonhlvmjhekhugvqnhgxbkhxqjpedglevkpwmfgbufoaxsaufbpdkhwircgdtcqtfvjqqlmospupwprqhgspdqvtwwtuulpnlvixhqfaqhjmcfisumqldedgpneaniasplhlcucxgaaaduuvcmrajcrmejrgisrdjhudxoleujwsjevocwenxdgsfrtoernxbrxphixgcjwdnunhmjcsuhlssusbrnswqqjxdahgqrwbnvshbhspivplllffporruvkurhcdorwolpegxgvndxtoigfngtbxxrbnlfrvnjhkfkunaxktvdprjfboovsqxjxkpsdulrjlyobdskckgksgxpssxmgfoadupfrjrildjcmihwvjwunnqfaqrilfknokcqsdaxgjtifffvkaorxufqcaerrafhhehrqcgxboswtboncxmjrvhoatrxjpgphsqrqhnvfrofhmjhuprlciuxmqgbdbfvonuierderspuiggdjpwqltontxvigwcblelnuicdwsvfpafrqpramaewqrmukonlpqfchnrbepaoujoqcimdmxwuavvfaswsjqknwxppsliigkbjxjfaegdvwdwcibfhkecprw"

// MARK: - 387. First Unique Character in a String
print("First Unique : \(soln.firstUniqChar("leetcode"))")
print("First Unique : \(soln.firstUniqChar(longStr2))")

// MARK: - 386. Lexical Order
print("Lexical Order: \(soln.lexicalOrder(13))");

print("Hello, World!")

// MARK: - 385. Mini Parser
let result = soln.deserialize("[123,[456,[789]]]")
print("mini parser: \(result)")

// MARK: - 383. Ransom Note
print("Ransom Note: \(soln.canConstruct("aac", "aab"))")


// MARK: - 377. Combination Sum IV
print("combination sum 4: \(soln.combinationSum4([4, 2, 1], 32))");

// MARK: - 372. Super Pow
print("super pow: \(soln.superPow(2,[3]))");

print("super pow: \(soln.superPow(4978626, [9,6,7,6,8,3,8,9,5,6,8,2,8,7,1,8,1,9,7,0,1,5,6,8,4,0,1,8,4,2,5,9,8,4,5,9,8,5,8,5,2,8,9,0,6,2,0,9,1,8,9,4,5,7,5,1,8,6,1,4,8,6,3,9,1,1,0,1,6,8,8,0,8,7,1,4,9,3,4,2,3,5,7,8,3,2,1,3,0,3,7,0,1,3,9,4,6,1,5,4,1,5,5,0,4,8,4,5,1,0,8,5,6,7,5,1,1,9,4,1,2,3,1,3,8,3,8,6,4,5,1,8,3,6,8,7,6,2,3,7,5,3,4,1,0,0,2,3,9,8,4,3,1,7,8,2,2,8,8,9,6,9,7,9,7,5,8,3,9,3,3,4,6,9,7,8,1,1,1,2,9,7,5,3,5,6,5,9,4,3,8,0,3,7,1,2,4,0,8,6,3,3,2,2,2,0,0,4,1,4,6,3,1,4,6,8,0,1,0,4,4,0,7,9,8,0,4,2,0,2,0,6,5,3,8,7,3,0,3,6,6,2,9,8,6,7,8,6,8,8,2,5,9,1,6,7,2,0,1,4,2,4,2,7,7,2,7,2,5,2,0,1,4,0,1,2,9,0,0,8,8,3,5,9,6,1,8,0,2,2,7,4,6,9,4,3,4,3,5,9,7,5,2,2,7,4,4,7,4,5,7,4,0,2,4,8,5,2,1,7,4,8,4,0,9,0,5,5,5,2,4,2,0,7,6,9,1,1,8,7,8,5,1,0,9,5,0,7,0,1,4,6,1,0,7,3,0,4,8,5,7,3,8,9,2,4,8,5,7,7,2,7,4,5,9,6,3,2,3,3,5,7,9,7,8,8,2,0,3,0,6,2,5,6,1,7,2,1,4,0,8,6,9,5,4,1,1,7,3,4,0,8,3,1,7,3,0,9,6,5,0,4,9,5,0,0,5,2,1,9,4,2,8,4,7,2,5,0,9,0,6,1,8,1,4,6,5,4,5,3,1,7,7,0,5,7,2,0,1,6,1,6,8,1,2,7,3,9,7,4,9,3,7,9,4,2,7,1,8,5,4,2,2,1,2,7,0,7,9,2,3,3,0,3,4,2,0,8,3,7,4,2,0,2,3,6,6,1,8,4,6,4,8,8,6,1,8,8,0,9,2,3,2,2,6,7,6,6,5,9,5,1,1,5,5,7,3,1,8,1,8,4,6,6,4,4,9,2,4,9,2,7,4,4,9,0,1,6,8,8,5,3,2,9,0,7,6,4,1,4,5,1,0,3,7,4,9,9,7,4,0,1,1,5,5,0,5,9,8,6,9,4,9,1,5,2,1,3,6,2,9,3,3,9,7,2,3,6,1,2,2,2,3,3,9,1,6,6,2,4,2,1,0,4,5,7,6,6,0,2,0,9,5,3,8,4,7,4,3,1,6,5,5,2,9,4,5,7,0,9,1,5,2,4,9,7,1,5,5,2,9,5,3,4,0,4,1,8,8,4,1,6,1,6,0,2,0,7,9,2,6,1,7,9,7,6,8,8,3,4,2,2,1,6,9,2,2,0,2,0,6,3,8,7,1,1,0,1,8,9,5,5,2,3,6,9,1,4,0,5,0,2,9,2,0,0,6,2,2,0,4,8,3,5,8,4,6,0,7,6,1,4,1,6,7,9,5,1,6,7,8,6,0,9,8,2,0,6,5,2,6,1,3,1,6,1,7,4,1,4,1,4,1,4,0,0,4,8,1,0,5,1,6,7,1,7,0,1,3,7,3,2,0,6,3,9,9,1,3,2,7,4,7,8,9,7,9,3,7,2,5,3,4,3,2,5,0,4,6,6,3,1,8,4,0,3,3,9,4,6,2,2,3,1,2,2,8,1,7,6,6,2,1,0,5,3,5,8,8,3,4,1,6,4,7,6,7,0,6,4,9,0,8,2,1,0,6,9,4,3,7,0,5,0,2,0,4,9,8,4,2,4,7,0,0,5,7,0,7,3,4,8,5,2,0,6,2,6,7,8,9,5,8,6,7,0,9,1,9,7,7,3,4,5,4,4,2,3,6,9,8,0,8,3,2,0,9,7,9,6,5,0,3,6,7,1,8,6,4,0,5,4,5,1,9,1,8,3,4,4,4,2,5,2,5,9,5,6,8,6,3,6,6,8,4,5,1,2,1,8,4,9,2,0,2,3,3,0,6,8,7,0,2,4,5,8,3,0,6,4,8,1,2,4,0,6,0,3,0,3,1]))");


print("Intersection of two arrays: \(soln.intersection([1, 2, 2, 1],[2, 2]))");
print("Intersection of two arrays: \(soln.intersect2([1, 2, 2, 1],[2, 2]))");
print("Intersection of two arrays: \(soln.intersect2([1],[1, 1]))");
var nums2 = [3, 2, 0, 1, 2];
soln.moveZeroes2(&nums2)
print("Move zeroes: \(nums2)");
print("Is Anagram: \(soln.isAnagram("a", "b"))")



