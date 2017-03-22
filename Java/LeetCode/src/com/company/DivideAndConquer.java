package com.company;

import java.util.*;
import java.lang.Math;


/**
 * Created by akshayb on 2/27/17.
 */
public class DivideAndConquer {

    // LC: 514. Freedom Trail
    // @see DFS

    // LC: 493. Reverse Pairs
    // Given an array nums, we call (i, j) an important reverse pair if i < j and nums[i] > 2*nums[j].
    // You need to return the number of important reverse pairs in the given array.
    // Input: [1,3,2,3,1] Output: 2
    // Input: [2,4,3,5,1] Output: 3
    // Read through detailed explanation:
    // https://discuss.leetcode.com/topic/79227/general-principles-behind-problems-similar-to-reverse-pairs
    // https://discuss.leetcode.com/topic/78933/very-short-and-clear-mergesort-bst-java-solutions
    public int reversePairs(int[] nums) {
        return mergeSort(nums, 0, nums.length-1);
    }
    private int mergeSort(int[] nums, int s, int e){
        if(s>=e) return 0;
        int mid = s + (e-s)/2;
        int cnt = mergeSort(nums, s, mid) + mergeSort(nums, mid+1, e);
        for(int i = s, j = mid+1; i<=mid; i++){
            while(j<=e && nums[i]/2.0 > nums[j]) j++;
            cnt += j-(mid+1);
        }
        Arrays.sort(nums, s, e+1);
        return cnt;
    }

    // LC: 327. Count of Range Sum
    // Given an integer array nums, return the number of range sums that lie in [lower, upper] inclusive.
    // Range sum S(i, j) is defined as the sum of the elements in nums between indices i and j (i ≤ j), inclusive.
    // Note:
    //  A naive algorithm of O(n2) is trivial. You MUST do better than that.
    // Example:
    //  Given nums = [-2, 5, -1], lower = -2, upper = 2,
    //  Return 3.
    //  The three ranges are : [0, 0], [2, 2], [0, 2] and their respective sums are: -2, -1, 2.
    // SP: https://discuss.leetcode.com/topic/33770/short-simple-o-n-log-n
    // https://discuss.leetcode.com/topic/33738/share-my-solution
    public int countRangeSum(int[] nums, int lower, int upper) {
        int n = nums.length;
        long[] sums = new long[n + 1];
        for (int i = 0; i < n; ++i)
            sums[i + 1] = sums[i] + nums[i];
        return countWhileMergeSort(sums, 0, n + 1, lower, upper);
    }

    private int countWhileMergeSort(long[] sums, int start, int end, int lower, int upper) {
        if (end - start <= 1) return 0;
        int mid = (start + end) / 2;
        int count = countWhileMergeSort(sums, start, mid, lower, upper)
                + countWhileMergeSort(sums, mid, end, lower, upper);
        int j = mid, k = mid, t = mid;
        long[] cache = new long[end - start];
        for (int i = start, r = 0; i < mid; ++i, ++r) {
            while (k < end && sums[k] - sums[i] < lower) k++;
            while (j < end && sums[j] - sums[i] <= upper) j++;
            while (t < end && sums[t] < sums[i]) cache[r++] = sums[t++];
            cache[r] = sums[i];
            count += j - k;
        }
        System.arraycopy(cache, 0, sums, start, t - start);
        return count;
    }

    // LC: 315. Count of Smaller Numbers After Self
    // You are given an integer array nums and you have to return a new counts array. The counts array has the property
    // where counts[i] is the number of smaller elements to the right of nums[i].
    // https://discuss.leetcode.com/topic/31405/9ms-short-java-bst-solution-get-answer-when-building-bst
    // SP :https://discuss.leetcode.com/topic/31162/mergesort-solution/2
    class Node {
        Node left, right;
        int val, sum, dup = 1;
        public Node(int v, int s) {
            val = v;
            sum = s;
        }
    }
    public List<Integer> countSmaller(int[] nums) {
        Integer[] ans = new Integer[nums.length];
        Node root = null;
        for (int i = nums.length - 1; i >= 0; i--) {
            root = insert(nums[i], root, ans, i, 0);
        }
        return Arrays.asList(ans);
    }
    private Node insert(int num, Node node, Integer[] ans, int i, int preSum) {
        if (node == null) {
            node = new Node(num, 0);
            ans[i] = preSum;
        } else if (node.val == num) {
            node.dup++;
            ans[i] = preSum + node.sum;
        } else if (node.val > num) {
            node.sum++;
            node.left = insert(num, node.left, ans, i, preSum);
        } else {
            node.right = insert(num, node.right, ans, i, preSum + node.dup + node.sum);
        }
        return node;
    }

