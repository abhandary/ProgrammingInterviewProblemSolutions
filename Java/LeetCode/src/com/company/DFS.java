package com.company;

import java.util.*;
import java.lang.Math;

class UndirectedGraphNode {
    int label;
    List<UndirectedGraphNode> neighbors;
    UndirectedGraphNode(int x) { label = x; neighbors = new ArrayList<UndirectedGraphNode>(); }
 };
/**
 * Created by akshayb on 2/27/17.
 */
public class DFS {


    


    int[][] cache;

    static final int[][] dirs = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    // LC: 417. Pacific Atlantic Water Flow
    // Given an m x n matrix of non-negative integers representing the height of each unit cell in a continent, the "Pacific ocean" touches the left and top edges of the matrix and the "Atlantic ocean" touches the right and bottom edges.
    // Water can only flow in four directions (up, down, left, or right) from a cell to another one with height equal or lower.
    // Find the list of grid coordinates where water can flow to both the Pacific and Atlantic ocean.
    // Note:
    //  The order of returned grid coordinates does not matter.
    //  Both m and n are less than 150.
    // https://discuss.leetcode.com/topic/62379/java-bfs-dfs-from-ocean
    public List<int[]> pacificAtlanticDFS(int[][] matrix) {
        List<int[]> res = new LinkedList<>();
        if(matrix == null || matrix.length == 0 || matrix[0].length == 0){
            return res;
        }
        int n = matrix.length, m = matrix[0].length;
        boolean[][]pacific = new boolean[n][m];
        boolean[][]atlantic = new boolean[n][m];
        for(int i=0; i<n; i++){
            dfs(matrix, pacific, Integer.MIN_VALUE, i, 0);
            dfs(matrix, atlantic, Integer.MIN_VALUE, i, m-1);
        }
        for(int i=0; i<m; i++){
            dfs(matrix, pacific, Integer.MIN_VALUE, 0, i);
            dfs(matrix, atlantic, Integer.MIN_VALUE, n-1, i);
        }
        for (int i = 0; i < n; i++)
            for (int j = 0; j < m; j++)
                if (pacific[i][j] && atlantic[i][j])
                    res.add(new int[] {i, j});
        return res;
    }

    int[][]dir = new int[][]{{0,1},{0,-1},{1,0},{-1,0}};

    public void dfs(int[][]matrix, boolean[][]visited, int height, int x, int y){
        int n = matrix.length, m = matrix[0].length;
        if(x<0 || x>=n || y<0 || y>=m || visited[x][y] || matrix[x][y] < height)
            return;
        visited[x][y] = true;
        for(int[]d:dir){
            dfs(matrix, visited, matrix[x][y], x+d[0], y+d[1]);
        }
    }

    int[][]dir = new int[][]{{1,0},{-1,0},{0,1},{0,-1}};
    public List<int[]> pacificAtlanticBFS(int[][] matrix) {
        List<int[]> res = new LinkedList<>();
        if(matrix == null || matrix.length == 0 || matrix[0].length == 0){
            return res;
        }
        int n = matrix.length, m = matrix[0].length;
        //One visited map for each ocean
        boolean[][] pacific = new boolean[n][m];
        boolean[][] atlantic = new boolean[n][m];
        Queue<int[]> pQueue = new LinkedList<>();
        Queue<int[]> aQueue = new LinkedList<>();
        for(int i=0; i<n; i++){ //Vertical border
            pQueue.offer(new int[]{i, 0});
            aQueue.offer(new int[]{i, m-1});
            pacific[i][0] = true;
            atlantic[i][m-1] = true;
        }
        for(int i=0; i<m; i++){ //Horizontal border
            pQueue.offer(new int[]{0, i});
            aQueue.offer(new int[]{n-1, i});
            pacific[0][i] = true;
            atlantic[n-1][i] = true;
        }
        bfs(matrix, pQueue, pacific);
        bfs(matrix, aQueue, atlantic);
        for(int i=0; i<n; i++){
            for(int j=0; j<m; j++){
                if(pacific[i][j] && atlantic[i][j])
                    res.add(new int[]{i,j});
            }
        }
        return res;
    }
    public void bfs(int[][]matrix, Queue<int[]> queue, boolean[][]visited){
        int n = matrix.length, m = matrix[0].length;
        while(!queue.isEmpty()){
            int[] cur = queue.poll();
            for(int[] d:dir){
                int x = cur[0]+d[0];
                int y = cur[1]+d[1];
                if(x<0 || x>=n || y<0 || y>=m || visited[x][y] || matrix[x][y] < matrix[cur[0]][cur[1]]){
                    continue;
                }
                visited[x][y] = true;
                queue.offer(new int[]{x, y});
            }
        }
    }

