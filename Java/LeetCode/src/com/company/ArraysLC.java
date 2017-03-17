package com.company;

import java.util.*;

import static java.lang.Math.max;
import static java.lang.Math.min;
import java.lang.Math;

/**
 * Created by axa on 2/16/17.
 */
public class ArraysLC {

    // LC: 532. K-diff Pairs in an Array
    // Given an array of integers and an integer k, you need to find the number of unique k-diff pairs in the array.
    // Here a k-diff pair is defined as an integer pair (i, j), where i and j are both numbers in the array and their absolute difference is k.
    // Time:   Space:
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/81714/java-o-n-solution-one-hashmap-easy-to-understand/2
    public int findPairs(int[] nums, int k) {
        if (nums == null || nums.length == 0 || k < 0)   return 0;

        Map<Integer, Integer> map = new HashMap<>();
        int count = 0;
        for (int i : nums) {
            map.put(i, map.getOrDefault(i, 0) + 1);
        }

        for (Map.Entry<Integer, Integer> entry : map.entrySet()) {
            if (k == 0) {
                //count how many elements in the array that appear more than twice.
                if (entry.getValue() >= 2) {
                    count++;
                }
            } else {
                if (map.containsKey(entry.getKey() + k)) {
                    count++;
                }
            }
        }

        return count;
    }

    // LC: 495. Teemo Attacking
    // Time: O(n), Space: O(c)
    // In LLP world, there is a hero called Teemo and his attacking can make his enemy Ashe be in poisoned condition.
    // Now, given the Teemo's attacking ascending time series towards Ashe and the poisoning time duration per Teemo's attacking, you need to output the total time that Ashe is in poisoned condition.
    // https://discuss.leetcode.com/topic/77067/java-7-lines-o-n-solution/2
    public int findPoisonedDuration(int[] timeSeries, int duration) {
        if (timeSeries.length == 0) { return 0; }
        int total = 0;
        int begin = timeSeries[0];
        for (int t : timeSeries) {
            total += t < begin + duration ? t - begin : duration;
            begin = t;
        }
        return total + duration;
    }

    // LC: 485. Max Consecutive Ones
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/75437/java-4-lines-concise-solution-with-explanation
    // https://discuss.leetcode.com/topic/75430/easy-java-solution
    public int findMaxConsecutiveOnes(int[] nums) {
        int maxOnes = 0;
        int currentCount = 0;
        for (int ix = 0; ix < nums.length; ix++) {
            if (nums[ix] == 1) {
                currentCount += 1;
            } else {
                currentCount = 0;
            }
            maxOnes = max(currentCount, maxOnes);
        }
        return maxOnes;
    }


    // LC: 448. Find All Numbers that Disappeared in an Array
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/65738/java-accepted-simple-solution
    //  * Iterate over the array.
    //  * For each value in the array, do ix = abs(val) - 1 and then check if num[ix] is greater than 0.
    //    If greater than 0 then make it negative.
    //  * Iterate over the array again and if the number at the current index position is positive then add (ix + 1) to the result array.


    public List<Integer> findDisappearedNumbers(int[] nums) {
        List<Integer> result = new ArrayList<>();

        for (int x : nums) {
            int val = Math.abs(x) - 1;
            if (nums[val] > 0) {
                nums[val] = -nums[val];
            }
        }

        for (int ix = 0; ix < nums.length; ix++) {
            if (nums[ix] > 0) {
                result.add(ix + 1);
            }
        }
        return result;
    }

    // LC: 442. Find All Duplicates in an Array
    // Given an array of integers, 1 ≤ a[i] ≤ n (n = size of array), some elements appear twice and others appear once.
    // Find all the elements that appear twice in this array.
    // Time: O(n) Space: O(c)
    // https://discuss.leetcode.com/topic/64735/java-simple-solution
    public List<Integer> findDuplicates(int[] nums) {
        List<Integer> result = new ArrayList<>();
        for (int val : nums) {
            int ix = Math.abs(val) - 1;
            if (nums[ix] < 0) {
                result.add(ix + 1);
            } else {
                nums[ix] = -nums[ix] ;
            }
        }
        return result;
    }


    // LC: 414. Third Maximum Number
    // Time: O(n)
    // Space: O(c)
    // https://discuss.leetcode.com/topic/63715/java-neat-and-easy-understand-solution-o-n-time-o-1-space
    public int thirdMax(int[] nums) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        Set<Integer> set = new HashSet<>();
        for (int i : nums) {
            if (!set.contains(i)) {
                pq.offer(i);
                set.add(i);
                if (pq.size() > 3) {
                    set.remove(pq.poll());
                }
            }
        }
        if (pq.size() < 3) {
            while (pq.size() > 1) {
                pq.poll();
            }
        }
        return pq.peek();
    }

    public int thirdMaxDifferent(int[] nums) {
        Integer max1 = null;
        Integer max2 = null;
        Integer max3 = null;
        for (Integer n : nums) {
            if (n.equals(max1) || n.equals(max2) || n.equals(max3)) continue;
            if (max1 == null || n > max1) {
                max3 = max2;
                max2 = max1;
                max1 = n;
            } else if (max2 == null || n > max2) {
                max3 = max2;
                max2 = n;
            } else if (max3 == null || n > max3) {
                max3 = n;
            }
        }
        return max3 == null ? max1 : max3;
    }