    // LC: 312. Burst Balloons
    // Given n balloons, indexed from 0 to n-1. Each balloon is painted with a number on it represented by array nums. You are asked to burst all the balloons. If the you burst balloon i you will get nums[left] * nums[i] * nums[right] coins. Here left and right are adjacent indices of i. After the burst, the left and right then becomes adjacent.
    // Find the maximum coins you can collect by bursting the balloons wisely.
    // Note:
    //  (1) You may imagine nums[-1] = nums[n] = 1. They are not real therefore you can not burst them.
    //  (2) 0 ≤ n ≤ 500, 0 ≤ nums[i] ≤ 100
    // https://discuss.leetcode.com/topic/30746/share-some-analysis-and-explanations
    public int maxCoins(int[] iNums) {
        int[] nums = new int[iNums.length + 2];
        int n = 1;
        for (int x : iNums) if (x > 0) nums[n++] = x;
        nums[0] = nums[n++] = 1;


        int[][] memo = new int[n][n];
        return burst(memo, nums, 0, n - 1);
    }

    public int burst(int[][] memo, int[] nums, int left, int right) {
        if (left + 1 == right) return 0;
        if (memo[left][right] > 0) return memo[left][right];
        int ans = 0;
        for (int i = left + 1; i < right; ++i)
            ans = Math.max(ans, nums[left] * nums[i] * nums[right]
                    + burst(memo, nums, left, i) + burst(memo, nums, i, right));
        memo[left][right] = ans;
        return ans;
    }

    public int maxCoinsDP(int[] iNums) {
        int[] nums = new int[iNums.length + 2];
        int n = 1;
        for (int x : iNums) if (x > 0) nums[n++] = x;
        nums[0] = nums[n++] = 1;


        int[][] dp = new int[n][n];
        for (int k = 2; k < n; ++k)
            for (int left = 0; left < n - k; ++left) {
                int right = left + k;
                for (int i = left + 1; i < right; ++i)
                    dp[left][right] = Math.max(dp[left][right],
                            nums[left] * nums[i] * nums[right] + dp[left][i] + dp[i][right]);
            }

        return dp[0][n - 1];
    }

    // LC: 282. Expression Add Operators
    // Given a string that contains only digits 0-9 and a target value, return all possibilities to add binary operators
    // (not unary) +, -, or * between the digits so they evaluate to the target value.
    // Examples:
    // "123", 6 -> ["1+2+3", "1*2*3"]
    // "232", 8 -> ["2*3+2", "2+3*2"]
    // "105", 5 -> ["1*0+5","10-5"]
    // "00", 0 -> ["0+0", "0-0", "0*0"]
    // "3456237490", 9191 -> []
    public List<String> addOperators(String num, int target) {
        List<String> rst = new ArrayList<String>();
        if(num == null || num.length() == 0) return rst;
        helper(rst, "", num, target, 0, 0, 0);
        return rst;
    }
    public void helper(List<String> rst, String path, String num, int target, int pos, long eval, long multed){
        if(pos == num.length()){
            if(target == eval)
                rst.add(path);
            return;
        }
        for(int i = pos; i < num.length(); i++){
            if(i != pos && num.charAt(pos) == '0') break;
            long cur = Long.parseLong(num.substring(pos, i + 1));
            if(pos == 0){
                helper(rst, path + cur, num, target, i + 1, cur, cur);
            }
            else{
                helper(rst, path + "+" + cur, num, target, i + 1, eval + cur , cur);

                helper(rst, path + "-" + cur, num, target, i + 1, eval -cur, -cur);

                helper(rst, path + "*" + cur, num, target, i + 1, eval - multed + multed * cur, multed * cur );
            }
        }
    }

