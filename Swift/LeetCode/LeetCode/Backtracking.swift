//
//  Backtracking.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 8/22/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

class Backtracking {

    var result : [[Int]]!
    
    var hmap = [String : Bool]()
    
    // LC:90. Subsets II
    // passes 10/19
    func subsetsWithDupHelper(_ nums : [Int], _ partial : [Int], _ begin : Int, _ result : inout [[Int]]) {
        var partial = partial
        result.append(partial)
        
        for ix in begin..<nums.count {
            if ix > 0 && nums[ix] == nums[ix - 1] { continue; }
            partial.append(nums[ix])
            subsetsWithDupHelper(nums, partial, ix + 1, &result)
            partial.removeLast()
        }
    }
    
    func subsetsWithDup(_ nums: [Int]) -> [[Int]] {
        
        let sorted = nums.sorted()
        var result = [[Int]]()
        subsetsWithDupHelper(sorted, [], 0, &result)
        return result
    }
    
    // passes all tests
    func subsetsWithDup2(_ nums: [Int]) -> [[Int]] {
        let sorted = nums.sorted()
        var result = [[Int]]()
        result.append([])
        var ix = 0
        while ix < sorted.count {
            var count = 0
            while count + ix < sorted.count && sorted[count + ix] == sorted[ix] { count += 1; }
            
            var previousN = result.count
            for kx in 0..<previousN {
                var instance = result[kx]
                for jx in 0..<count {
                    instance.append(sorted[ix])
                    result.append(instance)
                }
            }
            ix += count
        }
        return result
    }
    
    
    // LC:79. Word Search
    func existHelper(_ board : inout [[Character]], _ word : [Character], _ wx : Int, _ ix : Int, _ jx : Int) -> Bool {
        
        
        if wx == word.count { return true; }
        guard ix >= 0 && jx >= 0 && ix < board.count && jx < board[0].count else { return false; }
        
        
        if word[wx] != board[ix][jx] { return false; }
        let temp = board[ix][jx]
        board[ix][jx] = "$"
        let shifts = [[0, -1], [0, 1], [1, 0], [-1, 0]]
        for shift in shifts {
            if existHelper(&board, word, wx + 1, ix + shift[0], jx + shift[1]) == true {
                return true;
            }
        }
        board[ix][jx] = temp
        return false;
    }
    
    func exist(_ board: [[Character]], _ word: String) -> Bool {
        guard board.count > 0 else { return false; }
        
        var board = board
        let wchars = Array(word.characters)
        for ix in 0..<board.count {
            for jx in 0..<board[0].count {
                if existHelper(&board, wchars, 0, ix, jx)  == true { return true; }
            }
        }
        return false;
    }
    
    // LC:78. Subsets
    func subsets(_ nums: [Int]) -> [[Int]] {
        let n = nums.count;
        var result = [[Int]]();
        
        for ix in 0..<(1 << n) {
            var partial = [Int]();
            var num = ix;
            while num > 0 {
                let bitSet = Double(num & ~(num - 1));
                partial.append(nums[Int(log(bitSet) / log(2))]);
                num &= (num - 1);
            }
            result.append(partial);
        }
        return result;
    }
    
    // LC:77. Combinations
    func combineHelper(_ start : Int, _ n : Int, _ k : Int, _ partial : inout [Int], _ result : inout [[Int]]) {
        
        if k == 0 {
            result.append(partial)
            return
        }
        if start > n { return; }
        for ix in start...n {
            partial.append(ix)
            combineHelper(ix + 1, n, k - 1, &partial, &result)
            partial.removeLast()
        }
    }
    
    func combine(_ n: Int, _ k: Int) -> [[Int]] {
        var result = [[Int]]()
        var partial = [Int]()
        combineHelper(1, n, k, &partial, &result)
        return result
    }
    
    //LC:47. Permutations II 
    func permuteUniqueHelper(_ nums : inout [Int], _ pos : Int, _ result : inout [[Int]], _ partial : [Int], _ used : inout [Bool]) {
        if pos == nums.count {
            result.append(partial)
            return
        }
        
        for ix in 0..<nums.count {
            if used[ix] == true { continue; }
            if ix > 0 && nums[ix] == nums[ix - 1] && !used[ix - 1] { continue; }
            used[ix] = true
            var partial = partial
            partial.append(nums[ix])
            permuteUniqueHelper(&nums, pos + 1, &result, partial, &used)
            used[ix] = false
        }
    }
    
    func permuteUnique(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var nums = nums.sorted()
        var used = [Bool](repeating: false, count: nums.count)
        permuteUniqueHelper(&nums, 0, &result, [Int](), &used)
        return result
    }
    
    // @todo: passes only 21/30
    func permuteUniqueHelper(_ nums : inout [Int], _ pos : Int, _ result : inout [[Int]]) {
        if pos == nums.count - 1 {
            result.append(nums)
            return
        }
        
        for ix in pos..<nums.count {
            if ix != pos && nums[ix] == nums[ix - 1] { continue; }
            if ix != pos { swap(&nums[ix], &nums[pos]) }
            permuteUniqueHelper(&nums, pos + 1, &result)
            if ix != pos { swap(&nums[ix], &nums[pos]) }
        }
    }
    
