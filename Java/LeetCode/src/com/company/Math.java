package com.company;

/**
 * Created by akshayb on 3/7/17.
 */
public class Math {

    // 415. Add Strings
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

    // 263. Ugly Number
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

    // 258. Add Digits
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

    // 168. Excel Sheet Column Title
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
}