    // LC: 241. Different Ways to Add Parentheses
    // https://discuss.leetcode.com/topic/19901/a-recursive-java-solution-284-ms
    // SP: https://discuss.leetcode.com/topic/19894/1-11-lines-python-9-lines-c
    public List<Integer> diffWaysToCompute(String input) {
        List<Integer> ret = new LinkedList<Integer>();
        for (int i=0; i<input.length(); i++) {
            if (input.charAt(i) == '-' ||
                    input.charAt(i) == '*' ||
                    input.charAt(i) == '+' ) {
                String part1 = input.substring(0, i);
                String part2 = input.substring(i+1);
                List<Integer> part1Ret = diffWaysToCompute(part1);
                List<Integer> part2Ret = diffWaysToCompute(part2);
                for (Integer p1 :   part1Ret) {
                    for (Integer p2 :   part2Ret) {
                        int c = 0;
                        switch (input.charAt(i)) {
                            case '+': c = p1+p2;
                                break;
                            case '-': c = p1-p2;
                                break;
                            case '*': c = p1*p2;
                                break;
                        }
                        ret.add(c);
                    }
                }
            }
        }
        if (ret.size() == 0) {
            ret.add(Integer.valueOf(input));
        }
        return ret;
    }

    // LC: 240. Search a 2D Matrix II
    // Write an efficient algorithm that searches for a value in an m x n matrix. This matrix has the following properties:
    // Integers in each row are sorted in ascending from left to right.
    // Integers in each column are sorted in ascending from top to bottom.
    // SP: https://discuss.leetcode.com/topic/19496/4-lines-c-6-lines-ruby-7-lines-python-1-liners
    public boolean searchMatrix2(int[][] matrix, int target) {
        if(matrix == null || matrix.length < 1 || matrix[0].length <1) {
            return false;
        }
        int col = matrix[0].length-1;
        int row = 0;
        while(col >= 0 && row <= matrix.length-1) {
            if(target == matrix[row][col]) {
                return true;
            } else if(target < matrix[row][col]) {
                col--;
            } else if(target > matrix[row][col]) {
                row++;
            }
        }
        return false;
    }

    // LC: 218. The Skyline Problem
    // https://leetcode.com/problems/the-skyline-problem/#/description
    // SP: https://discuss.leetcode.com/topic/14987/108-ms-17-lines-body-explained
    // https://discuss.leetcode.com/topic/28482/once-for-all-explanation-with-clean-java-code-o-n-2-time-o-n-space
    public List<int[]> getSkyline(int[][] buildings) {
        List<int[]> result = new ArrayList<>();
        List<int[]> height = new ArrayList<>();
        for(int[] b:buildings) {
            // start point has negative height value
            height.add(new int[]{b[0], -b[2]});
            // end point has normal height value
            height.add(new int[]{b[1], b[2]});
        }

        // sort $height, based on the first value, if necessary, use the second to
        // break ties
        Collections.sort(height, (a, b) -> {
            if(a[0] != b[0])
                return a[0] - b[0];
            return a[1] - b[1];
        });

        // Use a maxHeap to store possible heights
        Queue<Integer> pq = new PriorityQueue<>((a, b) -> (b - a));

        // Provide a initial value to make it more consistent
        pq.offer(0);

        // Before starting, the previous max height is 0;
        int prev = 0;

        // visit all points in order
        for(int[] h:height) {
            if(h[1] < 0) { // a start point, add height
                pq.offer(-h[1]);
            } else {  // a end point, remove height
                pq.remove(h[1]);
            }
            int cur = pq.peek(); // current max height;

            // compare current max height with previous max height, update result and
            // previous max height if necessary
            if(prev != cur) {
                result.add(new int[]{h[0], cur});
                prev = cur;
            }
        }
        return result;
    }

    // LC: 215. Kth Largest Element in an Array
    // https://discuss.leetcode.com/topic/14597/solution-explained
    // QuickSelect approach in the link above is only partially correct, need to use
    // randomization at every step of the while loop
    public int findKthLargest(int[] nums, int k) {

        final PriorityQueue<Integer> pq = new PriorityQueue<>();
        for(int val : nums) {
            pq.offer(val);

            if(pq.size() > k) {
                pq.poll();
            }
        }
        return pq.peek();
    }



    // LC: 169. Majority Element
    // @see Arrays


    // LC: 53. Maximum Subarray
    // @see Arrays


    // LC: 23. Merge k Sorted Lists
    // https://discuss.leetcode.com/topic/2780/a-java-solution-based-on-priority-queue
    // IMP: retruning negative for comparator indicates that the first argument should come before
    // the second argument, return values appropriately from the comparator.
    public ListNode mergeKLists(ListNode[] lists) {

        if (lists==null||lists.length==0) return null;

        PriorityQueue<ListNode> queue=  new PriorityQueue<>((o1, o2) -> o1.val - o2.val);

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

    // LC: 4. Median of Two Sorted Arrays
    // @see Arrays
}