//    * Maintain max1, max2 and max3
//    * If a new element is equal to either max1, max2 or max3 then skip it.
//    * If you get a new element and max1 is empty or the new element is greater than max1, then bubble all three
//    * If you get a new element and max2 is empty or its greater than max2 then make max3 as max2 and set max2 to the new element.
//    * If you get a new element and max3 is empty or its greater than max3 then set max3 to the new element.
//
//    * If max3 == null then return max1 instead of max3, else return max3


    // LC: 384. Shuffle an Array
    // Time: O(n), space: O(c) outside of the result
    // https://leetcode.com/problems/shuffle-an-array/?tab=Description
    int[] n;
    Random random;
    public ArraysLC(int[] nums) {
        n = nums;
        random = new Random();
    }

    public ArraysLC() {
    }

    /** Resets the array to its original configuration and return it. */
    public int[] reset() {
        return n;
    }

    /** Returns a random shuffling of the array. */
    public int[] shuffle() {
        int[] result = n.clone();
        for (int ix = result.length - 1; ix > 0; ix--) {
            int val = random.nextInt(ix + 1);
            int temp = result[ix];
            result[ix] = result[val];
            result[val] = temp;
        }
        return result;
    }

    // LC: 289. Game of Life
    // Time:   Space:
    // https://discuss.leetcode.com/topic/29054/easiest-java-solution-with-explanation/2
    public void gameOfLife(int[][] board) {
        if (board == null || board.length == 0) return;
        int m = board.length, n = board[0].length;

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                int lives = liveNeighbors(board, m, n, i, j);

                // In the beginning, every 2nd bit is 0;
                // So we only need to care about when will the 2nd bit become 1.
                if (board[i][j] == 1 && lives >= 2 && lives <= 3) {
                    board[i][j] = 3; // Make the 2nd bit 1: 01 ---> 11
                }
                if (board[i][j] == 0 && lives == 3) {
                    board[i][j] = 2; // Make the 2nd bit 1: 00 ---> 10
                }
            }
        }

        for (int i = 0; i < m; i++) {
            for (int j = 0; j < n; j++) {
                board[i][j] >>= 1;  // Get the 2nd state.
            }
        }
    }

    public int liveNeighbors(int[][] board, int m, int n, int i, int j) {
        int lives = 0;
        for (int x = Math.max(i - 1, 0); x <= Math.min(i + 1, m - 1); x++) {
            for (int y = Math.max(j - 1, 0); y <= Math.min(j + 1, n - 1); y++) {
                lives += board[x][y] & 1;
            }
        }
        lives -= board[i][j] & 1;
        return lives;
    }

    // LC: 287. Find the Duplicate Number
    // Given an array nums containing n + 1 integers where each integer is between 1 and n (inclusive), prove that
    // at least one duplicate number must exist. Assume that there is only one duplicate number, find the duplicate one.
    // https://discuss.leetcode.com/topic/25913/my-easy-understood-solution-with-o-n-time-and-o-1-space-without-modifying-the-array-with-clear-explanation/2
    // https://discuss.leetcode.com/topic/27420/java-o-1-space-using-binary-search
    public int findDuplicate(int[] nums) {
        if (nums.length == 0) { return -1; }
        int slow = nums[0];
        int fast = nums[nums[0]];
        while (slow != fast) {
            slow = nums[slow];
            fast = nums[nums[fast]];
        }

        fast = 0;
        while (fast != slow) {
            slow = nums[slow];
            fast = nums[fast];
        }
        return fast;
    }

    public int findDuplicate2(int[] nums) {
        int low = 1, high = nums.length - 1;
        while (low <= high) {
            int mid = (int) (low + (high - low) * 0.5);
            int cnt = 0;
            for (int a : nums) {
                if (a <= mid) ++cnt;
            }
            if (cnt <= mid) low = mid + 1;
            else high = mid - 1;
        }
        return low;
    }

    // LC: 283. Move Zeroes
    // Time: O(n), Space: O(1)
    // https://discuss.leetcode.com/topic/24716/simple-o-n-java-solution-using-insert-index
    public void moveZeroes(int[] nums) {
        int dest = 0;
        for (int src = 0; src < nums.length; src++) {
            if (nums[src] != 0) {
                nums[dest++] = nums[src];
            }
        }
        while (dest < nums.length) {
            nums[dest++] = 0;
        }
    }

    public void moveZeroes2(int[] nums) {
        int ix = 0;
        int jx = 0;
        while (jx < nums.length) {
            if (nums[jx] != 0) {
                nums[ix++] = nums[jx];
            }
            jx++;
        }
        while (ix < nums.length) {
            nums[ix++] = 0;
        }
    }

    // LC: 268. Missing Number
    // Given an array containing n distinct numbers taken from 0, 1, 2, ..., n, find the one that is missing from
    // the array.
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/missing-number/?tab=Description
    public int missingNumber(int[] nums) {
        int sum = 0;
        for (int val : nums) {
            sum += val;
        }

        // Sn = (2a + (n - 1)*d) * n / 2
        int expectedSum = (nums.length) * (nums.length + 1) / 2;

        // missing number is expected sum minus current sum
        return expectedSum - sum;
    }

    // The basic idea is to use XOR operation. We all know that a^b^b =a, which means two xor operations with the same number will eliminate the number and reveal the original number.
    // In this solution, I apply XOR operation to both the index and value of the array. In a complete array with no missing numbers, the index and value should be perfectly corresponding( nums[index] = index), so in a missing array, what left finally is the missing number.
    // https://discuss.leetcode.com/topic/24535/4-line-simple-java-bit-manipulate-solution-with-explaination
    public int missingNumberBitManip(int[] nums) {

        int i = 0;
        int res = 0; // nums.length;
        for(i=0; i<nums.length; i++){
            res ^= i;
            res ^= nums[i];
        }
        return res ^ i;
        // return res - if using nums.length as init for res
    }

    // binary search
    public int missingNumberWithBinarySearch(int[] nums) {
        Arrays.sort(nums);
        int left = 0, right = nums.length, mid= (left + right)/2;
        while(left<right){
            mid = (left + right)/2;
            if(nums[mid]>mid) right = mid;
            else left = mid+1;
        }
        return left;
    }

    // LC: 238. Product of Array Except Self
    // Given an array of n integers where n > 1, nums, return an array output such that output[i] is equal to the
    // product of all the elements of nums except nums[i].
    // @todo: UNSOLVED
    // Time: O(n), space: O(c) outside of the result
    // https://leetcode.com/problems/product-of-array-except-self/?tab=Description
    public int[] productExceptSelf(int[] nums) {
        int[] result = new int[nums.length];
        if (nums.length == 0) { return result; }
        result[0] = 1;
        for (int ix = 1; ix < nums.length; ix++) {
            result[ix] = result[ix - 1] * nums[ix - 1];
        }
        int prev = 1;
        for (int ix = nums.length - 1; ix >= 0; ix--) {
            result[ix] *= prev;
            prev *= nums[ix];
        }
        return result;
    }

    // LC: 229. Majority Element II
    // Given an integer array of size n, find all elements that appear more than ⌊ n/3 ⌋ times. The algorithm
    // should run in linear time and in O(1) space.
    // @todo: UNSOLVED
    // Time: O(n), Space: O(1)
    // https://discuss.leetcode.com/topic/17564/boyer-moore-majority-vote-algorithm-and-my-elaboration/3
    // https://discuss.leetcode.com/topic/32510/java-easy-version-to-understand
    public List<Integer> majorityElement2(int[] nums) {
        if (nums == null || nums.length == 0)
            return new ArrayList<Integer>();
        List<Integer> result = new ArrayList<Integer>();
        int number1 = nums[0], number2 = nums[0], count1 = 0, count2 = 0, len = nums.length;
        for (int i = 0; i < len; i++) {
            if (nums[i] == number1)
                count1++;
            else if (nums[i] == number2)
                count2++;
            else if (count1 == 0) {
                number1 = nums[i];
                count1 = 1;
            } else if (count2 == 0) {
                number2 = nums[i];
                count2 = 1;
            } else {
                count1--;
                count2--;
            }
        }
        count1 = 0;
        count2 = 0;
        for (int i = 0; i < len; i++) {
            if (nums[i] == number1)
                count1++;
            else if (nums[i] == number2)
                count2++;
        }
        if (count1 > len / 3)
            result.add(number1);
        if (count2 > len / 3)
            result.add(number2);
        return result;
    }

    // LC: 228. Summary Ranges
    // Given a sorted integer array without duplicates, return the summary of its ranges.
    // For example, given [0,1,2,4,5,7], return ["0->2","4->5","7"].
    // Time:    Space:
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/17151/accepted-java-solution-easy-to-understand
    public List<String> summaryRanges(int[] nums) {
        List<String> list = new ArrayList<>();
        if(nums.length==1){
            list.add(nums[0]+"");
            return list;
        }
        for(int i=0;i<nums.length;i++){
            int a=nums[i];
            while(i+1<nums.length&&(nums[i+1]-nums[i])==1){
                i++;
            }
            if(a!=nums[i]){
                list.add(a+"->"+nums[i]);
            }else{
                list.add(a+"");
            }
        }
        return list;
    }


    // LC: 219. Contains Duplicate II
    // Time O(n), Space O(n)
    // Given an array of integers and an integer k, find out whether there are two distinct indices i and j in the array
    // such that nums[i] = nums[j] and the absolute difference between i and j is at most k.
    // https://leetcode.com/problems/contains-duplicate-ii/?tab=Description
    public boolean containsNearbyDuplicate(int[] nums, int k) {

        // 1. create a hashtable
        Hashtable<Integer,Integer> ht = new Hashtable<>();

        // 2. iterate over the entire array
        for (int ix = 0; ix < nums.length; ix++) {

            // 3. if the number at the current index has been seen before
            //    and difference between the current index and the last index is <= k
            //    then you have found a case that meets the requirement, return true
            if (ht.get(nums[ix]) != null && ((ix - ht.get(nums[ix])) <= k)) {
                return true;
            }

            // 4. If not then add the new (value, index) pair to the hashtable
            ht.put(nums[ix], ix);
        }

        // 5. no match found.
        return false;
    }


    // LC: 217. Contains Duplicate
    // Given an array of integers, find if the array contains any duplicates. Your function should return true if
    // any value appears at least twice in the array, and it should return false if every element is distinct.
    // Time: O(n), Space: O(n)
    // https://leetcode.com/problems/contains-duplicate/?tab=Description
    public boolean containsDuplicate(int[] nums) {
        Set<Integer> set = new HashSet<>();
        for (int val : nums) {
            if (set.contains(val)) {
                return true;
            }
            set.add(val);
        }
        return false;
    }

    // LC: 216. Combination Sum III
    // Find all possible combinations of k numbers that add up to a number n, given that
    // only numbers from 1 to 9 can be used and each combination should be a unique set of numbers.
    // Time:   Space:
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/26351/simple-and-clean-java-code-backtracking
    public List<List<Integer>> combinationSum3(int k, int n) {
        List<List<Integer>> ans = new ArrayList<>();
        combination(ans, new ArrayList<Integer>(), k, 1, n);
        return ans;
    }

    private void combination(List<List<Integer>> ans, List<Integer> comb, int k,  int start, int n) {
        if (comb.size() == k && n == 0) {
            List<Integer> li = new ArrayList<Integer>(comb);
            ans.add(li);
            return;
        }
        for (int i = start; i <= 9; i++) {
            comb.add(i);
            combination(ans, comb, k, i+1, n-i);
            comb.remove(comb.size() - 1);
        }
    }

    // LC: 209. Minimum Size Subarray Sum
    // Time:   Space:
    // Given an array of n positive integers and a positive integer s, find the minimal length of a contiguous
    // subarray of which the sum ≥ s. If there isn't one, return 0 instead.
    // For example, given the array [2,3,1,2,4,3] and s = 7,
    // the subarray [4,3] has the minimal length under the problem constraint.
    // https://discuss.leetcode.com/topic/18583/accepted-clean-java-o-n-solution-two-pointers
    public int minSubArrayLen(int s, int[] a) {
        if (a == null || a.length == 0)
            return 0;

        int i = 0, j = 0, sum = 0, min = Integer.MAX_VALUE;

        while (j < a.length) {
            sum += a[j++];

            while (sum >= s) {
                min = Math.min(min, j - i);
                sum -= a[i++];
            }
        }

        return min == Integer.MAX_VALUE ? 0 : min;
    }

    // LC: 189. Rotate Array
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/14341/easy-to-read-java-solution
    private void reverse(int[] nums, int ix, int jx) {
        while (ix < jx) {
            int temp = nums[ix];
            nums[ix] = nums[jx];
            nums[jx] = temp;
            ix += 1; jx -= 1;
        }
    }

    public void rotate(int[] nums, int k) {
        // 1. account for the case where k > nums.length
        k = k % nums.length;

        int n = nums.length;

        // 2. If k is zero then return
        if (k == 0) {
            return;
        }

        // 3. reverse the first n - k elements of the array
        reverse(nums, 0, n - k - 1);

        // 4. reverse the last k elements of the array.
        reverse(nums, n - k, n - 1);

        // 5. reverse the entire array.
        reverse(nums, 0, n - 1);
    }

    // LC: 169. Majority Element
    // Time: O(n), Space: O(c) - Moore Voting Algorithm
    // https://discuss.leetcode.com/topic/8692/o-n-time-o-1-space-fastest-solution
    public int majorityElement(int[] nums) {
        int major = nums[0];
        int count = 0;

        for (int val : nums) {
            if (count == 0) {
                major = val;
                count = 1;
            } else if (major == val) {
                count += 1;
            } else {
                count -= 1;
            }
        }
        return major;
    }

    // hastable solution
    public int majorityElementWithHT(int[] nums) {
        Hashtable<Integer, Integer> ht = new Hashtable<>();

        for (int val : nums) {
            if (ht.get(val) != null) {
                ht.put(val, ht.get(val) + 1);
                if (ht.get(val) > nums.length / 2) {
                    return val;
                }
            }
            ht.put(val, 1);
        }
        return 0;
    }

    // sorting - after sorting the n/2 nd element has to be the majority element
