//
//  CatchAll.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "CatchAll.hpp"
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

using namespace std;

struct ListNode {
    int val;
    ListNode *next;
    ListNode(int x) : val(x), next(NULL) {}
    bool operator<(ListNode* that) {
        return this->val < that->val;
    }
};

struct TreeNode {
    int val;
    TreeNode *left;
    TreeNode *right;
    TreeNode(int x) : val(x), left(NULL), right(NULL) {}
};

class Solution {
public:
    // 1
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
    
    // 2
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
    
    // 3 Length of Longest unique substring
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
    
    // 4 Median or two sorted arrays
    double findMedianSortedArrays(vector<int>& nums1, vector<int>& nums2) {
        /*
        int m1 = nums1.size() / 2;
        int m1 = nums2.size() / 2;
        int m1Left = 0;
        int m1Right = nums1.size() - 1;
        int m2Left = 0;
        int m2Right = nums2.size() - 1;
        
        while (m1 != m2 &&
               m1Right - m1Left > 1 &&
               m2Right - m2Left > 1 )
        {
            
        }
         */
        return 0;
    }
    
    // 5 Longest Palindromic substring
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
    
    // 6 ZigZag Conversion
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
    
    // 7
    int reverse(int x) {
        bool isMinus = x < 0? true: false;
        x = std::abs(x);
        long long rev = 0;
        int prev = 0;
        while (x) {
            prev = rev;
            rev *= 10;
            int val = (x % 10);
            x /= 10;
            
            if (rev > INT_MAX - val) return 0;
            
            rev += val;
        }
        
        return isMinus? -rev: rev;
    }
    
    // 8
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
    
    // 9
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
    
    // 11 Container with Most Water
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
    
    // 23 Merge K sorted lists
    ListNode* mergeKLists(vector<ListNode*>& lists) {
        ListNode* dummyHead = new ListNode(0);
        ListNode* tail = dummyHead;
        

        priority_queue<ListNode*, vector<ListNode*>> pQ;
        
        
        while (lists.size() > 0) {
            
            for (int ix = 0; ix < lists.size();) {
                if (lists[ix] == NULL) {
                    lists.erase(lists.begin() + ix);
                } else {
                    ix++;
                }
            }
            int minIx = INT_MAX;
            for (int ix = 0; ix < lists.size(); ix++)  {
                minIx = (minIx == INT_MAX)? ix: (lists[ix]->val < lists[minIx]->val? ix: minIx);
            }
            if (minIx < INT_MAX) {
                tail->next = lists[minIx];
                tail = tail->next;
                lists[minIx] = lists[minIx]->next;
            }
        }
        return dummyHead->next;
    }
public:
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
    string multiply(string num1, string num2) {
        string result(num1.size() + num2.size(), '0');
        std::reverse(num1.begin(), num1.end());
        std::reverse(num2.begin(), num2.end());
        
        for (int ix = 0; ix < num1.size(); ix++) {
            for (int jx = 0; jx < num2.size(); jx++) {
                int mult = (num1[ix] - '0') * (num2[jx] - '0');
                result[ix + jx] = mult + (result[ix + jx] - '0');
                result[ix + jx + 1] = (mult / 10) + '0';
            }
        }
        
        int ix;
        for (ix = result.size() - 1; result[ix] == '0' && ix > 0; ix--) {
            
        }
        result.resize(ix + 1);
        
        std::reverse(result.begin(), result.end());
        
        return result;
    }
    
