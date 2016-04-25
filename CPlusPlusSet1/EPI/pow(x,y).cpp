//
//  pow(x,y).cpp
//  EPI
//
//  Created by Akshay Bhandary on 2/14/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include "pow(x,y).hpp"
#include <complex>

class Solution {
public:
    double myPow(double x, int n) {
        bool isMinus = n < 0? true:false;
        n = std::abs(n);
        
        if (n == 0)  return 1;
        if (n == 1) return x;
        
        double intermediate = myPow(x, n/2);
        double inter2 = intermediate * intermediate;
        if (n % 2 == 0) {
            return isMinus? 1/inter2: inter2;
        } else {
            return isMinus? 1/inter2 * x: inter2 * x;
        }
    }
};


int main()
{
    Solution s;
    double result = s.myPow(8.88023, 3);
    
    return 0;
}