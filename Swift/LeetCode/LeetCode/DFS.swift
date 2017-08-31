//
//  DFS.swift
//  LeetCode
//
//  Created by Akshay Bhandary on 3/22/17.
//  Copyright © 2017 Akshay Bhandary. All rights reserved.
//

import Foundation

//class TreeNode {
//    public var val: Int
//    public var left: TreeNode?
//    public var right: TreeNode?
//    public init(_ val: Int) {
//        self.val = val
//        self.left = nil
//        self.right = nil
//    }
//}

class DFS {
    
    // LC:494. Target Sum
    // @todo: passed 117/139 test cases
    var numWays = 0
    var hmap = [String : Int]()
    
    func findTargetSumWaysHelper(_ nums: [Int], _ pos : Int, _ sum : Int, _ S: Int) -> Int  {
        
        if pos == nums.count {
            return sum == S ? 1 : 0
        }
        let keyStr = "\(pos)->\(sum)"
        if let val = hmap[keyStr] {
            return val;
        }
        
        let a = findTargetSumWaysHelper(nums, pos + 1, sum - nums[pos], S)
        let b = findTargetSumWaysHelper(nums, pos + 1, sum + nums[pos], S)
        hmap[keyStr] = a + b
        return a + b
    }
    
    func findTargetSumWays(_ nums: [Int], _ S: Int) -> Int {
        return findTargetSumWaysHelper(nums, 0, 0, S)
        
    }
    
    // LC:394. Decode String
    // @see: Stacks
    
    var cache : [[Int]]!;
    func longestIncreasingPathHelper(_ matrix: inout [[Int]], _ ix : Int, _ jx : Int)  -> Int {
        
        if cache[ix][jx] != 0 { return cache[ix][jx]; }
        
        let dirs = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        
        var maxVal = 1;
        for dx in 0..<dirs.count {
            let x = ix + dirs[dx][0], y = jx + dirs[dx][1];
            
            if x < 0 || x >= matrix.count || y < 0 || y >= matrix[0].count || matrix[x][y] <= matrix[ix][jx] { continue; }
            
            let len = 1 + longestIncreasingPathHelper(&matrix, x, y);
            maxVal = max(maxVal, len);
            
        }
        cache[ix][jx] = maxVal;
        return maxVal;
    }
    
    
    func longestIncreasingPath(_ matrix: [[Int]]) -> Int {
        
        guard matrix.count > 0 else { return 0; }
        cache = [[Int]](repeating: [Int](repeating: 0, count: matrix[0].count), count: matrix.count);
        var matrix = matrix;
        var maxVal = 1;
        for ix in 0..<matrix.count {
            for jx in 0..<matrix[0].count {
                maxVal = max(longestIncreasingPathHelper(&matrix, ix, jx), maxVal);
            }
        }
        return maxVal;
    }
    
    // LC:337. House Robber III
    // https://leetcode.com/problems/house-robber-iii/description/
    // https://discuss.leetcode.com/topic/39834/step-by-step-tackling-of-the-problem
    // https://discuss.leetcode.com/topic/39659/easy-understanding-solution-with-dfs
    
    // LC:332. Reconstruct Itinerary
    // https://leetcode.com/problems/reconstruct-itinerary/description/
    // SP https://discuss.leetcode.com/topic/36370/short-ruby-python-java-c
    // https://discuss.leetcode.com/topic/36383/share-my-solution
    
    // LC:257. Binary Tree Paths
    func binaryTreePathsHelper(_ root: TreeNode?, _ result : inout [String], _ partial : String){
        if let root = root {
            var partial = partial;
            partial += String(root.val);
            if root.left == nil && root.right == nil {
                result.append(partial);
                return;
            }
            if root.left != nil {
                binaryTreePathsHelper(root.left, &result, partial + "->");
            }
            if root.right != nil {
                binaryTreePathsHelper(root.right, &result, partial + "->");
            }
        }
    }
    
    func binaryTreePaths(_ root: TreeNode?) -> [String] {
        var result = [String]();
        binaryTreePathsHelper(root, &result, "");
        return result;
    }
    