    vector<vector<string>> groupAnagrams(vector<string>& strs) {
        vector<vector<string>> results;
        unordered_map<string, set<string>> myMap;
        for (int ix = 0; ix < strs.size(); ix++) {
            string key = strs[ix];
            sort(key.begin(), key.end());
            if (myMap.find(strs[ix]) == myMap.end()) {
                set<string> mySet;
                mySet.emplace(strs[ix]);
            } else {
                myMap[key].emplace(strs[ix]);
            }
        }
        unordered_map<string, set<string>>::iterator itr = myMap.begin();
        for(; itr != myMap.end(); itr++) {
            set<string> & current = itr->second;
            set<string>::iterator sitr = current.begin();
            vector<string> row;
            for (;sitr != current.end(); sitr++) {
                row.push_back(*sitr);
            }
            results.push_back(row);
        }
        return results;
    }
    void wiggleSort(vector<int>& nums) {
        if (nums.size() == 0 || nums.size() == 1) {
            return;
        }
        if (nums[0] > nums[1]) {
            swap(nums[1], nums[0]);
        }
        if (nums.size() == 2) {
            return;
        }
        if (nums[2] < nums[3]) {
            swap(nums[2], nums[3]);
        }
        // Now n - 1, n and n + 1 are in wiggle sort, iterate
        for (int nMinusOne = 0; nMinusOne + 2 < nums.size(); nMinusOne++) {
            int n = nMinusOne + 1;
            int nPlusOne = n + 1;
            if (nums[nMinusOne] < nums[n] && nums[n] <= nums[nPlusOne]) {
                swap(nums[n], nums[nPlusOne]);
            } else if (nums[nMinusOne] > nums[n] && nums[n] >= nums[nPlusOne]) {
                swap(nums[n], nums[nPlusOne]);
            }
        }
    }
    void wiggleSort2(vector<int>& nums) {
        if (nums.size() == 0) {
            return;
        }
        int len = nums.size();
        for (int i = 1; i < len; i++) {
            if ((i % 2 == 1 && nums[i] < nums[i - 1]) || (i % 2 == 0 && nums[i] > nums[i - 1])) {
                swap(nums[i - 1], nums[i]);
            }
        }
    }
    bool wordPattern(string pattern, string str) {
        stringstream ss(str);
        unordered_map<string, char> mymap;
        unordered_map<char, string> patternMap;
        int pix = 0;
        string next;
        while(ss >> next && pix < pattern.size()) {
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
        return pix == pattern.size();
    }
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
            powerHash = ix == 0? powerHash: powerHash * kBase;
        }
        
        for (ix = 0; ix < haystack.size() - needle.size(); ix++) {
            if (needleHash == haystackHash && !haystack.compare(ix, needle.size(), needle)) {
                return ix;
            }
            haystackHash -= (powerHash * haystack[ix]) % kMod;
            if (haystackHash < 0) {
                haystackHash += kBase;
            }
            haystackHash = (haystackHash * kBase) + haystack[ix + needle.size()];
        }
        if (needleHash == haystackHash && !needle.compare(haystack.size() - needle.size(), needle.size(), haystack)) {
            return haystack.size() - needle.size();
        }
        return -1;
    }
private:
    int getLen(ListNode* head) {
        int len = 0;
        while (head) {
            len++;
            head = head->next;
        }
        return len;
    }