//    class Solution {
//        public:
//        int majorityElement(vector<int>& nums) {
//            nth_element(nums.begin(), nums.begin() + nums.size() / 2, nums.end());
//            return nums[nums.size() / 2];
//        }
//    };

    // Randomization
//    int majorityElement(vector<int>& nums) {
//        int n = nums.size();
//        srand(unsigned(time(NULL)));
//        while (true) {
//            int idx = rand() % n;
//            int candidate = nums[idx];
//            int counts = 0;
//            for (int i = 0; i < n; i++)
//                if (nums[i] == candidate)
//                    counts++;
//            if (counts > n / 2) return candidate;
//        }
//    }

    // Divide and Conquer
//    int majority(vector<int>& nums, int left, int right) {
//        if (left == right) return nums[left];
//        int mid = left + ((right - left) >> 1);
//        int lm = majority(nums, left, mid);
//        int rm = majority(nums, mid + 1, right);
//        if (lm == rm) return lm;
//        return count(nums.begin() + left, nums.begin() + right + 1, lm) > count(nums.begin() + left, nums.begin() + right + 1, rm) ? lm : rm;
//    }

    // Bit Manipulation
    // Count the number of ones across all n numbers, bit by bit.
    // When the bit count exceeds n / 2 then OR the current mask to the major value.
//    int majorityElement(vector<int>& nums) {
//        int major = 0, n = nums.size();
//        for (int i = 0, mask = 1; i < 32; i++, mask <<= 1) {
//            int bitCounts = 0;
//            for (int j = 0; j < n; j++) {
//                if (nums[j] & mask) bitCounts++;
//                if (bitCounts > n / 2) {
//                    major |= mask;
//                    break;
//                }
//            }
//        }
//        return major;
//    }

    // LC: 167. Two Sum II - Input array is sorted
    // Given an array of integers that is already sorted in ascending order,
    // find two numbers such that they add up to a specific target number.
    // Time: O(n), Space: O(c)
    // @todo: UNSOLVED?
    // https://discuss.leetcode.com/topic/6229/share-my-java-ac-solution
    public int[] twoSum(int[] numbers, int target) {
        // 1. create a result array
        int[] empty = new int[0];
        int[] result = new int[2];

        // 2. set the start index to 0 and end index to n - 1
        int ix = 0, jx = numbers.length - 1;

        while (ix < jx) {

            // 3. if the numx[sx]  + nums[ex] == target, then you've found the indices.
            if (numbers[ix] + numbers[jx] == target) {
                result[0] = (ix + 1);
                result[1] = (jx + 1);
                return result;
            }

            if (numbers[ix] + numbers[jx] > target) {
                // 4. If it's greater than the target then decrement ex
                jx -= 1;
            } else {
                // 5. If it's lesser than the target then increment sx
                ix += 1;
            }
        }
        return empty;
    }

    // LC: 162. Find Peak Element
    // @todo: UNSOLVED?
    // https://discuss.leetcode.com/topic/5848/o-logn-solution-javacode/2
    public int findPeakElement(int[] num) {
        return helper(num,0,num.length-1);
    }

    public int helper(int[] num,int start,int end){
        if(start == end){
            return start;
        }else if(start+1 == end){
            if(num[start] > num[end]) return start;
            return end;
        }else{

            int m = (start+end)/2;

            if(num[m] > num[m-1] && num[m] > num[m+1]){

                return m;

            }else if(num[m-1] > num[m] && num[m] > num[m+1]){

                return helper(num,start,m-1);

            }else{

                return helper(num,m+1,end);

            }

        }
    }

    // LC: 154. Find Minimum in Rotated Sorted Array II
    // Time: O(log n) Space: O(1)
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/25248/super-simple-and-clean-java-binary-search
    public int findMin2(int[] nums) {
        int l = 0, r = nums.length-1;
        while (l < r) {
            int mid = (l + r) / 2;
            if (nums[mid] < nums[r]) {
                r = mid;
            } else if (nums[mid] > nums[r]){
                l = mid + 1;
            } else {
                r--;  //nums[mid]=nums[r] no idea, but we can eliminate nums[r];
            }
        }
        return nums[l];
    }

    // LC: 153. Find Minimum in Rotated Sorted Array
    // Time: O(log n), Space: O(c)
    // https://discuss.leetcode.com/topic/4100/compact-and-clean-c-solution
    public int findMin(int[] nums) {

        int left = 0;
        int right = nums.length - 1;
        do {
            int mid = left + ((right - left) / 2);
            if (nums[mid] > nums[right]) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }while (left < right);
        return nums[left];
    }

    // LC: 152. Maximum Product Subarray
    // Time:   Space:
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/3607/sharing-my-solution-o-1-space-o-n-running-time
    public int maxProduct(int[] A) {
        if (A.length == 0) {
            return 0;
        }

        int maxherepre = A[0];
        int minherepre = A[0];
        int maxsofar = A[0];
        int maxhere, minhere;

        for (int i = 1; i < A.length; i++) {
            maxhere = Math.max(Math.max(maxherepre * A[i], minherepre * A[i]), A[i]);
            minhere = Math.min(Math.min(maxherepre * A[i], minherepre * A[i]), A[i]);
            maxsofar = Math.max(maxhere, maxsofar);
            maxherepre = maxhere;
            minherepre = minhere;
        }
        return maxsofar;
    }

    //  LC: 128. Longest Consecutive Sequence
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/6148/my-really-simple-java-o-n-solution-accepted
    public int longestConsecutive(int[] num) {
        int res = 0;
        HashMap<Integer, Integer> map = new HashMap<Integer, Integer>();
        for (int n : num) {
            if (!map.containsKey(n)) {
                int left = (map.containsKey(n - 1)) ? map.get(n - 1) : 0;
                int right = (map.containsKey(n + 1)) ? map.get(n + 1) : 0;
                // sum: length of the sequence n is in
                int sum = left + right + 1;
                map.put(n, sum);

                // keep track of the max length
                res = Math.max(res, sum);

                // extend the length to the boundary(s)
                // of the sequence
                // will do nothing if n has no neighbors
                map.put(n - left, sum);
                map.put(n + right, sum);
            }
            else {
                // duplicates
                continue;
            }
        }
        return res;
    }

    // LC: 126. Word Ladder II

    // LC: 123. Best Time to Buy and Sell Stock III
    // Time O(n), O(1).
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/5934/is-it-best-solution-with-o-n-o-1
    public int maxProfit3(int[] prices) {
        int hold1 = Integer.MIN_VALUE, hold2 = Integer.MIN_VALUE;
        int release1 = 0, release2 = 0;
        for(int i:prices){                              // Assume we only have 0 money at first
            release2 = Math.max(release2, hold2+i);     // The maximum if we've just sold 2nd stock so far.
            hold2    = Math.max(hold2,    release1-i);  // The maximum if we've just buy  2nd stock so far.
            release1 = Math.max(release1, hold1+i);     // The maximum if we've just sold 1nd stock so far.
            hold1    = Math.max(hold1,    -i);          // The maximum if we've just buy  1st stock so far.
        }
        return release2; ///Since release1 is initiated as 0, so release2 will always higher than release1.
    }

    // LC: 122. Best Time to Buy and Sell Stock II
    // Time: O(n)
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/726/is-this-question-a-joke/13
    public int maxProfit2(int[] prices) {
        int total = 0;
        for (int i=0; i< prices.length-1; i++) {
            if (prices[i+1]>prices[i]) total += prices[i+1]-prices[i];
        }

        return total;
    }

    // LC: 121. Best Time to Buy and Sell Stock
    // Time: O(n)
    // https://discuss.leetcode.com/topic/19853/kadane-s-algorithm-since-no-one-has-mentioned-about-this-so-far-in-case-if-interviewer-twists-the-input
    public int maxProfit(int[] prices) {
        if (prices.length == 0) { return 0; }
        int minSoFar = prices[0];
        int max = 0;
        for (int ix = 1; ix < prices.length; ix++) {
            if (prices[ix] > minSoFar) {
                max = Math.max(max, prices[ix] - minSoFar);
            }
            minSoFar = Math.min(minSoFar, prices[ix]);
        }
        return max;
    }

    // LC: 120. Triangle
    // Time: O(n * m)
    public int minimumTotal(List<List<Integer>> triangle) {
        if (triangle.size() == 0) { return 0; }
        List<Integer> lastRow = new ArrayList<>(triangle.get(0));
        int min = lastRow.get(0);
        for (int ix = 1; ix < triangle.size(); ix++) {

            List<Integer> currentRow = new ArrayList<>(triangle.get(ix));
            int val = currentRow.get(0) + lastRow.get(0);
            currentRow.set(0, val);
            min = Math.min(min, val);
            val = currentRow.get(currentRow.size() - 1) + lastRow.get(lastRow.size() - 1);
            currentRow.set(currentRow.size() - 1, val);
            min = Math.min(min, val);
            for (int jx = 1; jx < currentRow.size() - 1; jx++) {
                val = triangle.get(ix).get(jx);
                int localMin = val + Math.min(lastRow.get(jx - 1), lastRow.get(jx));
                min = Math.min(min, localMin);
                currentRow.set(jx, localMin);
            }
            lastRow = currentRow;
        }
        return min;
    }

    // https://discuss.leetcode.com/topic/8077/my-8-line-dp-java-code-4-meaningful-lines-with-o-1-space
    // @todo: UNSOLVED
    public int minimumTotal2(List<List<Integer>> triangle) {
        for(int i = triangle.size() - 2; i >= 0; i--)
            for(int j = 0; j <= i; j++)
                triangle.get(i).set(j, triangle.get(i).get(j) + Math.min(triangle.get(i + 1).get(j), triangle.get(i + 1).get(j + 1)));
        return triangle.get(0).get(0);
    }

    // LC: 119. Pascal's Triangle II
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/4722/my-accepted-java-solution-any-better-code
    public List<Integer> getRow(int rowIndex) {
        List<Integer> list = new ArrayList<Integer>();
        if (rowIndex < 0)
            return list;

        for (int i = 0; i < rowIndex + 1; i++) {
            list.add(0, 1);
            for (int j = 1; j < list.size() - 1; j++) {
                list.set(j, list.get(j) + list.get(j + 1));
            }
        }
        return list;
    }

