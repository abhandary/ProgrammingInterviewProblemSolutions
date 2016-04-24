//
//  EPI.cpp
//  EPI
//
//  Created by Akshay Bhandary on 3/6/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "EPI.hpp"

#include <vector>
#include <unordered_map>
#include <string>
#include <complex>
#include <queue>
#include <unordered_set>
#include <algorithm>
#include <set>
#include <iostream>
#include <istream>
#include <algorithm>
#include <map>
#include <stack>
#include <random>

using namespace std;

class Solution
{
public:
#pragma mark - EPI 5.1 Parity
    short Parity(int64_t x) {
        
        x ^= x >> 32;
        x ^= x >> 16;
        x ^= x >> 8;
        x ^= x >> 4;
        x ^= x >> 2;
        x ^= x >> 1;
        
        return x & 0x1;
    }
    // Run Time: O(log n) where n is the word size
#pragma mark - EPI 5.2 Swap Bits
    long SwapBits(long x, int i, int j) {
        if (((x >> i) & 1) != ((x >> j) & 1)) {
            // two bits are not alike
            long bitMask = 1L << i | 1L << j;
            x ^= bitMask;
        }
        return x;
    }
    // Run Time: O(1)
#pragma mark - EPI 5.3 Reverse Bits
    long ReverseBits(long x) {
        short lookup[65536];
        int kBitMask = 0xFFFF;
        int kWordSize = 16;
        x = (lookup[(x & kBitMask)] << kWordSize * 3) |
            (lookup[((x >> kWordSize) & kBitMask)] << kWordSize * 2 ) |
            (lookup[((x >> kWordSize * 2) & kBitMask)] << kWordSize ) |
            (lookup[((x >> kWordSize * 3) & kBitMask)]);
        return x;
    }
    // Run Time: O(n/L)
#pragma mark - EPI 5.4 Closest Integer with Same Weight
    unsigned long closestBitSameWeightCount (unsigned long x) {
        unsigned long y = x;
        for (int ix = 0; ix < sizeof(x) * 4 - 1; ix++) {
            if (((x >> ix) & 1) != ((x >> (ix + 1)) & 1)) {
                unsigned long bitMask = 1UL << ix | 1UL << (ix + 1);
                y ^= bitMask;
                return y;
            }
        }
        return 0;
    }
    // Run Time: O(n)
#pragma mark - EPI 5.6 Divide X / Y
    unsigned divide (unsigned x, unsigned y) {
        unsigned result = 0;
        unsigned long long y_shift = (unsigned long long)y << 32;
        unsigned long long pow = 1UL << 32;
        while (x) {
            while (y_shift > x) {
                y_shift >>= 1;
                pow >>= 1;
            }
            x -= y_shift;
            result += pow;
        }
        return result;
    }
    // Run Time: O(n)
#pragma mark - EPI 5.7 x pow (y)

#pragma mark - EPI 5.8 Reverse Digits
    long reverse (int x) {
        bool isMinus = x < 0? true: false;
        x = abs(x);
        long result = 0;
        while (x) {
            result *= 10;
            result += x % 10;
            x /= 10;
        }
        return isMinus? -result: result;
    }
    // Run Time : O(d)
#pragma mark - EPI 5.9 Check if a Decimal int is a palindrome
    bool isPlaindrome(int x) {
        
        int numDigits = log10(x) + 1;
        int x_msd = x;
        int x_lsd = x;
        int msdMask = pow(10, numDigits - 1);
        for (int ix = 0; ix < numDigits / 2; ix++) {
            x_msd = x_msd / msdMask;
            x_lsd = x_lsd % 10;
            if (x_msd != x_lsd) {
                return false;
            }
            x_msd %= msdMask;
            x_lsd /= 10;
            msdMask /= 10;
        }
        
        return true;
    }
    // Run Time: O(d)
#pragma mark - EPI 10 Generate Uniform Random Numbers
    int zeroOneGen() {
        return rand() % 2;
    }
    int uniformRandom(int lower_bound, int upper_bound) {
        int num_outcomes = upper_bound - lower_bound + 1;
        int result = 0;
        
        do {
            for (int ix = 0; (1 << ix) < num_outcomes; ix++) {
                result = (result << 1) | zeroOneGen();
            }
        }while (result >= num_outcomes);
        
        return result;
    }
    // Run Time: O(lg(b - a + 1)
    
#pragma mark -
#pragma mark - EPI 6.1 Dutch Flag Partition 
    void dutchFlagPartition(int pivot_index, vector<int>& A) {
        std::swap(A[0], A[pivot_index]);
        pivot_index = 0;
        
        int smaller = 0;
        int equal = 0;
        size_t larger = A.size();
        while (equal < larger) {
            if (A[equal] == A[pivot_index]) {
                equal++;
            } else if (A[equal] < A[pivot_index]) {
                std::swap(A[smaller++], A[equal++]);
            } else {
                std::swap(A[--larger], A[equal]);
            }
        }
    }
    // Run Time: O(n)
#pragma mark - EPI 6.2 Increment an arbit precision integer
    vector<int> increment(const vector<int>& in) {
        vector<int> result = in;
        result.back()++;
        for (size_t ix = result.size() - 1; ix > 0 && result[ix] == 10; ix--) {
            result[ix] = 0;
            result[ix - 1]++;
        }
        if (result[0] == 10) {
            result[0] = 0;
            result.insert(result.begin(), 1);
        }
        return result;
    }
    // Run Time: O(n)
    
#pragma mark - EPI 6.3 Multiply Two Arbit precision integers
    vector<int> multiply(const vector<int>& num1, const vector<int>& num2) {
        vector<int> result(num1.size() + num2.size(), 0);
        vector<int> n1 = num1;
        vector<int> n2 = num2;
        
        std::reverse(n1.begin(), n1.end());
        std::reverse(n2.begin(), n2.end());
        
        for (int ix = 0; ix < n1.size(); ix++) {
            for (int jx = 0; jx < n2.size(); jx++) {
                result[ix + jx]  = result[ix] * result[jx];
                result[ix + jx + 1] = result[ix + jx] / 10;
                result[ix + jx] %= 10;
            }
        }
        int ix = 0;
        for (ix = n1.size() + n2.size() - 1; result[ix] == 0 && ix > 0; ix--) {
            result.pop_back();
        }
        

        std::reverse(result.begin(), result.end());
        return result;
    }
    // Run Time: O(nm)
    
#pragma mark - EPI 6.12 Sample offline data
    void RandomSampling(int k, vector<int>* A_ptr) {
        vector<int>& A = *A_ptr;
        
        default_random_engine gen((random_device())());
        for (int ix = 0; ix < k; ix++) {
            uniform_int_distribution<int> dis(ix, A.size() - 1);
            swap(A[ix], A[dis(gen)]);
        }
    }

    
#pragma mark - EPI 7.1
    string intToString(int n)
    {
        string result = "";
        bool isMinus = n < 0? true: false;
        n = abs(n);
        
        do {
            result += (n % 10) + '0';
            n /= 10;
            
        }while (n);
        
        if (isMinus) {
            result += '-';
        }
        
        std::reverse(result.begin(), result.end());
        
        return result;
    }
    // Run Time: O(log10 n)
    
