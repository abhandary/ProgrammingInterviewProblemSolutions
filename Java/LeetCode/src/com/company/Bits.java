package com.company;

/**
 * Created by akshayb on 3/3/17.
 */
public class Bits {


    // 
    // https://leetcode.com/problems/convert-a-number-to-hexadecimal/?tab=Description
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

    // 371. Sum of Two Integers
    // Time: O(n), space: O(n)
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
}
