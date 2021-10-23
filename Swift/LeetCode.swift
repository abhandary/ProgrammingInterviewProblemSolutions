class Solution {


    // LC199. Binary Tree Right Side View
    func rightSideView(_ root: TreeNode?) -> [Int] {
        var result = [Int]()        
        if let root = root {
            var queue = [TreeNode]()
            queue.append(root)

            var numInLevel = queue.count
            while (queue.count > 0) {
                let next = queue.removeFirst()
                numInLevel -= 1
                if let left = next.left { queue.append(left)  }
                if let right = next.right { queue.append(right)  }
                if (numInLevel == 0) {
                    result.append(next.val)
                    numInLevel = queue.count
                }
            }
        }
        return result            
    }

    // LC186. Reverse Words in a String II
    func reverseWordsHelper(_ s: inout [Character], _ left: Int, _ right: Int) {
        var left = left; 
        var right = right
        while left < right {
            s.swapAt(left, right)
            left += 1; right -= 1;
        }
    }
    
    func reverseWords(_ s: inout [Character]) {
        reverseWordsHelper(&s, 0, s.count - 1)
        var start = 0
        var end = 0
        while (end < s.count) {
            if (s[end] == " ") {
                reverseWordsHelper(&s, start, end - 1)
                start = end + 1
                end = start
            }
            end += 1
        }
        reverseWordsHelper(&s, start, end - 1)
    }

    // LC153. Find Minimum in Rotated Sorted Array
    func findMin(_ nums: [Int]) -> Int {
        var left = 0
        var right = nums.count - 1
        if (nums[0] <= nums[right]) { return nums[0] }
        while (left <= right) {
            let mid = left + (right - left)/2
            if (nums[mid + 1] < nums[mid]) {
                return nums[mid + 1]
            }
            if (nums[mid] < nums[mid - 1]) {
                return nums[mid]
            }
            if (nums[0] < nums[mid]) {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return -1
    }

    // LC129. Sum Root to Leaf Numbers
    func sumNumbersHelper(_ root: TreeNode?, _ partialNumber: Int, _ result: inout Int) {
        if let root = root {
            let nextPartial = partialNumber * 10 + root.val
            if root.left == nil && root.right == nil {
                result += nextPartial
                return
            }
            sumNumbersHelper(root.left, nextPartial, &result)
            sumNumbersHelper(root.right, nextPartial, &result)            
        }
    }
    
    func sumNumbers(_ root: TreeNode?) -> Int {
        var result = 0
        sumNumbersHelper(root, 0, &result)
        return result
    }

    // LC113. Path Sum II
    func pathSumHelper(_ root: TreeNode?, _ targetSum: Int, _ partialSum: Int, _ partial: [Int], _ result: inout [[Int]]) {
        if let root = root {
            let nextPartial = partial + [root.val]
            let nextPartialSum = partialSum + root.val
            if (root.left == nil && root.right == nil) {
                if (nextPartialSum == targetSum) {
                    result.append(nextPartial)                    
                }
                return
            }
            pathSumHelper(root.left, targetSum, nextPartialSum, nextPartial, &result)
            pathSumHelper(root.right, targetSum, nextPartialSum, nextPartial, &result)         
        }
    }
    
    func pathSum(_ root: TreeNode?, _ targetSum: Int) -> [[Int]] {
        var result = [[Int]]()
        pathSumHelper(root, targetSum, 0, [], &result)
        return result
    }

    // LC1. Two Sum
    func twoSum(_ nums: [Int], _ target: Int) -> [Int] {
        var map = [Int: Int]()
        for (index, value) in nums.enumerated() {
            if let storedIx = map[target - value] {
                return [storedIx, index]
            }
            map[value] = index
        }
        return [-1, -1]
    }
}