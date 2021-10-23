class Solution {
    

    // LC1480. Running Sum of 1d Array
    fun runningSum(nums: IntArray): IntArray {
        val result = IntArray(nums.size, { 0 })
        if (nums.size == 0) { return result }
        var runningSum = 0
        for(ix in 0..nums.size - 1) {
            runningSum += nums[ix]
            result[ix] = runningSum
        }
        return result
    }

    // LC1022. Sum of Root To Leaf Binary Numbers
    var result = 0
    
    fun sumRootToLeafHelper(root: TreeNode?, partial: Int) {
        if (root == null) { return }
        val nextPartial = (partial shl 1) or root.`val`
        if (root.left == null && root.right == null) {
            result += nextPartial
            return
        }
        sumRootToLeafHelper(root.left, nextPartial)
        sumRootToLeafHelper(root.right, nextPartial)
    }
    
    fun sumRootToLeaf(root: TreeNode?): Int {
        if (root == null) {  return 0 }
        sumRootToLeafHelper(root, 0)
        return result
    }

    // LC977. Squares of a Sorted Array
    fun sortedSquares(nums: IntArray): IntArray {
        var left = 0
        var right = nums.size - 1
        var result = IntArray(nums.size, {0})
        var ix = nums.size - 1
        while (left <= right) {
            if (Math.abs(nums[left]) < Math.abs(nums[right])) {
                result[ix--] = nums[right] * nums[right]
                right--
            } else {
                result[ix--] = nums[left] * nums[left]
                left++
            }
        }
        return result
    }

    // LC744. Find Smallest Letter Greater Than Target
    // review carefully ---
    fun nextGreatestLetter(letters: CharArray, target: Char): Char {
        var lo = 0
        var hi = letters.size
        while (lo < hi) {
            val mid = lo + (hi - lo)/2
            if (letters[mid] <= target) {
                lo = mid + 1
            } else {
                hi = mid
            }
        }
        return letters[lo % letters.size]
    }


    fun nextGreatestLetter(letters: CharArray, target: Char): Char {
        for (char in letters) {
            if (char.toInt() > target.toInt()) {
                return char
            }
        }
        return letters[0]
    }

// LC716. Max Stack
class MaxStack() {

    val stack = Stack<Int>()
    val maxStack = Stack<Int>()
    
    fun push(x: Int) {
        stack.push(x)
        if (maxStack.isEmpty()) {
            maxStack.push(x)
        } else {
            val currentMax = maxStack.peek()             
            maxStack.push(Math.max(currentMax, x))
        }

    }

    fun pop(): Int {
        maxStack.pop() 
        return stack.pop()
    }

    fun top(): Int {
        return stack.peek()
    }

    fun peekMax(): Int {
        return maxStack.peek()
    }

    fun popMax(): Int {
        val maxVal = maxStack.peek()
        val buffer = Stack<Int>()
        while (top() != maxVal) {
            buffer.push(pop())
        }
        pop()
        while (!buffer.isEmpty()) {
            push(buffer.pop())
        }
        return maxVal
    }

}

    // LC701. Insert into a Binary Search Tree
    fun insertIntoBST(root: TreeNode?, `val`: Int): TreeNode? {
        if (root == null) {
            return TreeNode(`val`)
        }
        if (root.`val` > `val`) {
            root.left = insertIntoBST(root.left, `val`)
            return root
        } else {
            root.right = insertIntoBST(root.right, `val`)
            return root
        }
    }

    // 412. Fizz Buzz
    fun fizzBuzz(n: Int): List<String> {
        var result = mutableListOf<String>()
        for (i in 0..n-1) {
            val test = i + 1
            if (test % 3 == 0 && test %5 == 0) {
                result.add("FizzBuzz")
            } else if (test % 3 == 0) {
                result.add("Fizz")
            } else if (test % 5 == 0) {
                result.add("Buzz")
            } else {
                result.add(test.toString())
            }
        }
        return result
    }

    // LC409. Longest Palindrome
    fun longestPalindrome(s: String): Int {
        var chars = s.toCharArray()
        val count = IntArray(128, {0}) 
        for (c in chars) {
            count[c.toInt()]++
        }
        var ans = 0
        var hasOdd = false
        for (v in count) {
            ans += v / 2 * 2
            if (v % 2 == 1) { hasOdd = true }
        }
        if (hasOdd) { ans++ }
        return ans
    }

    // LC404. Sum of Left Leaves
    fun sumOfLeftLeavesHelper(root: TreeNode?, isLeft: Boolean): Int {
        if (root == null) {
            return 0
        }

        if (root.left == null && root.right == null) {
            return if (isLeft == true) root.`val` else 0
        }

        var total = sumOfLeftLeavesHelper(root.left, true)
        total += sumOfLeftLeavesHelper(root.right, false)
        return total
    }
    fun sumOfLeftLeaves(root: TreeNode?): Int {
        return sumOfLeftLeavesHelper(root, false)
    }

    // LC394. Decode String
    // 3[a]2[bc]
    // 3[a2[c]]
    // 2[abc]3[cd]ef
    
    private var sx = 0
    
    
    
    fun decodeStringHelper(s: String): String {
        var result = ""
        var num = ""
        while (sx < s.length) {
            if (s[sx] == '[') { 
                sx++ 
                result += decodeStringHelper(s).repeat(num.toInt())
                num = "";
            } else if (s[sx] == ']') {
                sx++
                return result
            }else if (s[sx].isDigit()) {    
                num += s[sx++]
            } else {
                result += s[sx++]           
            }
        }
        return result
    }
    
    fun decodeString(s: String): String {
        sx = 0
        return decodeStringHelper(s)
    }

    // LC389. Find the Difference
    fun findTheDifference(s: String, t: String): Char {
        var sCountsMap = mutableMapOf<Char, Int>()
        
        for (ix in 0..s.length - 1) {
            sCountsMap[s[ix]] = sCountsMap.getOrDefault(s[ix], 0) + 1
        }
        
        for (ix in 0..t.length - 1) {
            if (sCountsMap.getOrDefault(t[ix], 0) == 0) {
                return t[ix]
            } else {
                sCountsMap[t[ix]] = sCountsMap.getOrDefault(t[ix], 0) - 1
            }
        }
        return '0'
    }

    // LC367. Valid Perfect Square
    fun isPerfectSquare(num: Int): Boolean {
        if (num < 2) { return true }
        var left = 2
        var right = num / 2
        while (left <= right) {
            val mid = left + (right - left) / 2
            val guessSquared = mid * mid
            if (guessSquared == num) { return true  }
            if (guessSquared < num) {
                left = mid + 1
            } else {
                right = mid - 1
            }
        }
        return false
    }

    fun isPerfectSquare(num: Int): Boolean {
        if (num < 2) { return true }

        var x = num / 2
        while (x * x > num) {
            x = (x + num / x) / 2;
        }
        return (x * x == num)
    }

    // LC350. Intersection of Two Arrays II
    public int[] intersect(int[] nums1, int[] nums2) {
    if (nums1.length > nums2.length) {
        return intersect(nums2, nums1);
    }
    HashMap<Integer, Integer> m = new HashMap<>();
    for (int n : nums1) {
        m.put(n, m.getOrDefault(n, 0) + 1);
    }
    int k = 0;
    for (int n : nums2) {
        int cnt = m.getOrDefault(n, 0);
        if (cnt > 0) {
            nums1[k++] = n;
            m.put(n, cnt - 1);
        }
    }
    return Arrays.copyOfRange(nums1, 0, k);
    }

    public int[] intersect(int[] nums1, int[] nums2) {
    Arrays.sort(nums1);
    Arrays.sort(nums2);
    int i = 0, j = 0, k = 0;
    while (i < nums1.length && j < nums2.length) {
        if (nums1[i] < nums2[j]) {
            ++i;
        } else if (nums1[i] > nums2[j]) {
            ++j;
        } else {
            nums1[k++] = nums1[i++];
            ++j;
        }
    }
    return Arrays.copyOfRange(nums1, 0, k);
}

    // LC349. Intersection of Two Arrays
    fun intersection(nums1: IntArray, nums2: IntArray): IntArray {
        return HashSet<Int>(nums1.toList()).intersect(HashSet<Int>(nums2.toList())).toIntArray()
    }

    // LC345. Reverse Vowels of a String
    fun reverseVowels(s: String): String {
        var schars = s.toMutableList()
        val vowels = setOf<Char>('a', 'e', 'i', 'o', 'u', 'A', 'E', 'I', 'O', 'U')
        var left = 0
        var right = s.length - 1
        while (left < right) {
            if (vowels.contains(s[left]) && vowels.contains(s[right])) {
                schars[left] = schars[right].also { schars[right] = schars[left]  }
                left++; right--;
            } 
            if (!vowels.contains(s[left])) {
                left++
            }
            if (!vowels.contains(s[right])) {
                right--
            }
        }   
        return String(schars.toCharArray())
    }

    // LC339. Nested List Weight Sum
    val depthMap = mutableMapOf<Int, Int>()
    
    fun depthSumHelper(nestedList: List<NestedInteger>, depth: Int) {
        for (ix in 0..nestedList.size - 1) {
            val nestedInteger = nestedList[ix]            
            if (nestedInteger.isInteger()) {
                depthMap[depth] = depthMap.getOrDefault(depth, 0) + nestedInteger.getInteger() ?: 0
            } else {
                depthSumHelper(nestedInteger.getList(), depth + 1)
            }
        }
    }
    
    fun depthSum(nestedList: List<NestedInteger>): Int {
        var sum = 0
        depthSumHelper(nestedList, 1)
        for (key in depthMap.keys) {
            sum = sum + key * depthMap.getOrDefault(key, 0)
        }
        return sum
     }

     public int depthSum(List<NestedInteger> nestedList) {
        Queue<NestedInteger> queue = new LinkedList<>();
        queue.addAll(nestedList);

        int depth = 1;
        int total = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                NestedInteger nested = queue.poll();
                if (nested.isInteger()) {
                    total += nested.getInteger() * depth;
                } else {
                    queue.addAll(nested.getList());
                }
            }
            depth++;
        }
        return total;
    }

    // LC290. Word Pattern
    fun wordPattern(pattern: String, s: String): Boolean {
        val words = s.split(' ')
        if (words.size != pattern.length) { return false }
        val hashMap = mutableMapOf<String, Int>()
        for (ix in 0..pattern.length - 1) {
            val charIx = hashMap.getOrPut("char_" + pattern[ix].toString(), { ix })
            val wordIx = hashMap.getOrPut("word_" + words[ix],{ ix })
            if (charIx != wordIx) {
                return false
            }
        }
        return true
    }

    // LC278. First Bad Version
    public int firstBadVersion(int n) {
        int left = 1;
        int right = n;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (isBadVersion(mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    // LC257. Binary Tree Path
    public void construct_paths(TreeNode root, String path, LinkedList<String> paths) {
    if (root != null) {
      path += Integer.toString(root.val);
      if ((root.left == null) && (root.right == null))  // if reach a leaf
        paths.add(path);  // update paths
      else {
        path += "->";  // extend the current path
        construct_paths(root.left, path, paths);
        construct_paths(root.right, path, paths);
      }
    }
    }
    public List<String> binaryTreePaths(TreeNode root) {
         LinkedList<String> paths = new LinkedList();
    construct_paths(root, "", paths);
    return paths;
    }

    // LC243. Shortest Word Distance
    fun shortestDistance(wordsDict: Array<String>, word1: String, word2: String): Int {
        val wordToIndexMap = mutableMapOf<String, Int>()
        var minSeenSoFar = Int.MAX_VALUE
        var word1Ix: Int? = null
        var word2Ix: Int? = null
        for (ix in 0..wordsDict.size - 1) {
            if (wordsDict[ix] == word1) {
                word1Ix = ix
            }
            if (wordsDict[ix] == word2) {
                word2Ix = ix
            }
            word1Ix?.let{ word1Ix -> 
                word2Ix?.let{ word2Ix -> 
                    minSeenSoFar = Math.min(minSeenSoFar, Math.abs(word1Ix - word2Ix))
                }
            }
        }
        return minSeenSoFar
    }

    // LC235. Lowest Common Ancestor of a Binary Search Tree
    fun lowestCommonAncestor(root: TreeNode?, p: TreeNode?, q: TreeNode?): TreeNode? {
        if (root == null) { return null }
        if (p == null) { return null }
        if (q == null) { return null }
        
        if (root.`val` > p.`val` && root.`val` > q.`val`) {
            return lowestCommonAncestor(root.left, p, q)
        } else if (root.`val` < p.`val` && root.`val` < q.`val`) {
            return lowestCommonAncestor(root.right, p, q)            
        } else {
            return root
        }

    // LC234. Palindrome Linked List
    private var frontPointer: ListNode? = null
    
    private fun recursivelyCheck(currentNode: ListNode?): Boolean {
        if (currentNode == null) { return true  }
        if (recursivelyCheck(currentNode.next) == false) {
            return false
        }
        val currentFrontPointer = frontPointer
        if (currentFrontPointer == null) { return true  }
        if (currentFrontPointer.`val` != currentNode.`val`) {
            return false
        }
        frontPointer = frontPointer?.next
        return true
    }
    
    fun isPalindrome(head: ListNode?): Boolean {
        frontPointer = head
        return recursivelyCheck(head)
    }

    // LC231. Power of Two
    boolean isPowerOfTwo(int n) {
        if (n == 0) return false;
        long x = n;
        return (x & (x - 1)) == 0;
    }

    bool isPowerOfTwo(int n) {
        if (n == 0) return false;
        long x = n;
        return (x & (-x)) == x;
    }

    // LC297. Serialize and Deserialize Binary Tree
    private fun rserialize(root: TreeNode?, str: String): String {
        var str = str
        if (root == null) {
            str += "null,"
        } else {
            str += root.`val`.toString() + ","
            str = rserialize(root.left, str)
            str = rserialize(root.right, str)            
        }
        return str
    }
    
	// Encodes a URL to a shortened URL.
    fun serialize(root: TreeNode?): String {
        return rserialize(root, "")
    }

     private fun rdserialize(nodes: MutableList<String>): TreeNode? {
         val current = nodes.removeAt(0)
         if (current == "null") {
             return null
         }
         val root = TreeNode(current.toInt())
         root.left = rdserialize(nodes)
         root.right = rdserialize(nodes)
         return root
     }
    
    // Decodes your encoded data to tree.
    fun deserialize(data: String): TreeNode? {
        val nodes = data.split(",")
        return rdserialize(nodes.toMutableList())
    }

    // LC238. Product of Array Except Self
    fun productExceptSelf(nums: IntArray): IntArray {
        var answers = IntArray(nums.size, {0})
        
        answers[0] = 1
        for (ix in 1..nums.size - 1) {
            answers[ix] = answers[ix - 1] * nums[ix - 1]
        }
        var rightProduct = 1
        for (jx in nums.size - 1 downTo 0) {
            answers[jx] *= rightProduct
            rightProduct *= nums[jx]
        }
        return answers
    }

    // LC226. Invert Binary Tree
    public TreeNode invertTree(TreeNode root) {
        if (root == null) {
            return null;
        }
        TreeNode right = invertTree(root.right);
        TreeNode left = invertTree(root.left);
        root.left = right;
        root.right = left;
        return root;        
    }

    // --- BFS
    public TreeNode invertTree(TreeNode root) {
        if (root == null) return null;
        Queue<TreeNode> queue = new LinkedList<TreeNode>();
        queue.add(root);
        while (!queue.isEmpty()) {
            TreeNode current = queue.poll();
            TreeNode temp = current.left;
            current.left = current.right;
            current.right = temp;
            if (current.left != null) queue.add(current.left);
            if (current.right != null) queue.add(current.right);
        }
        return root;
    }

    // LC230. Kth Smallest Element in a BST
    private var seenCount = 0
    
    fun kthSmallest(root: TreeNode?, k: Int): Int {
        if (root == null) { return Int.MAX_VALUE }
        var result = kthSmallest(root.left, k)
        if (seenCount == k) { return result }
        seenCount++
        if (seenCount == k) { return root.`val` }
        return kthSmallest(root.right, k)
    }

    // LC225. Implement Stack using Queues
    private LinkedList<Integer> q1 = new LinkedList<>();
    
    public MyStack() {
        
    }
    
    public void push(int x) {
        q1.add(x);
    int sz = q1.size();
    while (sz > 1) {
        q1.add(q1.remove());
        sz--;
    }
    }
    
    public int pop() {
        return q1.remove();
    }
    
    public int top() {
       return q1.peek(); 
    }
    
    public boolean empty() {
        return q1.isEmpty();
    }

    // LC219. Contains Duplicate II
    fun containsNearbyDuplicate(nums: IntArray, k: Int): Boolean {
        var seen = mutableSetOf<Int>()
        for (ix in 0..nums.size - 1) {
            if (seen.contains(nums[ix])) { return true }
            seen.add(nums[ix])
            if (seen.size > k) {
                seen.remove(nums[ix - k])
            }
        }
        return false
    }

    // LC215. Kth Largest Element in an Array
    fun findKthLargest(nums: IntArray, k: Int): Int {
        val heap = PriorityQueue { t1: Int, t2: Int -> t1 - t2  }
        for (num in nums) {
            heap.add(num)
            if (heap.size > k) {
                heap.poll()
            }
        }
        return heap.poll()
    }

    // LC205. Isomorphic Strings
    private String transformString(String s) {
        Map<Character, Integer> indexMapping = new HashMap<>();
        StringBuilder builder = new StringBuilder();
        
        for (int i = 0; i < s.length(); ++i) {
            char c1 = s.charAt(i);
            
            if (!indexMapping.containsKey(c1)) {
                indexMapping.put(c1, i);
            }
            
            builder.append(Integer.toString(indexMapping.get(c1)));
            builder.append(" ");
        }
        return builder.toString();
    }
    
    public boolean isIsomorphic(String s, String t) {
        return transformString(s).equals(transformString(t));
    }


    public boolean isIsomorphic(String s, String t) {
        int[] mappingDictStoT = new int[256];
        Arrays.fill(mappingDictStoT, -1);
        
        int[] mappingDictTtoS = new int[256];
        Arrays.fill(mappingDictTtoS, -1);
        
        for (int i = 0; i < s.length(); ++i) {
            char c1 = s.charAt(i);
            char c2 = t.charAt(i);
            
            // Case 1: No mapping exists in either of the dictionaries
            if (mappingDictStoT[c1] == -1 && mappingDictTtoS[c2] == -1) {
                mappingDictStoT[c1] = c2;
                mappingDictTtoS[c2] = c1;
            }
            
            // Case 2: Ether mapping doesn't exist in one of the dictionaries or Mapping exists and
            // it doesn't match in either of the dictionaries or both 
            else if (!(mappingDictStoT[c1] == c2 && mappingDictTtoS[c2] == c1)) {
                return false;
            }
        }
        
        return true;
    }

    // LC189. Rotate Array
    fun rotateHelper(nums: IntArray, left: Int, right: Int) {
        var left = left; var right = right
        while (left < right) {
            nums[left] = nums[right].also { nums[right] = nums[left] }
            left++; right--
        }
    }
    fun rotate(nums: IntArray, k: Int): Unit {
        val k = k % nums.size
        rotateHelper(nums, nums.size - k, nums.size - 1)
        rotateHelper(nums, 0, nums.size - k - 1)
        rotateHelper(nums, 0, nums.size - 1)
    }

    // LC167. Two Sum II - Input array is sorted
    fun twoSum(numbers: IntArray, target: Int): IntArray {

        var left = 0
        var right = numbers.size - 1
        while (left < right) {
            var sum = numbers[left] + numbers[right]
            if (sum == target) {
                return intArrayOf(left + 1, right + 1)
            } else if (sum < target) {left++}
            else { right-- }
        }
        return intArrayOf(-1, -1)
    }

    // LC160. Intersection of Two Linked Lists
    fun getIntersectionNode(headA:ListNode?, headB:ListNode?):ListNode? {
        var pA = headA
        var pB = headB
        while (pA != pB) {
            pA = if (pA == null) headB else pA?.next
            pB = if (pB == null) headA else pB?.next
        }
        return pA
    }

    // LC150. Evaluate Reverse Polish Notation
    fun evalRPN(tokens: Array<String>): Int {
        val stack = Stack<Int>()
        
        for (token in tokens) {
            if (!"+-/*".contains(token)) {
                stack.push(token.toInt())
            } else {
            val num2 = stack.pop()
            val num1 = stack.pop()
            when (token) {
                "+" -> stack.push(num1 + num2)
                "-" -> stack.push(num1 - num2)
                "/" -> stack.push(num1 / num2)
                "*" -> stack.push(num1 * num2)
            }  
            }

        }
        return stack.pop()
    }

    // LC144. Binary Tree Preorder Traversal
    public List<Integer> preorderTraversal(TreeNode root) {
    LinkedList<Integer> output = new LinkedList<>();

    TreeNode node = root;
    while (node != null) {
      if (node.left == null) {
        output.add(node.val);
        node = node.right;
      }
      else {
        TreeNode predecessor = node.left;
        while ((predecessor.right != null) && (predecessor.right != node)) {
          predecessor = predecessor.right;
        }

        if (predecessor.right == null) {
          output.add(node.val);
          predecessor.right = node;
          node = node.left;
        }
        else{
          predecessor.right = null;
          node = node.right;
        }
      }
    }
    return output;
  }

    // LC141. Linked List Cycle
    fun hasCycle(head: ListNode?): Boolean {
        if (head == null) {
            return false
        }
        var slow = head
        var fast = head.next
        while (slow != fast) {
            if (fast == null || fast.next == null) { return false }
            slow = slow?.next
            fast = fast.next.next
        }
        return true
    }

    // LC133. Clone Graph
    fun cloneGraph(node: Node?): Node? {
        if (node == null) {
            return null
        }
        if (clonedNodes[node] != null) {
            return clonedNodes[node]
        }
        val nodeClone = Node(node.`val`)
        clonedNodes[node] = nodeClone        
        for (neighbor in node.neighbors) {
            nodeClone.neighbors.add(cloneGraph(neighbor))
        }
        return nodeClone
    }

    // LC121. Best Time to Buy and Sell Stock
    fun maxProfit(prices: IntArray): Int {
        var minSoFar = prices[0]
        var maxProfit = 0
        for (ix in 0..prices.size-1) {
            if (prices[ix] < minSoFar) {
                minSoFar = prices[ix]
            }
            if (prices[ix] > minSoFar) {
                if (prices[ix] - minSoFar > maxProfit) {
                    maxProfit = prices[ix] - minSoFar
                }
            }
        }
        return maxProfit
    }

    // LC119. Pascal's Triangle II
    fun getRow(rowIndex: Int): List<Int> {
        var result = mutableListOf<Int>()
        result.add(1)        

        for(rx in 1..rowIndex) {
            for (cx in rx - 1 downTo 1) {
                result[cx] = result[cx - 1] + result[cx]
            }
            result.add(1)
        }
        return result
    }

    // LC118. Pascal's Triangle
    fun generate(numRows: Int): List<List<Int>> {
        var result = mutableListOf<List<Int>>()
        if (numRows == 0) { return result }
        result.add(listOf(1))
        if (numRows == 1) { return result }
        result.add(listOf(1, 1))
        if (numRows == 2) { return result }
        
        for (rx in 2..numRows-1) {
            val row = MutableList<Int>(rx + 1, {1})
            for (ix in 1..row.size-2) {
                val prevRow = result[result.size - 1]
                val prevLeft = prevRow[ix - 1]
                val prevRight = prevRow[ix] 
                row[ix] = prevLeft + prevRight
            }
            result.add(row)
        }
        return result
    }

    // LC116. Populating Next Right Pointers in Each Node
     fun connect(root: Node?): Node? {
        if (root == null) return root
        val queue = mutableListOf<Node>()
        queue.add(root)
        while(queue.isNotEmpty()) {
            val current = queue.removeAt(0)
            current.left?.let{
                queue.add(it)  
                it.next = current.right
            }
            current.right?.let { currentRight ->
                queue.add(currentRight)
                current.next?.let { currentNext -> 
                    currentRight.next = currentNext.left
                }
            }
        }
        return root
    }

    // LC112. Path Sum
    fun hasPathSumHelper(root: TreeNode?, targetSum: Int, partialSum: Int): Boolean {
        if (root == null) {
            return false
        }
        val updatedPartialSum = partialSum + root.`val`
        if (root.left == null && root.right == null) {
            return updatedPartialSum == targetSum
        }

        return hasPathSumHelper(root.left, targetSum, updatedPartialSum) || hasPathSumHelper(root.right, targetSum, updatedPartialSum)
    }
    
    fun hasPathSum(root: TreeNode?, targetSum: Int): Boolean {
        return hasPathSumHelper(root, targetSum, 0)
    }


    // LC110. Balanced Binary Tree
    final class TreeInfo {
        public final int height;
        public final boolean balanced;

        public TreeInfo(int height, boolean balanced) {
            this.height = height;
            this.balanced = balanced;
        }
    }

    private TreeInfo isBalancedTreeHelper(TreeNode root) {
    // An empty tree is balanced and has height = -1
    if (root == null) {
      return new TreeInfo(-1, true);
    }

    // Check subtrees to see if they are balanced.
    TreeInfo left = isBalancedTreeHelper(root.left);
    if (!left.balanced) {
      return new TreeInfo(-1, false);
    }
    TreeInfo right = isBalancedTreeHelper(root.right);
    if (!right.balanced) {
      return new TreeInfo(-1, false);
    }

    // Use the height obtained from the recursive calls to
    // determine if the current node is also balanced.
    if (Math.abs(left.height - right.height) < 2) {
      return new TreeInfo(Math.max(left.height, right.height) + 1, true);
    }
    return new TreeInfo(-1, false);
  }

  public boolean isBalanced(TreeNode root) {
    return isBalancedTreeHelper(root).balanced;
  }

    // LC108. Convert Sorted Array to Binary Search Tree
    fun sortedArrayToBSTHelper(nums: IntArray, leftLimit: Int, rightLimit: Int): TreeNode? {
        if (leftLimit > rightLimit) { return null }
        val mid = rightLimit - (rightLimit - leftLimit)/2
        val root = TreeNode(nums[mid])
        root.left = sortedArrayToBSTHelper(nums, leftLimit, mid - 1)
        root.right = sortedArrayToBSTHelper(nums, mid + 1, rightLimit)
        return root
    }
    
    fun sortedArrayToBST(nums: IntArray): TreeNode? {
        return sortedArrayToBSTHelper(nums, 0, nums.size - 1)
    }

    // LC105. Construct Binary Tree from Preorder and Inorder Traversal
    var preOrderIx = 0
    val inorderMap = mutableMapOf<Int, Int>()    
    
    fun buildTreeHelper(preorder: IntArray, inorderStartIx: Int, inorderEndIx: Int): TreeNode? {
       
        if (inorderStartIx > inorderEndIx) {
            return null
        }
        
        val rootVal = preorder[preOrderIx++]
        val root = TreeNode(rootVal)
        inorderMap[rootVal]?.let { inorderIx -> 
            root.left = buildTreeHelper(preorder, inorderStartIx, inorderIx - 1)            
            root.right = buildTreeHelper(preorder, inorderIx + 1, inorderEndIx)                        
        }
        return root
    }
    
    fun buildTree(preorder: IntArray, inorder: IntArray): TreeNode? {

        for (ix in 0..inorder.size - 1) {
            inorderMap[inorder[ix]] = ix
        }
        return buildTreeHelper(preorder, 0, inorder.size - 1)
    }

    // LC104. Maximum Depth of Binary Tree
    fun maxDepthBFS(root: TreeNode?): Int {
        var depth = 0
        if (root == null) { return depth }
        depth++
        val queue = mutableListOf<TreeNode>()
        queue.add(root)
        var numInLevel = queue.size
        while (queue.size > 0) {
            val current = queue.removeAt(0)
            current.left?.let { queue.add(it) }
            current.right?.let { queue.add(it) }
            numInLevel--
            if (numInLevel == 0 && queue.size > 0) {
                depth++
                numInLevel = queue.size
            }
        }
        return depth
    }
    fun maxDepth(root: TreeNode?): Int {
        if (root == null) { return 0 }
        return Math.max(1 + maxDepth(root.left), 1 + maxDepth(root.right))
    }

    // LC103. Binary Tree Zigzag Level Order Traversal
    fun zigzagLevelOrder(root: TreeNode?): List<List<Int>> {
        val result = mutableListOf<List<Int>>()
        if (root == null) { return result }
        val queue = mutableListOf<TreeNode>()
        queue.add(root)
        var level = mutableListOf<Int>()
        var numInLevel = queue.size
        var reverse = false
        while (queue.size > 0) {
            val current = queue.removeAt(0)
            level.add(current.`val`)
            current.left?.let { queue.add(it) }
            current.right?.let { queue.add(it) }
            numInLevel--
            if (numInLevel == 0) {
                result.add(
                    if (reverse) level.reversed() else level
                )
                reverse = !reverse
                level = mutableListOf<Int>()
                numInLevel = queue.size
            }
        }
        return result
    }

    // LC102. Binary Tree Level Order Traversal
    fun levelOrderIterative(root: TreeNode?): List<List<Int>> {
        val result = mutableListOf<MutableList<Int>>()
        val queue = mutableListOf<TreeNode>()
        if (root == null) { return result }
        queue.add(root)
        var level = mutableListOf<Int>()
        var numInLevel = queue.size
        while (queue.size > 0) {
            val current = queue.removeAt(0)
            level.add(current.`val`)
            current.left?.let { queue.add(it) }
            current.right?.let { queue.add(it) }
            numInLevel -= 1
            if (numInLevel == 0) {
                result.add(level)
                level = mutableListOf<Int>()
                numInLevel = queue.size
            }
        }
        return result
    }
    
    private fun levelOrderHelper(root: TreeNode, levels: MutableList<MutableList<Int>>, level: Int) {
        if (levels.size == level) {
            levels.add(mutableListOf<Int>())
        }
        levels.get(level).add(root.`val`)
        root.left?.let { levelOrderHelper(it, levels, level + 1) }
        root.right?.let { levelOrderHelper(it, levels, level + 1) }
    }
    
    // recursive
    fun levelOrder(root: TreeNode?): List<List<Int>> {
        val levels = mutableListOf<MutableList<Int>>()
        if (root == null) { return levels }
        levelOrderHelper(root, levels, 0)
        return levels
    }

    // LC101. Symmetric Tree
    private fun isSymmetricHelper(root1: TreeNode?, root2: TreeNode?): Boolean {
        if (root1 == null && root2 == null) return true
        if (root1 == null) return false
        if (root2 == null) return false
        if (root1.`val` != root2.`val`) return false
        return isSymmetricHelper(root1.left, root2.right) && isSymmetricHelper(root1.right, root2.left)
    }
    fun isSymmetric(root: TreeNode?): Boolean {
        if (root == null) return true
        return isSymmetricHelper(root.left, root.right)
    }

    // LC98. Validate Binary Search Tree
    fun isValidBSTHelper(root: TreeNode, leftLimit: Int, rightLimit: Int): Boolean {
        var leftIsValid = true
        var rightIsValid = true
        if (root.`val` < leftLimit || root.`val` > rightLimit) { return false }
        root.left?.let {
            if (it.`val` >= root.`val`) { return false }
            leftIsValid = isValidBSTHelper(it, leftLimit, root.`val` - 1)
        }
        root.right?.let {
            if (it.`val` <= root.`val`) { return false }
            rightIsValid = isValidBSTHelper(it, root.`val` + 1, rightLimit)
        }
        return leftIsValid && rightIsValid
    }
    
    fun isValidBST(root: TreeNode?): Boolean {
        if (root == null) { return true }
        return isValidBSTHelper(root, Int.MIN_VALUE, Int.MAX_VALUE)
    }

    // LC94. Binary Tree Inorder Traversal
    fun inorderTraversalHelper(root: TreeNode?, result:  MutableList<Int>): Unit {
        if (root == null) { return }
        inorderTraversalHelper(root.left, result)
        result.add(root.`val`)
        inorderTraversalHelper(root.right, result)
    }
    
    fun inorderTraversal(root: TreeNode?): List<Int> {
        val result = mutableListOf<Int>()
        inorderTraversalHelper(root, result)
        return result
    }

    // LC88. Merge Sorted Array
    fun merge(nums1: IntArray, m: Int, nums2: IntArray, n: Int): Unit {
        var wx = m + n -1
        var n1Ix = m - 1
        var n2Ix = n - 1
        while (n1Ix >= 0 && n2Ix >= 0) {
            if (nums1[n1Ix] > nums2[n2Ix]) {
                nums1[wx--] = nums1[n1Ix--]
            } else {
                nums1[wx--] = nums2[n2Ix--]
            }
        }
        while (n2Ix >= 0) {
            nums1[wx--] = nums2[n2Ix--]
        }
    }

    // LC81. Search in Rotated Sorted Array II
    fun search(nums: IntArray, target: Int): Boolean {
        if (nums.size == 0) { return false }
        var start = 0
        var end = nums.size - 1
        
        while (start <= end) {
            val mid = start + (end - start)/2
            if (nums[mid] == target) { return true }
            if (!isBinarySearchUseful(nums, start, nums[mid])) {
                start++
                continue
            }
            val pivotArray = existsInFirst(nums, start, nums[mid])
            val targetArray = existsInFirst(nums, start, target)
            if (pivotArray xor targetArray) {
                if (pivotArray) {
                    start = mid + 1
                } else {
                    end = mid - 1
                }
            } else {
                if (target < nums[mid]) {
                    end = mid - 1
                } else {
                    start = mid + 1
                }
            }
        }
        return false
    }

    // LC79. Word Search
    fun existHelper(board: Array<CharArray>, word: String, wordIx: Int, rowIx: Int, colIx: Int): Boolean {
        if (rowIx < 0 || colIx < 0 || rowIx >= board.size || colIx >= board[0].size) {
            return false
        }

        if (board[rowIx][colIx] != word[wordIx]) {
            return false
        }
        if (wordIx == word.length - 1) { return true  }
        val shifts = listOf(listOf(0, 1), listOf(1, 0), listOf(-1, 0), listOf(0, -1))        
        for (shift in shifts) {
            val origValue = board[rowIx][colIx]
            board[rowIx][colIx] = '!'
            if (existHelper(board, word, wordIx + 1, rowIx + shift[0], colIx + shift[1])) {
                return true
            }
            board[rowIx][colIx] = origValue
        }
        return false
    }
    
    fun exist(board: Array<CharArray>, word: String): Boolean {
        var board = board
        for (ix in 0..board.size - 1) {
            for (jx in 0..board[0].size - 1) {
                if (existHelper(board, word, 0, ix, jx)) {
                    return true
                }
            }
        }
        return false
    }

    // LC78. Subsets
    fun subsets(nums: IntArray): List<List<Int>> {
        val bitMask = 1 shl nums.size
        var result = mutableListOf(mutableListOf<Int>())
        for (mask in 1..bitMask - 1) {
            var subset = mutableListOf<Int>()
            for (ix in 0..nums.size - 1) {
                val current = 1 shl ix
                if (current and mask != 0) {
                    subset.add(nums[ix])
                }
            }
            result.add(subset)
        }
        return result
    }

    // LC75. Sort Colors
    fun sortColors1(nums: IntArray): Unit {
        var numRed = 0
        var numWhite = 0
        var numBlue = 0
        for (index in 0..nums.size-1) {
            when(nums[index]) {
                0 -> numRed += 1
                1 -> numWhite += 1
                2 -> numBlue += 1
                else -> error("unknown value")
            }
        }
        var index = 0
        while (numRed > 0) {
            nums[index] = 0
            index += 1
            numRed -= 1
        }
        while (numWhite > 0) {
            nums[index] = 1
            index += 1
            numWhite -= 1
        }
        while (numBlue > 0) {
            nums[index] = 2
            index += 1
            numBlue -= 1
        }
    }
    
    fun sortColors2(nums: IntArray): Unit {
        val counts = nums.groupBy { it }
        var index = 0
        counts[0]?.let { reds -> 
           nums.fill(0, index, index + reds.size) 
           index += reds.size
        }
        counts[1]?.let { whites -> 
           nums.fill(1, index, index + whites.size) 
           index +=  whites.size
        }
        counts[2]?.let { blues -> 
           nums.fill(2, index, index + blues.size) 
           index += blues.size
        }
    }
    
    fun sortColors(nums: IntArray): Unit {
        val counts = IntArray(3)
        nums.forEach{ counts[it]++ }
        var index = 0
        counts.forEachIndexed { i, n -> 
            nums.fill(i, index, index + n)  
            index += n
        }
    }

    // LC73. Set Matrix Zeroes
    fun setZeroes(matrix: Array<IntArray>): Unit {
        var isCol = false
        for (ix in 0..matrix.size - 1) {
            if (matrix[ix][0] == 0) { isCol = true }            
            for (jx in 1..matrix[0].size - 1) {
                if (matrix[ix][jx] == 0) {
                    matrix[ix][0] = 0
                    matrix[0][jx] = 0
                }
            }
        }
        
        for (ix in 1..matrix.size - 1) {
            for (jx in 1..matrix[0].size - 1) {
                if (matrix[ix][0] == 0) {
                    matrix[ix][jx] = 0
                }
                if (matrix[0][jx] == 0) {
                    matrix[ix][jx] = 0
                }
            }
        }
        if (matrix[0][0] == 0) {
            for (cx in 0..matrix[0].size - 1) {
                matrix[0][cx] = 0
            }
        }
        if (isCol) {
            for (rx in 0..matrix.size - 1) {
                matrix[rx][0] = 0
            }
        }
    }
    
    // LC62. Unique Paths
    fun uniquePaths(m: Int, n: Int): Int {
        if (m == 1 || n == 1) {
            return 1
        }
        return uniquePaths(m - 1, n) + uniquePaths(m, n - 1)
    }

    fun uniquePaths(m: Int, n: Int): Int {
       val board = Array(m + 1, { IntArray(n + 1, {1}) })
       
       for (ix in 1..m) {
           for (jx in 1..n) {
                board[ix][jx] = board[ix][jx - 1] + board[ix - 1][jx]                   
           }
        }
       return board[m - 1][n - 1]
    }

    // LC61. Rotate List
    fun rotateRight(head: ListNode?, k: Int): ListNode? {
        if (head == null) { return null }
        if (head.next == null) { return head }
        var oldTail = head
        var length = 1
        while (oldTail != null && oldTail.next != null) {
            length++
            oldTail = oldTail.next
        }
        oldTail?.next = head
        var newTail = head
        for (ix in 0..(length - k % length - 1) - 1) {
            newTail = newTail?.next
        }
        val newHead = newTail?.next
        newTail?.next = null
        return newHead
    }

    // LC55. Jump Game
    fun canJump(nums: IntArray): Boolean {
        var maxJump = nums[0] 
        var ix = 1
        while (ix <= maxJump && ix < nums.size) {
            maxJump = Math.max(maxJump, nums[ix] + ix)
            ix++
        }
        return maxJump >= nums.size - 1
    }

    // LC54. Spiral Matrix
    fun spiralOrder(matrix: Array<IntArray>): List<Int> {
       val result = mutableListOf<Int>()
       val rows = matrix.size
       val columns = matrix[0].size
       var up = 0
       var down = rows - 1
       var left = 0
       var right = columns - 1
       
        while (result.size < rows * columns) {
            // go right
            for (cx in left..right) {
                result.add(matrix[up][cx])
            }
            // go down
            for (rx in up + 1..down) {
                result.add(matrix[rx][right])
            }
            if (up != down) {
                // go left
                for (cx in right - 1 downTo left) {
                    result.add(matrix[down][cx])
                }
            }
            if (left != right) {
                // go up
                for (rx in down - 1 downTo up + 1) {
                    result.add(matrix[rx][left])
                }
            }
            left++
            right--
            up++
            down--
        }
        return result
    }

    // LC53. Maximum Subarray
    fun maxSubArray(nums: IntArray): Int {
        if (nums.size == 0) { return -1 }
        var localMaximum = nums[0]
        var globalMaximum = nums[0]
        for (ix in 1..nums.size - 1) {
            localMaximum = Math.max(nums[ix], localMaximum + nums[ix])
            globalMaximum = Math.max(localMaximum, globalMaximum)
        }
        return globalMaximum
    }

    // LC50. Pow(x, n)
    fun fastPowRecursive(x: Double, n: Long): Double {
        if (n == 0L) {
            return 1.0
        }
        val halfPow = fastPowRecursive(x, n / 2)        
        if (n % 2L == 0L) {
            return halfPow * halfPow
        } else {
            return halfPow * halfPow * x
        }
    }
    
    fun myPow(x: Double, n: Int): Double {
        var x = x
        var n = n
        if (n < 0) {
            n = -n
            x = 1 / x
        }
        return fastPowRecursive(x, n.toLong())
    }

    // LC49. Group Anagrams
    private fun groupAnagrams1(strs: Array<String>): List<List<String>> {
        val sortedStringToStrings = mutableMapOf<String, MutableList<String>>()
        for (index in 0..strs.size-1) {
            val strKey = strs[index].toCharArray().sorted().joinToString("")
            val storedList 
                = sortedStringToStrings.getOrPut(strKey, {mutableListOf<String>()})
            storedList.add(strs[index])
        }
        return sortedStringToStrings.values.toList()
    }
    
    private fun hashForString(s: String): String {
        val hashArray = IntArray(26, {0})
        for (index in 0..s.length-1) {
            hashArray[s[index].toInt() - 'a'.toInt()] += 1
        }
        return hashArray.joinToString("#")
    }
    
    fun groupAnagrams2(strs: Array<String>): List<List<String>> {
        val sortedStringToStrings = mutableMapOf<String, MutableList<String>>()
        for (index in 0..strs.size-1) {
            val strKey = hashForString(strs[index]) // strs[index].toCharArray().sorted().joinToString("")
            val storedList 
                = sortedStringToStrings.getOrPut(strKey, {mutableListOf<String>()})
            storedList.add(strs[index])
        }
        return sortedStringToStrings.values.toList()
    }
    
    companion object {
        private fun anagramSignature(str: String): String =
            str.asSequence().sorted().joinToString(separator="")
    }
    
    fun groupAnagrams3(strs: Array<String>): List<List<String>> {
        return strs
            .groupBy(Solution.Companion::anagramSignature) // Map<String, List<String>>
            .map { it.value }
    }
    
    fun groupAnagrams(strs: Array<String>): List<List<String>> {
        return strs.map {
             it.toCharArray().sorted() to it
        }
            .groupBy { it.first }
            .map {
                it.value.map { it.second }
            }.toList()
    }

    // LC48. Rotate Image
    private fun transpose(matrix: Array<IntArray>): Unit {
        val n = matrix.size
        for (ix in 0..n-1) {
            for (jx in ix..n-1){
                val tmp = matrix[ix][jx]
                matrix[ix][jx] = matrix[jx][ix]
                matrix[jx][ix] = tmp
            }
        }
    }
    
    private fun reflect(matrix: Array<IntArray>): Unit { 
        val n = matrix.size
        for (ix in 0..n-1) {
            for (jx in 0..(n/2)-1){
                val tmp = matrix[ix][jx]
                matrix[ix][jx] = matrix[ix][n - jx - 1]
                matrix[ix][n - jx - 1] = tmp
            }
        }
    }
    
    fun rotate(matrix: Array<IntArray>): Unit {
        transpose(matrix)
        reflect(matrix)
    }

    // LC47. Permutations II


    // LC46. Permutations
    fun permuteHelper(nums: MutableList<Int>, partialSize: Int, result: MutableList<List<Int>>) {
        if (partialSize == nums.size) {
            result.add(nums.toList())
            return
        }
        var nextIx = partialSize
        for (jx in nextIx..nums.size - 1) {
            nums[jx] = nums[nextIx].also{ nums[nextIx] = nums[jx] } 
            permuteHelper(nums, partialSize + 1, result)
            nums[jx] = nums[nextIx].also{ nums[nextIx] = nums[jx] } 
        }
    }
    
    fun permute(nums: IntArray): List<List<Int>> {
        var result = mutableListOf<List<Int>>()
        permuteHelper(nums.toMutableList(), 0, result)
        return result
    }

    // LC41. First Missing Positive
    fun firstMissingPositive(nums: IntArray): Int {
        var containsOne = false
        val n = nums.size
        for (ix in 0..nums.size - 1) {
            if (nums[ix] == 1) {
                containsOne = true
            }
        }
        if (containsOne == false) { return 1 }
        for (ix in 0..nums.size - 1) {
            if (nums[ix] <= 0 || nums[ix] > n) {
                nums[ix] = 1
            }
        }
        
        
        for (ix in 0..nums.size - 1) {
            val index = Math.abs(nums[ix])
            if (index == n) {
                nums[0] = -Math.abs(nums[0])
            } else {
                nums[index] = -Math.abs(nums[index])                
            }

        }
        for (ix in 1..nums.size - 1) {
            if (nums[ix] > 0) {
                return ix
            }
        }
        if (nums[0] > 0) { return n }
        return n + 1
    }

    // LC39. Combination Sum
    fun combinationSumHelper(candidates: List<Int>, nextIx: Int, target: Int, partial: List<Int>, partialSum: Int, result: MutableList<List<Int>>) {
        if (partialSum == target) {
            result.add(partial)
            return
        }

        for (ix in nextIx..candidates.size - 1) {
            if (partialSum + candidates[ix] >  target) {
                return
            }
            val nextPartial = partial.plus(candidates[ix])
            combinationSumHelper(candidates, ix, target, nextPartial, partialSum + candidates[ix], result)
        }
    }
    
    fun combinationSum(candidates: IntArray, target: Int): List<List<Int>> {
        val candidates = candidates.sorted()
        val result = mutableListOf<List<Int>>()
        val partial = listOf<Int>()
        combinationSumHelper(candidates, 0, target, partial, 0, result)
        return result
    }

    // LC38. Count and Say
    fun countAndSayRecursive(n: Int): String {
        if (n == 1) { return "1" }
        val s = countAndSay(n - 1)
        var count = 1
        var result = ""
        for (index in 1..s.length-1) {
            if (s[index] != s[index - 1]) {
                result += count.toString() + s[index - 1]
                count = 1
            } else {
                count++
            }
        }
        result += count.toString() + s[s.length - 1]
        return result
    }
    
    fun countAndSay(n: Int): String {
        var result = "1"
        for (index in 2..n) {
            val prev = result
            result = ""
            var count = 1
            for (index in 1..prev.length-1) {
                if (prev[index] != prev[index - 1]) {
                    result += count.toString() + prev[index - 1]
                    count = 1
                } else {
                    count++
                }
            }                   
            result += count.toString() + prev[prev.length - 1]
        }
        return result
    }

    // LC36. Valid Sudoku
    // replace int arrays with hashsets
    fun isValidSudoku(board: Array<CharArray>): Boolean {
        val N = 9
        var rows = IntArray(N, { 0 })
        var columns = IntArray(N, { 0 })
        var boxes = IntArray(N, { 0 })
        
        for (rx in 0..N-1) {
            for (cx in 0..N-1) {
                if (board[rx][cx] == '.') { continue }
                val valAtPos = board[rx][cx].toInt()
                val pos = 1 shl (valAtPos - 1)
                if (rows[rx] and pos > 0) { return false }
                rows[rx] = rows[rx]  or pos
                if (columns[cx] and pos > 0) { return false }
                columns[cx] = columns[cx]  or pos
                val bx = (rx / 3) * 3 + cx / 3
                if (boxes[bx] and pos > 0) { return false }
                boxes[bx] = boxes[bx] or pos
            }
        }
        return true
    }

    // LC35. Search Insert Position
    fun searchInsert(nums: IntArray, target: Int): Int {
        var left = 0
        var right = nums.size - 1
        while (left <= right) {
            val mid = left + (right - left)/2
            if (nums[mid] == target) { return mid }
            else if (nums[mid] < target) { left = mid + 1 }
            else { right = mid - 1 }
        }
        return left
    }

    // LC34. Find First and Last Position of Element in Sorted Array
    fun searchRange(nums: IntArray, target: Int): IntArray {
        var start = 0; var end = nums.size - 1;
        var left = -1; var right = -1
        while (start <= end) {
            val mid = end - (end - start)/2
            if (target == nums[mid]) {
                left = mid
            }
            if (nums[mid] == target || target < nums[mid]) {
                end = mid - 1
            } else {
                start = mid + 1
            }
        }
        start = 0; end = nums.size - 1
        while (start <= end) {
            val mid = end - (end - start)/2
            if (target == nums[mid]) {
                right = mid
            }
            if (nums[mid] == target || target > nums[mid]) {
                start = mid + 1
            } else {
                end = mid - 1
            }
        }
        return intArrayOf(left, right)
    }

    // LC33. Search in Rotated Sorted Array
    // [4, 5, 6, 7, 0, 1, 2]
    
    // [7, 8, 1, 2, 3, 4, 5, 6]
    // 2
    
    fun search(nums: IntArray, target: Int): Int {
        var left = 0; var right = nums.size-1
        while (left <= right) {
            val mid = right - (right - left) / 2
            if (nums[mid] == target) {
                return mid
            }
            if (nums[left] <= nums[mid]) {
                // pivot could be on right side
                if (target < nums[mid] && target >= nums[left]) {
                    right = mid - 1
                } else {
                    left = mid + 1
                }
            } else {
                // pivot could be on left side
                if (target > nums[mid] && target <= nums[right]) {
                    left = mid + 1
                } else {
                    right = mid - 1
                }
            }

        }
        return -1
    }

    // LC31. Next Permutation
    private fun reverse(nums: IntArray, ix: Int): Unit {
        var ix = ix
        var jx = nums.size - 1
        while (ix < jx) {
            nums[ix] = nums[jx].also { nums[jx] = nums[ix] }
            ix++; jx--;
        }
    }
    
    fun nextPermutation(nums: IntArray): Unit {
        var ix = nums.size - 2
        while (ix >= 0 && nums[ix] >= nums[ix + 1]) {
            ix--
        }
        if (ix >= 0) {
            var jx = nums.size - 1
            while (nums[jx] <= nums[ix]) {
                jx--
            }
            nums[ix] = nums[jx].also { nums[jx] = nums[ix] }
        }
        reverse(nums, ix + 1)
    }

    // LC27. Remove Element
    fun removeElement(nums: IntArray, `val`: Int): Int {
        var rx = 0; var wx = 0;
        while (rx < nums.size) {
            if (nums[rx] != `val`) {
                nums[wx++] = nums[rx]
            }
            rx++
        }
        return wx
    }

    // LC26. Remove Duplicates from Sorted Array
    fun removeDuplicates(nums: IntArray): Int {
        if (nums.size == 0) { return 0 }
        var writeIx = 1
        var readIx = 1
        while(readIx < nums.size) {
            if (nums[readIx] != nums[readIx - 1]) {
                nums[writeIx++] = nums[readIx]
            }
            readIx++
        }
        return writeIx
    }

    // LC20. Valid Parentheses
    fun isValid(s: String): Boolean {
        val stack = mutableListOf<Char>()
        s.forEach { c -> 
            if (c == '{' || c == '[' || c == '(') {
                stack.add(c)
            } else {
                if (stack.isEmpty()) { return false }
                val top = stack.removeAt(stack.size - 1)
                when(c) {
                    '}' -> if (top != '{') return false
                    ']' -> if (top != '[') return false
                    ')' -> if (top != '(') return false
                    else -> error("invalid char")
                }
            }
        }
        return stack.isEmpty()
    }

    // LC19. Remove Nth Node From End of List
    // two pass
    fun removeNthFromEnd(head: ListNode?, n: Int): ListNode? {
        if (head == null) { return null }
        val dummy = ListNode(0)
        dummy.next = head
        var length = 0
        var first = head
        while (first != null) {
            first = first?.next
            length++
        }
        length -= n
        first = dummy
        while (length > 0) {
            first = first?.next
            length--
        }
        first?.next= first?.next?.next
        return dummy?.next
    }

    // one pass
    fun removeNthFromEnd(head: ListNode?, n: Int): ListNode? {
        if (head == null) { return null }
        val dummy = ListNode(0)
        dummy.next = head

        var first = head
        for (ix in 1..n) {
            first = first?.next
        }
        var second = dummy
        while (first != null) {
            second = second?.next
            first = first?.next
        }
        second?.next = second?.next?.next
        return dummy?.next
    }

    // LC17. Letter Combinations of a Phone Number
    private var digitsMap = mapOf(
        '1' to "1",
        '2' to "abc",
        '3' to "def",
        '4' to "ghi",
        '5' to "jkl",
        '6' to "mno",
        '7' to "pqrs",
        '8' to "tuv",
        '9' to "wxyz",
        '0' to "0"
    )
    
    private fun letterCombinationsHelper(
        digits: String, 
        partial: String, 
        pIndex: Int,
        result: MutableList<String>) {
        if (partial.length == digits.length) {
            result.add(partial)
            return
        }
       
        digitsMap[digits[pIndex]]?.let { values -> 
            values.forEach { 
                letterCombinationsHelper(digits, partial + it, pIndex + 1, result)
            }
        }
    }
    
    fun letterCombinations(digits: String): List<String> {
        var result = mutableListOf<String>()
        if (digits == "") return result
        letterCombinationsHelper(digits, "", 0, result)
        return result
    }

    // LC15. 3Sum
    // [-1, 0, 1, 2, -1, -4]
    // [-4, -1, -1, 0, 1, 2]
    
    // [-2, 0, 1, 1, 2]
    // -- [-2, 0, 1, 1, 2]
    fun threeSum(input: IntArray): List<List<Int>> {
        var result = mutableListOf<List<Int>>()
        val nums = input.sorted()
        
        var ix = 0; var jx = ix + 1; var zx = nums.size - 1;
        while (ix < nums.size - 2) { 
            jx = ix + 1; zx = nums.size - 1;
            while (jx < zx) {
                val tripletSum = nums[ix] + nums[jx] + nums[zx]
                if (tripletSum == 0) {
                    result.add(listOf(nums[ix], nums[jx], nums[zx]))
                    zx--;jx++;
                    while (zx > jx && nums[zx] == nums[zx + 1]) { zx-- }  
                    while (jx < zx && nums[jx] == nums[jx - 1]) { jx++ }
                } else if (tripletSum > 0) { zx-- }
                else { jx++ }
            }
            while (ix + 1 <= nums.size - 1 && nums[ix] == nums[ix + 1]) { ix++ }
            ix++
        }
        return result
    }

    // LC14. Longest Common Prefix
    // ["flower", "flow", "flight"], 
    fun longestCommonPrefix1(strs: Array<String>): String {
        var index = 0
        var arraysIx = 0
        var prefix = ""
        var done = false
        while (!done) {
            for (arraysIx in 0..strs.size-1) {
                val current = strs[arraysIx]
                if (!done && (current.length <= index ||
                    current[index] != strs[0][index])) {
                    done = true
                }
                if (!done && arraysIx == strs.size-1) {
                    prefix += current[index]
                    index++
                }
            }
        }
        return prefix
    }

    // LC13. Roman to Integer
    fun romanToInt(s: String): Int {
        val map = hashMapOf(
            'I' to 1, 
            'V' to 5,
            'X' to 10,
            'L' to 50,
            'C' to 100,
            'D' to 500,
            'M' to 1000
        )
        var result = 0
        if (s.length == 0) { return result }
        var lastValue = map.getOrDefault(s[s.length-1], 0)
        for (index in s.length-1 downTo 0) {
            val current = map.getOrDefault(s[index], 0)
            if (current < lastValue) {
                result -= current
            } else {
                result += current
            }
            lastValue = current 
        }
        return result
    }

    // LC11. Container With Most Water
    fun maxArea(height: IntArray): Int {
        var maxArea = 0
        var ix = 0; var jx = height.size - 1;
        while (ix < jx) {
            val heightToUse = if (height[ix] < height[jx]) height[ix] else height[jx]
            val area = (jx - ix) * heightToUse
            maxArea = if (area > maxArea) area else maxArea
            if (height[ix] < height[jx]) { ix++ }
            else { jx-- }
        }
        return maxArea
    }

    // LC7. Reverse Integer
    // this is the most elegant solution
    fun reverse(x: Int): Int {
        var x = x
        var result: Int = 0
        while (x != 0) {
            val pop = x % 10
            x /= 10            
            if (result > Int.MAX_VALUE/10 || result == Int.MAX_VALUE/10 && pop > 7) { return 0 }
            if (result < Int.MIN_VALUE/10 || result == Int.MIN_VALUE/10 && pop < -8) { return 0 }
            result  = result * 10 + pop

        }
        return result
    }

    // LC5. Longest Palindromic Substring
    // baabad
    fun expandAroundCenter(s: String, left: Int, right: Int): Int {
        var ix = left; var jx = right;
        while (ix >= 0 && jx <= s.length-1 && s[ix] == s[jx]) {
            ix--; jx++;
        }
        return jx - ix - 1
    }
    
    fun longestPalindrome(s: String): String {
        if (s.length < 1) { return "" }

        var start = 0; var end = 0;
        for (ix in 0..s.length-2) {
            val len1 = expandAroundCenter(s, ix, ix)
            val len2 = expandAroundCenter(s, ix, ix + 1)
            val len = maxOf(len1, len2)
            
            if (len > end - start) {
                start = ix - (len - 1) / 2
                end = ix + len / 2
            } 
        }
        return s.substring(start, end + 1)
    }

    // LC3. Longest Substring Without Repeating Characters
    // abcabccbb  -> 3
        // firstUniqueIx - 0
        // firstUniqueIx - 0
    // bbbbb    -> 1
    // aabcdebcd  -> 5
    // !! check to see if there is a more elegant solution
    fun lengthOfLongestSubstring(s: String): Int {
        val charToIndexMap = mutableMapOf<Char, Int>()
        var firstUniqueIx = 0
        var longest = 0
        for (index in 0..s.length-1) {
            charToIndexMap[s[index]]?.let { storedIx -> 
                if (storedIx >= firstUniqueIx) {
                    firstUniqueIx = storedIx + 1
                }
            }
            charToIndexMap[s[index]] = index
            if (index - firstUniqueIx + 1 > longest) {
                longest = index - firstUniqueIx + 1 
            }
        }
        return longest
    }

    // LC2. Add Two Numbers
    fun addTwoNumbers(l1: ListNode?, l2: ListNode?): ListNode? {
        val head = ListNode(0)
        var itr = head
        var l1Itr = l1
        var l2Itr = l2
        var carry = 0
        while (l1Itr != null || l2Itr != null) {
            var sum = 0
            if (l1Itr != null) { 
                sum += l1Itr.`val` 
                l1Itr = l1Itr.next 
            }
            if (l2Itr != null) { 
                sum += l2Itr.`val`
                l2Itr = l2Itr.next
            }
            sum += carry
            itr.next = ListNode(sum % 10)
            carry = sum / 10
            itr = itr.next
        }
        if (carry > 0) { itr.next = ListNode(carry) }
        
        return head.next
    }

    // LC1. Two Sum
    fun twoSum(nums: IntArray, target: Int): IntArray {
        val mapValToIndex = mutableMapOf<Int, Int>()
        for ((index, value) in nums.iterator().withIndex()) {
            if (mapValToIndex.containsKey(target-value)) {
                return intArrayOf(mapValToIndex.getOrDefault(target-value, 0), index)
            }
            mapValToIndex[value] = index
        }
        return intArrayOf()
    }
}