    // LC:210. Course Schedule II
    // https://discuss.leetcode.com/topic/13873/two-ac-solution-in-java-using-bfs-and-dfs-with-explanation
    // https://discuss.leetcode.com/topic/17276/20-lines-c-bfs-dfs-solutions/2
 
    
    // LC:207. Course Schedule
    // https://discuss.leetcode.com/topic/17273/18-22-lines-c-bfs-dfs-solutions
    // https://discuss.leetcode.com/topic/13854/easy-bfs-topological-sort-java
    /*
     
    public boolean canFinish(int numCourses, int[][] prerequisites) {
        int[][] matrix = new int[numCourses][numCourses]; // i -> j
        int[] indegree = new int[numCourses];
    
        for (int i=0; i<prerequisites.length; i++) {
            int ready = prerequisites[i][0];
            int pre = prerequisites[i][1];
            if (matrix[pre][ready] == 0)
                indegree[ready]++; //duplicate case
            matrix[pre][ready] = 1;
        }
    
        int count = 0;
        Queue<Integer> queue = new LinkedList();
        for (int i=0; i<indegree.length; i++) {
            if (indegree[i] == 0) queue.offer(i);
        }
        while (!queue.isEmpty()) {
            int course = queue.poll();
            count++;
            for (int i=0; i<numCourses; i++) {
                if (matrix[course][i] != 0) {
                    if (--indegree[i] == 0)
                        queue.offer(i);
                }
            }
        }
        return count == numCourses;
    }
 
     class Solution {
        public:
            bool canFinish(int numCourses, vector<pair<int, int>>& prerequisites) {
                vector<unordered_set<int>> graph = make_graph(numCourses, prerequisites);
                vector<bool> onpath(numCourses, false), visited(numCourses, false);
                for (int i = 0; i < numCourses; i++)
                    if (!visited[i] && dfs_cycle(graph, i, onpath, visited))
                        return false;
                return true;
            }
        private:
            vector<unordered_set<int>> make_graph(int numCourses, vector<pair<int, int>>& prerequisites) {
                vector<unordered_set<int>> graph(numCourses);
                for (auto pre : prerequisites)
                    graph[pre.second].insert(pre.first);
                return graph;
            }
     
            bool dfs_cycle(vector<unordered_set<int>>& graph, int node, vector<bool>& onpath, vector<bool>& visited) {
                if (visited[node]) return false;
                onpath[node] = visited[node] = true;
                for (int neigh : graph[node])
                    if (onpath[neigh] || dfs_cycle(graph, neigh, onpath, visited))
                        return true;
                return onpath[node] = false;
            }
     };
     
    */
    
    // LC:200. Number of Islands
    func cover(_ grid : inout [[Character]], _ ix : Int, _ jx : Int) {
        
        if ix < 0 || ix >= grid.count || jx < 0 || jx >= grid[0].count { return; }
        if grid[ix][jx] == "0" { return; }
        
        let dir = [[0, 1], [0, -1], [1, 0], [-1, 0]];
        
        grid[ix][jx] = "X";
        for dx in 0..<dir.count {
            cover(&grid, ix + dir[dx][0], jx + dir[dx][1]);
        }
        
    }
    
    func numIslands(_ grid: [[Character]]) -> Int {
        guard grid.count > 0 else { return 0; }
        var gridCopy = grid;
        var count = 0;
        for ix in 0..<grid.count {
            for jx in 0..<grid[0].count {
                if grid[ix][jx] == "1" {
                    count += 1;
                    cover(&gridCopy, ix, jx);
                }
            }
        }
        return count;
    }
    
    // LC:199. Binary Tree Right Side View
    func rightSideView(_ root: TreeNode?) -> [Int] {
        guard root != nil else { return []; }
        
        var result = [Int]();
        var queue = [TreeNode]();
        queue.append(root!);
        var numInLevel = 1;
        var level = [Int]();
        while(queue.count > 0) {
            let current = queue.removeFirst();
            
            if let left = current.left { queue.append(left); }
            if let right = current.right { queue.append(right); }
            
            level.append(current.val);
            numInLevel -= 1;
            if (numInLevel == 0) {
                result.append(level.last!);
                level = [Int]();
                numInLevel = queue.count;
            }
        }
        return result;
        
    }
    
