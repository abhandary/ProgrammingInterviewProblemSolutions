//
//  Islands.cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "Islands.hpp"

#include <iostream>
#include <vector>
#include <string>
#import <unordered_map>

using namespace std;


class Solution {
private:
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
};


int main()
{
    vector<vector<char>> grid {{'1', '1'}};
    Solution s;
    int num = s.numIslands(grid);
    
    return 0;
}

