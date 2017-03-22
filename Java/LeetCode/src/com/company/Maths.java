package com.company;

import java.lang.Math;
import java.util.*;


/**
 * Created by akshayb on 3/7/17.
 */
public class Maths {

    // LC: 535. Encode and Decode TinyURL
    // @see Hashtables

    // LC: 523. Continuous Subarray Sum
    // Given a list of non-negative numbers and a target integer k, write a function to check if the array has a
    // continuous subarray of size at least 2 that sums up to the multiple of k, that is, sums up to n*k where n is
    // also an integer.
    // https://discuss.leetcode.com/topic/80793/java-o-n-time-o-k-space
    public boolean checkSubarraySum(int[] nums, int k) {
        Map<Integer, Integer> map = new HashMap<Integer, Integer>(){{put(0,-1);}};;
        int runningSum = 0;
        for (int i=0;i<nums.length;i++) {
            runningSum += nums[i];
            if (k != 0) runningSum %= k;
            Integer prev = map.get(runningSum);
            if (prev != null) {
                if (i - prev > 1) return true;
            }
            else map.put(runningSum, i);
        }
        return false;
    }

    // LC: 517. Super Washing Machines
    // You have n super washing machines on a line. Initially, each washing machine has some dresses or is empty.
    // For each move, you could choose any m (1 ≤ m ≤ n) washing machines, and pass one dress of each washing machine
    // to one of its adjacent washing machines at the same time .
    // Given an integer array representing the number of dresses in each washing machine from left to right on the
    // line, you should find the minimum number of moves to make all the washing machines have the same number of
    // dresses. If it is not possible to do it, return -1.
    // https://discuss.leetcode.com/topic/79938/super-short-easy-java-o-n-solution
    public int findMinMoves(int[] machines) {
        int total = 0;
        for(int i: machines) total+=i;
        if(total%machines.length!=0) return -1;
        int avg = total/machines.length, cnt = 0, max = 0;
        for(int load: machines){
            cnt += load-avg; //load-avg is "gain/lose"
            max = Math.max(Math.max(max, Math.abs(cnt)), load-avg);
        }
        return max;
    }

    // LC: 483. Smallest Good Base
    // For an integer n, we call k>=2 a good base of n, if all digits of n base k are 1.
    // Now given a string representing n, you should return the smallest good base of n in string format.
    // SP: https://discuss.leetcode.com/topic/76368/python-solution-with-detailed-mathematical-explanation-and-derivation/2


    // LC: 462. Minimum Moves to Equal Array Elements II
    // Given a non-empty integer array, find the minimum number of moves required to make all array elements equal,
    // where a move is incrementing a selected element by 1 or decrementing a selected element by 1.
    // You may assume the array's length is at most 10,000.
    // SP: https://discuss.leetcode.com/topic/68946/2-lines-python-2-ways
    public int minMoves2(int[] nums) {
        Arrays.sort(nums);
        int i = 0, j = nums.length-1;
        int count = 0;
        while(i < j){
            count += nums[j]-nums[i];
            i++;
            j--;
        }
        return count;
    }

    // LC: 453. Minimum Moves to Equal Array Elements
    // Given a non-empty integer array of size n, find the minimum number of moves required to make all array elements
    // equal, where a move is incrementing n - 1 elements by 1.
    // https://discuss.leetcode.com/topic/66557/java-o-n-solution-short
    public int minMoves(int[] nums) {
        if (nums.length == 0) return 0;
        int min = nums[0];
        for (int n : nums) min = Math.min(min, n);
        int res = 0;
        for (int n : nums) res += n - min;
        return res;
    }

    // LC: 441. Arranging Coins
    // You have a total of n coins that you want to form in a staircase shape, where every k-th row must have exactly k
    // coins.
    // Given n, find the total number of full staircase rows that can be formed.
    // n is a non-negative integer and fits within the range of a 32-bit signed integer.
    // https://discuss.leetcode.com/topic/65593/java-clean-code-with-explanations-and-running-time-2-solutions
    public int arrangeCoins(int n) {
        int start = 0;
        int end = n;
        int mid = 0;
        while (start <= end){
            mid = (start + end) >>> 1;
            if ((0.5 * mid * mid + 0.5 * mid ) <= n){
                start = mid + 1;
            }else{
                end = mid - 1;
            }
        }
        return start - 1;
    }

