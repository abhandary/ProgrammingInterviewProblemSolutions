//
//  All.cpp
//  EPI
//
//  Created by Akshay Bhandary on 3/6/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//


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

typedef struct {
    bool balanced;
    int height;
}RetVal;

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

struct TreeLinkNode {
    TreeLinkNode *left;
    TreeLinkNode *right;
    TreeLinkNode *next;
};

struct UndirectedGraphNode {
    int label;
    vector<UndirectedGraphNode *> neighbors;
    UndirectedGraphNode(int x) : label(x) {};
};

static bool largestCompare(int num1, int num2) {
    string s1 = to_string(num1);
    string s2 = to_string(num2);
    string sa = s1 + s2;
    string sb = s2 + s1;
    return sa.compare(sb) >= 0;
}

class Solution {
public:
#pragma mark -    LC 1 Two Sum
    
    vector<int> twoSum(vector<int>& nums, int target) {
        unordered_map<int, int> myset;
        for (int ix = 0; ix < nums.size(); ix++) {
            myset[nums[ix]] = ix;
        }
        vector<int> results;
        for (int ix = 0; ix < nums.size(); ix++)
        {
            int k = target - nums[ix];
            if (myset.find(k) != myset.end() &&
                myset[k] != ix)
            {
                results.push_back(ix);
                results.push_back(myset[k]);
                break;
            }
        }
        return results;
    }
    
#pragma mark -    LC 2 Add Two Numbers
    ListNode* addTwoNumbers(ListNode* l1, ListNode* l2) {
        
        int carry = 0;
        ListNode* head = NULL;
        ListNode* tail = NULL;
        
        while (l1 || l2) {
            int sum = l1? l1->val: 0;
            sum += l2? l2->val:0;
            sum += carry;
            carry = sum / 10;
            ListNode* temp = new ListNode(sum % 10);
            if (!head) {
                head = temp;
            } else {
                tail->next = temp;
            }
            tail = temp;
            l1 = l1? l1->next: NULL;
            l2 = l2? l2->next: NULL;
        }
        if (carry) {
            tail->next = new ListNode(carry);
        }
        return head;
    }
    
#pragma mark -    LC 3 Longest Substring Without Repeating Characters
    int lengthOfLongestSubstring(string s)
    {
        unordered_map<char, int> last_seen;
        int max_len = 0;
        int last_distinct = 0;
        for (int ix = 0; ix < s.size(); ix++) {
            
            if (last_seen.find(s[ix]) != last_seen.end() &&
                last_seen[s[ix]] >= last_distinct)
            {
                max_len = max(max_len, ix - last_distinct);
                last_distinct = last_seen[s[ix]] + 1;
            }
            last_seen[s[ix]] = ix;
            
        }
        max_len = max(max_len, (int)s.size() - last_distinct);
        return max_len;
    }

    
#pragma mark -    LC 5 Longest Palindromic Substring
    string expandAroundCenter(string s, int c1, int c2) {
        while (c1 >= 0 && c2 < s.size() && s[c1] == s[c2]) {
            c1--, c2++;
        }
        return s.substr(c1 + 1, c2 - c1 - 1);
    }
    