    // LC: 394. Decode String
    // @see Stacks


    // LC: 337. House Robber III
    // @see Trees


    // LC: 332. Reconstruct Itinerary
    // Given a list of airline tickets represented by pairs of departure and arrival airports [from, to], reconstruct the itinerary in order. All of the tickets belong to a man who departs from JFK. Thus, the itinerary must begin with JFK.
    // Note:
    // If there are multiple valid itineraries, you should return the itinerary that has the smallest lexical order when read as a single string. For example, the itinerary ["JFK", "LGA"] has a smaller lexical order than ["JFK", "LGB"].
    // All airports are represented by three capital letters (IATA code).
    // You may assume all tickets form at least one valid itinerary.
    //        Example 1:
    // tickets = [["MUC", "LHR"], ["JFK", "MUC"], ["SFO", "SJC"], ["LHR", "SFO"]]
    // Return ["JFK", "MUC", "LHR", "SFO", "SJC"].
    // Example 2:
    // tickets = [["JFK","SFO"],["JFK","ATL"],["SFO","ATL"],["ATL","JFK"],["ATL","SFO"]]
    // Return ["JFK","ATL","JFK","SFO","ATL","SFO"].
    // Another possible reconstruction is ["JFK","SFO","ATL","JFK","ATL","SFO"]. But it is larger in lexical order.
    // SP: https://discuss.leetcode.com/topic/36370/short-ruby-python-java-c
    public List<String> findItinerary(String[][] tickets) {
        for (String[] ticket : tickets)
            targets.computeIfAbsent(ticket[0], k -> new PriorityQueue()).add(ticket[1]);
        visit("JFK");
        return route;
    }

    Map<String, PriorityQueue<String>> targets = new HashMap<>();
    List<String> route = new LinkedList();

    void visit(String airport) {
        while(targets.containsKey(airport) && !targets.get(airport).isEmpty())
            visit(targets.get(airport).poll());
        route.add(0, airport);
    }

    public List<String> findItineraryItr(String[][] tickets) {
        Map<String, PriorityQueue<String>> targets = new HashMap<>();
        for (String[] ticket : tickets)
            targets.computeIfAbsent(ticket[0], k -> new PriorityQueue()).add(ticket[1]);
        List<String> route = new LinkedList();
        Stack<String> stack = new Stack<>();
        stack.push("JFK");
        while (!stack.empty()) {
            while (targets.containsKey(stack.peek()) && !targets.get(stack.peek()).isEmpty())
                stack.push(targets.get(stack.peek()).poll());
            route.add(0, stack.pop());
        }
        return route;
    }

    // LC: 329. Longest Increasing Path in a Matrix
    // Time: ??, Time: O(c)
    // https://discuss.leetcode.com/topic/34835/15ms-concise-java-solution
    int dfs(int[][] matrix, int ix, int jx, int m, int n) {

        if (cache[ix][jx] != 0) { return cache[ix][jx]; }

        int max = 1;
        for(int[] dir: dirs) {
            int x = ix + dir[0], y = jx + dir[1];
            if (x < 0 || y < 0 || x >= m || y >= n || matrix[x][y] <= matrix[ix][jx]) {
                continue;
            }
            int len = 1 + dfs(matrix, x, y, m, n);
            max = Math.max(max, len);
        }
        cache[ix][jx] = max;
        return max;
    }