public:
    ListNode *getIntersectionNode(ListNode *headA, ListNode *headB) {
        int L1 = getLen(headA);
        int L2 = getLen(headB);
        
        if (L2 > L1) {
            swap(headA, headB);
            swap(L1, L2);
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
    int compareVersion(string version1, string version2) {
        stringstream ss1(version1);
        stringstream ss2(version2);
        string t1, t2;
        while(getline(ss1, t1, '.') && getline(ss2, t2, '.')) {
            int v1 = stoi(t1);
            int v2 = stoi(t2);
            if (v1 < v2) {
                return -1;
            } else if (v1 > v2) {
                return 1;
            }
        }
        
        return ss1.eof() && ss2.eof()? 0: ss1.eof()? -1: 1;
    }
    int trailingZeroes(int n) {
        // Initialize result
        int count = 0;
        
        // Keep dividing n by powers of 5 and update count
        for (int i=5; n/i>=1; i *= 5)
            count += n/i;
        
        int twosCount = 0;
        // Keep dividing n by powers of 5 and update count
        for (int i=2; n/i>=1; i *= 2) {
            twosCount += n/i;
        }
        return min(count, twosCount);
    }
    vector<string> summaryRanges(vector<int>& nums) {
        vector<string> results;
        if (nums.size() == 0) {
            return results;
        }
        stringstream ss;

        int start = 0;
        int end = 0;
        for (int ix = 1; ix < nums.size(); ix++) {
            if (nums[ix] == nums[ix - 1] + 1) {
                end = ix;
            } else {
                string result = start == end? nums[start] + "": nums[start] + "->" + nums[end];
                results.emplace_back(result);
                start = ix, end = ix;
            }
        }
        int val = INT_MIN;
        string result = start == end? nums[start] +"" : nums[start] + "->" + nums[end];
        results.emplace_back(result);
        return results;
    }
private:
    bool hasDuplicates(const vector<vector<char>>& board, int rowStart, int rowEnd, int colStart, int colEnd)
    {
        unordered_set<int> boardMap;
        for (int ix = rowStart; ix < rowEnd; ix++) {
            for (int jx = colStart; jx < colEnd; jx++) {
                if (board[ix][jx] == '.') continue;
                if (boardMap.count(board[ix][jx])) {
                    return false;
                }
                boardMap.emplace(board[ix][jx]);
            }
        }
        return false;
    }
private:
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
public:
    bool isValidBST(TreeNode* root) {
        return isValidBSTHelper(root, INT_MIN, INT_MAX);
    }
private:
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
            for (int ix = 0; ix < shift.size(); ix++) {
                if (existHelper(board, ix + shift[ix][0], jx + shift[ix][1], word, partial, offset + 1)) {
                    board[ix][jx] = temp;
                    return true;
                }
            }
            board[ix][jx] = temp;
        }
        return false;
    }
public:
    bool exist(vector<vector<char>>& board, string word) {
        return existHelper(board, 0, 0, word, "", 0);
    }
private:
    bool isValid(const string& str) {
        if (str == "00" || str == "01") {
            return false;
        }
        if (str.size() > 3) {
            return false;
        }
        int ip = atoi(str.c_str());
        return ip >= 0 && ip <= 255;
    }
public:
    vector<string> restoreIpAddresses(string s) {
        vector<string> results;
        for (int ix = 1; ix <= 3; ix++) {
            string first = s.substr(0, ix);
            if (!isValid(first)) continue;
            for (int jx = 1; jx <= 3 && ix + jx < s.size(); jx++) {
                string second = s.substr(ix + jx, jx);
                if (!isValid(second)) continue;
                for (int zx = 1; zx <= 3 && ix + jx + zx <= s.size(); zx++) {
                    string third = s.substr(ix + jx, zx);
                    string fourth = s.substr(ix + jx + zx);
                    if (isValid(third) && isValid(fourth)) {
                        results.emplace_back(first + "." + second + "." + third + "." + fourth);
                    }
                }
            }
        }
        return results;
    }
