//
//  main.cpp
//  EPI
//
//  Created by Akshay Bhandary on 1/24/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#include <iostream>
#include <random>
#include <iostream>
#include <algorithm>
#include <vector>
#include <queue>

using namespace std;

struct IteratorCurrentAndEnd
{
public:
    vector<int>::const_iterator _current;
    vector<int>::const_iterator _end;
    
    bool operator<(const IteratorCurrentAndEnd& that) const {
        return *_current > *that._current;
    }
};




void applyPermutation(vector<int>* perm_ptr, vector<char>* A_ptr) {
    vector<int>& perm = *perm_ptr;
    vector<char>& A = *A_ptr;
    
    for(int ix = 0; ix < A.size(); ix++) {
        int next = ix;
        while (perm[next] >= 0) {
            swap(A[ix], A[perm[next]]);
            int temp = perm[next];
            perm[next] -= perm.size();
            next = temp;
        }
    }
}

void nextPermutation(vector<int>* perm_ptr) {
    vector<int>& perm = *perm_ptr;
    
    long long ix = perm.size() - 2;
    
    for(; ix >= 0 && perm[ix] > perm[ix - 1]; ix--) {
        
    }
    
    if (ix == -1) {
        return;
    }
    
    // p[ix] < p[ix + 1]
    long long jx = perm.size() - 1;
    while (perm[jx] < perm[ix]) {
        jx--;
    }
    
    swap(perm[jx],perm[ix]);
    reverse(perm.begin() + ix + 1, perm.end());
}

void randomSampling(vector<int>& array, int k) {

    random_device dev;
    default_random_engine generator(dev());
                   
    for (int ix = 0; ix < k; ix++) {
        uniform_int_distribution<int> dis(ix, static_cast<int>(array.size() - 1));
        swap(array[ix], array[dis(generator)]);
    }
}


vector<int> mergeSorted(const vector<vector<int>>& in)
{
    vector<int> result;
    priority_queue<IteratorCurrentAndEnd, vector<IteratorCurrentAndEnd>> pq;
    
    for (const vector<int>& array : in) {
        pq.emplace(IteratorCurrentAndEnd{array.cbegin(), array.cend()});
    }
    
    while (!pq.empty()) {
        IteratorCurrentAndEnd it = pq.top();
        pq.pop();
        
        if (it._current != it._end) {
            result.emplace_back(*it._current);
            pq.emplace(IteratorCurrentAndEnd{next(it._current), it._end});
        }
    }
    
    return result;
}

vector<int> sortIncreasingDecreasing(const vector<int>& in)
{
    typedef enum { INC, DEC} SType;
    vector<int> result;
    SType order = INC;
    
    vector<vector<int>> intermediate;
    int six = 0;
    for (int ix = 1; ix <= in.size(); ix++) {
        
        if (ix == in.size() ||
            (order == INC && in[ix - 1] > in[ix]) ||
            (order == DEC && in[ix - 1] < in[ix]))
        {
            if (order == INC) {
                intermediate.emplace_back(in.cbegin() + six, in.cbegin() + six + ix);
            } else {
                intermediate.emplace_back(in.crbegin() + in.size() - ix, in.crbegin() + in.size() - six);
            }
            six = ix;
            order = SType(!order);
        }
    }
    
    result = mergeSorted(intermediate);
    
    return result;
}


int intSqRoot(int x) {
    
    int l = 0;
    int h = x;
    
    while (l <= h) {
        int mid = l + (h - l) / 2;
        
        if (mid * mid < x) {
            l = mid + 1;
        } else if (mid * mid > x) {
            h = mid - 1;
        } else {
            return mid;
        }
    }
    return l - 1;
}


int main(int argc, const char * argv[]) {
    
    int perm[] = {1, 0, 3, 2};
    
    char A[] = {'a', 'b', 'c', 'd'};
    vector<int> permV(perm, perm + 4);
    vector<char> AV(A, A + 4);
    
    randomSampling(permV, 2);
    
    std::cout << " === Permuted Vector ===" << std::endl;
    for(int ix = 0; ix < permV.size(); ix++) {
        std::cout << permV[ix] << " ";
    }
    int sorted1[] = {1, 2, 13, 14};
    int sorted2[] = {11, 12, 14, 15, 16};
    
    vector<int> s1(sorted1, sorted1 + 4);
    vector<int> s2(sorted2, sorted2 + 5);
    
    vector<vector<int>> in;
    in.emplace_back(s1);
    in.emplace_back(s2);
    vector<int> result = mergeSorted(in);
    
    std::cout << "\n === Sorted Vector ===" << std::endl;
    for(int ix = 0; ix < result.size(); ix++) {
        std::cout << result[ix] << " ";
    }

    int incdec[] = {57, 131, 493, 294, 221, 339, 418, 452, 442, 190};
    vector<int>incdecV (incdec, incdec + 10);
    
    result = sortIncreasingDecreasing(incdecV);
    
    std::cout << "\n === Sorted Vector ===" << std::endl;
    for(int ix = 0; ix < result.size(); ix++) {
        std::cout << result[ix] << " ";
    }

    std::cout << " Int Sq Root:" << intSqRoot(24) << std::endl;
    
    return 0;
    
}