//    vector<int> getRow(int rowIndex) {
//        vector<int> A(rowIndex+1, 0);
//        A[0] = 1;
//        for(int i=1; i<rowIndex+1; i++)
//            for(int j=i; j>=1; j--)
//                A[j] += A[j-1];
//        return A;
//    }

    // LC: 118. Pascal's Triangle
    // Time: O(n2), space: O(c) outside the result
    // https://leetcode.com/problems/pascals-triangle/?tab=Description
    public List<List<Integer>> generate(int numRows) {
        List<List<Integer>> result = new ArrayList<>(new ArrayList<>());

        for (int ix = 1; ix <= numRows; ix++) {
            // 1. each row has as many elements are the row number
            ArrayList<Integer> row = new ArrayList<>(ix);
            for (int jx = 0; jx < ix; jx++) {
                row.add(1);
            }

            // 2. Update all elements of the row except the first and the last
            // use the previous row as a reference to update.
            int left = 1; int right = row.size() - 1;
            while (left < right) {
                List<Integer> previousRow = result.get(result.size() - 1);
                row.set(left, previousRow.get(left - 1) + previousRow.get(left));
                left += 1;
            }

            // 3. add the new row
            result.add(row);
        }

        // 4. return the result.
        return result;
    }

    // https://discuss.leetcode.com/topic/6805/my-concise-solution-in-java/2
    // concise
    public List<List<Integer>> generate2(int numRows)
    {
        List<List<Integer>> allrows = new ArrayList<List<Integer>>();
        ArrayList<Integer> row = new ArrayList<Integer>();
        for(int i=0;i<numRows;i++)
        {
            row.add(0, 1);
            for(int j=1;j<row.size()-1;j++)
                row.set(j, row.get(j)+row.get(j+1));
            allrows.add(new ArrayList<Integer>(row));
        }
        return allrows;

    }

    // LC: 106. Construct Binary Tree from Inorder and Postorder Traversal
    // https://discuss.leetcode.com/topic/3296/my-recursive-java-code-with-o-n-time-and-o-n-space
    // @todo: UNSOLVED
    public TreeNode buildTree2(int[] inorder, int[] postorder) {
        if (inorder == null || postorder == null || inorder.length != postorder.length)
            return null;
        HashMap<Integer, Integer> hm = new HashMap<Integer,Integer>();
        for (int i=0;i<inorder.length;++i)
            hm.put(inorder[i], i);
        return buildTreePostIn(inorder, 0, inorder.length-1, postorder, 0,
                postorder.length-1,hm);
    }

    TreeNode buildTreePostIn(int[] inorder, int is, int ie, int[] postorder, int ps, int pe,
                             HashMap<Integer,Integer> hm){
        if (ps>pe || is>ie) return null;
        TreeNode root = new TreeNode(postorder[pe]);
        int ri = hm.get(postorder[pe]);
        TreeNode leftchild = buildTreePostIn(inorder, is, ri-1, postorder, ps, ps+ri-is-1, hm);
        TreeNode rightchild = buildTreePostIn(inorder,ri+1, ie, postorder, ps+ri-is, pe-1, hm);
        root.left = leftchild;
        root.right = rightchild;
        return root;
    }

    // LC: 105. Construct Binary Tree from Preorder and Inorder Traversal
    // https://discuss.leetcode.com/topic/3695/my-accepted-java-solution
    // @todo: UNSOLVED
    public TreeNode buildTree(int[] preorder, int[] inorder) {
        return helper(0, 0, inorder.length - 1, preorder, inorder);
    }

    public TreeNode helper(int preStart, int inStart, int inEnd, int[] preorder, int[] inorder) {
        if (preStart > preorder.length - 1 || inStart > inEnd) {
            return null;
        }
        TreeNode root = new TreeNode(preorder[preStart]);
        int inIndex = 0; // Index of current root in inorder

        // this can be made faster using a lookup table, check EPI
        for (int i = inStart; i <= inEnd; i++) {
            if (inorder[i] == root.val) {
                inIndex = i;
            }
        }
        root.left = helper(preStart + 1, inStart, inIndex - 1, preorder, inorder);
        root.right = helper(preStart + inIndex - inStart + 1, inIndex + 1, inEnd, preorder, inorder);
        return root;
    }

    // LC: 90. Subsets II
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/22638/very-simple-and-fast-java-solution
    public List<List<Integer>> subsetsWithDup(int[] nums) {
        Arrays.sort(nums);
        List<List<Integer>> res = new ArrayList<>();
        List<Integer> each = new ArrayList<>();
        helper(res, each, 0, nums);
        return res;
    }
    public void helper(List<List<Integer>> res, List<Integer> each, int pos, int[] n) {
        if (pos <= n.length) {
            res.add(each);
        }
        int i = pos;
        while (i < n.length) {
            each.add(n[i]);
            helper(res, new ArrayList<>(each), i + 1, n);
            each.remove(each.size() - 1);
            i++;
            while (i < n.length && n[i] == n[i - 1]) {i++;}
        }
        return;
    }

    // LC: 88. Merge Sorted Array
    // @todo: UNSOLVED
    // Time: O(m + n)
    // https://discuss.leetcode.com/topic/10257/3-line-java-solution
    public void merge(int[] A, int m, int[] B, int n) {
        int i=m-1, j=n-1, k=m+n-1;
        while (i>-1 && j>-1) A[k--]= (A[i]>B[j]) ? A[i--] : B[j--];
        while (j>-1)         A[k--]=B[j--];
    }

    // LC: 85. Maximal Rectangle
    // @todo: UNSOLVED
    // https://leetcode.com/problems/maximal-rectangle/#/solutions
    public int maximalRectangle(char[][] matrix) {
        if (matrix==null||matrix.length==0||matrix[0].length==0)
            return 0;
        int cLen = matrix[0].length;    // column length
        int rLen = matrix.length;       // row length
        // height array
        int[] h = new int[cLen+1];
        h[cLen]=0;
        int max = 0;


        for (int row=0;row<rLen;row++) {
            Stack<Integer> s = new Stack<Integer>();
            for (int i=0;i<cLen+1;i++) {
                if (i<cLen)
                    if(matrix[row][i]=='1')
                        h[i]+=1;
                    else h[i]=0;

                if (s.isEmpty()||h[s.peek()]<=h[i])
                    s.push(i);
                else {
                    while(!s.isEmpty()&&h[i]<h[s.peek()]){
                        int top = s.pop();
                        int area = h[top]*(s.isEmpty()?i:(i-s.peek()-1));
                        if (area>max)
                            max = area;
                    }
                    s.push(i);
                }
            }
        }
        return max;
    }