    // LC:133. Clone Graph
    // @todo: standard DFS
    /*
    private HashMap<Integer, UndirectedGraphNode> map = new HashMap<>();
        public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
            return clone(node);
        }
    
        private UndirectedGraphNode clone(UndirectedGraphNode node) {
            if (node == null) return null;
    
            if (map.containsKey(node.label)) {
                return map.get(node.label);
            }
            UndirectedGraphNode clone = new UndirectedGraphNode(node.label);
            map.put(clone.label, clone);
            for (UndirectedGraphNode neighbor : node.neighbors) {
                clone.neighbors.add(clone(neighbor));
            }
        return clone;
    }
    */
    
    // LC:129. Sum Root to Leaf Numbers
    func sumNumbersHelper(_ root : TreeNode?, _ partial : Int, _ result : inout Int) {
        if let root = root {
            var partial = partial;
            partial *= 10;
            partial += root.val;
            if root.left == nil && root.right == nil {
                result += partial;
            }
            sumNumbersHelper(root.left, partial, &result);
            sumNumbersHelper(root.right, partial, &result);
        }
    }
    
    func sumNumbers(_ root: TreeNode?) -> Int {
        if root == nil { return 0; }
        var result = 0;
        sumNumbersHelper(root, 0, &result);
        return result;
    }
    
    // LC:117. Populating Next Right Pointers in Each Node II
    // @todo: passes only 10/61
    /*
    public void connect(TreeLinkNode root) {
        if(root == null)
            return;
    
        if(root.left != null){
            prev = root.left;
        }
    
        if (prev != null) { prev.next = root.right; }
    
        if (root.right != null) {
            prev = root.right;
        }
        if (root.next != null && prev != null) {
            prev.next = root.next.left;
        }
    
        connect(root.left);
        connect(root.right);
    }
    */
    
    // LC:116. Populating Next Right Pointers in Each Node
    /*
    public void connect(TreeLinkNode root) {
        if(root == null)
            return;
    
        if(root.left != null){
            root.left.next = root.right;
            if(root.next != null)
                root.right.next = root.next.left;
        }
    
        connect(root.left);
        connect(root.right);
    }
    */
    
    // LC:114. Flatten Binary Tree to Linked List
    var prev : TreeNode?
    
    func flatten(_ root: TreeNode?) {
        if let root = root {
            flatten(root.right)
            flatten(root.left)
            root.right = prev
            root.left = nil
            prev = root
        }
    }
    
    
    /*
    void flatten(TreeNode *root) {
        TreeNode*now = root;
        while (now)
        {
            if(now->left)
            {
                //Find current node's prenode that links to current node's right subtree
				TreeNode* pre = now->left;
				while(pre->right)
				{
                    pre = pre->right;
				}
				pre->right = now->right;
                //Use current node's left subtree to replace its right subtree(original right
                //subtree is already linked by current node's prenode
				now->right = now->left;
				now->left = NULL;
            }
            now = now->right;
        }
    }
    */
    
    // LC:113. Path Sum II
    func pathSumHelper(_ root : TreeNode?, _ sum : Int, _ partial : [Int], _ result : inout [[Int]]) {
        
        var partial = partial
        var sum = sum
        if let root = root {
            sum -= root.val;
            partial.append(root.val)
            
            if root.left == nil && root.right == nil {
                if sum == 0 {
                    result.append(partial)
                }
                return
            }
            
            pathSumHelper(root.left, sum, partial, &result)
            pathSumHelper(root.right, sum, partial, &result)
        }
        return;
    }
    
    func pathSum(_ root: TreeNode?, _ sum: Int) -> [[Int]] {
        var result = [[Int]]()
        pathSumHelper(root, sum, [], &result)
        return result
    }
    
    
    // LC:112. Path Sum
    func hasPathSum(_ root: TreeNode?, _ sum: Int) -> Bool {
        guard root != nil else { return false; }
        var sum = sum
        if let root = root {
            sum -= root.val
            if root.left == nil && root.right == nil && sum == 0 {
                return true
            }
            return hasPathSum(root.left, sum) || hasPathSum(root.right, sum);
        }
        return false;
    }
    
    
    // LC:111. Minimum Depth of Binary Tree
    func minDepth(_ root: TreeNode?) -> Int {
        
        if let root = root {
            if root.left == nil && root.right == nil {
                return 1;
            }
            
            if root.left != nil && root.right != nil {
                return 1 + min(minDepth(root.left), minDepth(root.right))
            }
            if root.left != nil {
                return 1 + minDepth(root.left);
            }
            return 1 + minDepth(root.right);
        }
        
        return 0
    }
    
    
    // LC:110. Balanced Binary Tree
    func isBalancedHelper(_ root : TreeNode?) -> (Bool, Int) {
        
        if let root = root {
            var leftResult : (Bool, Int) = (false, 0);
            if let left = root.left {
                leftResult = isBalancedHelper(left);
                if leftResult.0 == false { return (false, -1); }
            }
            var rightResult : (Bool, Int) = (false, 0);
            if let right = root.right {
                rightResult = isBalancedHelper(right);
                if rightResult.0 == false { return (false, -1); }
            }
            return (abs(leftResult.1 - rightResult.1) <= 1, max(leftResult.1, rightResult.1) + 1);
        }
        return (true, 0);
    }
    