    // LC: 423. Reconstruct Original Digits from English
    // https://discuss.leetcode.com/topic/63386/one-pass-o-n-java-solution-simple-and-clear
    // https://discuss.leetcode.com/topic/63382/share-my-simple-and-easy-o-n-solution
    // SP: https://discuss.leetcode.com/topic/63432/fun-fact
    public String originalDigits(String s) {
        int[] count = new int[10];
        for (int i = 0; i < s.length(); i++){
            char c = s.charAt(i);
            if (c == 'z') count[0]++;
            if (c == 'w') count[2]++;
            if (c == 'x') count[6]++;
            if (c == 's') count[7]++; //7-6
            if (c == 'g') count[8]++;
            if (c == 'u') count[4]++;
            if (c == 'f') count[5]++; //5-4
            if (c == 'h') count[3]++; //3-8
            if (c == 'i') count[9]++; //9-8-5-6
            if (c == 'o') count[1]++; //1-0-2-4
        }
        count[7] -= count[6];
        count[5] -= count[4];
        count[3] -= count[8];
        count[9] = count[9] - count[8] - count[5] - count[6];
        count[1] = count[1] - count[0] - count[2] - count[4];
        StringBuilder sb = new StringBuilder();
        for (int i = 0; i <= 9; i++){
            for (int j = 0; j < count[i]; j++){
                sb.append(i);
            }
        }
        return sb.toString();
    }


    // LC: 415. Add Strings
    // Time: O(m + n), Space: O(m + n) for the string builder
    // https://leetcode.com/problems/add-strings/?tab=Description
    public String addStrings(String num1, String num2) {
        int ix = num1.length() - 1;
        int jx = num2.length() - 1;
        int carry = 0;
        StringBuilder sb = new StringBuilder();
        while (ix >= 0 || jx >= 0) {
            int sum = (ix >= 0 ? num1.charAt(ix) - '0' : 0) + (jx >= 0 ? num2.charAt(jx) - '0' : 0) + carry;
            carry = sum / 10;
            sum %= 10;
            sb.append("" + sum);
            ix--; jx--;
        }
        if (carry > 0) {
            sb.append("" + carry);
        }
        return sb.reverse().toString();
    }

    // LC: 415. Add Strings
    // Given two non-negative integers num1 and num2 represented as string, return the sum of num1 and num2.
    // Note:
    // The length of both num1 and num2 is < 5100.
    // Both num1 and num2 contains only digits 0-9.
    // Both num1 and num2 does not contain any leading zero.
    // You must not use any built-in BigInteger library or convert the inputs to integer directly.
    // https://discuss.leetcode.com/topic/62310/straightforward-java-8-main-lines-25ms
    //
    public String addStrings2(String num1, String num2) {
        StringBuilder sb = new StringBuilder();
        int carry = 0;
        for(int i = num1.length() - 1, j = num2.length() - 1; i >= 0 || j >= 0 || carry == 1; i--, j--){
            int x = i < 0 ? 0 : num1.charAt(i) - '0';
            int y = j < 0 ? 0 : num2.charAt(j) - '0';
            sb.append((x + y + carry) % 10);
            carry = (x + y + carry) / 10;
        }
        return sb.reverse().toString();
    }

    // LC: 413. Arithmetic Slices
    // https://leetcode.com/problems/arithmetic-slices/#/description
    // https://discuss.leetcode.com/topic/63302/simple-java-solution-9-lines-2ms
    public int numberOfArithmeticSlices(int[] A) {
        int curr = 0, sum = 0;
        for (int i=2; i<A.length; i++)
            if (A[i]-A[i-1] == A[i-1]-A[i-2]) {
                curr += 1;
                sum += curr;
            } else {
                curr = 0;
            }
        return sum;
    }

    // LC: 400. Nth Digit
    // https://discuss.leetcode.com/topic/59314/java-solution

    public int findNthDigit(int n) {
        int len = 1;
        long count = 9;
        int start = 1;

        while (n > len * count) {
            n -= len * count;
            len += 1;
            count *= 10;
            start *= 10;
        }

        start += (n - 1) / len;
        String s = Integer.toString(start);
        return Character.getNumericValue(s.charAt((n - 1) % len));
    }

    // SP: https://discuss.leetcode.com/topic/59378/short-python-java
    public int findNthDigitSP(int n) {
        n -= 1;
        int digits = 1, first = 1;
        while (n / 9 / first / digits >= 1) {
            n -= 9 * first * digits;
            digits++;
            first *= 10;
        }
        return (first + n/digits + "").charAt(n%digits) - '0';
    }

    // LC: 397. Integer Replacement
    // @see Bits

    // LC: 396. Rotate Function
    // https://discuss.leetcode.com/topic/58616/java-solution-o-n-with-non-mathametical-explaination
    // https://discuss.leetcode.com/topic/58459/java-o-n-solution-with-explanation
    public int maxRotateFunction(int[] A) {
        if(A.length == 0){
            return 0;
        }

        int sum =0, iteration = 0, len = A.length;

        for(int i=0; i<len; i++){
            sum += A[i];
            iteration += (A[i] * i);
        }

        int max = iteration;
        for(int j=1; j<len; j++){
            // for next iteration lets remove one entry value of each entry and the prev 0 * k
            iteration = iteration - sum + A[j-1]*len;
            max = Math.max(max, iteration);
        }

        return max;
    }