public:
    void reverseWords(string &s) {
        if (s.find(" ") == string::npos) {
            return;
        }
        std::reverse(s.begin(), s.end());
        size_t begin = 0;
        size_t pos = 0;
        while ((pos = s.find(" ", begin)) != string::npos) {
            std::reverse(s.begin() + begin, s.begin() + pos);
            begin = pos + 1;
        }
        std::reverse(s.begin() + pos, s.end());
    }
    int minimumTotal(vector<vector<int>>& triangle) {
        if (!triangle.size()) return 0;
        vector<int> prev = triangle[0];
        int minTotal = prev[0];
        for (int rx = 1; rx < triangle.size(); rx++) {
            int localMin = INT_MAX;
            vector<int> current = triangle[rx];
            for (int ix = 0; ix < current.size(); ix++) {
                current[ix] += min(ix - 1 >= 0? min(prev[ix - 1], prev[ix]):prev[ix], ix + 1 < prev.size()? min(prev[ix + 1], prev[ix]): prev[ix]);
                localMin = min(localMin, current[ix]);
            }
            minTotal = localMin;
            prev = move(current);
        }
        return minTotal;
    }
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
                matrix[ix + jx][size - 1 - ix] = temp1;
                matrix[size - 1 - ix][size - 1 - jx] = temp2;
                matrix[size - 1 - jx][ix] = temp4;
            }
        }
    }
    static bool compare(const pair<int,int>& x, const pair<int,int>& y) {
        return x.first < y.first;
    }
    bool containsNearbyAlmostDuplicate(vector<int>& nums, int k, int t) {
        if (!nums.size()) return false;
        
        vector<pair<int,int>> sorted;
        for (int ix = 0; ix < nums.size(); ix++) {
            sorted.emplace_back(nums[ix], ix);
        }
        
        sort(sorted.begin(), sorted.end(), compare);
        for (int ix = 0; ix < nums.size(); ix++) {
            int jx = 0;
            while (abs(sorted[jx].first + nums[ix]) <= t && jx < sorted.size()) {
                if (sorted[jx].second != ix && abs(sorted[jx].second - ix) <= k) {
                    return true;
                }
                jx++;
            }
        }
        return false;
    }
    int divide(int dividend, int divisor) {
        bool isMinus = dividend < 0? true: false;
        isMinus = divisor < 0? !isMinus: isMinus;
        
        long long x = abs(dividend);
        long long y = (long long)abs(divisor) << 32;
        long long pow = 1L << 32;
        int div = 0;
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
};


int main()
{
    Solution s;
    /*
    vector<ListNode*> lists;
    ListNode* newNode = new ListNode(1);
    lists.push_back(newNode);
    newNode = new ListNode(0);
    lists.push_back(newNode);
     */
    // s.mergeKLists(lists);
    
    /*
    char board[11][11] = {"..4...63.",".........","5......9.","...56....","4.3.....1","...7.....","...5.....",".........","........."};
    
    vector<vector<char>> fullBoard;
    
    for (int ix = 0 ; ix < 10; ix++) {
        vector<char> row;
        row.assign(board[ix], board[ix] + 10);
        fullBoard.push_back(row);
    }
    s.isValidSudoku(fullBoard);
    */
   // s.multiply("123", "456");
    
//    vector<int> nums = {1,5,1,1,6,4};
  //  s.wiggleSort2(nums);
   // s.wordPattern("aaa", "aa aa aa aa");
    /*
    s.strStr("aaa", "a");
    
    ListNode* headA = new ListNode(3);
    ListNode* headB = new ListNode(2);
    headB->next = headA;
    */
    // ListNode* intersect = s.getIntersectionNode(headA, headB);
  //  s.compareVersion("1.1", "1");
  //  s.trailingZeroes(1808548329);
    /*
    vector<int> nums1 = {-2147483648,-2147483647,2147483647};
    s.summaryRanges(nums1);
    */
    
    /*
    vector<string> board = {"ABCE","SFCS","ADEE"};
    

     
    vector<vector<char>> boardChars;
    for (int ix = 0; ix < board.size(); ix++) {
        vector<char> row;
        for (char c: board[ix]) {
            row.push_back(c);
        }
        boardChars.push_back(move(row));
    }
    string word = "ABCCED";
    s.exist(boardChars, word);
    */
    string in = "0000";
//    s.restoreIpAddresses(in);
  
  //  vector<vector<int>> triangle = {{1},{2,3}};
  //  s.minimumTotal(triangle);
 //   vector<vector<int>> matrix = {{1,2,3,4},{5,6,7,8},{9,10,11,12},{13,14,15,16}};
 //   s.rotate(matrix);
    vector<int> array = {-1, -1};
   // s.containsNearbyAlmostDuplicate(array, 1, 0);
    s.divide(2147483647, 1);
    return 0;
}