    string longestPalindrome(string s) {
        int longest = 0;
        string longestString = s.substr(0, 1);
        for (int ix = 0; ix < s.size() - 1; ix++) {
            string p1 = expandAroundCenter(s, ix, ix);
            if (p1.size() > longest) {
                longest = p1.size();
                longestString = p1;
            }
            
            string p2 = expandAroundCenter(s, ix, ix + 1);
            if (p2.size() > longest) {
                longest = p2.size();
                longestString = p2;
            }
        }
        return longestString;
    }
    
#pragma mark -    LC 6 Zig Zag Conversion
    string convert(string s, int numRows) {
        if (numRows == 1) return s;
        string result = "";
        int step = 2 * numRows - 2;
        for (int n = 0; n < numRows; n++) {
            if (n == 0 || n == numRows - 1) {
                for(int ix = n; ix < s.size(); ix += step) {
                    result += s[ix];
                }
            } else {
                int j = n;
                bool flag = true;
                int step1 = 2 * (numRows - 1 - n);
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
    
#pragma mark -    LC 7
    int reverse(int x) {
        bool isMinus = x < 0? true: false;
        x = abs(x);
        long long result = 0;
        
        while (x) {
            result *= 10;
            int digit = (x % 10);
            x /= 10;
            
            if (result > INT_MAX - digit) return 0;
            
            result += digit;
        }
        
        return isMinus? -result: result;
    }
    
    
#pragma mark -    LC 8
    int myAtoi(string str) {
        int ix = 0;
        while (str[ix] == ' ') {
            ix++;
            
        }
        bool isPlus = false;
        if (str[ix] == '+') {
            isPlus = true; ix++;
        }
        bool isMinus = false;
        if (str[ix] == '-') {
            isMinus = true;
            ix++;
        }
        if (isPlus && isMinus) return false;
        int val = 0;
        for (; ix < str.size(); ix++) {
            if (!isdigit(str[ix])) {
                break;
            }
            val *= 10;
            int newVal = str[ix] - '0';
            if (!isMinus && val > INT_MAX -newVal) {
                val = INT_MAX;
                break;
            }
            if (isMinus && -val < INT_MIN + newVal) {
                val = INT_MIN; break;
            }
            val += str[ix] - '0';
        }
        
        return isMinus? -val: val;
    }
    
#pragma mark -    LC 9
    bool isPalindrome(int x) {
        
        if (x < 0) {
            return false;
        }
        
        int numDigits = log10(x) + 1;
        int msd = numDigits - 1;
        
        for (int ix = 0; ix < numDigits / 2; ix++) {
            int div = pow(10, msd);
            if (x / div  != x % 10) {
                return false;
            }
            x %= div;
            x /= 10;
            msd -= 2;
        }
        return true;
    }
    
#pragma mark -    LC 11
    int maxArea(vector<int>& height) {
        if (height.empty() || height.size() < 2)  {
            return 0;
        }
        
        int left = 0;
        int right = height.size() - 1;
        int maxArea = 0;
        while (left < right) {
            int area = (right - left) * min(height[right], height[left]);
            maxArea = max(maxArea, area);
            if (height[right] < height[left]) {
                right--;
            } else {
                left++;
            }
        }
        return maxArea;
    }
    
#pragma mark -    LC 12
    string intToRoman(int num) {
        map<int, string> intToRoman;
        intToRoman[1000] = "M";
        intToRoman[900]  = "CM";
        intToRoman[500]  = "D";
        intToRoman[400]  = "CD";
        intToRoman[100]  = "C";
        intToRoman[90]   = "XC";
        intToRoman[50]   = "L";
        intToRoman[40]   = "XL";
        intToRoman[10]   = "X";
        intToRoman[5]    = "V";
        intToRoman[9]    = "IX";
        intToRoman[4]    = "IV";
        intToRoman[1]    = "I";
        
        string result;
        map<int, string>::reverse_iterator rit = intToRoman.rbegin();
        while (rit != intToRoman.rend())
        {
            while (num >= rit->first)
            {
                result += rit->second;
                num -= rit->first;
            }
            ++rit;
        }
        return result;
    }
    
#pragma mark -    LC 13
    int romanToInt(string s) {
        unordered_map<char, int> roman;
        roman['M'] = 1000;
        roman['C'] = 100;
        roman['D'] = 500;
        roman['L'] = 50;
        roman['X'] = 10;
        roman['V'] = 5;
        roman['I'] = 1;
        
        int maxSeen = 0;
        int sum = 0;
        for(int ix = s.size() - 1; ix >= 0; --ix) {
            char c = s[ix];
            if (roman[c] >= maxSeen) {
                maxSeen = roman[c];
                sum += maxSeen;
            } else {
                sum -= roman[c];
            }
        }
        return sum;
    }
    
#pragma mark -    LC 14
    string longestCommonPrefix(vector<string>& strs) {
        
        if (strs.size() == 0) return "";
        string result = "";
        int pos = 0;
        char ch = 0;
        
        while (1) {
            for (int ix = 0; ix < strs.size(); ix++) {
                string & curr = strs[ix];
                if (pos >= curr.size() || (ix > 0 && ch != curr[pos])) {
                    return result;
                }
                ch = ix == 0? curr[pos]: ch;
            }
            result += ch;
            pos++;
        }
        return result;
    }
    
#pragma mark -    LC 15
    bool isPresent(vector<vector<int>>& results, vector<int>& result) {
        for (int ix = 0; ix < results.size(); ix++) {
            if (results[ix][0] == result[0] &&
                results[ix][1] == result[1] &&
                results[ix][2] == result[2]) {
                return true;
            }
        }
        return false;
    }
    
    vector<vector<int>> threeSum(vector<int>& nums) {
        
        vector<vector<int>> results;
        if (nums.size() == 0 || nums.size() < 3) return results;
        sort(nums.begin(), nums.end());
        
        for (int ax = 0; ax < nums.size() - 2; ax++) {
            int left = ax + 1;
            int right = nums.size() - 1;
            while (left < right) {
                if (nums[ax] + nums[left] + nums[right] == 0) {
                    vector<int> result {nums[ax], nums[left], nums[right]};
                    results.push_back(result);
                    right--;
                    // while (left < right && nums[right] == nums[right - 1]) right--;
                    //    while (left < right && nums[left] == nums[left + 1]) left++;
                } else if (nums[ax] + nums[left] + nums[right] > 0) {
                    right--;
                } else {
                    left++;
                }
            }
        }
        return results;
    }
    
#pragma mark -    LC 17
    vector<string> letterCombinations(string digits) {
        vector<string> results;
        if (digits.size() == 0) return results;
        vector<string> combinations = {"0", "1", "abc",
            "def", "ghi", "jkl",
            "mno", "pqrs", "tuv",
            "wxyz"};
        
        lcHelper(digits, 0, "", results, combinations);
        return results;
    }
    
    void lcHelper(string digits,
                  int offset,
                  string partial,
                  vector<string>& results,
                  const vector<string>& combinations)
    {
        if (offset == digits.size()) {
            results.push_back(partial);
            return;
        }
        
        int num = digits[offset] - '0';
        for (int ix = 0; ix < combinations[num].size(); ix++) {
            lcHelper(digits, offset + 1, partial + combinations[num][ix], results, combinations);
        }
    }
    
#pragma mark -    LC 19
    ListNode* removeNthFromEnd(ListNode* head, int n) {
        if (head == NULL) return head;
        ListNode* dummyHead = new ListNode(0);
        dummyHead->next = head;
        ListNode* forward = dummyHead;
        int ix = 0;
        for (; ix < n && forward->next; ix++) {
            forward = forward->next;
        }
        if (ix == n) {
            ListNode* trail = dummyHead;
            while(forward->next) {
                trail = trail->next;
                forward = forward->next;
            }
            trail->next = trail->next->next;
        }
        return dummyHead->next;
    }
    
#pragma mark -    LC 20
    char invert(char c){
        if (c == ')') return '(';
        if (c == ']') return '[';
        if (c == '}') return '{';
        return 0;
    }
    bool isValid(string s) {
        stack<char> mystack;
        
        for (char c : s) {
            if (c == '{' || c == '[' || c == '(') {
                mystack.push(c);
            } else {
                if (mystack.empty() || mystack.top() != invert(c)) {
                    return false;
                }
                mystack.pop();
            }
        }
        return mystack.size() == 0;
    }

#pragma mark -    LC 21
    ListNode* mergeTwoLists(ListNode* l1, ListNode* l2) {
        ListNode* dummyHead = new ListNode(0);
        ListNode* tail = dummyHead;
        while (l1 && l2) {
            if (l1->val < l2->val) {
                tail->next = l1;
                tail = l1;
                l1 = l1->next;
            } else {
                tail->next = l2;
                tail = l2;
                l2 = l2->next;
            }
            tail->next = NULL;
        }
        if (l1) {
            tail->next = l1;
        } else {
            tail->next = l2;
        }
        return dummyHead->next;
    }
    
#pragma mark -    LC 22
    void gpHelper(int numLeft, int numRight, string partial, vector<string>& results) {
        if (numRight == 0) {
            results.push_back(partial);
            return;
        }
        if (numLeft > 0) {
            gpHelper(numLeft - 1, numRight, partial + "(", results);
            
        }
        if (numLeft < numRight) {
            gpHelper(numLeft, numRight - 1, partial + ")", results);
        }
        
    }
    vector<string> generateParenthesis(int n) {
        vector<string> results;
        string partial = "";
        gpHelper(n, n, partial, results);
        return results;
    }
    
#pragma mark -    LC 26
    int removeDuplicates(vector<int>& nums)
    {
        int rx = 0;
        int wx = 0;
        while (rx < nums.size()) {
            nums[wx++] = nums[rx++];
            while (rx < nums.size() && nums[rx - 1] == nums[rx]) {
                rx++;
            }
        }
        return wx;
    }
    
#pragma mark -    LC 27
    int removeElement(vector<int>& nums, int val) {
        int wx = 0;
        int rx = 0;
        while(rx < nums.size()) {
            if (nums[rx] != val) {
                nums[wx++] = nums[rx++];
            } else {
                rx++;
            }
        }
        return wx;
    }
    
#pragma mark -    LC 28
    int strStr(string haystack, string needle) {
        
        if (needle.size() > haystack.size()) return -1;
        
        int kBase = 26;
        int kMod = 997;
        int haystackHash = 0;
        int needleHash = 0;
        int powerHash = 1;
        int ix = 0;
        
        for (ix = 0; ix < needle.size(); ix++) {
            needleHash = (needleHash*kBase + needle[ix]) % kMod;
            haystackHash = (haystackHash*kBase + haystack[ix]) % kMod;
            powerHash = ix == 0? powerHash: (powerHash * kBase) % kMod;
        }
        
        for (ix = 0; ix < haystack.size() - needle.size(); ix++) {
            if (needleHash == haystackHash && !haystack.compare(ix, needle.size(), needle)) {
                return ix;
            }
            haystackHash -= (powerHash * haystack[ix]) % kMod;
            if (haystackHash < 0) {
                haystackHash += kMod;
            }
            haystackHash = ((haystackHash * kBase) + haystack[ix + needle.size()]) % kMod;
        }
        if (needleHash == haystackHash && !haystack.compare(haystack.size() - needle.size(), needle.size(), needle)) {
            return haystack.size() - needle.size();
        }
        return -1;
    }
    
#pragma mark -    LC 29
    int divide(int dividend, int divisor) {
        bool isMinus = dividend < 0? true: false;
        isMinus = divisor < 0? !isMinus: isMinus;
        
        long long x = abs(dividend);
        long long y = (long long)abs(divisor) << 32;
        long long pow = 1L << 32;
        long long div = 0;
        while (x > 0) {
            while (y > x) {
                pow >>= 1;
                y >>= 1;
            }
            div += pow;
            x -= y;
        }
        return isMinus? -div: div;
    }
    
#pragma mark -    LC 33
    int search(vector<int>& nums, int target) {
        
        int low = 0;
        int high = nums.size() - 1;
        while (low <= high) {
            int mid = (low + high) / 2;
            if (nums[mid] == target) {
                return mid;
            }
            if ((target > nums[mid] && target <= nums[high]) ||
                (target > nums[mid] && nums[high] <= nums[mid] && nums[low] >= nums[high]) ||
                (target < nums[mid] && target <= nums[high] &&  nums[high] <= nums[mid])) {
                low = mid + 1;
            }
            else
            {
                high = mid - 1;
            }
        }
        return -1;
    }
    
#pragma mark -    LC 36
    bool isValidSudoku(vector<vector<char>>& board) {
        
        // check each row
        for (int ix = 0; ix < board.size(); ix++) {
            if (hasDuplicates(board, ix, ix+1, 0, board.size())) {
                return false;
            }
        }
        
        // check each column
        for (int jx = 0; jx < board.size(); jx++) {
            if (hasDuplicates(board, 0, board.size(), jx, jx+1)) {
                return false;
            }
        }
        
        int quadrant = sqrt(board.size());
        // check each grid
        for(int I = 0; I < quadrant; I++) {
            for (int J = 0; J < quadrant; J++) {
                if (hasDuplicates(board, I*quadrant, (I + 1)*quadrant, J*quadrant, (J + 1)*quadrant )) {
                    return false;
                }
            }
        }
        return true;
    }
    
    bool hasDuplicates(const vector<vector<char>>& board, int rowStart, int rowEnd, int colStart, int colEnd)
    {
        unordered_set<int> boardMap;
        for (int ix = rowStart; ix < rowEnd; ix++) {
            for (int jx = colStart; jx < colEnd; jx++) {
                if (board[ix][jx] == '.') continue;
                
                if (boardMap.count(board[ix][jx])) {
                    return true;
                }
                boardMap.emplace(board[ix][jx]);
            }
        }
        return false;
    }
    
#pragma mark -    LC 38
    string countAndSay(int n) {
        string s = "";
        if (n == 0) return s;
        s = "1";
        for (int ix = 0; ix < n - 1; ix++) {
            string newString = "";
            int count = 1;
            for (int sx = 1; sx < s.size(); sx++) {
                if (s[sx] != s[sx - 1]) {
                    newString += to_string(count) + s[sx - 1];
                    count = 1;
                } else {
                    count++;
                }
            }
            newString += to_string(count) + s.back();
            s = newString;
        }
        return s;
    }
    
#pragma mark -    LC 43
    string multiply(string num1, string num2) {
        
        vector<int> result(num1.size() + num2.size(), 0);
        std::reverse(num1.begin(), num1.end());
        std::reverse(num2.begin(), num2.end());
        
        for (int ix = 0; ix < num1.size(); ix++) {
            for (int jx = 0; jx < num2.size(); jx++) {
                int mult = (num1[ix] - '0') * (num2[jx] - '0');
                result[ix + jx] += mult;
                result[ix + jx + 1] += result[ix + jx] / 10;
                result[ix + jx] %= 10;
            }
        }
        
        int ix;
        for (ix = result.size() - 1; result[ix] == 0 && ix > 0; ix--) {
            
        }
        string output;
        for (; ix >= 0; ix--) {
            output += result[ix] + '0';
        }
        
        return output;
    }
    
#pragma mark -    LC 46
    void permuteHelper(vector<int>& nums, int offset, vector<int>& partial, vector<vector<int>>& results)
    {
        if (offset == nums.size()) {
            results.push_back(partial);
            return;
        }
        
        for(int ix = offset; ix < nums.size(); ix++) {
            swap(partial[offset], partial[ix]);
            permuteHelper(nums, offset + 1, partial, results);
            swap(partial[offset], partial[ix]);
        }
    }

    vector<vector<int>> permute(vector<int>& nums) {
        vector<vector<int>> results;
        vector<int> partial = nums;
        permuteHelper(nums, 0, partial, results);
        return results;
    }
    
#pragma mark -    LC 48
    void rotate(vector<vector<int>>& matrix) {
        if (!matrix.size()) {
            return;
        }
        for (int ix = 0; ix < matrix.size() / 2; ix++) {
            for (int jx = ix; jx < matrix.front().size() - 1 - ix; jx++) {
                int size = matrix.front().size();
                int temp1 = matrix[ix][jx];
                int temp2 = matrix[jx][size - 1 - ix];
                int temp3 = matrix[size - 1 - ix][size - 1 - jx];
                int temp4 = matrix[size - 1 - jx][ix];
                matrix[ix][jx] = temp4;
                matrix[jx][size - 1 - ix] = temp1;
                matrix[size - 1 - ix][size - 1 - jx] = temp2;
                matrix[size - 1 - jx][ix] = temp3;
            }
        }
    }
#pragma mark - LC 50
    double myPow(double x, int n) {
        bool isMinus = n < 0? true:false;
        n = abs(n);
        if (n == 0)  return 1;
        if (n == 1) return isMinus?1/x:x;
        
        double intermediate = myPow(x, n/2);
        double inter2 = intermediate * intermediate;
        if (n % 2 == 0) {
            return isMinus? 1/inter2: inter2;
        } else {
            return isMinus? 1/(inter2 * x): inter2 * x;
        }
    }
    
#pragma mark - LC 53
    int maxSubArray(vector<int>& nums) {
        if (nums.size() == 0) return 0;
        
        int startIx = 0;
        int maxSoFar = nums[0];
        int maxEndingHere = 0;
        for (int ix = 0; ix < nums.size(); ix++) {
            maxEndingHere = max(0, maxEndingHere + nums[ix]);
            maxSoFar = max(maxSoFar, maxEndingHere);
        }
        return maxSoFar;
    }
    
#pragma mark - LC 54
    vector<int> spiralOrder(vector<vector<int>>& matrix) {
        
        vector<int> results;
        if (matrix.size() == 0) return results;
        int m = matrix.size();
        int n = matrix[0].size();
        int x = 0; int y = 0;
        while (m > 0 && n > 0) {
            if (m == 1) {
                for (int ix = 0; ix < n; ix++) {
                    results.push_back(matrix[x][y++]);
                }
                break;
            }
            if (n == 1) {
                for (int jx = 0; jx < m; jx++) {
                    results.push_back(matrix[x++][y]);
                }
                break;
            }
            for (int ix = 0; ix < n - 1; ix++) {
                results.push_back(matrix[x][y++]);
            }
            for (int ix = 0; ix < m - 1; ix++) {
                results.push_back(matrix[x++][y]);
            }
            for (int ix = 0; ix < n - 1; ix++) {
                results.push_back(matrix[x][y--]);
            }
            for (int ix = 0; ix < m - 1; ix++) {
                results.push_back(matrix[x--][y]);
            }
            x++, y++;
            m -= 2, n -= 2;
        }
        return results;
    }
    
#pragma mark - LC 55
    bool canJump(vector<int>& nums) {
        int maxJump = 0;
        int ix;
        for (ix = 0; ix < nums.size() && maxJump >= ix; ix++) {
            maxJump = max(maxJump, ix + nums[ix]);
        }
        return maxJump >= nums.size() - 1;
    }
#pragma mark - LC 56
    static bool myfunction (Interval left,Interval right) { return left.start != right.start? left.start < right.start: left.end < right.end; }
public:
    vector<Interval> merge(vector<Interval>& intervals) {
        sort(intervals.begin(), intervals.end(), myfunction);
        vector<Interval> results;
        for (int ix = 0; ix < intervals.size(); ) {
            Interval merged = intervals[ix++];
            while (ix < intervals.size() && merged.end >= intervals[ix].start) {
                merged.end = max(merged.end, intervals[ix].end);
                merged.start = min(merged.start, intervals[ix].start);
                ix++;
            }
            results.push_back(merged);
        }
        
        return results;
    }
#pragma mark - LC 58
    int lengthOfLastWord(string s) {
        
        if (s.size() == 0) return 0;
        int ix;
        for (ix = s.size() - 1; s[ix] == ' ' && ix >= 0; ix--);
        int endIx = ix;
        for (; ix >= 0 && s[ix] != ' ' ; ix--) ;
        
        return endIx - ix;
    }
#pragma mark - LC 59
    vector<vector<int>> generateMatrix(int n) {
        vector<vector<int>> matrix(n, vector<int>(n, 0));
        int val = 1;
        for (int ix = 0; ix < n / 2; ix++) {
            int size = matrix.size() - 1 - ix;
            for (int jx = ix; jx < size; jx++) {
                matrix[ix][jx] = val++;
            }
            for (int jx = ix; jx < size; jx++) {
                matrix[jx][size] = val++;
            }
            for (int jx = ix; jx < size; jx++) {
                matrix[size][matrix.size() - 1 - jx] = val++;
            }
            for (int jx = ix; jx < size; jx++) {
                matrix[matrix.size() - 1 - jx][ix] = val++;
            }
        }
        if (n & 1) matrix[n/2][n/2] = val;
        
        return matrix;
    }
#pragma mark - LC 66
    vector<int> plusOne(vector<int>& digits) {
        vector<int> result = digits;
        if (digits.size() == 0) return result;
        result.back()++;
        for (int ix = result.size() - 1; result[ix] > 9 && ix > 0; ix--) {
            result[ix] = 0;
            result[ix - 1]++;
        }
        
        if (result[0] > 9) {
            result[0] = 0;
            result.insert(result.begin(), 1);
        }
        return result;
    }
#pragma mark - LC 67
    string addBinary(string a, string b) {
        std::reverse(a.begin(), a.end());
        std::reverse(b.begin(), b.end());
        string result = "";
        if (a.size() == 0 || b.size() == 0) return result;
        int carry = 0;
        
        if (b.size() > a.size()) {
            std::swap(a, b);
        }
        int ix = 0;
        for (ix = 0 ; ix < a.size(); ix++) {
            int bVal = ix < b.size()? b[ix] - '0': 0;
            int curr = a[ix] - '0' + bVal + carry;
            result += (curr % 2) + '0';
            carry = curr / 2;
        }
        if (carry) {
            result += carry + '0';
        }
        std::reverse(result.begin(), result.end());
        return result;
    }
#pragma mark - LC 69
    int mySqrt(int x) {
        if (x == 1) {
            return 1;
        }
        double c = x / 2.0;
        double epsilon = 0.1;
        
        while ( fabs(c * c - x) > epsilon) {
            
            if ( c * c > x) {
                c *= 0.5;
            } else {
                c *= 1.5;
            }
        }
        return c;
    }
#pragma mark - LC 70
    int climbStairsHelper(int n, vector<int>& lookup) {
        
        if (n == 0) return 1;
        if (n == 1) return 1;
        
        if (lookup[n] > 0) {
            return lookup[n];
        }
        int sum = 0;
        for (int ix = 1; ix <= 2; ix++) {
            sum += climbStairsHelper(n - ix, lookup);
        }
        lookup[n] = sum;
        return sum;
    }

    int climbStairs(int n) {
        vector<int> lookup(n + 1, 0);
        return climbStairsHelper(n, lookup);
    }
#pragma mark - LC 71
    string simplifyPath(string path) {
        deque<string> pathStack;
        stringstream ss(path);
        string word;
        string result = "";
        while(getline(ss, word, '/')) {
            if (word == ".") {
                continue;
            } else if (word == "..") {
                if (pathStack.size()) {
                    pathStack.pop_back();
                }
            } else if (word.size()) {
                pathStack.push_back(word);
            }
        }
        
        while (pathStack.size()) {
            result += "/";
            result += pathStack.front();
            pathStack.pop_front();
        }
        return result.size()? result: "/";
    }
#pragma mark - LC 79
    bool existHelper(vector<vector<char>>& board, int ix, int jx, string word, string partial, int offset) {
        if (ix < 0 || ix >= board.size() || jx < 0 || jx >= board[ix].size()) {
            return false;
        }
        if (board[ix][jx] == '.') {
            return false;
        }
        partial += board[ix][jx];
        if (partial[offset] != word[offset]) {
            return false;
        }
        if (partial == word) {
            return true;
        }
        if (partial.size() < word.size()) {
            char temp = board[ix][jx];
            board[ix][jx] = '.';
            
            vector<vector<int>> shift = {{0, -1}, {0, 1}, {1, 0}, {-1, 0}};
            for (int sx = 0; sx < shift.size(); sx++) {
                if (existHelper(board, ix + shift[sx][0], jx + shift[sx][1], word, partial, offset + 1)) {
                    board[ix][jx] = temp;
                    return true;
                }
            }
            board[ix][jx] = temp;
        }
        return false;
    }

    bool exist(vector<vector<char>>& board, string word) {
        for (int ix = 0; ix < board.size(); ix++) {
            for (int jx = 0; jx < board[ix].size(); jx++) {
                if (existHelper(board, ix, jx, word, "", 0)) {
                    return true;
                }
            }
        }
        return false;
    }
#pragma mark - LC 80
    int removeDuplicates2(vector<int>& nums) {
        int len = 0;
        int wx = 0;
        int rx = wx + 1;
        int count = 1;
        while (wx < nums.size()) {
            count = 0;
            while (rx < nums.size() && nums[rx - 1] == nums[rx] && count < 2) {
                count++;
                nums[wx++] = nums[rx++];
            }
            while (nums[rx - 1] == nums[rx]) {
                rx++;
            }
            while (rx < nums.size() && nums[rx - 1] != nums[rx]) {
                nums[wx++] = nums[rx++];
            }
        }
        return wx;
    }
#pragma mark - LC 83
    ListNode* deleteDuplicates(ListNode* head) {
        if (head == NULL) return NULL;
        
        ListNode* prev = head;
        ListNode* next = prev->next;
        
        while (next) {
            while (next && next->val == prev->val) {
                prev->next = next->next;
                next = next->next;
            }
            prev = next;
            next = next? next->next: NULL;
        }
        return head;
    }
#pragma mark - LC 86
    ListNode* partition(ListNode* head, int x) {
        ListNode* lessThanX = new ListNode(0);
        ListNode* greaterThanX = new ListNode(0);
        ListNode* lessItr = lessThanX;
        ListNode* greaterItr = greaterThanX;
        
        ListNode* itr = head;
        while (itr) {
            if (itr->val < x) {
                lessItr->next = itr;
                lessItr = itr;
            } else {
                greaterItr->next = itr;
                greaterItr = itr;
            }
            itr = itr->next;
        }
        lessItr->next = greaterThanX->next;
        greaterItr->next = NULL;
        return lessThanX->next;
    }
#pragma mark - LC 88
    void merge(vector<int>& nums1, int m, vector<int>& nums2, int n) {
        int ix = m - 1;
        int jx = n - 1;
        int wx = m + n - 1;
        
        while(ix >= 0 && jx >= 0) {
            if (nums1[ix] > nums2[jx]) {
                nums1[wx--] = nums1[ix--];
            } else {
                nums1[wx--] = nums2[jx--];
            }
        }
        while (jx >= 0) {
            nums1[wx--] = nums2[jx--];
        }
    }
#pragma mark - LC 93
    bool isValid2(const string& str) {
        if (str.size() > 1 && str[0] == '0') {
            return false;
        }
        if (str.size() > 3) {
            return false;
        }
        int ip = atoi(str.c_str());
        return ip >= 0 && ip <= 255;
    }

    vector<string> restoreIpAddresses(string s) {
        vector<string> results;
        for (int ix = 1; ix <= 3 && ix < s.size(); ix++) {
            string first = s.substr(0, ix);
            if (!isValid2(first)) continue;
            for (int jx = 1; jx <= 3 && ix + jx < s.size(); jx++) {
                string second = s.substr(ix, jx);
                if (!isValid2(second)) continue;
                for (int zx = 1; zx <= 3 && ix + jx + zx < s.size(); zx++) {
                    string third = s.substr(ix + jx, zx);
                    string fourth = s.substr(ix + jx + zx);
                    if (isValid2(third) && isValid2(fourth)) {
                        results.emplace_back(first + "." + second + "." + third + "." + fourth);
                    }
                }
            }
        }
        return results;
    }
#pragma mark - LC 94
    vector<int> inorderTraversal(TreeNode* root) {
        std::vector<int> result;
        if (root == NULL) {
            return result;
        }
        result = inorderTraversal(root->left);
        result.push_back(root->val);
        std::vector<int> right = inorderTraversal(root->right);
        for (int ix = 0; ix < right.size(); ix++) {
            result.push_back(right[ix]);
        }
        return result;
    }
#pragma mark - LC 98
    bool isValidBSTHelper(TreeNode* root, int lowRange, int highRange) {
        if (root == NULL) {
            return true;
        }
        
        if (root->val < lowRange || root->val > highRange) {
            return false;
        }
        
        if ((root->left && root->val == INT_MIN) || (root->right && root->val == INT_MAX)) {
            return false;
        }
        return isValidBSTHelper(root->left, lowRange, root->val - 1) &&
        isValidBSTHelper(root->right, root->val + 1, highRange);
    }
    bool isValidBST(TreeNode* root) {
        return isValidBSTHelper(root, INT_MIN, INT_MAX);
    }
#pragma mark - LC 100
    bool isSameTree(TreeNode* p, TreeNode* q) {
        if (p == NULL && q == NULL) {
            return true;
        }
        if (p == NULL) {
            return false;
        }
        if (q == NULL) {
            return false;
        }
        return (p->val == q->val) && isSameTree(p->left, q->left) && isSameTree(p->right, q->right);
    }
#pragma mark - LC 101
    bool isSymmetricHelper(TreeNode* p, TreeNode* q) {
        if (p == NULL && q == NULL) {
            return true;
        }
        if (p == NULL || q == NULL) {
            return false;
        }
        return p->val == q->val && isSymmetricHelper(p->left, q->right) && isSymmetricHelper(p->right, q->left);
    }
public:
    bool isSymmetric(TreeNode* root) {
        if (root == NULL) return true;
        return isSymmetricHelper(root->left, root->right);
    }
#pragma mark - LC 102
    vector<vector<int>> levelOrder(TreeNode* root) {
        queue<TreeNode*> bfsQ;
        vector<vector<int>> results;
        if (root == NULL) return results;
        bfsQ.push(root);
        int numInLevel = 1;
        vector<int> level;
        while (!bfsQ.empty()) {
            TreeNode* next = bfsQ.front();
            bfsQ.pop();
            numInLevel--;
            if (next->left) bfsQ.push(next->left);
            if (next->right) bfsQ.push(next->right);
            level.push_back(next->val);
            if (numInLevel == 0) {
                numInLevel = bfsQ.size();
                results.emplace_back(move(level));
            }
        }
        return results;
    }
#pragma mark - LC 103
    vector<vector<int>> zigzagLevelOrder(TreeNode* root) {
        vector<vector<int>> results;
        if (!root) {
            return results;
        }
        bool flip = false;
        queue<TreeNode*> bfsQ;
        bfsQ.emplace(root);
        int numNodes = bfsQ.size();
        vector<int> result;
        while (bfsQ.size()) {
            TreeNode* current = bfsQ.front();
            bfsQ.pop();
            if (current->left) {
                bfsQ.emplace(current->left);
            }
            if (current->right) {
                bfsQ.emplace(current->right);
            }
            result.emplace_back(current->val);
            numNodes--;
            if (!numNodes) {
                numNodes = bfsQ.size();
                if (flip) {
                    std::reverse(result.begin(), result.end());
                }
                flip = !flip;
                results.emplace_back(move(result));
            }
        }
        return results;
    }
#pragma mark - LC 104
    int maxDepth(TreeNode* root) {
        if (root == NULL) return 0;
        
        if (root->left == NULL && root->right == NULL) {
            return 1;
        }
        return max(maxDepth(root->left), maxDepth(root->right)) + 1;
    }
#pragma mark - LC 105
    TreeNode* buildTreeHelper(vector<int>& inorder, int inStart, int inLen,
                              vector<int>& preOrder, int preStart, int preLen,
                              unordered_map<int,int>& inorder_to_ix)
    {
        if (inLen <= 0 || preLen <= 0) return NULL;
        
        int val = preOrder[preStart];
        TreeNode* root = new TreeNode(val);
        int inorder_ix = inorder_to_ix[val];
        int leftSubTreeSize = inorder_ix - inStart;
        int rightSubTreeSize = inLen - leftSubTreeSize - 1;
        root->left = buildTreeHelper(inorder, inStart, leftSubTreeSize,
                                     preOrder, preStart + 1, leftSubTreeSize, inorder_to_ix);
        root->right = buildTreeHelper(inorder, inorder_ix + 1, rightSubTreeSize,
                                      preOrder, preStart + 1 + leftSubTreeSize, rightSubTreeSize, inorder_to_ix);
        return root;
    }
    
    TreeNode* buildTree(vector<int>& preorder, vector<int>& inorder) {
        if (!inorder.size() || !preorder.size()) return NULL;
        unordered_map<int,int> inorder_to_ix;
        for (int ix = 0; ix < inorder.size(); ix++) {
            inorder_to_ix[inorder[ix]] = ix;
        }
        return buildTreeHelper(inorder, 0, inorder.size(),
                               preorder, 0, preorder.size(), inorder_to_ix);
    }
#pragma mark - LC 107
    vector<vector<int>> levelOrderBottom(TreeNode* root) {
        vector<vector<int>> result;
        queue<TreeNode*> myQ;
        if (root == NULL) return result;
        int levelSize = 1;
        myQ.emplace(root);
        vector<int> level;
        while(!myQ.empty()) {
            TreeNode* curr = myQ.front();
            myQ.pop();
            
            if (curr->left) myQ.emplace(curr->left);
            if (curr->right) myQ.emplace(curr->right);
            level.push_back(curr->val);
            --levelSize;
            if (levelSize == 0) {
                levelSize = myQ.size();
                result.push_back(move(level));
            }
        }
        std::reverse(result.begin(), result.end());
        return result;
    }
#pragma mark - LC 108
    TreeNode* sortedArrayToBSTHelper(const vector<int>& nums, int low, int high) {
        if (low > high) {
            return NULL;
        }
        int mid = low + (high - low) / 2;
        TreeNode* root = new TreeNode(nums[mid]);
        root->left = sortedArrayToBSTHelper(nums, low, mid - 1);
        root->right = sortedArrayToBSTHelper(nums, mid + 1, high);
        return root;
    }

    TreeNode* sortedArrayToBST(vector<int>& nums) {
        
        return sortedArrayToBSTHelper(nums, 0, nums.size() - 1);
    }
#pragma mark - LC 109
    TreeNode* sortedListToBSTHelper(ListNode* head, size_t len) {
        if (head == NULL || len == 0) return NULL;
        
        ListNode* secondHalf = head;
        
        for (int ix = 0; ix < len / 2; ix++) {
            secondHalf = secondHalf->next;
        }
        TreeNode* root = new TreeNode(secondHalf->val);
        root->left  = sortedListToBSTHelper(head, len / 2);
        root->right = sortedListToBSTHelper(secondHalf->next, len % 2? (len / 2): (len / 2 - 1));
        return root;
    }

    TreeNode* sortedListToBST(ListNode* head) {
        ListNode* itr = head;
        size_t count = 0;
        while (itr) {
            count++;
            itr = itr->next;
        }
        return sortedListToBSTHelper(head, count);
    }
#pragma mark - LC 110
    RetVal isBalancedHelper(TreeNode* root) {
        if (root == NULL) {
            return {true, 0};
        }
        RetVal r1 = isBalancedHelper(root->left);
        if (!r1.balanced) {
            return {false, -1};
        }
        RetVal r2 = isBalancedHelper(root->right);
        if (!r2.balanced) {
            return {false, -1};
        }
        return {abs(r1.height - r2.height) <= 1, 1 + max(r1.height, r2.height)};
    }

    bool isBalanced(TreeNode* root) {
        if (root == NULL) return true;
        RetVal ret = isBalancedHelper(root);
        return ret.balanced;
    }
#pragma mark - LC 111
    int minDepth(TreeNode* root) {
        if (root == NULL) {
            return 0;
        }
        
        if (root->left == NULL && root->right == NULL) {
            return 1;
        }
        
        if (!root->right) {
            return 1 + minDepth(root->left);
        }
        
        if (!root->left) {
            return 1 + minDepth(root->right);
        }
        
        return min(1 + minDepth(root->left), 1 + minDepth(root->right));
    }
#pragma mark - LC 112
    bool hasPathSumHelper(TreeNode* root, int partialSum, int sum)
    {
        if (root == NULL) {
            return false;
        }
        if (root->left == NULL && root->right == NULL) {
            return partialSum + root->val == sum;
        }
        return hasPathSumHelper(root->left, partialSum + root->val, sum) ||
        hasPathSumHelper(root->right, partialSum + root->val, sum);
    }
    bool hasPathSum(TreeNode* root, int sum) {
        if (root == NULL) return false;
        return hasPathSumHelper(root, 0, sum);
    }
#pragma mark - LC 116
    void connect(TreeLinkNode *root) {
        
        TreeLinkNode* rootItr = root;
        while (rootItr) {
            TreeLinkNode* nextItr = rootItr;
            while (nextItr) {
                if (nextItr->left) {
                    nextItr->left->next = nextItr->right;
                }
                if (nextItr->right && nextItr->next) {
                    nextItr->right->next = nextItr->next->left;
                }
                nextItr = nextItr->next;
            }
            rootItr = rootItr->left;
        }
    }
#pragma mark - LC 118
    vector<vector<int>> generate(int numRows) {
        vector<vector<int>> result;
        for(int ix = 0; ix < numRows; ix++) {
            vector<int> level(ix + 1, 1);
            for (int jx = 1; jx < level.size() - 1; jx++) {
                level[jx] = result.back()[jx - 1] + result.back()[jx];
            }
            result.push_back(move(level));
        }
        return result;
    }
#pragma mark - LC 119
    vector<int> getRow(int rowIndex) {
        vector<int> current;
        current.push_back(1);
        if (rowIndex == 0) return current;
        current.push_back(1);
        if (rowIndex == 1) return current;
        
        vector<int> prev;
        for (int ix = 2; ix <= rowIndex; ix++) {
            prev = move(current);
            current = move(vector<int>(ix + 1, 1));
            for(int jx = 1; jx < current.size() - 1; jx++) {
                current[jx] = prev[jx - 1] + prev[jx];
            }
        }
        return current;
    }
#pragma mark - LC 120
    int minimumTotal(vector<vector<int>>& triangle) {
        if (!triangle.size()) return 0;
        vector<int> prev = triangle[0];
        
        for (int rx = 1; rx < triangle.size(); rx++) {
            vector<int> current = triangle[rx];
            current.front() += prev.front();
            for (int jx = 1; jx < current.size() - 1; jx++) {
                current[jx] += min(prev[jx - 1], prev[jx]);
            }
            current.back() += prev.back();
            prev.swap(current);
        }
        
        return *min_element(prev.begin(), prev.end());
    }
#pragma mark - 125
    bool isPalindrome(string s) {
        int left = 0;
        int right = s.size() - 1;
        while (left < right) {
            while(left < right && !isalnum(s[left])) left++;
            while(left < right && !isalnum(s[right])) right--;
            
            if (tolower(s[left]) != tolower(s[right])) {
                return false;
            }
            left++, right--;
        }
        return true;
    }
#pragma mark - 129
    void sumNumbersHelper(TreeNode* root, vector<int>& results, int partial) {
        partial *= 10;
        partial += root->val;
        if (root->left == NULL && root->right == NULL) {
            results.push_back(partial);
            return;
        }
        
        if (root->left) {
            sumNumbersHelper(root->left, results, partial);
        }
        if (root->right) {
            sumNumbersHelper(root->right, results, partial);
        }
    }
    
    int sumNumbers(TreeNode* root) {
        if (root == NULL) return 0;
        
        vector<int> results;
        int partial = 0;
        sumNumbersHelper(root, results, partial);
        int sum = 0;
        for (int ix = 0; ix < results.size(); ix++) {
            sum += results[ix];
        }
        return sum;
    }
#pragma mark - LC 133
    UndirectedGraphNode *cloneGraph(UndirectedGraphNode *node) {
        if (node == NULL) {
            return NULL;
        }
        
        queue<UndirectedGraphNode*> bfsQ;
        unordered_map<UndirectedGraphNode*, UndirectedGraphNode*> visited;
        visited[node] = new UndirectedGraphNode(node->label);
        bfsQ.push(node);
        
        while (!bfsQ.empty()) {
            UndirectedGraphNode* next = bfsQ.front();
            bfsQ.pop();
            UndirectedGraphNode* clone = visited[next];
            vector<UndirectedGraphNode *>& neighbors = next->neighbors;
            for (int ix = 0; ix < neighbors.size(); ix++) {
                if (visited.find(neighbors[ix]) == visited.end()) {
                    bfsQ.push(neighbors[ix]);
                    visited[neighbors[ix]] = new UndirectedGraphNode(neighbors[ix]->label);
                }
                clone->neighbors.push_back(visited[neighbors[ix]]);
            }
        }
        return visited[node];
    }
#pragma mark - LC 136
    int singleNumber(vector<int>& nums) {
        if (!nums.size()) return 0;
        int num = nums[0];
        for (int ix = 1; ix < nums.size(); ix++) {
            num ^= nums[ix];
        }
        return num;
    }
#pragma mark - LC 139
    bool wordBreakHelper(string s, unordered_set<string>& wordDict, unordered_set<string>& wordsSeen) {
        if (wordDict.count(s)) return true;
        if (wordsSeen.count(s)) return false;
        for (int ix = 1; ix < s.size(); ix++) {
            string s1 = s.substr(0, ix);
            string s2 = s.substr(ix);
            if (wordDict.count(s1) && wordBreak(s2, wordDict)) {
                return true;
            }
        }
        wordsSeen.emplace(s);
        return false;
    }
public:
    bool wordBreak(string s, unordered_set<string>& wordDict) {
        unordered_set<string> wordsSeen;
        return wordBreakHelper(s, wordDict, wordsSeen);
    }
#pragma mark - LC 141
    bool hasCycle(ListNode *head) {
        if (!head || !head->next) return false;
        ListNode* slow = head;
        ListNode* fast = head->next->next;
        
        while (fast && slow != fast) {
            slow = slow->next;
            fast = fast->next;
            fast = fast ? fast->next:NULL;
        }
        return fast;
    }
#pragma mark - LC 144
    vector<int> preorderTraversal(TreeNode* root) {
        
        stack<TreeNode*> s;
        vector<int> results;
        if (root == NULL) return results;
        s.emplace(root);
        while (s.size() > 0) {
            TreeNode* next = s.top();
            s.pop();
            results.push_back(next->val);
            if (next->right) s.emplace(next->right);
            if (next->left)  s.emplace(next->left);
        }
        return results;
    }
#pragma mark - LC 151
    void reverseWords(string &s) {
        vector<string> wordList;
        stringstream wordStream(s);
        string word;
        while (wordStream >> word)
            wordList.push_back(word);
        
        string des = "";
        int i = wordList.size() - 1;
        for (; i > 0; i--)
            des += wordList[i] + " ";
        if (i == 0)
            des += wordList[i];
        s = des;
    }
#pragma mark - LC 153
    int findMin(vector<int>& nums) {
        int start = 0;
        int end = nums.size() - 1;
        
        while (start <= end) {
            int mid = (start + end) / 2;
            if ((mid == 0 || mid > 0 && nums[mid - 1] > nums[mid]) && nums[mid] <= nums[end])
            {
                return nums[mid];
            }
            
            if (nums[mid] >= nums[start] && nums[mid] > nums[end]) {
                start = mid + 1;
            } else {
                end = mid - 1;
            }
        }
        return 0;
    }
#pragma mark - 160
    int getLen(ListNode* head) {
        int len = 0;
        while (head) {
            len++;
            head = head->next;
        }
        return len;
    }
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        int L1 = getLen(headA);
        int L2 = getLen(headB);
        
        if (L2 > L1) {
            std::swap(headA, headB);
            std::swap(L1, L2);
        }
        while(L1 > L2) {
            headA = headA->next;
            L1--;
        }
        while (headA && headB && headA != headB) {
            headA = headA->next;
            headB = headB->next;
        }
        return headA == headB? headA: NULL;
    }
#pragma mark - LC 165
    int compareVersion(string version1, string version2) {
        stringstream ss1(version1);
        stringstream ss2(version2);
        string t1, t2;
        int v1Count = 0;
        int v2Count = 0;
        
        while(!ss1.eof() && !ss2.eof()) {
            
            getline(ss2, t2, '.');
            getline(ss1, t1, '.');
            
            int v1 = stoi(t1);
            int v2 = stoi(t2);
            v1Count++, v2Count++;
            if (v1 < v2) {
                return -1;
            } else if (v1 > v2) {
                return 1;
            }
        }
        
        return ss1.eof() && ss2.eof()? 0: ss1.eof()? -1: 1;
    }
#pragma mark - LC 168
    string convertToTitle(int n) {
        string result;
        
        while (n) {
            result += 'A' + ((n - 1) % 26);
            n  = (n - 1) / 26;
        } ;
        std::reverse(result.begin(), result.end());
        return result;
    }
#pragma mark - LC 169
    int majorityElement(vector<int>& nums) {
        int count = 1;
        int majIx = 0;
        for (int ix = 1; ix < nums.size(); ix++) {
            if (nums[majIx] == nums[ix]) {
                count++;
            } else {
                count--;
            }
            if (count == 0) {
                majIx = ix;
                count = 1;
            }
        }
        return nums[majIx];
    }
#pragma mark - LC 171
    int titleToNumber(string s) {
        int result = 0;
        for (char c : s) {
            result *= 26;
            result += c - 'A' + 1;
        }
        return result;
    }
#pragma mark - LC 172
    int trailingZeroes(int n) {
        // Initialize result
        int count = 0;
        
        // Keep dividing n by powers of 5 and update count
        for (int i=5; n/i>=1; i *= 5)
            count += n/i;
        
        return count;
    }
#pragma mark - LC 179

    string largestNumber(vector<int>& nums) {
        std::sort(nums.begin(), nums.end(), largestCompare);
        string result;
        int nonZeroSeen = false;
        for (int num : nums) {
            if (num > 0) {
                nonZeroSeen = true;
            }
            if (nonZeroSeen) {
                result += to_string(num);
            }
        }
        return result;
    }
#pragma mark - LC 189
    void rotate(vector<int>& nums, int k) {
        k %= nums.size();
        int n = nums.size();
        std::reverse(nums.begin(), nums.begin() + n - k);
        std::reverse(nums.begin() + n - k, nums.end());
        std::reverse(nums.begin(), nums.end());
    }
#pragma mark - LC 190
    uint32_t reverseBits(uint32_t n) {
        
        unsigned int v = n;     // input bits to be reversed
        unsigned int r = v;    // r will be reversed bits of v; first get LSB of v
        int s = sizeof(v) * CHAR_BIT - 1; // extra shift needed at end
        
        for (v >>= 1; v; v >>= 1)
        {
            r <<= 1;
            r |= v & 1;
            s--;
        }
        r <<= s; // shift when v's highest bits are zero
        return r;
    }
#pragma mark - LC 191
    int hammingWeight(uint32_t n) {
        int count = 0;
        while(n) {
            count++;
            n &= (n - 1);
        }
        return count;
    }
#pragma mark - LC 198
    int rob(vector<int>& nums) {
        vector<int> maxV(nums.size(), 0);
        int maxSoFar = 0;
        for (int ix = 0; ix < nums.size(); ix++) {
            int sum1 = nums[ix] + (ix - 2 >= 0?maxV[ix - 2]: 0);
            int sum2 = nums[ix] + (ix - 3 >= 0?maxV[ix - 3]: 0);
            maxV[ix] = max(sum1, sum2);
            maxSoFar = max(maxV[ix], maxSoFar);
        }
        return maxSoFar;
    }
#pragma mark - LC 199
    vector<int> rightSideView(TreeNode* root) {
        vector<int> results;
        if (!root) return results;
        
        queue<TreeNode*> bfsQ;
        bfsQ.emplace(root);
        
        while (bfsQ.size()) {
            int numNodes = bfsQ.size();
            for (int ix = 0; ix < numNodes; ix++) {
                TreeNode* current = bfsQ.front();
                bfsQ.pop();
                if (ix == 0) {
                    results.push_back(current->val);
                }
                if (current->right) {
                    bfsQ.emplace(current->right);
                }
                if (current->left) {
                    bfsQ.emplace(current->left);
                }
            }
        }
        return results;
    }
#pragma mark - LC 200
    void coverIsland(vector<vector<char>>& grid, int r, int c, size_t rowSize, size_t colSize)
    {
        if (r < 0 || r >= rowSize || c < 0 || c >= colSize) {
            return;
        }
        if (grid[r][c] == '0' || grid[r][c] == 'c') {
            return;
        }
        grid[r][c] = 'c';
        coverIsland(grid, r + 1, c, rowSize, colSize);
        coverIsland(grid, r - 1, c, rowSize, colSize);
        coverIsland(grid, r, c + 1, rowSize, colSize);
        coverIsland(grid, r, c - 1, rowSize, colSize);
    }
public:
    int numIslands(vector<vector<char>>& grid) {
        vector<vector<char>> myGrid = grid;
        int numIslands = 0;
        for (int ix = 0; ix < myGrid.size(); ix++) {
            for (int jx = 0; jx < myGrid[ix].size(); jx++) {
                if (myGrid[ix][jx] == '1') {
                    numIslands++;
                    coverIsland(myGrid, ix, jx, myGrid.size(), myGrid[ix].size());
                }
            }
        }
        return numIslands;
    }
#pragma mark - LC 202
    bool isHappy(int n) {
        unordered_set<int> happyMap;
        
        while(1) {
            int sum = 0;
            while (n) {
                int digit = n % 10;
                sum += digit * digit;
                n /= 10;
            }
            n = sum;
            
            if (n == 1) return true;
            if (!happyMap.emplace(n).second) {
                return false;
            }
        }
    }
    bool isHappy2(int n) {
        
        while(n != 1 && n != 4) {
            int sum = 0;
            while (n) {
                int digit = n % 10;
                sum += digit * digit;
                n /= 10;
            }
            n = sum;
        }
        return n == 1;
    }
#pragma mark - LC 203
    ListNode* removeElements(ListNode* head, int val) {
        if (head == NULL) return NULL;
        
        ListNode* dummyHead = new ListNode(0);
        dummyHead->next = head;
        ListNode* trail = dummyHead;
        ListNode* curr = dummyHead->next;
        while (curr) {
            while (curr && curr->val == val) {
                trail->next = curr->next;
                curr = curr->next;
            }
            trail = curr;
            curr = curr? curr->next: NULL;
        }
        return dummyHead->next;
    }
#pragma mark - LC 205
    bool isIsomorphic(string s, string t) {
        if (s.size() != t.size()) return false;
        
        unordered_map<char, char> sMap;
        unordered_map<char, char> tMap;
        for (int ix = 0; ix < s.size(); ix++) {
            if (sMap.count(s[ix])) {
                if (sMap[s[ix]] != t[ix]) {
                    return false;
                }
            } else {
                sMap[s[ix]] = t[ix];
            }
            if (tMap.count(t[ix])) {
                if (tMap[t[ix]] != s[ix]) {
                    return false;
                }
            } else {
                tMap[t[ix]] = s[ix];
            }
        }
        return true;
    }
#pragma mark - LC 206
    ListNode* reverseList(ListNode* head) {
        if (head == NULL || head->next == NULL) return head;
        
        /*
         ListNode* newHead = reverseList(head->next);
         head->next->next = head;
         head->next = NULL;
         */
        ListNode* trail = head;
        ListNode* curr  = head->next;
        head->next = NULL;
        while (curr) {
            ListNode* savedNext = curr->next;
            curr->next = trail;
            trail = curr;
            curr = savedNext;
        }
        return trail;
    }
#pragma mark - LC 215
    void swap(int& a, int& b) {
        int temp = a;
        a = b;
        b = temp;
    }
    
    int findKthLargest(vector<int>& nums, int k) {
        
        int pos = 0;
        int currentSize = nums.size();
        int nstart = 0;
        int nend = nums.size() - 1;
        
        while (1) {
            int pivot = rand() % currentSize;
            
            // partition the array on the pivot
            swap(nums[0], nums[pivot]);
            
            int dx = nstart + 1;
            for (int ix = nstart + 1; ix <= nend; ix++) {
                if (nums[ix] < nums[0]) {
                    swap(nums[dx++], nums[ix]);
                }
            }
            swap(nums[dx - 1], nums[0]);
            
            if (dx == k) {
                return nums[dx];
            } else if (dx < k) {
                nend = dx;
            } else {
                nstart = dx + 1;
                k -= dx;
            }
            currentSize = nend - nstart + 1;
        }
    }
#pragma mark - LC 217
    bool containsDuplicate(vector<int>& nums) {
        unordered_set<int> mySet;
        for (int val : nums) {
            if (mySet.count(val)) {
                return true;
            }
            mySet.emplace(val);
        }
        return false;
    }
#pragma mark - LC 219
    bool containsNearbyDuplicate(vector<int>& nums, int k) {
        unordered_map<int, int> lastSeenIndexMap;
        for (int ix = 0; ix < nums.size(); ix++) {
            if (lastSeenIndexMap.count(nums[ix]) && ix - lastSeenIndexMap[nums[ix]] <= k) {
                return true;
            }
            lastSeenIndexMap[nums[ix]] = ix;
        }
        return false;
    }
#pragma mark - LC 220
    static bool compare(const pair<int,int>& x, const pair<int,int>& y) {
        return x.first < y.first;
    }
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        if (!nums.size()) return false;
        
        vector<pair<int,int>> sorted;
        for (int ix = 0; ix < nums.size(); ix++) {
            sorted.emplace_back(nums[ix], ix);
        }
        
       // std::sort(sorted.begin(), sorted.end(), compare);
        for (int ix = 0; ix < nums.size(); ix++) {
            int jx = ix + 1;
            
            while (sorted[jx].first - sorted[ix].first <= t && jx < sorted.size()) {
                if (abs(sorted[jx].second - sorted[ix].second) <= k) {
                    return true;
                }
                jx++;
            }
        }
        return false;
    }
#pragma mark - LC 222
    int countNodes(TreeNode* root) {
        if (!root) {
            return 0;
        }
        TreeNode* node = root->left;
        int height = 0;
        while (node) {
            node = node->left;
            height++;
        }
        int level = 0;
        int depth = 0;
        int count = 0;
        while (root) {
            depth = level;
            node = root->left;
            if (!node) {
                break;
            }
            while (node) {
                node = node->right;
                depth++;
            }
            level++;
            if (depth == height) {
                root = root->right;
                count += 1 << (height - level);
            }
            else {
                root = root->left;
            }
        }
        if (root && level == height) {
            count++;
        }
        return (1 << height) - 1 + count;
    }
#pragma mark - LC 226
    TreeNode* invertTree(TreeNode* root) {
        if (root == NULL) return root;
        std::swap(root->left, root->right);
        invertTree(root->left);
        invertTree(root->right);
        return root;
    }
#pragma mark - LC 228
    vector<string> summaryRanges(vector<int>& nums) {
        vector<string> results;
        if (nums.size() == 0) {
            return results;
        }
        int start = 0;
        int end = 0;
        stringstream ss;
        for (int ix = 1; ix < nums.size(); ix++) {
            if (nums[ix] == nums[ix - 1] + 1) {
                end = ix;
            } else {
                ss.str("");
                start == end? ss << nums[start] : ss << nums[start] << "->" << nums[end];
                results.emplace_back(ss.str());
                start = ix, end = ix;
            }
        }
        ss.str("");
        start == end? ss << nums[start] : ss << nums[start] << "->" << nums[end];
        results.emplace_back(ss.str());
        return results;
    }
#pragma mark - LC 231
    bool isPowerOfTwo(int n) {
        return n != 0 && n != INT_MIN && (n & (n - 1)) == 0;
    }
#pragma mark - LC 234
    int listLength(ListNode* head) {
        ListNode* itr = head;
        int count = 0;
        while (itr) {
            count++;
            itr = itr->next;
        }
        return count;
    }
public:
    bool isPalindrome(ListNode* head) {
        int len = listLength(head);
        ListNode* fast = head;
        int halfLen = len / 2;
        ListNode* trail = NULL;
        while (halfLen) {
            ListNode* next = fast->next;
            fast->next = trail;
            trail = fast;
            fast = next;
            halfLen--;
        }
        // trail now points to the reversed first half
        if (len % 2) {
            fast = fast->next;
        }
        while (fast) {
            if (fast->val != trail->val) {
                return false;
            }
            fast = fast->next;
            trail = trail->next;
        }
        return true;
    }
#pragma mark - LC 235
    TreeNode* lowestCommonAncestor(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (root == NULL) return NULL;
        TreeNode* itr = root;
        while (itr) {
            if (itr->val < p->val && itr->val < q->val) {
                itr = itr->right;
            } else if (itr->val > p->val && itr->val > q->val) {
                itr = itr->left;
            } else {
                return itr;
            }
        }
        return NULL;
    }
#pragma mark - LC 236
    pair<TreeNode*, int> lcaHelper(TreeNode* root, TreeNode* p, TreeNode* q) {
        if (root == NULL) {
            return {NULL, 0};
        }
        
        pair<TreeNode*,int> left = lcaHelper(root->left, p, q);
        if (left.second == 2) {
            return left;
        }
        
        pair<TreeNode*,int> right = lcaHelper(root->right, p, q);
        if (right.second == 2) {
            return right;
        }
        int total = left.second + right.second + (int)(root == p) + (int)(root == q);
        return {total == 2? root: NULL, total};
    }
    
    TreeNode* lowestCommonAncestor2(TreeNode* root, TreeNode* p, TreeNode* q) {
        pair<TreeNode*, int> result = lcaHelper(root, p, q);
        return result.first;
    }
#pragma mark - LC 237
    void deleteNode(ListNode* node) {
        if (!node || !node->next) return;
        node->val = node->next->val;
        node->next = node->next->next;
    }
#pragma mark - LC 240
    bool searchMatrix(vector<vector<int>>& matrix, int target) {
        if (!matrix.size()) return false;
        int rx = 0;
        int cx = matrix[0].size() - 1;
        
        while (rx < matrix.size() && cx >= 0) {
            if (target == matrix[rx][cx]) {
                return true;
            }
            if (target < matrix[rx][cx]) {
                cx--;
            } else {
                rx++;
            }
        }
        return false;
    }
#pragma mark - LC 242
    bool isAnagram(string s, string t) {
        sort(s.begin(), s.end());
        sort(t.begin(), t.end());
        return s == t;
    }
#pragma mark - LC 257
    void binaryTreePathsHelper(TreeNode* root, vector<string>* results_p, string partial) {
        vector<string> & results = *results_p;
        if (root == NULL) return;
        if (root->left == NULL && root->right == NULL) {
            partial += to_string(root->val);
            results.emplace_back(partial);
            return;
        }
        binaryTreePathsHelper(root->left, results_p, partial + to_string(root->val) + "->");
        binaryTreePathsHelper(root->right, results_p, partial + to_string(root->val) + "->");
    }
    vector<string> binaryTreePaths(TreeNode* root) {
        vector<string> results;
        if (root == NULL) return results;
        if (root->left == NULL && root->right == NULL) {
            results.emplace_back(to_string(root->val));
            return results;
        }
        binaryTreePathsHelper(root->left, &results, to_string(root->val) + "->");
        binaryTreePathsHelper(root->right, &results, to_string(root->val) + "->");
        return results;
    }
#pragma mark - LC 258
    int addDigits(int num) {
        if(num % 9 == 0 && num!=0) {
            return 9;
        }
        return (num%9);
    }
#pragma mark - LC 263
    bool passesFermatTest (int p)
    {
        for (int ix = 0; ix < 5; ix++) {
            int a = rand() % (p - 1);
            if ((int)pow(a, p - 1) % p == 1) {
                return true;
            }
        }
        return false;
    }
    bool isPrime (int n) {
        int sqrtN = sqrt(n);
        for (int ix = 2; ix <= sqrtN; ix++) {
            if (n % ix == 0) {
                return false;
            }
        }
        return true;
    }
public:
    bool isUgly(int num) {
        
        if(num < 1)
            return false;
        
        for(int i = 2; i <= 5; i++)
        {
            while(num%i == 0)
                num /= i;
        }
        
        return num == 1;
    }
#pragma mark - LC 278
    bool isBadVersion(int version) {return true;}
    int firstBadVersion(int n) {
        int lower = 1;
        int upper = n;
        int firstBadVersion = 0;
        while (lower <= upper) {
            int mid = lower + (upper - lower) / 2;
            if (isBadVersion(mid)) {
                firstBadVersion = mid; // found a potential
                upper = mid - 1;
            } else {
                lower = mid + 1;
            }
        }
        return firstBadVersion;
    }
#pragma mark - LC 283
    void moveZeroes(vector<int>& nums) {
        int wx = 0;
        int rx = 0;
        while (rx < nums.size()) {
            if (nums[rx] != 0) {
                nums[wx++] = nums[rx];
            }
            rx++;
        }
        while (wx < nums.size()) {
            nums[wx++] = 0;
        }
    }
#pragma mark - LC 290
    bool wordPattern(string pattern, string str) {
        stringstream ss(str);
        unordered_map<string, char> mymap;
        unordered_map<char, string> patternMap;
        int pix = 0;
        string next;
        while(pix < pattern.size() && ss >> next) {
            if (patternMap.count(pattern[pix])) {
                if (patternMap[pattern[pix]] != next) {
                    return false;
                }
            }
            else if (mymap.count(next)) {
                if (mymap[next] != pattern[pix]) {
                    return false;
                }
            }
            else {
                patternMap[pattern[pix]] = next;
                mymap[next] = pattern[pix];
            }
            pix++;
        }
        return pix == pattern.size() && ss.eof();
    }
#pragma mark - LC 292
    bool canWinNim(int n) {
        return n % 4 > 0;
    }
#pragma mark - LC 299
    string getHint(string secret, string guess) {
        
        int secretCounts[10] = {0};
        int guessCounts[10] = {0};
        
        int bulls = 0;
        int cows = 0;
        
        for (int ix = 0; ix < secret.size(); ix++)
        {
            if (secret[ix] == guess[ix])
            {
                bulls++;
            }
            else
            {
                secretCounts[secret[ix] - '0']++;
                guessCounts[guess[ix] - '0']++;
            }
        }
        
        for (int i = 0; i < 10; i++)
        {
            cows += min(secretCounts[i], guessCounts[i]);
        }
        
        return to_string(bulls) + "A" + to_string(cows) + "B";
    }
#pragma mark - 300
    int lengthOfLIS(vector<int>& nums) {
        vector<int> lookup(nums.size(), 0);
        int maxLen = 0;
        for (int ix = 0; ix < nums.size(); ix++) {
            lookup[ix] = 1;
            for (int jx = ix - 1; jx >= 0; jx--) {
                if (nums[jx] < nums[ix] && lookup[jx] + 1 > lookup[ix]) {
                    lookup[ix] = lookup[jx] + 1;
                }
            }
            maxLen = lookup[ix] > maxLen? lookup[ix]: maxLen;
        }
        return maxLen;
    }
#pragma mark - LC 326
    bool isPowerOfThree(int n) {
        double a = log10(n)/log10(3);
        int m = a;
        return m - a == 0;
    }
#pragma mark - LC 329
    int longestIncreasingPathHelper(vector<vector<int>>& matrix, int ix, int jx, int len, vector<vector<int>>& memo) {
        
        int maxLen = len;
        
        if (memo[ix][jx] > 0) {
            return memo[ix][jx];
        }
        
        vector<vector<int>> shift = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
        for (int sx = 0; sx < 4; sx++) {
            int rshift = ix + shift[sx][0];
            int cshift = jx + shift[sx][1];
            if (rshift >= 0 && rshift < matrix.size() &&
                cshift >= 0 && cshift < matrix.front().size() &&
                matrix[ix][jx] < matrix[rshift][cshift]) {
                maxLen = max(maxLen, 1 + longestIncreasingPathHelper(matrix, rshift, cshift, len, memo));
            }
        }
        memo[ix][jx] = maxLen;
        return maxLen;
    }
    
    int longestIncreasingPath(vector<vector<int>>& matrix) {
        if (!matrix.size()) return 0;
        int maxLen = 0;
        vector<vector<int> > memo(matrix.size(), vector<int>(matrix.front().size(), 0));
        for (int ix = 0; ix < matrix.size(); ix++) {
            for (int jx = 0; jx < matrix.front().size(); jx++) {
                maxLen = max(maxLen, longestIncreasingPathHelper(matrix, ix, jx, 1, memo));
            }
        }
        return maxLen;
    }

};

#pragma mark - LC 155
class MinStack {
    stack<int> myStack;
    stack<int> minStack;
public:
    void push(int x) {
        myStack.push(x);
        if (minStack.size() == 0 || x <= minStack.top()) {
            minStack.push(x);
        }
    }
    