    public int longestIncreasingPath(int[][] matrix) {
        int max = 1;
        if (matrix.length == 0) { return 0; }
        int m = matrix.length, n = matrix[0].length;
        cache = new int[m][n];
        for (int ix = 0; ix < m; ix++) {
            for (int jx = 0; jx < n; jx++) {
                max = Math.max(max, dfs(matrix, ix, jx, m, n));
            }
        }
        return max;
    }

    // LC: 301. Remove Invalid Parentheses
    // Remove the minimum number of invalid parentheses in order to make the input string valid. Return all possible
    // results.
    // Note: The input string may contain letters other than the parentheses ( and ).
    // Examples:
    // "()())()" -> ["()()()", "(())()"]
    // "(a)())()" -> ["(a)()()", "(a())()"]
    // ")(" -> [""]
    // https://discuss.leetcode.com/topic/34875/easy-short-concise-and-fast-java-dfs-3-ms-solution
    public List<String> removeInvalidParentheses(String s) {
        List<String> ans = new ArrayList<>();
        remove(s, ans, 0, 0, new char[]{'(', ')'});
        return ans;
    }

    public void remove(String s, List<String> ans, int last_i, int last_j,  char[] par) {
        for (int stack = 0, i = last_i; i < s.length(); ++i) {
            if (s.charAt(i) == par[0]) stack++;
            if (s.charAt(i) == par[1]) stack--;
            if (stack >= 0) continue;
            for (int j = last_j; j <= i; ++j)
                if (s.charAt(j) == par[1] && (j == last_j || s.charAt(j - 1) != par[1]))
                    remove(s.substring(0, j) + s.substring(j + 1, s.length()), ans, i, j, par);
            return;
        }
        String reversed = new StringBuilder(s).reverse().toString();
        if (par[0] == '(') // finished left to right
            remove(reversed, ans, 0, 0, new char[]{')', '('});
        else // finished right to left
            ans.add(reversed);
    }

    // LC: 257. Binary Tree Paths
    // @see Trees

    // LC: 210. Course Schedule II
    // There are a total of n courses you have to take, labeled from 0 to n - 1.
    // Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is
    // expressed as a pair: [0,1]
    // Given the total number of courses and a list of prerequisite pairs, return the ordering of courses you should
    // take to finish all courses.
    // There may be multiple correct orders, you just need to return one of them. If it is impossible to finish all
    // courses, return an empty array.
    // For example:
    //  2, [[1,0]]
    // There are a total of 2 courses to take. To take course 1 you should have finished course 0. So the correct course
    //  order is [0,1]
    //  4, [[1,0],[2,0],[3,1],[3,2]]
    // There are a total of 4 courses to take. To take course 3 you should have finished both courses 1 and 2. Both
    // courses 1 and 2 should be taken after you finished course 0. So one correct course order is [0,1,2,3]. Another correct ordering is[0,2,1,3].
    // Note:
    //  The input prerequisites is a graph represented by a list of edges, not adjacency matrices. Read more about how
    //  a graph is represented.
    //  You may assume that there are no duplicate edges in the input prerequisites.
    // https://discuss.leetcode.com/topic/13873/two-ac-solution-in-java-using-bfs-and-dfs-with-explanation
    // https://discuss.leetcode.com/topic/17354/java-dfs-double-cache-visiting-each-vertex-once-433ms
    public int[] findOrder(int numCourses, int[][] prerequisites) {
        List<List<Integer>> adj = new ArrayList<>(numCourses);
        for (int i = 0; i < numCourses; i++) adj.add(i, new ArrayList<>());
        for (int i = 0; i < prerequisites.length; i++) adj.get(prerequisites[i][1]).add(prerequisites[i][0]);
        boolean[] visited = new boolean[numCourses];
        Stack<Integer> stack = new Stack<>();
        for (int i = 0; i < numCourses; i++) {
            if (!topologicalSort(adj, i, stack, visited, new boolean[numCourses])) return new int[0];
        }
        int i = 0;
        int[] result = new int[numCourses];
        while (!stack.isEmpty()) {
            result[i++] = stack.pop();
        }
        return result;
    }

