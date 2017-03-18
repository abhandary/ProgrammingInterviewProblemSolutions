package com.company;

import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/3/17.
 */
public class Bits {

    HashMap<Integer, Integer> hm;

    Bits() {
        hm = new HashMap<>();
    }

    // LC - 405. Convert a Number to Hexadecimal
    // O(c), space: O(c)
    // https://leetcode.com/problems/convert-a-number-to-hexadecimal/?tab=Description
    public String toHex2(int num) {
        String lookup = "0123456789abcdef";
        char[] table = lookup.toCharArray();

        if (num == 0) { return "0"; }
        int mask = 0xf;
        StringBuffer sb = new StringBuffer();
        while (num != 0) {
            sb.append(table[num & mask]);
            num >>>= 4;
        }
        return sb.reverse().toString();
    }

    public String toHex(int num) {
        String lookup = "0123456789abcdef";
        char[] table = lookup.toCharArray();

        if (num == 0) { return "0"; }
        int mask = 0xf;
        StringBuffer sb = new StringBuffer();
        for (int ix = 0; ix < 8 && num != 0; ix++) {
            sb.append(table[num & mask]);
            num >>= 4;
        }
        return sb.reverse().toString();
    }

    // LC - 389. Find the Difference
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/find-the-difference/?tab=Description
    public char findTheDifference(String s, String t) {
        char result = '\0';
        int ix = 0;
        char[] schars = s.toCharArray();
        char[] tchars = t.toCharArray();
        for (ix = 0; ix < schars.length; ix++) {
            result ^= schars[ix] ^ tchars[ix];
        }
        result ^= tchars[ix];
        return result;
    }

    // LC - 397. Integer Replacement
    // Time: ?? Time: ??
    // https://leetcode.com/problems/integer-replacement/?tab=Description
    public int integerReplacement(int n) {
        if (n <= 1) { return 0; }
        if (n == Integer.MAX_VALUE) { return 32; }


        if (hm.get(n) == null) {
            if ((n & 1) != 0) {
                hm.put(n, 1 + Math.min(integerReplacement( n - 1), integerReplacement(n + 1)));
            } else {
                hm.put(n, 1 + integerReplacement( n / 2));
            }
        }
        return hm.get(n);
    }
    // LC - 371. Sum of Two Integers
    // Time: O(k), space: O(n)
    // https://leetcode.com/problems/sum-of-two-integers/?tab=Description
    int getSum(int a, int b) {
        while (b != 0) {
            int temp = a ^ b;
            b = (a & b) << 1;
            a = temp;
        }
        return a;
    }

    int getSumRecursive(int a, int b) {
        return b==0? a:getSum(a^b, (a&b)<<1); //be careful about the terminating condition;
    }

    // LC - 338. Counting Bits
    // Time: O(n), Space: O(c) outside of the result
    // https://leetcode.com/problems/counting-bits/?tab=Solutions
    public int[] countBits(int num) {
        int[] result = new int[num + 1];
        for (int ix = 1; ix <= num; ix++) {
            result[ix] = result[ix >>> 1] + (ix & 1);
        }
        return result;
    }

    // LC - 268. Missing Number
    // Time: O(n), Space: O(c)
    // https://leetcode.com/problems/missing-number/?tab=Description
    public int missingNumber(int[] nums) {
        int missing = 0;
        int ix = 0;
        for (ix = 0; ix < nums.length; ix++) {
            missing ^= nums[ix] ^ ix;
        }
        return ix ^ missing;
    }

    // LC - 231. Power of Two
    // Time: O(c), space: O(c)
    // https://leetcode.com/problems/power-of-two/?tab=Description
    public boolean isPowerOfTwo(int n) {
        return n > 0 && ((n & (n - 1)) == 0);
    }

    // LC - 191. Number of 1 Bits
    // Time: O(k), where k is the number of bits, Space: O(c)
    // https://leetcode.com/problems/number-of-1-bits/?tab=Description
    public int hammingWeight(int n) {
        int count = 0;

        // cannot use n > 0 here since input 2147483648 would correspond to -2147483648
        // in java and the code would not enter the while if the condition is
        // n>0 for n=2147483648.
        while (n != 0) {
            n &= (n - 1);
            count++;
        }
        return count;
    }


