//
//  main.cpp
//  C++ Practice
//
//  Created by Akshay Bhandary on 9/6/15.
//  Copyright (c) 2015 Akshay Bhandary. All rights reserved.
//

#include <iostream>
#include <vector>
#include <stack>
#include <unordered_map>
#include <set>
#include <algorithm>
#include <ostream>
#include <sstream>

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
};

struct Interval {
    int start;
    int end;
    Interval() : start(0), end(0) {}
    Interval(int s, int e) : start(s), end(e) {}
};

struct Compare {
    bool operator() (Interval l,Interval r) { return (l.start != r.start? l.start < r.start: l.end < r.end);}
} ;

class Solution {
public:

    // 1. Two Sum
    
    vector<int> twoSum(vector<int>& nums,
                       int target) {
        vector<int> result;
        unordered_map<int, int> map;
        for(int ix=0; ix < nums.size();ix++) {
            map[nums[ix]] = ix;
        }
        
        for(int ix=0; ix < nums.size(); ix++) {
            unordered_map<int, int>::iterator it
            = map.find(target - nums[ix]);
            if(it != map.end() &&
               it->second > ix) {
                result.emplace_back(ix + 1);
                result.emplace_back(it->second + 1);
                return result;
            } 
        } // end for
        return result;
    }
    

    
    // 2. Add Two Numbers:
    ListNode* addTwoNumbers(ListNode* l1,
                            ListNode* l2) {
        ListNode* head = NULL;
        ListNode* tail = NULL;
        ListNode* itr1 = l1;
        ListNode* itr2 = l2;
        int carry = 0;
        while(itr1 || itr2) {
            int sum = (itr1?itr1->val:0) +
            (itr2?itr2->val:0) + carry;
            ListNode* temp = new ListNode(sum % 10);
            carry = sum / 10;
            if (tail) tail->next = temp;
            tail = temp;
            head = head == NULL? tail: head;
            itr1 = itr1?itr1->next:NULL;
            itr2 = itr2?itr2->next:NULL;
        }
        if (carry) tail->next = new ListNode(carry);
        return head;
    }
    