    func permuteUnique2(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var nums = nums.sorted()
        // var used = [Bool](repeating: false, count : nums.count)
        permuteUniqueHelper(&nums, 0, &result)
        return result
    }
    
    /* ACCEPTED
    void recursion(vector<int> num, int i, int j, vector<vector<int> > &res) {
        if (i == j-1) {
            res.push_back(num);
            return;
        }
        for (int k = i; k < j; k++) {
            if (i != k && num[i] == num[k]) continue;
            swap(num[i], num[k]);
            recursion(num, i+1, j, res);
        }
     }
     
     vector<vector<int> > permuteUnique(vector<int> &num) {
        sort(num.begin(), num.end());
        vector<vector<int> >res;
        recursion(num, 0, num.size(), res);
        return res;
     }
     */
    
    // LC:46. Permutations
    func permuteHelper(_ nums : inout [Int], _ pos : Int, _ result : inout [[Int]]) {
        
        if pos == nums.count {
            result.append(nums)
            return
        }
        
        for ix in pos..<nums.count {
            if ix != pos {
                swap(&nums[ix], &nums[pos])
            }
            permuteHelper(&nums, pos + 1, &result)
            if ix != pos {
                swap(&nums[ix], &nums[pos])
            }
        }
    }
    
    func permute(_ nums: [Int]) -> [[Int]] {
        var result = [[Int]]()
        var nums = nums
        permuteHelper(&nums, 0, &result)
        return result
    }
    
    //LC:40. Combination Sum II
    func combinationSum2Helper(_ candidates: [Int], _ target: Int, _ result : inout [[Int]], _  partial : [Int], _ begin : Int) {
        
        guard target >= 0 else { return; }
        if target == 0 {
            result.append(partial);
            return;
        }
        
        
        var partial = partial;
        for ix in begin..<candidates.count {
            if ix > begin && candidates[ix] == candidates[ix - 1] { continue; }
            let newTarget = target - candidates[ix]
            if (newTarget >= 0) {
                partial.append(candidates[ix]);
                combinationSum2Helper(candidates, newTarget, &result, partial, ix + 1);
                partial.removeLast();
            }
        }
        
    }
    
    func combinationSum2(_ candidates: [Int], _ target: Int) -> [[Int]] {
        let  sortedCandidates = candidates.sorted();
        var result = [[Int]]()
        var partial = [Int]()
        combinationSum2Helper(sortedCandidates, target, &result, partial, 0)
        return result;
    }
    
    //LC:39. Combination Sum
    func combinationSumHelper(_ candidates: [Int], _ ix: Int, _ partial: inout [Int], _ target: Int) {
        
        if target == 0 {
            result.append(partial);
            return
        }
        
        var jx = ix;
        while jx < candidates.count  {
            let value = candidates[jx]
            if target - value >= 0 {
                partial.append(value)
                combinationSumHelper(candidates, jx, &partial, target - value);
                partial.removeLast();
            }
            jx += 1;
        }
    }
    
    func combinationSum(_ candidates: [Int], _ target: Int) -> [[Int]] {
        result = [[Int]]();
        var partial = [Int]();
        combinationSumHelper(candidates, 0, &partial, target);
        return result;
    }
    
    //LC:22. Generate Parentheses
    func generateParenthesisHelper(_ n: Int, _ leftCount : Int, _ rightCount : Int, _ partial : String, _ result : inout [String]) {
        
        var leftCount = leftCount, rightCount = rightCount;
        if leftCount == 0 && rightCount == 0 {
            result.append(partial);
            return;
        }
        
        if leftCount < rightCount {
            generateParenthesisHelper(n, leftCount, rightCount - 1, partial + ")", &result);
        }
        
        if leftCount > 0 {
            generateParenthesisHelper(n, leftCount - 1, rightCount, partial + "(", &result);
            
        }
    }
    
    func generateParenthesis(_ n: Int) -> [String] {
        var result = [String]();
        generateParenthesisHelper(n, n, n, "", &result);
        return result;
    }

    
    //LC:17. Letter Combinations of a Phone Number
    func letterCombinationsHelper(_ digits: String, _ partial : String, _ pos : Int, _ map : [Character : String], _ result : inout [String])
    {
        if pos == digits.characters.count {
            result.append(partial);
            return;
        }
        let chars = Array(digits.characters);
        let mappedChars = Array(map[chars[pos]]!.characters)
        for char in mappedChars {
            letterCombinationsHelper(digits, partial + String(char), pos + 1, map, &result);
        }
    }
    func letterCombinations(_ digits: String) -> [String]
    {
        var result = [String]()
        guard digits.characters.count > 0 else { return result; }
        let map : [Character : String] = ["0" : "0", "1" : "1", "2" : "abc", "3" : "def", "4" : "ghi", "5" : "jkl", "6" : "mno", "7" : "pqrs", "8" : "tuv", "9" : "wxyz"];
        letterCombinationsHelper(digits, "", 0, map, &result);
        return result;
    }

}