    func isBalanced(_ root: TreeNode?) -> Bool {
        let result =  isBalancedHelper(root);
        return result.0;      
    }

    // LC:109. Convert Sorted List to Binary Search Tree
    func toBST(_ head : ListNode?, _ tail : ListNode?) -> TreeNode? {
        if head === tail { return nil }
        var slow = head
        var fast = head
        while fast !== tail && fast?.next !== tail {
            slow = slow?.next
            fast = fast?.next?.next
        }
        let root = TreeNode(x: slow!.val)
        root.left = toBST(head, slow)
        root.right = toBST(slow!.next, tail)
        return root
    }
    
    func sortedListToBST(_ head: ListNode?) -> TreeNode? {
        if let head = head {
            return toBST(head, nil)
        }
        return nil
    }
    
    
    // LC:108. Convert Sorted Array to Binary Search Tree
    func sortedArrayToBSTHelper(_ nums: [Int], _ left : Int, _ right : Int) -> TreeNode? {
        if left > right { return nil; }
        let mid = left + (right - left) / 2;
        var root = TreeNode(x: nums[mid]);
        root.left = sortedArrayToBSTHelper(nums, left, mid - 1);
        root.right = sortedArrayToBSTHelper(nums, mid + 1, right);
        return root;
    }
    
    func sortedArrayToBST(_ nums: [Int]) -> TreeNode? {
        guard nums.count > 0 else { return nil; }
        
        return   sortedArrayToBSTHelper(nums, 0, nums.count - 1);
    }
    
    // LC:106. Construct Binary Tree from Inorder and Postorder Traversal
    // @see: Arrays
    
    // LC:105. Construct Binary Tree from Preorder and Inorder Traversal
    // @see: Arrays
    
    // LC: 104. Maximum Depth of Binary Tree
    func maxDepth(_ root: TreeNode?) -> Int {
        if let root = root {
            return 1 + max(maxDepth(root.left), maxDepth(root.right));
        }
        return 0;
    }
    
    // LC: 101. Symmetric Tree
    func isSymmetricHelper(_ left : TreeNode?, _ right : TreeNode?) -> Bool {
        if left == nil && right == nil { return true; }
        if left == nil || right == nil || left!.val != right!.val { return false;}
        return isSymmetricHelper(left!.right, right!.left) && isSymmetricHelper(left!.left, right!.right);
    }
    
    func isSymmetric(_ root: TreeNode?) -> Bool {
        if root == nil { return true; }
        return isSymmetricHelper(root!.left, root!.right);
    }
    
    
    
    // LC: 100. Same Tree
    func isSameTree(_ p: TreeNode?, _ q: TreeNode?) -> Bool {
        if p == nil && q == nil { return true; }
        if p == nil || q == nil || p!.val != q!.val { return false; }
        
        return isSameTree(p!.left, q!.left) && isSameTree(p!.right, q!.right);
        
    }
    
    // LC: 98. Validate Binary Search Tree
    func isValidBSTHelper(_ root : TreeNode?, _ left : Int, _ right : Int) -> Bool {
        if let root = root {
            if root.val < left || root.val > right { return false; }
            var leftValid = true;
            if (root.left != nil) {
                leftValid = isValidBSTHelper(root.left, left, root.val - 1);
            }
            var rightValid = true;
            if (root.right != nil) {
                rightValid = isValidBSTHelper(root.right, root.val + 1, right);
            }
            return leftValid && rightValid;
        }
        return true;
    }
    
    func isValidBST(_ root: TreeNode?) -> Bool {
        if root == nil { return true; }
        return isValidBSTHelper(root, Int.min, Int.max);
    }
}
