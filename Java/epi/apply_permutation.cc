
#include <iostream>
#include <algorithm>
#include <vector>
using namespace std;

void applyPermutation(vector<int>* perm_ptr, vector<char>* A_ptr) {
   vector<int>& perm = *perm_ptr;
   vector<char>& A = *A_ptr;

   for(int ix = 0; ix < A.size(); ix++) {
       int next = ix;
       while (perm[next] >= 0) {
          swap(A[ix], A[perm[next]]);
          next = perm[next];
          perm[next] -= perm.size();
       }
   }
}


int main()
{
   int perm[] = {2, 0, 1, 3};
   char A[] = {'a', 'b', 'c', 'd'};
   vector<int> permV(perm, perm + 4);
   vector<char> AV(A, A + 4);

   applyPermutation(&permV, &AV);
   std::cout << " === Permuted Vector ===" << std::endl;
   for(int ix = 0; ix < AV.size(); ix++) {
      std::cout << AV[ix] << " ";
   }
}