//    int maximalRectangle(vector<vector<char> > &matrix) {
//        if(matrix.empty()) return 0;
//    const int m = matrix.size();
//    const int n = matrix[0].size();
//        int left[n], right[n], height[n];
//        fill_n(left,n,0); fill_n(right,n,n); fill_n(height,n,0);
//        int maxA = 0;
//        for(int i=0; i<m; i++) {
//            int cur_left=0, cur_right=n;
//            for(int j=0; j<n; j++) { // compute height (can do this from either side)
//                if(matrix[i][j]=='1') height[j]++;
//                else height[j]=0;
//            }
//            for(int j=0; j<n; j++) { // compute left (from left to right)
//                if(matrix[i][j]=='1') left[j]=max(left[j],cur_left);
//                else {left[j]=0; cur_left=j+1;}
//            }
//            // compute right (from right to left)
//            for(int j=n-1; j>=0; j--) {
//                if(matrix[i][j]=='1') right[j]=min(right[j],cur_right);
//                else {right[j]=n; cur_right=j;}
//            }
//            // compute the area of rectangle (can do this from either side)
//            for(int j=0; j<n; j++)
//                maxA = max(maxA,(right[j]-left[j])*height[j]);
//        }
//        return maxA;
//    }

    // LC: 84. Largest Rectangle in Histogram
    // https://discuss.leetcode.com/topic/7599/o-n-stack-based-java-solution
    // @todo: UNSOLVED, didn't pass all tests
    public int largestRectangleArea(int[] height) {
        int len = height.length;
        Stack<Integer> s = new Stack<Integer>();
        int maxArea = 0;
        for(int i = 0; i <= len; i++){
            int h = (i == len ? 0 : height[i]);
            if(s.isEmpty() || h >= height[s.peek()]){
                s.push(i);
            }else{
                int tp = s.pop();
                maxArea = Math.max(maxArea, height[tp] * (s.isEmpty() ? i : i - 1 - s.peek()));
                i--;
            }
        }
        return maxArea;
    }

    // LC: 81. Search in Rotated Sorted Array II
    // https://discuss.leetcode.com/topic/8087/c-concise-log-n-solution
    // @todo: UNSOLVED
    // Time: O(log n)
    public boolean search2(int[] nums, int target) {
        int start = 0, end = nums.length - 1, mid = -1;
        while(start <= end) {
            mid = (start + end) / 2;
            if (nums[mid] == target) {
                return true;
            }
            //If we know for sure right side is sorted or left side is unsorted
            if (nums[mid] < nums[end] || nums[mid] < nums[start]) {
                if (target > nums[mid] && target <= nums[end]) {
                    start = mid + 1;
                } else {
                    end = mid - 1;
                }
                //If we know for sure left side is sorted or right side is unsorted
            } else if (nums[mid] > nums[start] || nums[mid] > nums[end]) {
                if (target < nums[mid] && target >= nums[start]) {
                    end = mid - 1;
                } else {
                    start = mid + 1;
                }
                //If we get here, that means nums[start] == nums[mid] == nums[end], then shifting out
                //any of the two sides won't change the result but can help remove duplicate from
                //consideration, here we just use end-- but left++ works too
            } else {
                end--;
            }
        }

        return false;
    }

    // LC: 80. Remove Duplicates from Sorted Array II
    // https://discuss.leetcode.com/topic/17180/3-6-easy-lines-c-java-python-ruby
    // @todo: UNSOLVED
    // Time: O(n)
    public int removeDuplicates2(int[] nums) {
        int i = 0;
        for (int n : nums)
            if (i < 2 || n > nums[i - 2])
                nums[i++] = n;
        return i;
    }

    // LC: 79. Word Search
    // https://discuss.leetcode.com/topic/7907/accepted-very-short-java-solution-no-additional-space
    boolean visit(char[][] board, String word, int wx, int ix, int jx) {
        int[][] next = {{0, -1}, {0, 1}, {1, 0}, {-1, 0}};

        if (ix < 0 || ix >= board.length) { return  false; }
        if (jx < 0 || jx >= board[0].length) { return false; }

        char current = board[ix][jx];
        if (current == ' ') { return false; }
        if (current != word.charAt(wx)) { return false; }

        if (wx == word.length() - 1) { return true; }

        board[ix][jx] = ' ';
        for (int nx = 0; nx < next.length; nx++) {
            if (visit(board, word, wx + 1, ix + next[nx][0], jx + next[nx][1])) {
                return true;
            }
        }
        board[ix][jx] = current;
        return false;
    }

    public boolean exist(char[][] board, String word) {
        if (word.length() == 0) { return false; }
        for (int ix = 0; ix < board.length; ix++) {
            for (int jx = 0; jx < board[0].length; jx++) {
                char current = board[ix][jx];
                boolean exists = false;
                if (current == word.charAt(0)) {
                    exists = visit(board, word, 0, ix, jx);
                }
                if (exists == true) { return true; }
            }
        }
        return false;
    }

    // LC: 78. Subsets
    // https://discuss.leetcode.com/topic/46159/a-general-approach-to-backtracking-questions-in-java-subsets-permutations-combination-sum-palindrome-partitioning
    // Time: O(2 raised n) same as the number of subsets of n, Space: O(c)
    public List<List<Integer>> subsets(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length == 0) { return  result; }

        for (int ix = 0; ix < 1 << nums.length; ix++) {
            int bits = ix;
            List<Integer> set = new ArrayList<>();
            while (bits > 0) {
                int next = bits & ~(bits - 1);
                int val = (int) (Math.log(next)/Math.log(2));
                set.add(nums[val]);
                bits &= (bits - 1);
            }
            result.add(set);
        }

        return result;
    }

    // LC: 75. Sort Colors
    // Time: O(n)
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

    // one pass, in place
    // https://discuss.leetcode.com/topic/6968/four-different-solutions
    // @todo: UNSOLVED
    void sortColors2(int A[], int n) {
        int n0 = -1, n1 = -1, n2 = -1;
        for (int i = 0; i < n; ++i) {
            if (A[i] == 0)
            {
                A[++n2] = 2; A[++n1] = 1; A[++n0] = 0;
            }
            else if (A[i] == 1)
            {
                A[++n2] = 2; A[++n1] = 1;
            }
            else if (A[i] == 2)
            {
                A[++n2] = 2;
            }
        }
    }

    // LC: 74. Search a 2D Matrix
    // @todo: UNSOLVED
    // Time: O(log (m + n)
    // https://discuss.leetcode.com/topic/3227/don-t-treat-it-as-a-2d-matrix-just-treat-it-as-a-sorted-list
    // https://discuss.leetcode.com/topic/4846/binary-search-on-an-ordered-matrix
    public boolean searchMatrix(int[][] matrix, int target) {
        if (matrix.length == 0) return false;
        int row_num = matrix.length;
        int col_num = matrix[0].length;

        int begin = 0, end = row_num * col_num - 1;

        while(begin <= end){
            int mid = (begin + end) / 2;
            int mid_value = matrix[mid/col_num][mid%col_num];

            if( mid_value == target){
                return true;

            }else if(mid_value < target){
                //Should move a bit further, otherwise dead loop.
                begin = mid+1;
            }else{
                end = mid-1;
            }
        }

        return false;
    }

    // Time: O(m + n)
    public boolean searchMatrix2(int[][] matrix, int target) {
        int i = 0, j = matrix[0].length - 1;
        while (i < matrix.length && j >= 0) {
            if (matrix[i][j] == target) {
                return true;
            } else if (matrix[i][j] > target) {
                j--;
            } else {
                i++;
            }
        }

        return false;
    }

    // LC: 73. Set Matrix Zeroes
    // Time: O(m x n); Space: O(m + n)
    // https://discuss.leetcode.com/topic/5056/any-shorter-o-1-space-solution
    public void setZeroes(int[][] matrix) {
        if (matrix.length == 0) { return; }

        int[] rows = new int[matrix.length];
        int[] cols = new int[matrix[0].length];
        for (int ix = 0; ix < matrix.length; ix++) {
            for (int jx = 0; jx < matrix[0].length; jx++) {
                if (matrix[ix][jx] == 0) {
                    rows[ix] = 1;
                    cols[jx] = 1;
                }
            }
        }
        for (int ix = 0; ix < matrix.length; ix++) {
            for (int jx = 0; jx < matrix[0].length; jx++) {
                if (rows[ix] == 1 || cols[jx] == 1) {
                    matrix[ix][jx] = 0;
                }
            }
        }
    }

    // uses a trick to avoid allocating more space
