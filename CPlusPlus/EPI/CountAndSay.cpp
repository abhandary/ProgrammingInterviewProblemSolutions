//
//  CountAndSay.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "CountAndSay.hpp"

#include <iostream>
#include <vector>
#include <string>
#import <unordered_map>

using namespace std;


class Solution {
public:
    string countAndSay(int n) {
        string s = "";
        if (n == 0) return s;
        s = "1";
        for (int ix = 0; ix < n - 1; ix++) {
            string newString = "";
            int count = 1;
            for (int sx = 1; sx < s.size(); sx++) {
                if (s[ix] != s[ix - 1]) {
                    newString += to_string(count) + s[ix - 1];
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
};


int main()
{
    Solution s;
    string result = s.countAndSay(4);
    
    return 0;
}