    // LC: 372. Super Pow
    // Your task is to calculate ab mod 1337 where a is a positive integer and b is an extremely large positive integer
    // given in the form of an array.
    // Example1:
    // a = 2 b = [3]
    // Result: 8
    // Example2:
    // a = 2 b = [1,0]
    // Result: 1024
    // SP: https://discuss.leetcode.com/topic/50458/1-liners-other-with-explanations
    // SP: https://discuss.leetcode.com/topic/50591/fermat-and-chinese-remainder/2
    // https://discuss.leetcode.com/topic/50586/math-solusion-based-on-euler-s-theorem-power-called-only-once-c-java-1-line-python
    public int superPow(int a, int[] b) {
        if (a % 1337 == 0) return 0;
        int p = 0;
        for (int i : b) p = (p * 10 + i) % 1140;
        if (p == 0) p += 1440;
        return power(a, p, 1337);
    }
    public int power(int a, int n, int mod) {
        a %= mod;
        int ret = 1;
        while (n != 0) {
            if ((n & 1) != 0) ret = ret * a % mod;
            a = a * a % mod;
            n >>= 1;
        }
        return ret;
    }

    // LC: 368. Largest Divisible Subset
    // Given a set of distinct positive integers, find the largest subset such that every pair (Si, Sj) of elements in
    // this subset satisfies: Si % Sj = 0 or Sj % Si = 0.
    // If there are multiple solutions, return any subset is fine.
    // Example 1:
    // nums: [1,2,3] Result: [1,2] (of course, [1,3] will also be ok)
    // e.g.2 nums: [1,2,4,8] Result: [1,2,4,8]
    // https://discuss.leetcode.com/topic/49455/4-lines-in-python
    public List<Integer> largestDivisibleSubset(int[] nums) {
        List<Integer> res = new ArrayList<Integer>();
        if (nums == null || nums.length == 0) return res;
        Arrays.sort(nums);
        int[] dp = new int[nums.length];
        dp[0] = 1;

        //for each element in nums, find the length of largest subset it has.
        for (int i = 1; i < nums.length; i++){
            for (int j = i-1; j >= 0; j--){
                if (nums[i] % nums[j] == 0){
                    dp[i] = Math.max(dp[i],dp[j] + 1);
                }
            }
        }

        //pick the index of the largest element in dp.
        int maxIndex = 0;
        for (int i = 1; i < nums.length; i++){
            maxIndex = dp[i] > dp[maxIndex] ?  i :  maxIndex;
        }

        //from nums[maxIndex] to 0, add every element belongs to the largest subset.
        int temp = nums[maxIndex];
        int curDp = dp[maxIndex];
        for (int i = maxIndex; i >= 0; i--){
            if (temp % nums[i] == 0 && dp[i] == curDp){
                res.add(nums[i]);
                temp = nums[i];
                curDp--;
            }
        }
        return res;
    }

    // LC: 367. Valid Perfect Square
    // Given a positive integer num, write a function which returns True if num is a perfect square else False.
    // Note: Do not use any built-in library function such as sqrt.
    // Example 1:
    // Input: 16 Returns: True
    // Example 2: Input: 14 Returns: False
    // https://discuss.leetcode.com/topic/49342/3-4-short-lines-integer-newton-most-languages
    // https://discuss.leetcode.com/topic/49325/a-square-number-is-1-3-5-7-java-code
    public boolean isPerfectSquare(int num) {
        int low = 1, high = num;
        while (low <= high) {
            long mid = (low + high) >>> 1;
            if (mid * mid == num) {
                return true;
            } else if (mid * mid < num) {
                low = (int) mid + 1;
            } else {
                high = (int) mid - 1;
            }
        }
        return false;
    }

    // LC: 365. Water and Jug Problem
    // You are given two jugs with capacities x and y litres. There is an infinite amount of water supply available.
    // You need to determine whether it is possible to measure exactly z litres using these two jugs.
    // If z liters of water is measurable, you must have z liters of water contained within one or both buckets by
    // the end.
    // Operations allowed:
    // Fill any of the jugs completely with water.
    // Empty any of the jugs.
    // Pour water from one jug into another till the other jug is completely full or the first jug itself is empty.
    // https://discuss.leetcode.com/topic/49238/math-solution-java-solution
    public boolean canMeasureWater(int x, int y, int z) {
        //limit brought by the statement that water is finallly in one or both buckets
        if(x + y < z) return false;
        //case x or y is zero
        if( x == z || y == z || x + y == z ) return true;

        //get GCD, then we can use the property of Bézout's identity
        return z%GCD(x, y) == 0;
    }

    public int GCD(int a, int b){
        while(b != 0 ){
            int temp = b;
            b = a%b;
            a = temp;
        }
        return a;
    }

