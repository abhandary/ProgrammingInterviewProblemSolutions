//
//  SpiralMatrix.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "SpiralMatrix.hpp"

#include <iostream>
#include <vector>
#include <string>
#import <unordered_map>

using namespace std;



class Solution {
public:
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
};



int main()
{
    Solution s;
    vector<vector<int>> matrix = {{1, 2, 3}, {4, 5, 6}, {7, 8, 9}};
    vector<int> results = s.spiralOrder(matrix);
    
    return 0;
}
