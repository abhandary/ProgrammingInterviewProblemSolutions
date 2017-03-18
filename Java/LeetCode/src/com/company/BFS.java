package com.company;

import java.util.ArrayDeque;
import java.util.ArrayList;
import java.util.List;
import java.util.*;
import java.lang.Math;

/**
 * Created by akshayb on 3/6/17.
 */
public class BFS {

    // LC: 529. Minesweeper
    // @see DFS

    // LC: 515. Find Largest Value in Each Tree Row
    // Time: O(n), Space: O(c)
    // SP: https://discuss.leetcode.com/topic/78991/python-bfs
    // https://discuss.leetcode.com/topic/79178/9ms-java-dfs-solution
    public List<Integer> largestValues(TreeNode root) {
        List<Integer> result = new ArrayList<>();
        if (root == null) { return result; }
        ArrayDeque<TreeNode> q = new ArrayDeque<>();
        q.offer(root);
        int numInLevel = 1;
        int max = Integer.MIN_VALUE;
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            numInLevel--;

            if (current.left != null) q.offer(current.left);
            if (current.right != null) q.offer(current.right);

            max = Math.max(current.val, max);
            if (numInLevel == 0) {
                result.add(max);
                numInLevel = q.size();
                max = Integer.MIN_VALUE;
            }
        }
        return result;
    }

    // LC: 513. Find Bottom Left Tree Value
    // Given a binary tree, find the leftmost value in the last row of the tree.
    // Time: O(n), space: O(2 raise d)
    // https://leetcode.com/problems/find-bottom-left-tree-value/?tab=Description
    public int findBottomLeftValue(TreeNode root) {
        Queue<TreeNode> q = new ArrayDeque<>();
        q.offer(root);
        int leftMost = root.val;
        int numInLevel = 1;
        while (!q.isEmpty()) {
            TreeNode current = q.poll();
            numInLevel--;
            if (current.left != null) { q.offer(current.left); }
            if (current.right != null) { q.offer(current.right); }

            if (numInLevel == 0) {
                if (!q.isEmpty()) {
                    TreeNode head = q.peek();
                    leftMost = head.val;
                }
                numInLevel = q.size();
            }
        }
        return leftMost;
    }

    // SP:  https://discuss.leetcode.com/topic/78981/right-to-left-bfs-python-java
    public int findLeftMostNodeSP(TreeNode root) {
        Queue<TreeNode> queue = new LinkedList<>();
        queue.add(root);
        while (!queue.isEmpty()) {
            root = queue.poll();
            if (root.right != null)
                queue.add(root.right);
            if (root.left != null)
                queue.add(root.left);
        }
        return root.val;
    }



    // LC: 417. Pacific Atlantic Water Flow
    // @see DFS

    // LC: 407. Trapping Rain Water II
    // https://discuss.leetcode.com/topic/60418/java-solution-using-priorityqueue
    public class Cell {
        int row;
        int col;
        int height;
        public Cell(int row, int col, int height) {
            this.row = row;
            this.col = col;
            this.height = height;
        }
    }

    public int trapRainWater(int[][] heights) {
        if (heights == null || heights.length == 0 || heights[0].length == 0)
            return 0;

        PriorityQueue<Cell> queue = new PriorityQueue<>(1, new Comparator<Cell>(){
            public int compare(Cell a, Cell b) {
                return a.height - b.height;
            }
        });

        int m = heights.length;
        int n = heights[0].length;
        boolean[][] visited = new boolean[m][n];

        // Initially, add all the Cells which are on borders to the queue.
        for (int i = 0; i < m; i++) {
            visited[i][0] = true;
            visited[i][n - 1] = true;
            queue.offer(new Cell(i, 0, heights[i][0]));
            queue.offer(new Cell(i, n - 1, heights[i][n - 1]));
        }

        for (int i = 0; i < n; i++) {
            visited[0][i] = true;
            visited[m - 1][i] = true;
            queue.offer(new Cell(0, i, heights[0][i]));
            queue.offer(new Cell(m - 1, i, heights[m - 1][i]));
        }

        // from the borders, pick the shortest cell visited and check its neighbors:
        // if the neighbor is shorter, collect the water it can trap and update its height as its height plus the water trapped
        // add all its neighbors to the queue.
        int[][] dirs = new int[][]{{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
        int res = 0;
        while (!queue.isEmpty()) {
            Cell cell = queue.poll();
            for (int[] dir : dirs) {
                int row = cell.row + dir[0];
                int col = cell.col + dir[1];
                if (row >= 0 && row < m && col >= 0 && col < n && !visited[row][col]) {
                    visited[row][col] = true;
                    res += Math.max(0, cell.height - heights[row][col]);
                    queue.offer(new Cell(row, col, Math.max(heights[row][col], cell.height)));
                }
            }
        }

        return res;
    }

    // LC: 310. Minimum Height Trees
    // For a undirected graph with tree characteristics, we can choose any node as the root. The result graph is then
    // a rooted tree. Among all possible rooted trees, those with minimum height are called minimum height trees (MHTs).
    // Given such a graph, write a function to find all the MHTs and return a list of their root labels.
    // Format
    // The graph contains n nodes which are labeled from 0 to n - 1. You will be given the number n and a list of
    // undirected edges (each edge is a pair of labels).
    // You can assume that no duplicate edges will appear in edges. Since all edges are undirected, [0, 1] is the same
    // as [1, 0] and thus will not appear together in edges.
    // https://discuss.leetcode.com/topic/30572/share-some-thoughts
    // https://discuss.leetcode.com/topic/30956/two-o-n-solutions
    public List<Integer> findMinHeightTrees(int n, int[][] edges) {
        if (n == 1) return Collections.singletonList(0);

        List<Set<Integer>> adj = new ArrayList<>(n);
        for (int i = 0; i < n; ++i) adj.add(new HashSet<>());
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        List<Integer> leaves = new ArrayList<>();
        for (int i = 0; i < n; ++i)
            if (adj.get(i).size() == 1) leaves.add(i);

        while (n > 2) {
            n -= leaves.size();
            List<Integer> newLeaves = new ArrayList<>();
            for (int i : leaves) {
                int j = adj.get(i).iterator().next();
                adj.get(j).remove(i);
                if (adj.get(j).size() == 1) newLeaves.add(j);
            }
            leaves = newLeaves;
        }
        return leaves;
    }

    // LC: 301. Remove Invalid Parentheses
    // @see DFS

    // LC: 279. Perfect Squares
    // Given a positive integer n, find the least number of perfect square numbers (for example, 1, 4, 9, 16, ...)
    // which sum to n.
    // For example, given n = 12, return 3 because 12 = 4 + 4 + 4; given n = 13, return 2 because 13 = 4 + 9.
    // SP: https://discuss.leetcode.com/topic/23808/o-sqrt-n-in-ruby-c-c
    // SP: https://discuss.leetcode.com/topic/23812/static-dp-c-12-ms-python-172-ms-ruby-384-ms
    // https://discuss.leetcode.com/topic/26400/an-easy-understanding-dp-solution-in-java
    public int numSquares(int n) {
        int[] dp = new int[n + 1];
        Arrays.fill(dp, Integer.MAX_VALUE);
        dp[0] = 0;
        for(int i = 1; i <= n; ++i) {
            int min = Integer.MAX_VALUE;
            int j = 1;
            while(i - j*j >= 0) {
                min = Math.min(min, dp[i - j*j] + 1);
                ++j;
            }
            dp[i] = min;
        }
        return dp[n];
    }

    // LC: 210. Course Schedule II
    // @see DFS

    // LC: 207. Course Schedule
    // @see DFS


    // LC: 200. Number of Islands
    // @see DFS

    // LC: 199. Binary Tree Right Side View
    // @see Trees

    // LC: 133. Clone Graph
    // @see DFS


    // LC: 130. Surrounded Regions
    // Given a 2D board containing 'X' and 'O' (the letter O), capture all regions surrounded by 'X'.
    // A region is captured by flipping all 'O's into 'X's in that surrounded region.
    // https://leetcode.com/problems/surrounded-regions/#/description
    // SP: https://discuss.leetcode.com/topic/18706/9-lines-python-148-ms
    // https://discuss.leetcode.com/topic/17224/a-really-simple-and-readable-c-solution-only-cost-12ms
    public void solve(char[][] board) {

        int i,j;
        int row=board.length;

        if(row == 0) return;

        int col=board[0].length;

        for(i=0;i<row;i++){
            check(board,i,0,row,col);
            if(col>1)
                check(board,i,col-1,row,col);
        }
        for(j=1;j+1<col;j++){
            check(board,0,j,row,col);
            if(row>1)
                check(board,row-1,j,row,col);
        }
        for(i=0;i<row;i++)
            for(j=0;j<col;j++)
                if(board[i][j]=='O')
                    board[i][j]='X';
        for(i=0;i<row;i++)
            for(j=0;j<col;j++)
                if(board[i][j]=='1')
                    board[i][j]='O';
    }
    void check(char[][] vec,int i,int j,int row,int col){
        if(vec[i][j]=='O'){
            vec[i][j]='1';
            if(i>1)
                check(vec,i-1,j,row,col);
            if(j>1)
                check(vec,i,j-1,row,col);
            if(i+1<row)
                check(vec,i+1,j,row,col);
            if(j+1<col)
                check(vec,i,j+1,row,col);
        }
    }

    // LC: 126. Word Ladder II
    // @see Arrays


    // LC: 111. Minimum Depth of Binary Tree
    // @see Trees

    // LC: 107. Binary Tree Level Order Traversal II
    // @see Trees

    // LC: 103. Binary Tree Zigzag Level Order Traversal
    // @see Trees


    // LC: 102. Binary Tree Level Order Traversal
    // @see Trees


    // LC: 101. Symmetric Tree
    // @see DFS
}