    // LC: 357. Count Numbers with Unique Digits
    // Given a non-negative integer n, count all numbers with unique digits, x, where 0 ≤ x < 10n.
    // Example:
    // Given n = 2, return 91. (The answer should be the total numbers in the range of 0 ≤ x < 100, excluding
    // [11,22,33,44,55,66,77,88,99])
    // https://discuss.leetcode.com/topic/47983/java-dp-o-1-solution
    // https://discuss.leetcode.com/topic/48332/java-o-1-with-explanation
    public int countNumbersWithUniqueDigits(int n) {
        if (n == 0)     return 1;

        int res = 10;
        int uniqueDigits = 9;
        int availableNumber = 9;
        while (n-- > 1 && availableNumber > 0) {
            uniqueDigits = uniqueDigits * availableNumber;
            res += uniqueDigits;
            availableNumber--;
        }
        return res;
    }

    // LC: 343. Integer Break
    // @see Dynamic Programming

    // LC: 335. Self Crossing
    // You are given an array x of n positive numbers. You start at point (0,0) and moves x[0] metres to the north,
    // then x[1] metres to the west, x[2] metres to the south, x[3] metres to the east and so on. In other words, after
    // each move your direction changes counter-clockwise.
    // Write a one-pass algorithm with O(1) extra space to determine, if your path crosses itself, or not.
    // https://discuss.leetcode.com/topic/38014/java-oms-with-explanation
    // SP: https://discuss.leetcode.com/topic/38068/another-python
    // https://discuss.leetcode.com/topic/39428/simple-java-solution
    public boolean isSelfCrossing(int[] x) {
        int l = x.length;
        if(l <= 3) return false;

        for(int i = 3; i < l; i++){
            if(x[i] >= x[i-2] && x[i-1] <= x[i-3]) return true;  //Fourth line crosses first line and onward
            if(i >=4)
            {
                if(x[i-1] == x[i-3] && x[i] + x[i-4] >= x[i-2]) return true; // Fifth line meets first line and onward
            }
            if(i >=5)
            {
                if(x[i-2] - x[i-4] >= 0 && x[i] >= x[i-2] - x[i-4] && x[i-1] >= x[i-3] - x[i-5] && x[i-1] <= x[i-3]) return true;  // Sixth line crosses first line and onward
            }
        }
        return false;
    }

    // LC: 326. Power of Three
    // Given an integer, write a function to determine if it is a power of three.
    // Follow up:
    // Could you do it without using any loop / recursion?
    // https://discuss.leetcode.com/topic/36150/1-line-java-solution-without-loop-recursion
    // https://discuss.leetcode.com/topic/33536/a-summary-of-all-solutions-new-method-included-at-15-30pm-jan-8th
    public boolean isPowerOfThree(int n) {
        // 1162261467 is 3^19,  3^20 is bigger than int
        return ( n>0 &&  1162261467%n==0);
    }


    // LC: 319. Bulb Switcher
    // There are n bulbs that are initially off. You first turn on all the bulbs. Then, you turn off every second bulb.
    // On the third round, you toggle every third bulb (turning on if it's off or turning off if it's on). For the ith
    // round, you toggle every i bulb. For the nth round, you only toggle the last bulb. Find how many bulbs are on
    // after n rounds.
    // https://discuss.leetcode.com/topic/31929/math-solution
    // https://discuss.leetcode.com/topic/39558/share-my-o-1-solution-with-explanation
    int bulbSwitch(int n) {
        return sqrt(n);
    }

    // LC: 313. Super Ugly Number
    // Write a program to find the nth super ugly number.
    // Super ugly numbers are positive numbers whose all prime factors are in the given prime list primes of size k. For example, [1, 2, 4, 7, 8, 13, 14, 16, 19, 26, 28, 32] is the sequence of the first 12 super ugly numbers given primes = [2, 7, 13, 19] of size 4.
    // Note:
    // (1) 1 is a super ugly number for any given primes.
    // (2) The given numbers in primes are in ascending order.
    // (3) 0 < k ≤ 100, 0 < n ≤ 106, 0 < primes[i] < 1000.
    // (4) The nth super ugly number is guaranteed to fit in a 32-bit signed integer.
    // https://discuss.leetcode.com/topic/34841/java-three-methods-23ms-36-ms-58ms-with-heap-performance-explained
    public int nthSuperUglyNumber(int n, int[] primes) {
        int[] ugly = new int[n];
        int[] idx = new int[primes.length];

        ugly[0] = 1;
        for (int i = 1; i < n; i++) {
            //find next
            ugly[i] = Integer.MAX_VALUE;
            for (int j = 0; j < primes.length; j++)
                ugly[i] = Math.min(ugly[i], primes[j] * ugly[idx[j]]);

            //slip duplicate
            for (int j = 0; j < primes.length; j++) {
                while (primes[j] * ugly[idx[j]] <= ugly[i]) idx[j]++;
            }
        }

        return ugly[n - 1];
    }

    // LC: 279. Perfect Squares
    // @see BFS