    private boolean topologicalSort(List<List<Integer>> adj, int v, Stack<Integer> stack, boolean[] visited, boolean[] isLoop) {
        if (visited[v]) return true;
        if (isLoop[v]) return false;
        isLoop[v] = true;
        for (Integer u : adj.get(v)) {
            if (!topologicalSort(adj, u, stack, visited, isLoop)) return false;
        }
        visited[v] = true;
        stack.push(v);
        return true;
    }


    // LC: 207. Course Schedule
    // There are a total of n courses you have to take, labeled from 0 to n - 1.
    // Some courses may have prerequisites, for example to take course 0 you have to first take course 1, which is
    // expressed as a pair: [0,1]
    // Given the total number of courses and a list of prerequisite pairs, is it possible for you to finish all courses?
    // For example:
    // 2, [[1,0]]
    // There are a total of 2 courses to take. To take course 1 you should have finished course 0. So it is possible.
    // 2, [[1,0],[0,1]]
    // There are a total of 2 courses to take. To take course 1 you should have finished course 0, and to take course
    // 0 you should also have finished course 1. So it is impossible.
    // https://discuss.leetcode.com/topic/13854/easy-bfs-topological-sort-java
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

    // https://discuss.leetcode.com/topic/15762/java-dfs-and-bfs-solution/2
    public boolean canFinishDFS(int numCourses, int[][] prerequisites) {
        ArrayList[] graph = new ArrayList[numCourses];
        for(int i=0;i<numCourses;i++)
            graph[i] = new ArrayList();

        boolean[] visited = new boolean[numCourses];
        for(int i=0; i<prerequisites.length;i++){
            graph[prerequisites[i][1]].add(prerequisites[i][0]);
        }

        for(int i=0; i<numCourses; i++){
            if(!dfs(graph,visited,i))
                return false;
        }
        return true;
    }

    private boolean dfs(ArrayList[] graph, boolean[] visited, int course){
        if(visited[course])
            return false;
        else
            visited[course] = true;;

        for(int i=0; i<graph[course].size();i++){
            if(!dfs(graph,visited,(int)graph[course].get(i)))
                return false;
        }
        visited[course] = false;
        return true;
    }

    // LC: 200. Number of Islands
    // https://leetcode.com/problems/number-of-islands/?tab=Description
    // Time: O(m * n)??, Space: O(m + n) for the recursion stack
    // ==== test it ===
    private void coverIsland(char[][] grid, int ix, int jx) {
        if (grid[ix][jx] == '2' || grid[ix][jx] == '0') {
            return;
        }
        grid[ix][jx] = '2';
        int [][] next = {{0, -1}, {0, 1}, {-1, 0}, {0, -1}};
        for (int kx = 0; kx < next.length; kx++) {
            coverIsland(grid, ix + next[kx][0], jx + next[kx][1]);
        }
    }

    public int numIslands(char[][] grid) {
        int numIslands = 0;
        if (grid.length == 0) { return numIslands; }


        for (int ix = 0; ix < grid.length; ix++) {
            for (int jx = 0; jx < grid[0].length; jx++) {
                if (grid[ix][jx] == '1') {
                    numIslands++;
                    // cover all 1's on this island
                    coverIsland(grid, ix, jx);
                }
            }
        }
        return numIslands;
    }

    // LC: 199. Binary Tree Right Side View
    // https://leetcode.com/problems/binary-tree-right-side-view/?tab=Description
    // @see Trees

