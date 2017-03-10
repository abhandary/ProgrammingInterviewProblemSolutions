package com.company;

import java.util.*;

import static java.lang.Math.max;
import static java.lang.Math.min;
import java.lang.Math;

/**
 * Created by axa on 2/16/17.
 */
public class ArraysLC {
    // 485. Max Consecutive Ones
    // Time: O(n)
    // Space: O(c)
    // https://leetcode.com/problems/max-consecutive-ones/?tab=Description
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


    // 448. Find All Numbers that Disappeared in an Array
    // Time: O(n)
    // Space: O(c)
    // https://leetcode.com/problems/find-all-numbers-disappeared-in-an-array/?tab=Description
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

    // 442. Find All Duplicates in an Array
    // Time: O(n)
    // Space: O(c)
    // https://leetcode.com/problems/find-all-duplicates-in-an-array/?tab=Description
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


    // 414. Third Maximum Number
    // Time: O(n)
    // Space: O(c)
    // https://leetcode.com/problems/third-maximum-number/?tab=Description
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


    // 384. Shuffle an Array
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

    // 283. Move Zeroes
    // Time: O(n)
    // Space: O(c)
    // https://leetcode.com/problems/move-zeroes/?tab=Description
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

    // 268. Missing Number
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
        // Arrays.sort(nums);
        int left = 0, right = nums.length, mid= (left + right)/2;
        while(left<right){
            mid = (left + right)/2;
            if(nums[mid]>mid) right = mid;
            else left = mid+1;
        }
        return left;
    }

    // 219. Contains Duplicate II
    // Time O(n), Space O(n)
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


    // 217. Contains Duplicate
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


    // 189. Rotate Array
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/rotate-array/?tab=Description
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

    // 169. Majority Element
    // Time: O(n), Space: O(c) - Moore Voting Algorithm
    // https://leetcode.com/problems/majority-element/?tab=Description
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

    // 167. Two Sum II - Input array is sorted
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/two-sum-ii-input-array-is-sorted/?tab=Description
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

    // 153. Find Minimum in Rotated Sorted Array
    // Time: O(log n), Space: O(c)
    // https://leetcode.com/problems/find-minimum-in-rotated-sorted-array/?tab=Description
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

    // 118. Pascal's Triangle
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

    // 73. Set Matrix Zeroes
    // Time: O(m x n); Space: O(m + n)
    // https://leetcode.com/problems/set-matrix-zeroes/?tab=Description
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

    // 66. Plus One
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

    // 54. Spiral Matrix
    // Time: O(m x n), Space: O(c)
    // https://leetcode.com/problems/spiral-matrix/?tab=Solutions
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

    // 55. Jump Game
    public boolean canJump(int[] nums) {
        if (nums.length == 0) { return false; }
        int maxJump = 0;
        for (int ix = 0; ix < nums.length && maxJump >= ix; ix++) {
            maxJump = max(maxJump, nums[ix] + ix);
        }

        return maxJump >= nums.length - 1;
    }

    // 53. Maximum Subarray
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/maximum-subarray/?tab=Description
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

    // 48. Rotate Image
    // Time: O(m x n), Space: O(c)
    // https://leetcode.com/problems/rotate-image/?tab=Description
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

    // 40. Combination Sum II
    // Time: ??, Space ??
    // PRACTICE, VERIFY WITH TEST CASES
    // https://leetcode.com/problems/combination-sum-ii/?tab=Description
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

    // 39. Combination Sum
    // [2, 3, 6, 7] target = 7
    // PRACTICE, VERIFY WITH TEST CASES

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

    // 31. Next Permutation
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/next-permutation/?tab=Description
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

    // 27. Remove Element
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

    // 26. Remove Duplicates from Sorted Array
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


    // 18. 4Sum
    // Time: O(n3), Space: O(c)
    // https://leetcode.com/problems/4sum/?tab=Description
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

    // 16. 3Sum Closest
    // Time: O(n2), Space: O(n)
    // https://leetcode.com/problems/3sum-closest/?tab=Description
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

    // 15. 3Sum
    // Time: O(n2), Space: O(c)
    // https://leetcode.com/problems/3sum/?tab=Description
    public List<List<Integer>> threeSum(int[] nums) {
        List<List<Integer>> result = new ArrayList<>();
        if (nums.length < 3) { return result; }

        Arrays.sort(nums);
        for (int ix = 0; ix < nums.length - 2; ix++) {
            if (ix == 0 || nums[ix] != nums[ix - 1]) {
                int jx = ix + 1;
                int zx = nums.length - 1;
                while (jx < zx) {
                    int sum = nums[ix] + nums[jx] + nums[zx];
                    if (sum == 0) {
                        result.add(Arrays.asList(nums[ix], nums[jx], nums[zx]));
                        while (jx < zx && nums[jx] == nums[jx + 1]) { jx++; }
                        while (jx < zx && nums[zx - 1] == nums[zx]) { zx--; }
                        jx++; zx--;
                    } else if (sum > 0) {
                        zx--;
                    } else {
                        jx++;
                    }
                }
            }
        }


        // 11. Container With Most Water
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/container-with-most-water/?tab=Solutions
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



    // 1. Two Sum
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