    // 3. Longest Substring without Repeating Characters (HARD)
    // Given a string, find the length of the longest substring without repeating characters
    int lengthOfLongestSubstring(string s) {
        int start = 0;
        int maxSoFar = 0;
        unordered_map<char, int> map;
        for(int ix=0; ix<s.size(); ix++) {
            if (map.find(s[ix])!= map.end())
            {
                if (map[s[ix]] >= start) {
                    maxSoFar = ix - start> maxSoFar? ix - start: maxSoFar;
                    start = map[s[ix]] + 1;
                }
            }
            map[s[ix]] = ix;
        }
        maxSoFar = s.size()-start > maxSoFar? s.size() - start: maxSoFar;        
        return maxSoFar;
    }

    
    // 4. Median of Two Sorted Arrays
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2)
    {
        int ix = 0, jx = 0;
        int tx = 0;
        int total=nums1.size()+nums2.size();
        vector<int> result(total, 0);
        
        while(tx < total) {
            if (ix<nums1.size()&&jx< nums2.size()) {
                result[tx++] = nums1[ix] < nums2[jx]? nums1[ix++]: nums2[jx++];
            } else if (ix < nums1.size()) {
                result[tx++] = nums1[ix++];
            } else {
                result[tx++] = nums2[jx++];
            }
        } // end of while loop
        
        if (total % 2 == 0) {
            return (result[total / 2] + result[total / 2 - 1]) / 2.0;
        } else {
            return result[total / 2];
        }
    }

    // 6. ZigZag Conversion
    string convert(string s, int numRows) {
        if (numRows == 1) return s;
        string result = "";
        int step = 2 * numRows - 2;
        for (int n=0; n<numRows; n++) {
            if (n == 0 || n == numRows - 1) {
                for(int ix = n; ix < s.size(); ix += step) {
                    result += s[ix];
                }
            } else {
                int j = n;
                bool flag = true;
                int step1 = 2*(numRows-1-n);
                int step2 = step - step1;
                
                while (j < s.length()) {
                    result += s[j];
                    j = flag? j + step1: j + step2;
                    flag = !flag;
                }                
            }
        }
        return result;
    }

    // 7. Reverse Integer
    int reverse(int x) {
        bool isMinus = false;
        isMinus = x < 0? true: false;
        x = abs(x);
        int reverse = 0;
        
        while(x) {
            reverse *= 10;
            int val = x % 10;
            reverse += val;
            x /= 10;
        }
        return isMinus? -reverse: reverse;
    }

    
    // 9. Palindrome Number
    bool isPalindrome(int x) {
        if (x < 0) return false;
        int kNumDigits = floor(log10(x)) + 1;
        int x_remain = x;
        int msd_shift = pow(10, kNumDigits - 1);
        
        for(int ix=0; ix<kNumDigits/2; ix++) {
            if (x_remain/msd_shift!=x%10) {
                return false;
            }
            x_remain %= msd_shift;
            x /= 10;
            msd_shift /= 10;
        } // end for
        return true;
    }

    
    // 12 Roman to Integer
    int romanToInt(string s) {
        unordered_map<char, int> roman;
        roman['M'] = 1000;
        roman['D'] = 500;
        roman['C'] = 100;
        roman['L'] = 50;
        roman['X'] = 10;
        roman['V'] = 5;
        roman['I'] = 1;
        
        int number = 0;
        int currMax = 0;
        for (int ix = s.size() - 1; ix >= 0; ix--) {
            int val = roman[s[ix]];
            number = val<currMax?number-val:number+val;
            currMax = val > currMax? val:currMax;
        } // end for
        return number;
    }

    // 13. Integer to Roman:
    string intToRoman(int num) {
        string res;
        int n_M = int(num/1000);
        res += string(n_M,'M');
        num = num%1000;
        int n_C = int(num/100);
        if (n_C!=0){
            if (n_C<=3){res += string(n_C,'C');}
            if (n_C==4){res += "CD";}
            if (n_C>=5 && n_C<=8){ res+="D";res += string(n_C-5,'C');}
            if (n_C==9){res += "CM";}
        }
        num = num%100;
        int n_X = int(num/10);
        if (n_X!=0){
            if (n_X<=3){res += string(n_X,'X');}
            if (n_X==4){res += "XL";}
            if (n_X>=5 && n_X<=8){res+="L"; res += string(n_X-5,'X'); }
            if (n_X==9){res += "XC";}
        }
        num = num%10;
        int n_I = int(num/1);
        if (n_I!=0){
            if (n_I<=3){res += string(n_I,'I');}
            if (n_I==4){res += "IV";}
            if (n_I>=5 && n_I<=8){res+="V"; res += string(n_I-5,'I'); }
            if (n_I==9){res += "IX";}
        }
        return res;       
    }

    // 15 3 SUM (kind of works, times out)
    vector<vector<int>> threeSum(vector<int>& nums) {
        sort(nums.begin(), nums.end());
        vector<vector<int>> output;
        for (int ix=0; ix<nums.size(); ix++) {
            int a = nums[ix];
            int start = ix + 1;
            int end = nums.size() - 1;
            while (start < end) {
                int b = nums[start];
                int c = nums[end];
                if (a+b+c == 0) {
                    vector<int> result {a, b, c};
                    output.push_back(result);
                    start++; end--;
                } else if (a+b+c > 0) {
                    end--;
                } else {
                    start++;
                }
            }
        }  
        return output;
    }
    
    // 16 3 SUM Closest (kind of works)
    int threeSumClosest(vector<int>& nums, int target) {
        int diffFromTarget = INT32_MAX;
        sort(nums.begin(), nums.end());
        int result = -1;
        for(int ix = 0; ix < nums.size(); ix++) {
            int a = nums[ix];
            int start = ix + 1;
            int end = nums.size() - 1;
            while (start < end) {
                int b = nums[start];
                int c = nums[end];
                if (a+b+c == target) {
                    return target;
                }
                int sum = a+b+c;
                if (target>=0 && target-sum < diffFromTarget || target < 0 && target - sum > diffFromTarget) {
                    result = sum;
                    diffFromTarget = target - sum;
                }
                sum>target?end--:start++;
            }
        }
        return result;
    }
    
    // 19 Remove Nth Node From End of List
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        if (head == NULL) return NULL;
        ListNode* dummy = new ListNode(0);
        dummy->next = head;
        ListNode* itr = dummy;
        int ix = 0;
        for(ix = 0;ix < n && itr->next;ix++) {
            itr = itr->next;
        }
        if (ix < n) return head;
        ListNode* itr2 = dummy;
        while (itr->next) {
            itr = itr->next;
            itr2 = itr2->next;
        }
        itr2->next = itr2->next->next;
        return dummy->next;
    }

    // 20 Valid Parantheses
    char invert(char c) {
        return c;
    }
    
    bool isValid(string s) {
        stack<char> mystack;
        
        for(int ix = 0; ix < s.size(); ix++) {
            if(s[ix]=='(' || s[ix]=='{' || s[ix]=='[') {
                mystack.push(s[ix]);
            } else {
                if (mystack.size() == 0 || mystack.top() != invert(s[ix])) {
                    return false;
                }
                mystack.pop();
            }
        }
        return mystack.size() == 0;
    }

    
    // 22 Generate Parentheses
    void genParenHelper(int left, int right, string s, vector<string>& result)
    {
        if (left > right) return;
        
        if (left == 0 && right == 0) {
            result.emplace_back(s);
            return;
        }
        if (left > 0) {
            genParenHelper(left - 1, right, s + '(', result);
            
        }
        
        if (left < right) {
            genParenHelper(left, right - 1, s + ')', result);
        }
    }
    
    vector<string> generateParenthesis(int n) {
        string s = "";
        vector<string> result;
        genParenHelper(n, n, s, result);
        return result;
    }
    
    
    // 38 Count and Say
    string countAndSay(int n) {
        string s = "1";
        string result = s;
        for (int ix = 1 ;ix < n; ix++) {
            s = result;
            result = "";
            int curr = 1;
            for(int jx = 0; jx < s.size();jx++) {
                if (jx + 1 < s.size() && s[jx + 1] == s[jx]) {
                    curr++;
                } else {
                    char num  = curr + '0';
                    result += num;
                    result += s[jx];
                }
            }
        }
        return result;
    }
    
    // 49 Group Anagrams
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        unordered_map<string, set<string>> map;
        
        for(int ix = 0; ix < strs.size(); ix++) {
            string sorted = strs[ix];
            sort(sorted.begin(), sorted.end());
            map[sorted].emplace(strs[ix]);
        }
        vector<vector<string>> result;
        for(auto kv: map) {
            vector<string> intermediate;
            copy(kv.second.begin(), kv.second.end(), back_inserter(intermediate));
            for (int ix = 0; ix < intermediate.size(); ix++) {
                cout << intermediate[ix] << std::endl;
            }
            result.emplace_back(intermediate);
        }
        return result;
    }
    
    // 48 Rotate Image
    void rotate(vector<vector<int>>& matrix) {
        int start = 0;
        int end   = matrix.size() - 1;
        while (start < end) {
            for (int ix = start; ix < end;ix++) {
                int temp = matrix[start][ix];
                matrix[start][ix] = matrix[end - ix][start];
                matrix[end - ix][start] = matrix[end][end - ix];
                matrix[end][end - ix] = matrix[start + ix][end];
                matrix[start + ix][end] = temp;
            }
            start++, end--;
        }
    }
    
    // 56 Merge Intervals
    vector<Interval> merge(vector<Interval>& intervals) {
        if (intervals.size() == 0) return intervals;
        
        sort(intervals.begin(), intervals.end(), Compare());
        vector<Interval> result;
        Interval curr = intervals[0];
        for(int ix = 1; ix < intervals.size(); ix++) {
            if (intervals[ix].start <= curr.end) {
                curr.end = curr.end > intervals[ix].end? curr.end: intervals[ix].end;
                curr.start = intervals[ix].start < curr.start?intervals[ix].start: curr.start;
            } else {
                result.emplace_back(curr);
                curr = intervals[ix];
            }
        }
        result.emplace_back(curr);
        return result;
    }
    // 31 Next Permutation
    void nextPermutation(vector<int>& nums) {
        if (nums.size() == 0) return;
        int ix;
        for (ix = nums.size() - 2; ix >= 0; ix--) {
            if (nums[ix] < nums[ix - 1]) break;
        }
        
        if (ix < 0) {
            sort(nums.begin(), nums.end());
        } else {
            int jx;
            for (jx = ix + 1; jx < nums.size() && nums[jx] > nums[ix]; jx++);
            swap(nums[ix], nums[jx - 1]);
            ::reverse(nums.begin() + ix + 1, nums.end());
        }
    }
    
    // 61 Rotate List (passed 213 / 230
    ListNode* rotateRight(ListNode* head, int k) {
        if (head == NULL || k == 0) return head;
        int count = 0;
        
        ListNode* itr = head;
        while(itr) {
            count++;
            itr = itr->next;
        }
        k = k % count;
        itr = head;
        for(int ix = 0; ix < k && itr->next; ix++) {
            itr = itr->next;
        }
        
        // if (ix == k)
        {
            ListNode* headItr = head;
            while(itr->next) {
                itr = itr->next;
                headItr = headItr->next;
            }
            
            ListNode* temp = headItr->next;
            itr->next = head;
            headItr->next = NULL;
            head = temp;
        }
        return head;
    }

    // 189 Rotate Array
    void rotate(vector<int>& nums, int k) {
        k = k % nums.size();
        if (k == 0) return;
        
        ::reverse(nums.end() - k, nums.end());
        ::reverse(nums.begin(), nums.end());
        ::reverse(nums.begin() + k, nums.end());
    }
    
    // 43 Multiply Strings
    string multiply(string num1, string num2) {
        ::reverse(num1.begin(), num1.end());
        ::reverse(num2.begin(), num2.end());
        
        int carry = 0;
        vector<int> result(num1.size() + num2.size(), 0);
        for (int ix = 0; ix < num1.size(); ix++) {
            for(int jx = 0; jx < num2.size(); jx++) {
                result[ix + jx] += (num1[ix] - '0') * (num2[jx] - '0');
                result[ix + jx + 1] += result[ix + jx] / 10;
                result[ix + jx] %= 10;
            }
        }
        int ix = 0;
        for(ix = result.size() - 1; ix > 0 && result[ix] == 0; ix--);
        
        stringstream ss;
        while(ix >= 0 ) {
            ss << result[ix];
            ix--;
        }
        
        return ss.str();
    }
    
    // 64 Minimum Path Sum
    int minPathSum(vector<vector<int>>& grid) {
        vector<vector<int>> sum = grid;
        for(int ix = 0; ix < grid.size(); ix++) {
            for(int jx = 0; jx < grid[ix].size(); jx++) {
                if (ix == 0 && jx == 0) continue;
                int s1 = ix > 0?(sum[ix][jx] + sum[ix - 1][jx]):INT32_MAX;
                int s2 = jx > 0?(sum[ix][jx]  + sum[ix][jx - 1]):INT32_MAX;
                sum[ix][jx] = s1 < s2?s1: s2;
            }
        }
        return sum.back().back();
    }
    
    // 67 Add Binary
    string addBinary(string a, string b) {
        int ix = a.size() - 1;
        int jx = b.size() - 1;
        string output = "";
        int carry = 0;
        while(ix >= 0 || jx >= 0) {
            int result = (ix >= 0?a[ix--] - '0':0) + (jx >= 0?b[jx--] - '0':0) + carry;
            output += (result % 2 + '0');
            carry = result / 2;
        }
        if (carry) output += carry + '0';
        ::reverse(output.begin(), output.end());
        return output;
    }
    
    // 74 Search a 2D Matrix
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        if (matrix.size() == 0) return false;
        int rstart = 0;
        int cstart = 0;
        int rend = matrix.size() - 1;
        int cend = matrix[0].size() - 1;
        
        while (rstart <= rend && cstart <= cend) {
            
            if (target < matrix[rstart][cstart]) {
                return false;
            }
            
            if (target == matrix[rstart][cstart]) {
                return true;
            }

            if (target > matrix[rstart][cend]) {
                rstart++;
            }
            else  {
                cstart++;
            }
        }
        return false;
    }
};

int main(int argc, const char * argv[]) {
    // insert code here...
    Solution sol;
    vector<string> strings = {"eat", "tea", "tan", "ate", "nat", "bat"};
    std::cout << "Hello, World!\n";
    vector<int> nums = {1, 2};
    sol.nextPermutation(nums);
    sol.groupAnagrams(strings);
    
    stringstream ss;
    copy(nums.begin(), nums.end(), ostream_iterator<int>(ss, " "));
    cout << " nums:" << ss.str() << std::endl;
    cout << " mult:" << sol.multiply("1", "1") << endl;
    
    vector<vector<int>> matrix = {{1,3,5,7},{10,11,16,20},{23,30,34,50}};
    
    cout << "Matrix Search:" << sol.searchMatrix(matrix, 3) << endl;
    
    return 0;
}