    void pop() {
        if (myStack.size() > 0) {
            int top = myStack.top();
            myStack.pop();
            if (top == minStack.top()) {
                minStack.pop();
            }
        }
    }
    
    int top() {
        return myStack.top();
    }
    
    int getMin() {
        return minStack.top();
    }
    
};

#pragma mark - LC 225
class Stack {
    queue<int> q1;
    queue<int> q2;
public:
    // Push element x onto stack.
    void push(int x) {
        if (q1.size()) {
            q1.push(x);
        } else {
            q2.push(x);
        }
    }
    
    // Removes the element on top of the stack.
    void pop() {
        if (q1.size() == 0 && q2.size() == 0) return;
        
        queue<int> & currQ = q1.size()? q1: q2;
        queue<int> & secondQ = q1.size()? q2: q1;
        while (currQ.size() > 1) {
            secondQ.push(currQ.front());
            currQ.pop();
        }
        currQ.pop();
    }
    
    // Get the top element.
    int top() {
        if (q1.size() == 0 && q2.size() == 0) return -1;
        queue<int> & currQ = q1.size()? q1: q2;
        queue<int> & secondQ = q1.size()? q2: q1;
        int top = -1;
        while (currQ.size()) {
            secondQ.push(currQ.front());
            if (currQ.size() == 1) top = currQ.front();
            currQ.pop();
        }
        return top;
    }
    
    // Return whether the stack is empty.
    bool empty() {
        return !q1.size() && !q2.size();
    }
};
#pragma mark - LC 232
class Queue {
    stack<int> pushStack;
    stack<int> popStack;
public:
    // Push element x to the back of queue.
    void push(int x) {
        pushStack.push(x);
    }
    
    // Removes the element from in front of queue.
    void pop(void) {
        
        if (popStack.empty()) {
            while (pushStack.size()) {
                int top = pushStack.top();
                pushStack.pop();
                popStack.push(top);
            }
        }
        if (popStack.size()) {
            popStack.pop();
        }
    }
    
    // Get the front element.
    int peek(void) {
        
        if (!popStack.size()) {
            while (pushStack.size()) {
                int top = pushStack.top();
                pushStack.pop();
                popStack.push(top);
            }
            
        }
        return popStack.top();
    }
    
    // Return whether the queue is empty.
    bool empty(void) {
        return !pushStack.size() && !popStack.size();
    }
};


int main ()
{
    vector<int> nums = {302};
    Solution s;
    s.largestNumber(nums);
    return 0;
}