    // This is a naive implementation, shown for comparison, and to help in understanding the better functions.
    // It uses 24 arithmetic operations (shift, add, and).
    int hammingWeight2(int n)
    {
        n = (n & 0x55555555) + (n >>  1 & 0x55555555); // put count of each  2 bits into those  2 bits
        n = (n & 0x33333333) + (n >>  2 & 0x33333333); // put count of each  4 bits into those  4 bits
        n = (n & 0x0F0F0F0F) + (n >>  4 & 0x0F0F0F0F); // put count of each  8 bits into those  8 bits
        n = (n & 0x00FF00FF) + (n >>  8 & 0x00FF00FF); // put count of each 16 bits into those 16 bits
        n = (n & 0x0000FFFF) + (n >> 16 & 0x0000FFFF); // put count of each 32 bits into those 32 bits
        return n;
    }

    // This uses fewer arithmetic operations than any other known implementation on machines with slow multiplication.
    // It uses 17 arithmetic operations.
    int hammingWeight3(int n)
    {
        n -= (n >> 1) & 0x55555555; //put count of each 2 bits into those 2 bits
        n = (n & 0x33333333) + (n >> 2 & 0x33333333); //put count of each 4 bits into those 4 bits
        n = (n + (n >> 4)) & 0x0F0F0F0F; //put count of each 8 bits into those 8 bits
        n += n >> 8; // put count of each 16 bits into those 8 bits
        n += n >> 16; // put count of each 32 bits into those 8 bits
        return n & 0xFF;
    }

    // This uses fewer arithmetic operations than any other known implementation on machines with fast multiplication.
    // It uses 12 arithmetic operations, one of which is a multiply.
    int hammingWeight4(int n)
    {
        n -= (n >> 1) & 0x55555555; // put count of each 2 bits into those 2 bits
        n = (n & 0x33333333) + (n >> 2 & 0x33333333); // put count of each 4 bits into those 4 bits
        n = (n + (n >> 4)) & 0x0F0F0F0F; // put count of each 8 bits into those 8 bits
        return n * 0x01010101 >> 24; // returns left 8 bits of x + (x<<8) + (x<<16) + (x<<24)
    }

    // LC - 190. Reverse Bits
    // Time: O(c), Space: O(c)
    // https://leetcode.com/problems/reverse-bits/?tab=Solutions
    public int reverseBits(int n) {
        n = (n >>> 16) | (n << 16);
        n = ((n & 0xff00ff00) >>> 8) | ((n & 0x00ff00ff) << 8);
        n = ((n & 0xf0f0f0f0) >>> 4) | ((n & 0x0f0f0f0f) << 4);
        n = ((n & 0xcccccccc) >>> 2) | ((n & 0x33333333) << 2);
        n = ((n & 0xaaaaaaaa) >>> 1) | ((n & 0x55555555) << 1);
        return n;
    }

    // 136. Single Number
    // Time: O(n), Space: O(c)
    // Given an array of integers, every element appears twice except for one. Find that single one.
    // https://leetcode.com/problems/single-number/?tab=Description
    public int singleNumber(int[] nums) {
        if (nums.length == 0) { return -1; }
        int num = nums[0];
        for (int ix = 1; ix < nums.length; ix++) {
            num ^= nums[ix];
        }
        return num;
    }

    // 67. Add Binary
    // https://leetcode.com/problems/add-binary/?tab=Description
    public String addBinary(String a, String b) {
        char[] bchars = b.toCharArray();
        char[] achars = a.toCharArray();
        StringBuilder result = new StringBuilder();
        int ix = achars.length - 1, jx = bchars.length - 1;
        int c = 0;
        while (ix >= 0 || jx >= 0 || c == 1) {
            c += (ix >= 0 ? achars[ix] - '0' : 0);
            c += (jx >= 0 ? bchars[jx] - '0' : 0);
            result.append((c % 2) + "");
            c /= 2;
            ix--; jx--;
        }
        return result.reverse().toString();
    }
}
