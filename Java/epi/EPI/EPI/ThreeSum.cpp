//
//  ThreeSum.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include <iostream>
#include <vector>
#include <string>
#import <unordered_map>

using namespace std;

class Solution {
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
public:
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
                    if (!isPresent(results, result)) {
                        results.push_back(result);
                    }
                    right--;
                } else if (nums[ax] + nums[left] + nums[right] > 0) {
                    right--;
                } else {
                    left++;
                }
            }
        }
        return results;
    }
    
public:
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
private:
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
        
        for (int ix = 0; ix < combinations[digits[offset]].size(); ix++) {
            lcHelper(digits, offset + 1, partial + combinations[digits[offset]][ix], results, combinations);
        }
    }
};


int main()
{
    vector<int> S {7,-1,14,-12,-8,7,2,-15,8,8,-8,-14,-4,-5,7,9,11,-4,-15,-6,1,-14,4,3,10,-5,2,1,6,11,2,-2,-5,-7,-6,2,-15,11,-6,8,-4,2,1,-1,4,-6,-15,1,5,-15,10,14,9,-8,-6,4,-6,11,12,-15,7,-1,-9,9,-1,0,-4,-1,-12,-2,14,-9,7,0,-3,-4,1,-2,12,14,-10,0,5,14,-1,14,3,8,10,-8,8,-5,-2,6,-11,12,13,-7,-12,8,6,-13,14,-2,-5,-11,1,3,-6};
    
    Solution s;
  //  vector<vector<int>> results = s.threeSum(S);
    
    vector<string> results = s.letterCombinations("2");
    
    return 0;
}