//    void setZeroes(vector<vector<int> > &matrix) {
//        int col0 = 1, rows = matrix.size(), cols = matrix[0].size();
//
//        for (int i = 0; i < rows; i++) {
//            if (matrix[i][0] == 0) col0 = 0;
//            for (int j = 1; j < cols; j++)
//                if (matrix[i][j] == 0)
//                    matrix[i][0] = matrix[0][j] = 0;
//        }
//
//        for (int i = rows - 1; i >= 0; i--) {
//            for (int j = cols - 1; j >= 1; j--)
//                if (matrix[i][0] == 0 || matrix[0][j] == 0)
//                    matrix[i][j] = 0;
//            if (col0 == 0) matrix[i][0] = 0;
//        }
//    }

    // LC: 66. Plus One
    // Time: O(n), Space: O(c) outside of the result
    // https://leetcode.com/problems/plus-one/?tab=Description
    public int[] plusOne(int[] digits) {
        int l = digits.length;
        digits[l - 1] += 1;
        for (int jx = l - 1; jx > 0 && digits[jx] == 10; jx--) {
            digits[jx] = 0;
            digits[jx - 1] += 1;
        }
        if (digits[0] == 10) {
            int[] result = new int[l + 1];
            result[0] = 1;
            return result;
        }
        return digits;
    }

    public int[] plusOneAlt(int[] digits) {

        int n = digits.length;
        for(int i=n-1; i>=0; i--) {
            if(digits[i] < 9) {
                digits[i]++;
                return digits;
            }
            digits[i] = 0;
        }

        int[] newNumber = new int [n+1];
        newNumber[0] = 1;

        return newNumber;
    }

    // LC: 64. Minimum Path Sum
    // Time: O(m * n)
    // https://discuss.leetcode.com/topic/15269/10-lines-28ms-o-n-space-dp-solution-in-c-with-explanations
    public int minPathSum(int[][] grid) {
        if (grid.length == 0) { return 0; }
        int m = grid.length, n = grid[0].length;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                grid[ix][jx] += Math.min((ix > 0 ? grid[ix - 1][jx] : Integer.MAX_VALUE), (jx > 0 ? grid[ix][jx - 1] : Integer.MAX_VALUE));
            }
        }
        return grid[m - 1][n - 1];
    }

    // LC: 63. Unique Paths II
    // Time O(m * n), Space: O(1) outside of the input
    // https://leetcode.com/problems/unique-paths-ii/#/solutions
    // https://discuss.leetcode.com/topic/10974/short-java-solution
    public int uniquePathsWithObstacles(int[][] obstacleGrid) {
        if (obstacleGrid.length == 0) return 0;
        if (obstacleGrid[0][0] == 1) return 0; // IMP edge case

        int m = obstacleGrid.length, n = obstacleGrid[0].length;
        int[][] grid = new int[m][n];
        grid[0][0] = 1;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                if (obstacleGrid[ix][jx] == 1) continue; // IMP to edge cases like [[0, 1]]
                if (ix > 0 && obstacleGrid[ix - 1][jx] != 1) {
                    grid[ix][jx] += grid[ix - 1][jx];
                }
                if (jx > 0 && obstacleGrid[ix][jx - 1] != 1) {
                    grid[ix][jx] += grid[ix][jx - 1];
                }
            }
        }
        return grid[m - 1][n - 1];
    }

    // LC: 62. Unique Paths
    // Time O(m * n), Space: O(1) outside of the input
    // https://discuss.leetcode.com/topic/15265/0ms-5-lines-dp-solution-in-c-with-explanations
    public int uniquePaths(int m, int n) {
        int[][] grid = new int[m][n];
        grid[0][0] = 1;
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                if (ix == 0 && jx == 0) continue;
                grid[ix][jx] = (ix > 0 ? grid[ix - 1][jx] : 0) + (jx > 0 ? grid[ix][jx - 1] : 0);
            }
        }
        return grid[m - 1][n - 1];
    }

    // LC: 59. Spiral Matrix II
    // https://discuss.leetcode.com/topic/4362/my-super-simple-solution-can-be-used-for-both-spiral-matrix-i-and-ii
    public int[][] generateMatrix(int n) {
        // Declaration
        int[][] matrix = new int[n][n];

        // Edge Case
        if (n == 0) {
            return matrix;
        }

        // Normal Case
        int rowStart = 0;
        int rowEnd = n-1;
        int colStart = 0;
        int colEnd = n-1;
        int num = 1; //change

        while (rowStart <= rowEnd && colStart <= colEnd) {
            for (int i = colStart; i <= colEnd; i ++) {
                matrix[rowStart][i] = num ++; //change
            }
            rowStart ++;

            for (int i = rowStart; i <= rowEnd; i ++) {
                matrix[i][colEnd] = num ++; //change
            }
            colEnd --;

            for (int i = colEnd; i >= colStart; i --) {
                if (rowStart <= rowEnd)
                    matrix[rowEnd][i] = num ++; //change
            }
            rowEnd --;

            for (int i = rowEnd; i >= rowStart; i --) {
                if (colStart <= colEnd)
                    matrix[i][colStart] = num ++; //change
            }
            colStart ++;
        }

        return matrix;
    }

    // LC: 57. Insert Interval
    // @todo: UNSOLVED, HARD
    // https://discuss.leetcode.com/topic/7808/short-and-straight-forward-java-solution/1
    public List<Interval> insert(List<Interval> intervals, Interval newInterval) {
        List<Interval> result = new LinkedList<>();
        int i = 0;
        // add all the intervals ending before newInterval starts
        while (i < intervals.size() && intervals.get(i).end < newInterval.start)
            result.add(intervals.get(i++));
        // merge all overlapping intervals to one considering newInterval
        while (i < intervals.size() && intervals.get(i).start <= newInterval.end) {
            newInterval = new Interval( // we could mutate newInterval here also
                    Math.min(newInterval.start, intervals.get(i).start),
                    Math.max(newInterval.end, intervals.get(i).end));
            i++;
        }
        result.add(newInterval); // add the union of intervals we got
        // add all the rest
        while (i < intervals.size()) result.add(intervals.get(i++));
        return result;
    }

    // LC: 56. Merge Intervals
    // Time: O(n)
    // @todo: UNSOLVED
    //https://discuss.leetcode.com/topic/4319/a-simple-java-solution
    class Interval {
        int start;
        int end;
        Interval() { start = 0; end = 0; }
        Interval(int s, int e) { start = s; end = e; }
    }

    public List<Interval> merge(List<Interval> intervals) {
        if (intervals.size() <= 1)
            return intervals;

        // Sort by ascending starting point using an anonymous Comparator
        intervals.sort((i1, i2) -> Integer.compare(i1.start, i2.start));

        List<Interval> result = new LinkedList<Interval>();
        int start = intervals.get(0).start;
        int end = intervals.get(0).end;

        for (Interval interval : intervals) {
            if (interval.start <= end) // Overlapping intervals, move the end if needed
                end = Math.max(end, interval.end);
            else {                     // Disjoint intervals, add the previous one and reset bounds
                result.add(new Interval(start, end));
                start = interval.start;
                end = interval.end;
            }
        }

        // Add the last interval
        result.add(new Interval(start, end));
        return result;
    }

    // LC: 55. Jump Game
    // Time: O(n), space: O(c)
    // https://discuss.leetcode.com/topic/4911/linear-and-simple-solution-in-c/2
    public boolean canJump(int[] nums) {
        if (nums.length == 0) { return false; }
        int maxJump = 0;
        for (int ix = 0; ix < nums.length && maxJump >= ix; ix++) {
            maxJump = max(maxJump, nums[ix] + ix);
        }

        return maxJump >= nums.length - 1;
    }


    // LC: 54. Spiral Matrix
    // Time: O(m * n), Space: O(1)
    // https://discuss.leetcode.com/topic/3713/super-simple-and-easy-to-understand-solution/2
    public List<Integer> spiralOrder2(int[][] matrix) {

        List<Integer> res = new ArrayList<Integer>();

        if (matrix.length == 0) {
            return res;
        }

        int rowBegin = 0;
        int rowEnd = matrix.length-1;
        int colBegin = 0;
        int colEnd = matrix[0].length - 1;

        while (rowBegin <= rowEnd && colBegin <= colEnd) {
            // Traverse Right
            for (int j = colBegin; j <= colEnd; j ++) {
                res.add(matrix[rowBegin][j]);
            }
            rowBegin++;

            // Traverse Down
            for (int j = rowBegin; j <= rowEnd; j ++) {
                res.add(matrix[j][colEnd]);
            }
            colEnd--;

            if (rowBegin <= rowEnd) {
                // Traverse Left
                for (int j = colEnd; j >= colBegin; j --) {
                    res.add(matrix[rowEnd][j]);
                }
            }
            rowEnd--;

            if (colBegin <= colEnd) {
                // Traver Up
                for (int j = rowEnd; j >= rowBegin; j --) {
                    res.add(matrix[j][colBegin]);
                }
            }
            colBegin ++;
        }

        return res;
    }

    public List<Integer> spiralOrder(int[][] matrix) {

        List<Integer> result = new ArrayList<>();
        if (matrix.length == 0) { return result; }

        int m = matrix.length;
        int n = matrix[0].length;
        int u = 0, r = n - 1, l = 0, d = m - 1;

        while (true) {
            for (int col = l; col <= r; col++) {
                result.add(matrix[u][col]);
            }
            if (++u > d) break;
            for (int row = u; row <= d; row++) {
                result.add(matrix[row][r]);
            }
            if (--r < l) break;
            for (int col = r; col >= l; col--) {
                result.add(matrix[d][col]);
            }
            if (--d < u) break;
            for (int row = d; row >= u; row--) {
                result.add(matrix[row][l]);
            }
            if (++l > r) break;
        }
        return result;
    }



    // LC: 53. Maximum Subarray
    // https://discuss.leetcode.com/topic/6413/dp-solution-some-thoughts
    // Time: O(n), space: O(1)
    public int maxSubArray2(int[] nums) {
        if (nums.length == 0) { return -1; }
        int maxTillHere = nums[0];
        int max = nums[0];
        for (int ix = 1; ix < nums.length; ix++) {
            maxTillHere = Math.max(nums[ix], maxTillHere + nums[ix]);
            max = Math.max(max, maxTillHere);
        }
        return max;
    }

    public int maxSubArray(int[] nums) {

        if (nums.length == 0) { return Integer.MIN_VALUE; }

        int maxTillHere = nums[0];
        int max = nums[0];
        for (int ix = 1; ix < nums.length; ix++) {
            maxTillHere = Math.max(nums[ix], maxTillHere + nums[ix]);
            max = Math.max(max, maxTillHere);
        }
        return max;
    }

    // Time: O(n), Space: O(n)
    public int maxSubArrayDP(int[] A) {
        int n = A.length;
        int[] dp = new int[n];//dp[i] means the maximum subarray ending with A[i];
        dp[0] = A[0];
        int max = dp[0];

        for(int i = 1; i < n; i++){
            dp[i] = A[i] + (dp[i - 1] > 0 ? dp[i - 1] : 0);
            max = Math.max(max, dp[i]);
        }

        return max;
    }

    // LC: 48. Rotate Image
    // Time: O(m x n), Space: O(c)
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/6796/a-common-method-to-rotate-the-image
    // Transpose the matrix and then flip horizontally
    public void rotate(int[][] matrix) {
        for(int i = 0; i<matrix.length; i++){
            for(int j = i + 1; j<matrix[0].length; j++){
                int temp = 0;
                temp = matrix[i][j];
                matrix[i][j] = matrix[j][i];
                matrix[j][i] = temp;
            }
        }
        for(int i =0 ; i<matrix.length; i++){
            for(int j = 0; j<matrix.length/2; j++){
                int temp = 0;
                temp = matrix[i][j];
                matrix[i][j] = matrix[i][matrix.length-1-j];
                matrix[i][matrix.length-1-j] = temp;
            }
        }
    }

    // LC: 45. Jump Game II
    // Time: O(n), BFS??
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/3191/o-n-bfs-solution
    int jump2(int A[], int n) {
        if(n<2)return 0;
        int level=0,currentMax=0,i=0,nextMax=0;

        while(currentMax-i+1>0){		//nodes count of current level>0
            level++;
            for(;i<=currentMax;i++){	//traverse current level , and update the max reach of next level
                nextMax=max(nextMax,A[i]+i);
                if(nextMax>=n-1)return level;   // if last element is in level+1,  then the min jump=level
            }
            currentMax=nextMax;
        }
        return 0;
    }

    public int jump(int[] nums) {
        int sc = 0;
        int e = 0;
        int max = 0;
        for(int i=0; i<nums.length-1; i++) {
            max = Math.max(max, i+nums[i]);
            if( i == e ) {
                sc++;
                e = max;
            }
        }
        return sc;
    }

    // LC: 42. Trapping Rain Water
    // @todo: UNSOLVED, HARD
    // https://discuss.leetcode.com/topic/3016/share-my-short-solution
    public int trap(int[] A){
        int a=0;
        int b=A.length-1;
        int max=0;
        int leftmax=0;
        int rightmax=0;
        while(a<=b){
            leftmax=Math.max(leftmax,A[a]);
            rightmax=Math.max(rightmax,A[b]);
            if(leftmax<rightmax){
                max+=(leftmax-A[a]);       // leftmax is smaller than rightmax, so the (leftmax-A[a]) water can be stored
                a++;
            }
            else{
                max+=(rightmax-A[b]);
                b--;
            }
        }
        return max;
    }

    // LC: 41. First Missing Positive
    // @todo: UNSOLVED, HARD
    // Time: O(n), Space: O(1)
    // https://discuss.leetcode.com/topic/2633/share-my-o-n-time-o-1-space-solution/2
    public int firstMissingPositive(int[] A) {
        int n=A.length;
        if(n==0)
            return 1;
        int k=partition(A)+1;
        int temp=0;
        int first_missing_Index=k;
        for(int i=0;i<k;i++){
            temp=Math.abs(A[i]);
            if(temp<=k)
                A[temp-1]=(A[temp-1]<0)?A[temp-1]:-A[temp-1];
        }
        for(int i=0;i<k;i++){
            if(A[i]>0){
                first_missing_Index=i;
                break;
            }
        }
        return first_missing_Index+1;
    }

    public int partition(int[] A){
        int n=A.length;
        int q=-1;
        for(int i=0;i<n;i++){
            if(A[i]>0){
                q++;
                swap(A,q,i);
            }
        }
        return q;
    }


    // LC: 40. Combination Sum II
    // Time: ??, Space ??
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/19845/java-solution-using-dfs-easy-understand
    private void combinationSum2Helper(int[] candidates, int target, List<List<Integer>> result, List<Integer> partial, int begin) {
        if (target < 0) { return; }
        if (target == 0) {
            result.add(new ArrayList<>(partial));
            return;
        }
        for (int ix = begin; ix < candidates.length; ix++) {
            if (ix > begin && candidates[ix] == candidates[ix - 1]) { continue; }
            if (target - candidates[ix] >= 0) {
                partial.add(candidates[ix]);
                combinationSum2Helper(candidates, target - candidates[ix], result, partial, ix + 1);
                partial.remove(partial.size() - 1);
            }
        }
    }

    public List<List<Integer>> combinationSum2(int[] candidates, int target) {
        Arrays.sort(candidates);
        List<List<Integer>> result = new ArrayList<>();
        combinationSum2Helper(candidates, target, result, new ArrayList<>(), 0);
        return result;
    }

    // LC: 39. Combination Sum
    // [2, 3, 6, 7] target = 7
    // @todo: UNSOLVED
    // https://discuss.leetcode.com/topic/46161/a-general-approach-to-backtracking-questions-in-java-subsets-permutations-combination-sum-palindrome-partitioning
    private void combinationSumHelper(int[] candidates, int target, List<List<Integer>> result, List<Integer> partial, int begin) {
        if (target < 0) { return; }
        if (target == 0) {
            result.add(new ArrayList<>(partial));
            return;
        }
        for (int ix = begin; ix < candidates.length; ix++) {
            if (target - candidates[ix] >= 0) {
                partial.add(candidates[ix]);
                combinationSumHelper(candidates, target - candidates[ix], result, partial, ix);
                partial.remove(partial.size() - 1);
            }
        }
    }

    public List<List<Integer>> combinationSum(int[] candidates, int target) {
        // Arrays.sort(candidates);
        List<List<Integer>> result = new ArrayList<>();
        combinationSumHelper(candidates, target, result, new ArrayList<>(), 0);
        return result;
    }

    // LC: 35. Search Insert Position
    // Time: O(log n), Space: O(c)
    // https://discuss.leetcode.com/topic/7874/my-8-line-java-solution
    public int searchInsert(int[] nums, int target) {
        if (nums.length == 0) { return -1; }
        int low = 0, high = nums.length - 1;
        do {
            int mid = low + (high - low) / 2;
            if (nums[mid] == target) { return mid; }
            if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }while (low <= high);
        return low;
    }

    // LC: 34. Search for a Range
    // Time: O(log n), Space: O(c)
    // https://discuss.leetcode.com/topic/6327/a-very-simple-java-solution-with-only-one-binary-search-algorithm
    public int[] searchRange(int[] nums, int target) {
        int[] result = new int[]{-1, -1};
        if (nums.length == 0) { return result; }
        int low = 0, high = nums.length - 1;

        do {
            int mid = low + (high - low) / 2;
            if (nums[mid] < target) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }while (low < high);
        if (low >= nums.length || nums[low] != target) { return result; }
        result[0] = low;

        high = nums.length - 1;

        while (low < high){
            int mid = low + (high - low) / 2 + 1;
            if (nums[mid] > target)  {
                high = mid - 1;
            } else {
                low = mid;
            }
        }
        result[1] = high;
        return result;
    }

    // LC: 33. Search in Rotated Sorted Array
    // Time: O(log n), Space: O(c)
    // https://discuss.leetcode.com/topic/3538/concise-o-log-n-binary-search-solution
    public int search(int[] nums, int target) {
        if (nums.length == 0) return -1;
        int low = 0, high = nums.length - 1;
        do {
            int mid = low + (high - low) / 2;
            if (nums[mid] == target) { return mid; }

            if (nums[low] <= nums[mid]) {
                if (target >= nums[low] && target < nums[mid]) {
                    high = mid - 1;
                } else {
                    low = mid + 1;
                }
            } else {
                if (target > nums[mid] && target <= nums[high]) {
                    low = mid + 1;
                } else {
                    high = mid - 1;
                }
            }

        } while (low <= high);
        return -1;
    }

    // LC: 31. Next Permutation
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/14124/sharing-my-clean-and-easy-understand-java-code-with-explanation
    private void swap(int[] nums, int ix, int jx) {
        int temp = nums[ix];
        nums[ix] = nums[jx];
        nums[jx] = temp;
    }

    private void reverse2(int[] nums, int start, int end) {
        while (start < end) {
            swap(nums, start, end);
            start++; end--;
        }
    }

    public void nextPermutation(int[] nums) {
        if (nums.length < 2) { return; }
        int n = nums.length;
        int jx = n - 1;
        while (jx > 0) {
            if (nums[jx - 1] < nums[jx]) break;
            jx--;
        }
        if (jx == 0) {
            reverse2(nums, 0, n - 1);
            return;
        }
        int ix = nums.length - 1;
        int index = jx - 1;
        while (ix >= jx) {
            if (nums[ix] > nums[index]) break;
            ix--;
        }
        swap(nums, index, ix);
        reverse2(nums, jx, n - 1);
    }

    // LC: 27. Remove Element
    // Time: O(n), space: O(c)
    public int removeElement(int[] nums, int val) {
        int ix = 0;
        for (int jx = 0; jx < nums.length; jx++) {
            if (nums[jx] != val) {
                nums[ix++] = nums[jx];
            }
        }
        return ix;
    }

    // LC: 26. Remove Duplicates from Sorted Array
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/remove-duplicates-from-sorted-array/?tab=Description
    public int removeDuplicates(int[] nums) {
        int ix = 1;

        for (int jx = 1; jx < nums.length; jx++) {
            if (nums[jx] != nums[jx - 1]) {
                nums[ix++] = nums[jx];
            }
        }
        return ix;
    }

    // The more intuitive one
    public int removeDuplicatesAlt(int[] nums) {
        int ix = 0;

        for (int jx = 1; jx < nums.length; jx++) {
            if (nums[jx] != nums[ix]) {
                nums[++ix] = nums[jx];
            }
        }
        return ix + 1;
    }


    // LC: 18. 4Sum
    // Time: O(n3), Space: O(c)
    // https://discuss.leetcode.com/topic/28641/my-16ms-c-code
    public List<List<Integer>> fourSum(int[] nums, int target) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length < 3) { return result; }
        Arrays.sort(nums);
        int n = nums.length;
        for (int ix = 0; ix < nums.length - 3; ix++) {
            if (ix > 0 && nums[ix] == nums[ix - 1]) continue;
            if (nums[ix] + nums[ix + 1] + nums[ix + 2] + nums[ix + 3] > target) break;
            if (nums[ix] + nums[n - 1] + nums[n - 2] + nums[n - 3] < target) continue;
            for (int jx = ix + 1; jx < nums.length - 2; jx++) {
                if (jx > ix + 1 && nums[jx] == nums[jx - 1]) continue;
                if (nums[ix] + nums[jx] + nums[jx + 1] + nums[jx + 2] > target) break;
                if (nums[ix] + nums[jx] + nums[n - 1] + nums[n - 2] < target) continue;
                int left = jx + 1;
                int right = n - 1;
                while (left < right) {
                    int sum = nums[ix] + nums[jx] + nums[left] + nums[right];
                    if (sum < target) {
                        left++;
                    } else if (sum > target) {
                        right--;
                    } else {
                        result.add(Arrays.asList(nums[ix], nums[jx], nums[left], nums[right]));
                        while (left < right && nums[left] == nums[left + 1]) { left++; }
                        while (left < right && nums[right] == nums[right - 1]) { right--;}
                        left++; right--;
                    }
                }
            }
        }
        return result;
    }

    // LC: 16. 3Sum Closest
    // Time: O(n2), Space: O(n)
    // https://discuss.leetcode.com/topic/5192/java-solution-with-o-n2-for-reference
    public int threeSumClosest(int[] nums, int target) {
        Arrays.sort(nums);
        int minDiffSoFar = Integer.MAX_VALUE;
        int sumOfMinDiff  = 0;
        for (int ix = 0; ix < nums.length - 2; ix++) {
            int jx = ix + 1, zx = nums.length - 1;
            while (jx < zx) {
                int sum = nums[ix] + nums[jx] + nums[zx];
                int diff = Math.abs(target - sum);
                if (diff == 0) { return sum; }
                if (diff < minDiffSoFar) {
                    minDiffSoFar = diff;
                    sumOfMinDiff = sum;
                }
                if (sum > target) {
                    zx--;
                } else {
                    jx++;
                }
            }
        }
        return sumOfMinDiff;
    }

    // LC: 15. 3Sum
    // Time: O(n2), Space: O(c)
    // https://leetcode.com/problems/3sum/?tab=Description
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length < 3) {
            return result;
        }

        Arrays.sort(nums);
        for (int ix = 0; ix < nums.length - 2; ix++) {
            if (ix == 0 || nums[ix] != nums[ix - 1]) {
                int jx = ix + 1;
                int zx = nums.length - 1;
                while (jx < zx) {
                    int sum = nums[ix] + nums[jx] + nums[zx];
                    if (sum == 0) {
                        result.add(Arrays.asList(nums[ix], nums[jx], nums[zx]));
                        while (jx < zx && nums[jx] == nums[jx + 1]) {
                            jx++;
                        }
                        while (jx < zx && nums[zx - 1] == nums[zx]) {
                            zx--;
                        }
                        jx++;
                        zx--;
                    } else if (sum > 0) {
                        zx--;
                    } else {
                        jx++;
                    }
                }
            }
        }
        return result;
    }


    // LC: 11. Container With Most Water
    // Time: O(n), Space: O(c)
    // https://discuss.leetcode.com/topic/25004/easy-concise-java-o-n-solution-with-proof-and-explanation/2
    public int maxArea(int[] height) {

        // 1. set ix = 0, jx = len - 1
        int ix = 0, jx = height.length - 1;

        int maxA = 0;

        while (ix < jx) {

            int h = min(height[ix], height[jx]);

            // 2. get the current area as the min of height(ix), height(jx) times jx - ix
            // 3. Record if it's greater than the current max
            maxA = max(maxA,  h * (jx - ix));

            // 4. For next step in the iteration pick the height that is shorter, if both are equal then pick either one.
            while (height[ix] <= h && ix < jx) {
                ix += 1;
            }

            while (height[jx] <= h && ix < jx) {
                jx -= 1;
            }

        }
        return maxA;
    }

    // LC: 4. Median of Two Sorted Arrays
    // @todo: HARD, UNSOLVED, EXCEEDS TIME LIMIT
    // https://discuss.leetcode.com/topic/16797/very-concise-o-log-min-m-n-iterative-solution-with-detailed-explanation/2
    double findMedianSortedArrays(int[] nums1, int[] nums2) {
        int N1 = nums1.length;
        int N2 = nums2.length;
        if (N1 < N2) return findMedianSortedArrays(nums2, nums1);	// Make sure A2 is the shorter one.

        if (N2 == 0) return ((double)nums1[(N1-1)/2] + (double)nums1[N1/2])/2;  // If A2 is empty

        int lo = 0, hi = N2 * 2;
        while (lo <= hi) {
            int mid2 = (lo + hi) / 2;   // Try Cut 2
            int mid1 = N1 + N2 - mid2;  // Calculate Cut 1 accordingly

            double L1 = (mid1 == 0) ? Integer.MIN_VALUE : nums1[(mid1-1)/2];	// Get L1, R1, L2, R2 respectively
            double L2 = (mid2 == 0) ? Integer.MIN_VALUE : nums2[(mid2-1)/2];
            double R1 = (mid1 == N1 * 2) ? Integer.MAX_VALUE : nums1[(mid1)/2];
            double R2 = (mid2 == N2 * 2) ? Integer.MAX_VALUE : nums2[(mid2)/2];

            if (L1 > R2) lo = mid2 + 1;		// A1's lower half is too big; need to move C1 left (C2 right)
            else if (L2 > R1) hi = mid2 - 1;	// A2's lower half too big; need to move C2 left.
            else return (Math.max(L1,L2) + Math.min(R1, R2)) / 2;	// Otherwise, that's the right cut.
        }
        return -1;
    }


    // LC: 1. Two Sum
    public int[] twoSumBasic(int[] nums, int target) {
        int[] result = new int[2];
        Hashtable<Integer, Integer> hs = new Hashtable<>();
        for (int ix = 0; ix < nums.length; ix++) {
            if (hs.get(target - nums[ix]) != null) {
                result[0] = hs.get(target - nums[ix]);
                result[1] = ix;
                return result;
            }
            hs.put(nums[ix], ix);
        }

        return result;
    }



}
