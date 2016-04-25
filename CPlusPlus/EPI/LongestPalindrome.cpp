//
//  LongestPalindrome.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/13/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "LongestPalindrome.hpp"


#include <iostream>
#include <vector>
#include <string>

using namespace std;

class Solution {
    
public:
    string expandAroundCenter(string s, int c1, int c2) {
        while (c1 >= 0 && c2 < s.size() && s[c1] == s[c2]) {
            c1--, c2++;
        }
        return s.substr(c1 + 1, c2 - c1 - 1);
    }
    string longestPalindrome(string s) {
        int longest = 0;
        string longestString;
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
private:
    
};


int main()
{
    Solution s;
    std::cout << s.longestPalindrome("bd") << std::endl;
}