    int stringToInt(const string& s) {
        bool isMinus = s.front() == '-'? true: false;
        int result = 0;
        for (int ix = isMinus?1:0; ix < s.size(); ix++) {
            result *= 10;
            result += s[ix] - '0';
        }
        return isMinus? -result: result;
    }
    // Run Time: O(n)
    
    
#pragma mark - EPI 7.2 Base Conversion
    string convertBase(string s, int b1, int b2) {
        string result;
        int decimal = 0;
        for (int ix = 0; ix < s.size(); ix++) {
            decimal *= b1;
            decimal += isdigit(s[ix])? s[ix] - '0': s[ix] - 'A' + 10;
        }
        
        do {
            int digit = decimal % b2;
            result += digit <= 9? digit + '0': digit - 10 + 'A';
            decimal /= b2;
        }while (decimal);
        
        std::reverse(result.begin(), result.end());
        
        return result;
    }
    // Run Time: O(n(1 + logb2b1))
    
#pragma mark - EPI 7.3 Spreadsheet column encoding
    int ssDecodeColID(string s) {
        int result = 0;
        
        for (int ix = 0; ix < s.size(); ix++) {
            result *= 26;
            result += s[ix] - 'A' + 1;
        }
        
        return result;
    }
    // Run Time: O(n)
    
#pragma mark - EPI 7.4 Replace and Remove
    // Replace each 'a' by two d's
    // Delete each entry containing a 'b'
    int replaceAndRemove(int size, char s[]) {
        int countA = 0;
        int write_ix = 0;
        for (int ix = 0; ix < size; ix++) {
            if (s[ix] != 'b') {
                s[write_ix++] = s[ix];
            }
            if (s[ix] == 'a') {
                countA++;
            }
        }
        int ix = write_ix - 1;
        int wix = write_ix + countA - 1;
        while (ix >= 0) {
            if (s[ix] != 'a') {
                s[wix--] = s[ix];
            } else {
                s[wix--] = 'd';
                s[wix--] = 'd';
            }
            ix--;
        }
        return write_ix + countA;
    }
    // Run Time: O(n), Space: O(1)
    
#pragma mark - EPI 7.5 Test Palindromicity
    bool isPalindrome(const string& s) {
        int left = 0;
        int right = s.size() - 1;
        
        while (left < right) {
            if (!isalnum(s[left]) && left < right) {
                left++;
            }
            if (!isalnum(s[right]) && left < right) {
                right--;
            }
            if (tolower(s[left++]) != tolower(s[right--])) {
                return false;
            }
        }
        return true;
    }
    // Run Time: O(n)

#pragma mark - EPI 7.6 Reverse all the words in a sentence
    void reverseSentence(string* s_ptr) {
        string& s = *s_ptr;
        std::reverse(s.begin(), s.end());
        size_t end = 0;
        size_t start = 0;
        while ((end = s.find(" ", start)) != string::npos) {
            std::reverse(s.begin() + start, s.begin() + end);
            start = end + 1;
        }
        std::reverse(s.begin() + start, s.end());
    }
    // Run Time: O(n)
    
#pragma mark - EPI 7.7 Mnemonics for a Phone Number
    vector<string> phoneMnemonic(const string& number) {
        string partial(number.size(), 0);
        vector<string> results;
        phoneMnemonicHelper(number, partial, 0, results);
        return results;
    }
    