    // LC: 133. Clone Graph
    // Time: O(V * E)??, Space: O(n)
    // https://discuss.leetcode.com/topic/9629/depth-first-simple-java-solution
    private void cloneGraphHelper(UndirectedGraphNode node, HashMap<UndirectedGraphNode, UndirectedGraphNode> hm) {
        if (hm.get(node) != null) {
            return;
        }
        UndirectedGraphNode cloneRoot = new UndirectedGraphNode(node.label);
        hm.put(node, cloneRoot);
        for (UndirectedGraphNode neighbor : node.neighbors) {
            if (hm.get(neighbor) == null) {
                cloneGraphHelper(neighbor, hm);
            }
            cloneRoot.neighbors.add(hm.get(neighbor));
        }
    }

    public UndirectedGraphNode cloneGraph(UndirectedGraphNode node) {
        if (node == null) { return null; }
        HashMap<UndirectedGraphNode, UndirectedGraphNode> hm = new HashMap<>();
        cloneGraphHelper(node, hm);
        return hm.get(node);
    }


    // LC: 129. Sum Root to Leaf Numbers
    // @see Trees


    // LC: 124. Binary Tree Maximum Path Sum
    // @see Trees

    // LC: 117. Populating Next Right Pointers in Each Node II
    // @see Trees

    // LC: 116. Populating Next Right Pointers in Each Node
    // @see Trees


    // LC: 114. Flatten Binary Tree to Linked List
    // Time: O(n), Space: O(h) for the recursion
    // https://discuss.leetcode.com/topic/11444/my-short-post-order-traversal-java-solution-for-share/2
    public void flatten(TreeNode root) {
        if (root == null) { return; }
        flatten(root.right);
        flatten(root.left);
        root.right = prev;
        root.left  = null;
        prev = root;
    }

    //https://discuss.leetcode.com/topic/3995/share-my-simple-non-recursive-solution-o-1-space-complexity
    void flattenItr(TreeNode root) {
        TreeNode now = root;
        while (now != null)
        {
            if(now.left != null)
            {
                //Find current node's prenode that links to current node's right subtree
                TreeNode pre = now.left;
                while(pre.right != null)
                {
                    pre = pre.right;
                }
                pre.right = now.right;
                //Use current node's left subtree to replace its right subtree(original right
                //subtree is already linked by current node's prenode
                now.right = now.left;
                now.left = null;
            }
            now = now.right;
        }
    }


    // LC: 113. Path Sum II
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/5414/dfs-with-one-linkedlist-accepted-java-solution
    void pathSumHelper(TreeNode root, int sum, List<Integer> partial, List<List<Integer>> result) {
        if (root == null) { return; }
        sum -= root.val;
        partial.add(root.val);
        if (root.left == null && root.right == null) {
            if (sum == 0) {
                result.add(new ArrayList(partial));
            }
        } else {
            pathSumHelper(root.left, sum, partial, result);
            pathSumHelper(root.right, sum, partial, result);
        }

        // IMP to remove in both cases!!
        partial.remove(partial.size() - 1);
    }

    public List<List<Integer>> pathSum(TreeNode root, int sum) {
        List<List<Integer>> result = new ArrayList<>();
        pathSumHelper(root, sum, new ArrayList<>(), result);
        return result;
    }

    // LC: 112. Path Sum
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/3149/accepted-my-recursive-solution-in-java
    public boolean hasPathSum(TreeNode root, int sum) {

        if (root == null) { return false; }

        sum -= root.val;
        if (root.left == null && root.right == null) {
            return sum == 0;
        }
        boolean leftResult = hasPathSum(root.left, sum);
        if (leftResult) {
            return true;
        }

        boolean rightResult = hasPathSum(root.right, sum);
        if (rightResult) {
            return true;
        }
        return false;
    }

    public boolean hasPathSum2(TreeNode root, int sum) {
        if(root == null) return false;

        if(root.left == null && root.right == null && sum - root.val == 0) return true;

        return hasPathSum(root.left, sum - root.val) || hasPathSum(root.right, sum - root.val);
    }

