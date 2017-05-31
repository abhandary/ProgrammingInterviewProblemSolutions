
#include <iostream>
#include <vector>

using namespace std;

void subsets_helper(int n, int k, int offset, vector<int>& subset,
                    vector<vector<int>>& results) {
    if (subset.size() == k) {
        results.emplace_back(subset);
        return;
    }
    
    
    for (int ix = offset; ix <= n; ix++) {
        subset.push_back(ix);
        subsets_helper(n, k, ix + 1, subset, results);
        subset.pop_back();
    }
}


vector<vector<int>> subsets_itr(int n, int k)
{
    vector<vector<int>> results;
    vector<int> subset(0, k);
    
    for (int kx = 1; kx <= k; kx++) {
        for(int ix = kx; ix <= n; ix++) {
            subset[kx] = ix;
        }
    }
    return results;
}


vector<vector<int>> subsets(int n, int k) {
   vector<int> empty;
   vector<vector<int>> results;
   subsets_helper(n, k, 1, empty, results);
    return results;
}


int main()
{
   vector<vector<int>> results = subsets(5, 3);
   
   std::cout << "========== N Choose K ==============" << std::endl;
   for(int ix = 0; ix < results.size(); ix++) {
       vector<int>& subset = results[ix];
       for (int jx = 0; jx < subset.size(); jx++) {
           std::cout << subset[jx] << ", ";
       }
       std::cout << std::endl;
   }
   std::cout << "===================================" << std::endl;
   return 0;
}