    void phoneMnemonicHelper(string number, string partial, int offset, vector<string>& results) {
        if (offset == number.size()) {
            results.emplace_back(partial); // O(n) to make a copy
            return;
        }
        
        static string lookup[] = {"0", "1", "abc", "def", "ghi", "jkl", "mno", "pqrs", "tuv", "wxyz"};
        
        for(char c : lookup[number[offset] - '0']) {
            phoneMnemonicHelper(number, partial + c, offset + 1, results);
        }
    }
    
    // Run Time: T(n) <= 4T(n) = O(4raiseN * N)
#pragma mark - 7.8 The Look and Say Problem
    string lookAndSay(int n) {
        string result = "1";
        for (int ix = 1; ix < n; ix++) {
            result = nextLookAndSay(result);
        }
        return result;
    }
    string nextLookAndSay(const string& s) {
        string result;
        int count = 1;
        int ix = 1;
        for (ix = 1; ix < s.size(); ix++) {
            if (s[ix] == s[ix - 1]) {
                count++;
            } else {
                result += to_string(count) + s[ix - 1];
            }
        }
        result += to_string(count) + s[ix - 1];
        return result;
    }
    
    string nextLookAndSay2(const string& s) {
        string result;
        for (int ix = 0; ix < s.size(); ix++) {
            int count = 1;
            while(ix + 1 < s.size() && s[ix] == s[ix + 1]) {
                count++; ix++;
            }
            result += to_string(count) + s[ix];
        }
        return result;
    }
    
#pragma mark - EPI 7.9 Convert From Roman to Decimal
    int romanToDecimal(const string& roman) {
        unordered_map<char, int> lookup;
        lookup['M'] = 1000;
        lookup['D'] = 500;
        lookup['C'] = 100;
        lookup['L'] = 50;
        
 
        int sum =lookup[roman.size() - 1];
        for (int ix = roman.size() - 2; ix >= 0; ix--) {
            
            if (lookup[ix] < lookup[ix + 1]) {
                sum -= lookup[ix];
            } else {
                sum += lookup[ix];
            }
        }
        return sum;
    }
    // Run Time: O(n)
    
#pragma mark - EPI 7.10 Compute all valid IP Addresses
    vector<string> getValidIPAddresses(const string& s) {
        vector<string> results;
        for (int ix = 1; ix <= 3 && ix < s.size(); ix++) {
            string s1 = s.substr(0, ix);
            if (!isValid(s1)) {
                continue;
            }
            for (int jx = 1; jx <= 3 && ix + jx < s.size(); jx++) {
                string s2 = s.substr(ix, jx);
                if (!isValid(s2)) {
                    continue;
                }
                for (int zx = 1; zx <= 3 && ix + jx + zx < s.size(); zx++) {
                    string s3 = s.substr(ix + jx, zx);
                    if (!isValid(s3)) {
                        continue;
                    }
                    string s4 = s.substr(ix + jx + zx);
                    if (isValid(s4)) {
                        results.emplace_back(s1 + "." + s2 + "." + s3 + "." + s4);
                    }
                }
            }
        }
        return results;
    }
    bool isValid(const string& sub) {
        return false;
    }
    
#pragma mark - EPI 7.11 Write a string sinusoidally

#pragma mark - EPI 7.12 Implement RLE
    string encoding(const string& s) {
        string result;
        for (int ix = 0; ix < s.size(); ix++) {
            int count = 1;
            while (ix + 1 < s.size() && s[ix] == s[ix + 1]) {
                count++; ix++;
            }
            result += to_string(count) + s[ix];
        }
        return result;
    }
    // Run Time: O(n)

#pragma mark EPI 11.2 Sort an Increasing-Decreasing Array
    vector<int> mergeSorted(const vector<vector<int>>& arrays) {
        vector<int> array;
        
        return array;
    }
    vector<int> sortKIncreasingDecreasingArray(const vector<int>& A) {
        typedef enum {INC, DEC} SubarrayType;
        vector<vector<int>> subarrays;
        
        SubarrayType type = INC;
        int start_ix = 0;
        for (int ix = 1; ix <= A.size(); ix++) {
            if (ix == A.size() ||
                (type == INC && A[ix - 1] >= A[ix]) ||
                (type == DEC && A[ix - 1] < A[ix])) {
                    if (type == INC) {
                        subarrays.emplace_back(A.begin() + start_ix, A.begin() + ix);
                    } else {
                        subarrays.emplace_back(A.rbegin() + A.size() - ix, A.rbegin() + A.size() - start_ix);
                    }
                    start_ix = ix;
                }
        }
        return mergeSorted(subarrays);
    }

    
};




int main() {
    
    vector<int> myArray = {1, 2, 3, 4, 5, 6};
    Solution s;
   // s.RandomSampling(2, &myArray);
   // int sameWeight = s.closestBitSameWeightCount(134);
   // int result = s.divide(166, 13);
  //  int rev = s.reverse(-64312);
    string result = s.encoding("aaaaabccca");
    return 0;
}