    // 111. Minimum Depth of Binary Tree
    // Given a binary tree, find its minimum depth.
    // The minimum depth is the number of nodes along the shortest path from the root node down to the nearest leaf node.
    // @see Trees

    // LC: 110. Balanced Binary Tree
    // @see Trees


    // LC: 109. Convert Sorted List to Binary Search Tree
    // Time: O(n log n), space: O(log n)
    // https://leetcode.com/problems/convert-sorted-list-to-binary-search-tree/?tab=Description
    public TreeNode sortedListToBST(ListNode head) {

        if (head == null) { return null; }
        if (head.next == null) { return new TreeNode(head.val); }

        int len = 0;
        for (ListNode itr = head; itr != null; itr = itr.next) { len++; }

        ListNode itr = head;
        for (int ix = 0; ix < (len / 2) - 1; ix++) {
            itr = itr.next;
        }

        TreeNode newRoot = new TreeNode(itr.next.val);
        newRoot.right = sortedListToBST(itr.next.next);
        itr.next = null;
        newRoot.left = sortedListToBST(head);
        return newRoot;
    }

    // LC: 108. Convert Sorted Array to Binary Search Tree
    // @see Trees

    // LC: 106. Construct Binary Tree from Inorder and Postorder Traversal
    // @see arrays

    // LC: 105. Construct Binary Tree from Preorder and Inorder Traversal
    // @see arrays

    // LC: 104. Maximum Depth of Binary Tree
    // Given a binary tree, find its maximum depth.
    // The maximum depth is the number of nodes along the longest path from the root node down to the farthest leaf node.
    // https://discuss.leetcode.com/topic/4087/simple-solution-using-java
    // https://discuss.leetcode.com/topic/7139/can-leetcode-share-top-performing-solution-s-of-problems-for-each-supported-language
    public int maxDepth(TreeNode root) {
        if(root==null){
            return 0;
        }
        return 1+Math.max(maxDepth(root.left),maxDepth(root.right));
    }

    // LC: 103. Binary Tree Zigzag Level Order Traversal
    // https://leetcode.com/problems/binary-tree-zigzag-level-order-traversal/?tab=Description
    // @see Trees

    // LC: 101. Symmetric Tree
    // Time: O(n), space: O(h)
    // https://discuss.leetcode.com/topic/5941/recursive-and-non-recursive-solutions-in-java
    boolean isSymmetricHelper(TreeNode left, TreeNode right) {
        if (left == null && right == null) { return true; }
        if (left == null) { return false; }
        if (right == null) { return false; }

        return left.val == right.val && isSymmetricHelper(left.right, right.left) && isSymmetricHelper(left.left, right.right);
    }

    public boolean isSymmetric(TreeNode root) {
        if (root == null) { return true; }

        return isSymmetricHelper(root.left, root.right);
    }

    // LC: 100. Same Tree
    // @see Trees

    // LC: 99. Recover Binary Search Tree
    // @see Trees

    // LC: 98. Validate Binary Search Tree
    // Time: O(n), Space: O(h)
    // https://discuss.leetcode.com/topic/7179/my-simple-java-solution-in-3-lines
    public boolean isValidBST(TreeNode root) {
        return isValidBST(root, Long.MIN_VALUE, Long.MAX_VALUE);
    }

    public boolean isValidBST(TreeNode root, long minVal, long maxVal) {
        if (root == null) return true;
        if (root.val >= maxVal || root.val <= minVal) return false;
        return isValidBST(root.left, minVal, root.val) && isValidBST(root.right, root.val, maxVal);
    }

    TreeNode prev;

    public boolean isValidBST2(TreeNode root) {
        TreeNode prev = null;
        return validate(root);
    }

    boolean validate(TreeNode node) {
        if (node == null) return true;
        if (!validate(node.left)) return false;
        if (prev != null && prev.val >= node.val) return false;
        prev = node;
        return validate(node.right);
    }
}