    // LC: 273. Integer to English Words
    // https://discuss.leetcode.com/topic/23054/my-clean-java-solution-very-easy-to-understand
    private final String[] LESS_THAN_20 = {"", "One", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve", "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", "Eighteen", "Nineteen"};
    private final String[] TENS = {"", "Ten", "Twenty", "Thirty", "Forty", "Fifty", "Sixty", "Seventy", "Eighty", "Ninety"};
    private final String[] THOUSANDS = {"", "Thousand", "Million", "Billion"};

    public String numberToWords(int num) {
        if (num == 0) return "Zero";

        int i = 0;
        String words = "";

        while (num > 0) {
            if (num % 1000 != 0)
                words = helper(num % 1000) +THOUSANDS[i] + " " + words;
            num /= 1000;
            i++;
        }

        return words.trim();
    }

    private String helper(int num) {
        if (num == 0)
            return "";
        else if (num < 20)
            return LESS_THAN_20[num] + " ";
        else if (num < 100)
            return TENS[num / 10] + " " + helper(num % 10);
        else
            return LESS_THAN_20[num / 100] + " Hundred " + helper(num % 100);
    }

    // LC: 268. Missing Number
    // @see Bits

    // LC: 264. Ugly Number II
    // Write a program to find the n-th ugly number.
    // Ugly numbers are positive numbers whose prime factors only include 2, 3, 5. For example, 1, 2, 3, 4, 5, 6, 8, 9,
    // 10, 12 is the sequence of the first 10 ugly numbers.
    // Note that 1 is typically treated as an ugly number, and n does not exceed 1690.
    // https://discuss.leetcode.com/topic/21791/o-n-java-solution
    public int nthUglyNumber(int n) {
        int[] ugly = new int[n];
        ugly[0] = 1;
        int index2 = 0, index3 = 0, index5 = 0;
        int factor2 = 2, factor3 = 3, factor5 = 5;
        for(int i=1;i<n;i++){
            int min = Math.min(Math.min(factor2,factor3),factor5);
            ugly[i] = min;
            if(factor2 == min)
                factor2 = 2*ugly[++index2];
            if(factor3 == min)
                factor3 = 3*ugly[++index3];
            if(factor5 == min)
                factor5 = 5*ugly[++index5];
        }
        return ugly[n-1];
    }

    // LC: 263. Ugly Number
    // Time: ?? O (log n)?, Space: O(c)
    // https://leetcode.com/problems/ugly-number/?tab=Description
    public boolean isUgly(int num) {
        for (int ix = 2; ix < 6 && num > 0; ix++) {
            while (num % ix == 0) {
                num /= ix;
            }
        }
        return num == 1;
    }

    // LC: 258. Add Digits
    // Time: ??, Space: O(c)
    // https://leetcode.com/problems/add-digits/?tab=Description
    public int addDigits(int num) {
        int n = num;
        while (n / 10 > 0) {
            int result = 0;
            while (n / 10 > 0) {
                result += n % 10;
                n /= 10;
            }
            result += n;
            n = result;
        }
        return n;
    }

    // The essence of this problem is that 10^n ≡ 1 (mod 9), and thus
    // a_n10^n + ... + a_110 + a_0 ≡ a_n + ... + a_1 + a_0 (mod 9).
    // This process can be continued until a number less than 9 is gotten, i.e. num % 9.
    // For any digit n, n = n % 9 unless n = 9. The only confusing case is n % 9 = 0,
    // but addDigits(num) = 0 if and only if num = 0, otherwise it should be 9 in fact.
    int addDigits2(int num) {
        int res = num % 9;
        return (res != 0 || num == 0) ? res : 9;
    }

    // LC: 233. Number of Digit One
    // Given an integer n, count the total number of digit 1 appearing in all non-negative integers less than or equal to n.
    // For example:
    // Given n = 13,
    // Return 6, because digit 1 occurred in the following numbers: 1, 10, 11, 12, 13.
    // Show Hint
    // https://discuss.leetcode.com/topic/18054/4-lines-o-log-n-c-java-python
    public int countDigitOne(int n) {
        int ones = 0;
        for (long m = 1; m <= n; m *= 10)
            ones += (n/m + 8) / 10 * m + (n/m % 10 == 1 ? n%m + 1 : 0);
        return ones;
    }


    // LC: 231. Power of Two
    // Given an integer, write a function to determine if it is a power of two.
    // @see Bits

    // LC: 224. Basic Calculator
    // @see Stacks

    // LC: 223. Rectangle Area
    // Find the total area covered by two rectilinear rectangles in a 2D plane.
    // Each rectangle is defined by its bottom left corner and top right corner as shown in the figure.
    // Assume that the total area is never beyond the maximum possible value of int.
    // https://discuss.leetcode.com/topic/17705/just-another-short-way/3
    public int computeArea(int A, int B, int C, int D, int E, int F, int G, int H) {
        int left = Math.max(A,E), right = Math.max(Math.min(C,G), left);
        int bottom = Math.max(B,F), top = Math.max(Math.min(D,H), bottom);
        return (C-A)*(D-B) - (right-left)*(top-bottom) + (G-E)*(H-F);
    }



    // LC: 204. Count Primes
    // Count the number of prime numbers less than a non-negative number, n.
    // https://discuss.leetcode.com/topic/13654/my-simple-java-solution
    public int countPrimes(int n) {
        boolean[] notPrime = new boolean[n];
        int count = 0;
        for (int i = 2; i < n; i++) {
            if (notPrime[i] == false) {
                count++;
                for (int j = 2; i*j < n; j++) {
                    notPrime[i*j] = true;
                }
            }
        }

        return count;
    }


    // LC: 202. Happy Number
    // Write an algorithm to determine if a number is "happy".
    // A happy number is a number defined by the following process: Starting with any positive integer, replace the
    // number by the sum of the squares of its digits, and repeat the process until the number equals 1 (where it
    // will stay), or it loops endlessly in a cycle which does not include 1. Those numbers for which this process ends
    // in 1 are happy numbers.
    // https://discuss.leetcode.com/topic/12587/my-solution-in-c-o-1-space-and-no-magic-math-property-involved
    public boolean isHappy(int n) {
        Set<Integer> inLoop = new HashSet<Integer>();
        int squareSum,remain;
        while (inLoop.add(n)) {
            squareSum = 0;
            while (n > 0) {
                remain = n%10;
                squareSum += remain*remain;
                n /= 10;
            }
            if (squareSum == 1)
                return true;
            else
                n = squareSum;

        }
        return false;

    }


    // LC: 172. Factorial Trailing Zeroes
    // Given an integer n, return the number of trailing zeroes in n!.
    // Note: Your solution should be in logarithmic time complexity.
    // https://discuss.leetcode.com/topic/6516/my-one-line-solutions-in-3-languages
    public int trailingZeroes(int n) {
        return n == 0 ? 0 : n / 5 + trailingZeroes(n / 5);
    }

    // LC: 171. Excel Sheet Column Number
    // Given a column title as appear in an Excel sheet, return its corresponding column number.
    // https://discuss.leetcode.com/topic/6458/my-solutions-in-3-languages-does-any-one-have-one-line-solution-in-java-or-c
    public int titleToNumber(String s) {
        int result = 0;
        for (int i = 0; i < s.length(); result = result * 26 + (s.charAt(i) - 'A' + 1), i++);
        return result;
    }


    // LC: 168. Excel Sheet Column Title
    // Time: O(log(26) n), Space: ??
    // https://leetcode.com/problems/excel-sheet-column-title/?tab=Description
    public String convertToTitle(int n) {
        String lookup = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
        char[] lchars = lookup.toCharArray();

        StringBuilder sb = new StringBuilder();
        while (n > 0) {
            int r = (n - 1) % 26;
            sb.append(lchars[r]);
            n = (n - 1) / 26;
        }
        return sb.reverse().toString();
    }

    // LC: 166. Fraction to Recurring Decimal
    // @see Hashtables


    // LC: 149. Max Points on a Line
    // @see Hashtables


    // LC: 69. Sqrt(x)
    // https://discuss.leetcode.com/topic/8680/a-binary-search-solution
    public int sqrt(int x) {
        if (x == 0)
            return 0;
        int left = 1, right = Integer.MAX_VALUE;
        while (true) {
            int mid = left + (right - left)/2;
            if (mid > x/mid) {
                right = mid - 1;
            } else {
                if (mid + 1 > x/(mid + 1))
                    return mid;
                left = mid + 1;
            }
        }
    }


    // LC: 67. Add Binary
    // @see Bits


    // 66. Plus One
    // @see Arrays

    // LC: 65. Valid Number
    // Validate if a given string is numeric.
    // Some examples:
    // "0" => true " 0.1 " => true "abc" => false "1 a" => false "2e10" => true
    // Note: It is intended for the problem statement to be ambiguous. You should gather all requirements up front
    // before implementing one.
    // https://discuss.leetcode.com/topic/9490/clear-java-solution-with-ifs
    public boolean isNumber(String s) {
        s = s.trim();

        boolean pointSeen = false;
        boolean eSeen = false;
        boolean numberSeen = false;
        boolean numberAfterE = true;
        for(int i=0; i<s.length(); i++) {
            if('0' <= s.charAt(i) && s.charAt(i) <= '9') {
                numberSeen = true;
                numberAfterE = true;
            } else if(s.charAt(i) == '.') {
                if(eSeen || pointSeen) {
                    return false;
                }
                pointSeen = true;
            } else if(s.charAt(i) == 'e') {
                if(eSeen || !numberSeen) {
                    return false;
                }
                numberAfterE = false;
                eSeen = true;
            } else if(s.charAt(i) == '-' || s.charAt(i) == '+') {
                if(i != 0 && s.charAt(i-1) != 'e') {
                    return false;
                }
            } else {
                return false;
            }
        }

        return numberSeen && numberAfterE;
    }

    // LC: 60. Permutation Sequence
    // The set [1,2,3,…,n] contains a total of n! unique permutations.
    // By listing and labeling all of the permutations in order,
    // We get the following sequence (ie, for n = 3):
    // https://discuss.leetcode.com/topic/17348/explain-like-i-m-five-java-solution-in-o-n
    public String getPermutation(int n, int k) {
        int pos = 0;
        List<Integer> numbers = new ArrayList<>();
        int[] factorial = new int[n+1];
        StringBuilder sb = new StringBuilder();

        // create an array of factorial lookup
        int sum = 1;
        factorial[0] = 1;
        for(int i=1; i<=n; i++){
            sum *= i;
            factorial[i] = sum;
        }
        // factorial[] = {1, 1, 2, 6, 24, ... n!}

        // create a list of numbers to get indices
        for(int i=1; i<=n; i++){
            numbers.add(i);
        }
        // numbers = {1, 2, 3, 4}

        k--;

        for(int i = 1; i <= n; i++){
            int index = k/factorial[n-i];
            sb.append(String.valueOf(numbers.get(index)));
            numbers.remove(index);
            k-=index*factorial[n-i];
        }

        return String.valueOf(sb);
    }

    // LC: 50. Pow(x, n)
    // Implement pow(x, n).
    public double myPow(double x, int n) {
        if(n == 0) return 1.;
        double res = myPow(x, n / 2);
        return n % 2 == 0 ? res * res : n < 0 ? res * res * (1 / x) : res * res * x;
    }

    // LC: 43. Multiply Strings
    // https://discuss.leetcode.com/topic/30508/easiest-java-solution-with-graph-explanation
    public String multiply(String num1, String num2) {
        int m = num1.length(), n = num2.length();
        int[] pos = new int[m + n];

        for(int i = m - 1; i >= 0; i--) {
            for(int j = n - 1; j >= 0; j--) {
                int mul = (num1.charAt(i) - '0') * (num2.charAt(j) - '0');
                int p1 = i + j, p2 = i + j + 1;
                int sum = mul + pos[p2];

                pos[p1] += sum / 10;
                pos[p2] = (sum) % 10;
            }
        }

        StringBuilder sb = new StringBuilder();
        for(int p : pos) if(!(sb.length() == 0 && p == 0)) sb.append(p);
        return sb.length() == 0 ? "0" : sb.toString();
    }

    // https://discuss.leetcode.com/topic/9449/brief-c-solution-using-only-strings-and-without-reversal
//    string multiply(string num1, string num2) {
//        string sum(num1.size() + num2.size(), '0');
//
//        for (int i = num1.size() - 1; 0 <= i; --i) {
//            int carry = 0;
//            for (int j = num2.size() - 1; 0 <= j; --j) {
//                int tmp = (sum[i + j + 1] - '0') + (num1[i] - '0') * (num2[j] - '0') + carry;
//                sum[i + j + 1] = tmp % 10 + '0';
//                carry = tmp / 10;
//            }
//            sum[i] += carry;
//        }
//
//        size_t startpos = sum.find_first_not_of("0");
//        if (string::npos != startpos) {
//            return sum.substr(startpos);
//        }
//        return "0";
//    }

    // LC: 29. Divide Two Integers
    public int divide(int dividend, int divisor) {
        //Reduce the problem to positive long integer to make it easier.
        //Use long to avoid integer overflow cases.
        int sign = 1;
        if ((dividend > 0 && divisor < 0) || (dividend < 0 && divisor > 0))
            sign = -1;
        long ldividend = Math.abs((long) dividend);
        long ldivisor = Math.abs((long) divisor);

        //Take care the edge cases.
        if (ldivisor == 0) return Integer.MAX_VALUE;
        if ((ldividend == 0) || (ldividend < ldivisor))	return 0;

        long lans = ldivide(ldividend, ldivisor);

        int ans;
        if (lans > Integer.MAX_VALUE){ //Handle overflow.
            ans = (sign == 1)? Integer.MAX_VALUE : Integer.MIN_VALUE;
        } else {
            ans = (int) (sign * lans);
        }
        return ans;
    }


    private long ldivide(long ldividend, long ldivisor) {
        // Recursion exit condition
        if (ldividend < ldivisor) return 0;

        //  Find the largest multiple so that (divisor * multiple <= dividend),
        //  whereas we are moving with stride 1, 2, 4, 8, 16...2^n for performance reason.
        //  Think this as a binary search.
        long sum = ldivisor;
        long multiple = 1;
        while ((sum+sum) <= ldividend) {
            sum += sum;
            multiple += multiple;
        }
        //Look for additional value for the multiple from the reminder (dividend - sum) recursively.
        return multiple + ldivide(ldividend - sum, ldivisor);
    }

    // LC: 13. Roman to Integer
    // Given a roman numeral, convert it to an integer.
    // Input is guaranteed to be within the range from 1 to 3999.
    // https://discuss.leetcode.com/topic/821/my-solution-for-this-question-but-i-don-t-know-is-there-any-easier-way
    public int romanToInt(String s) {
        int res = 0;
        for (int i = s.length() - 1; i >= 0; i--) {
            char c = s.charAt(i);
            switch (c) {
                case 'I':
                    res += (res >= 5 ? -1 : 1);
                    break;
                case 'V':
                    res += 5;
                    break;
                case 'X':
                    res += 10 * (res >= 50 ? -1 : 1);
                    break;
                case 'L':
                    res += 50;
                    break;
                case 'C':
                    res += 100 * (res >= 500 ? -1 : 1);
                    break;
                case 'D':
                    res += 500;
                    break;
                case 'M':
                    res += 1000;
                    break;
            }
        }
        return res;
    }


    // LC: 12. Integer to Roman
    // Given an integer, convert it to a roman numeral.
    // Input is guaranteed to be within the range from 1 to 3999.
    // https://discuss.leetcode.com/topic/12384/simple-solution
    public String intToRoman(int num) {
        String M[] = {"", "M", "MM", "MMM"};
        String C[] = {"", "C", "CC", "CCC", "CD", "D", "DC", "DCC", "DCCC", "CM"};
        String X[] = {"", "X", "XX", "XXX", "XL", "L", "LX", "LXX", "LXXX", "XC"};
        String I[] = {"", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX"};
        return M[num/1000] + C[(num%1000)/100] + X[(num%100)/10] + I[num%10];
    }

    // LC: 9. Palindrome Number
    // Determine whether an integer is a palindrome. Do this without extra space.
    public boolean isPalindrome(int x) {
        int count = 0;
        while (x / 10 > 0) {
            count++;
        }
        int pow = count * 10;
        int xReal = x;
        for (int ix = 0; ix < count / 2; ix++) {
            if ( x % 10 != xReal / pow) { return false; }
        }
    }


    // LC: 8. String to Integer (atoi)
    // Implement atoi to convert a string to an integer.
    // Hint: Carefully consider all possible input cases. If you want a challenge, please do not see below and ask
    // yourself what are the possible input cases.
    // Notes: It is intended for this problem to be specified vaguely (ie, no given input specs). You are responsible
    // to gather all the input requirements up front.
    // https://discuss.leetcode.com/topic/12473/java-solution-with-4-steps-explanations
    public int myAtoi(String str) {
        int index = 0, sign = 1, total = 0;
        //1. Empty string
        if(str.length() == 0) return 0;

        //2. Remove Spaces
        while(str.charAt(index) == ' ' && index < str.length())
            index ++;

        //3. Handle signs
        if(str.charAt(index) == '+' || str.charAt(index) == '-'){
            sign = str.charAt(index) == '+' ? 1 : -1;
            index ++;
        }

        //4. Convert number and avoid overflow
        while(index < str.length()){
            int digit = str.charAt(index) - '0';
            if(digit < 0 || digit > 9) break;

            //check if total will be overflow after 10 times and add digit
            if(Integer.MAX_VALUE/10 < total || Integer.MAX_VALUE/10 == total && Integer.MAX_VALUE %10 < digit)
                return sign == 1 ? Integer.MAX_VALUE : Integer.MIN_VALUE;

            total = 10 * total + digit;
            index ++;
        }
        return total * sign;
    }

    // LC: 7. Reverse Integer
    // https://discuss.leetcode.com/topic/6104/my-accepted-15-lines-of-code-for-java
    public int reverse(int x)
    {
        int result = 0;

        while (x != 0)
        {
            int tail = x % 10;
            int newResult = result * 10 + tail;
            if ((newResult - tail) / 10 != result)
            { return 0; }
            result = newResult;
            x = x / 10;
        }

        return result;
    }

    // LC: 2. Add Two Numbers
    // https://discuss.leetcode.com/topic/799/is-this-algorithm-optimal-or-what
    public ListNode addTwoNumbers(ListNode l1, ListNode l2) {
        ListNode c1 = l1;
        ListNode c2 = l2;
        ListNode sentinel = new ListNode(0);
        ListNode d = sentinel;
        int sum = 0;
        while (c1 != null || c2 != null) {
            sum /= 10;
            if (c1 != null) {
                sum += c1.val;
                c1 = c1.next;
            }
            if (c2 != null) {
                sum += c2.val;
                c2 = c2.next;
            }
            d.next = new ListNode(sum % 10);
            d = d.next;
        }
        if (sum / 10 == 1)
            d.next = new ListNode(1);
        return sentinel.next;
    }
}
