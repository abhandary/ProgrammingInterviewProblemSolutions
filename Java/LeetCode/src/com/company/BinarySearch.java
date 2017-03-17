package com.company;

/**
 * Created by akshayb on 3/7/17.
 */
public class BinarySearch {

    // IMP: Try to visualize Binary Search as eliminations and see if the
    // eliminations make sense in each case.

    // 374. Guess Number Higher or Lower
    // Time: O( log n), Space: O(c)
    // https://leetcode.com/problems/guess-number-higher-or-lower/?tab=Description
    int guess(int mid) {
        return 0;
    }

    public int guessNumber(int n) {
        int low = 1;
        int high = n;
        int mid = low + (high - low) / 2;
        int g = 0;
        while ((g = guess(mid)) != 0) {
            if (g == -1) {
                high = mid - 1;
            } else {
                low = mid + 1;
            }
            mid = low + (high - low) / 2;
        }
        return mid;
    }

    // 287. Find the Duplicate Number
    // Time: < O(n2) > O(n log n), Space: O(c)
    // PRACTICE, UNDERSTAND!
    // https://leetcode.com/problems/find-the-duplicate-number/#/description
    public int findDuplicate(int[] nums) {
        int low = 1;
        int high = nums.length - 1;
        while (low < high) {
            int mid = low + (high - low) / 2;
            int count = 0;
            for (int ix = 0; ix < nums.length; ix++) {
                if (nums[ix] <= mid) count++;
            }
            if (count <= mid) {
                low = mid + 1;
            } else {
                high = mid;
            }
        }
        return low;
    }

    // Time: O(n), Space: O(c)
    // Figure OUT how!!
    public int findDuplicateLinear(int[] nums) {
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


    // 278. First Bad Version
    // Time: O(log n), Space: O(c)
    // https://leetcode.com/problems/first-bad-version/?tab=Description
    private boolean isBadVersion(int n) {
        return false;
    }

    public int firstBadVersion(int n) {
        int low = 1;
        int high = n;
        int mid;
        int candidate = 1;
        do {
            mid = low + (high - low) / 2;
            if (isBadVersion(mid)) {
                candidate = mid;
                high = mid - 1;
            } else {
                low = mid + 1;
            }
        }while (low <= high);
        return candidate;
    }


    // 35. Search Insert Position
    // Time: O(log n), space: O(c)
    // https://leetcode.com/problems/search-insert-position/?tab=Description
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

    // 34. Search for a Range
    // Time: O(log n), Space: O(c)
    // https://leetcode.com/problems/search-for-a-range/?tab=Description
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

    // 33. Search in Rotated Sorted Array
    // Time: O(log n), space: O(c)
    // https://leetcode.com/problems/search-in-rotated-sorted-array/?tab=Solutions
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
}
