Time Complexity: O(M \times N)O(M×N), where MM is the number of rows and NN is the number of columns of the Board.
Space Complexity: O(1)O(1)

1. How to save space?
- If using Java, use byte[][].
- Don't make an extra board. Just rewrite the current one.
- All you need is a set of the cells that are alive
2. What if this can't fit into an array?
- Read the rows as streams from a disk, read 3 rows at a time
3. What if we just give you generating functions G(row, col, time) for the cell states?
- Just do the math with the generating functions.


class Solution {
    fun gameOfLife(board: Array<IntArray>): Unit {
        val neighbors = listOf(0, -1, 1)
        
        val rowCount = board.size
        val colCount = board[0].size
        for (row in 0..rowCount - 1) {
            for (col in 0..colCount - 1) {
                // gotcha - not having liveNeighbors outside of the inner for loop airs
                var liveNeighbors = 0
                for (ix in 0..2) {
                    for (jx in 0..2) {
                        if (!(neighbors[ix] == 0 && neighbors[jx] == 0)) {
                            val r = row + neighbors[ix]
                            val c = col + neighbors[jx]
                            if (r < rowCount && r >= 0 && c < colCount && c >= 0) {
                                if (Math.abs(board[r][c]) == 1) {
                                    liveNeighbors++
                                }
                                
                            }
                        }
                    }
                }
                // gotcha using r and c instead of row and col for doing these checks. 
                // gotcha - not enclosing second condition within parans here
                if (board[row][col] == 1 && (liveNeighbors < 2 || liveNeighbors > 3)) {
                    board[row][col] = -1 // live before, dead now.
                }
                if (board[row][col] == 0 && liveNeighbors == 3) {
                    board[row][col] = 2 // dead before, live now
                } 
            }
        }
        for (row in 0..rowCount - 1) {
            for (col in 0..colCount - 1) {
                if (board[row][col] == -1) {
                    board[row][col] = 0
                }
                if (board[row][col] == 2) {
                    board[row][col] = 1
                }
            }
        }
    }


    // number of islands
    private fun explore(visited: MutableList<MutableList<Char>>, x: Int, y: Int) {
        if (x >= visited.size || y >= visited[0].size || x < 0 || y < 0) {
            return
        }
        val shifts = arrayOf(arrayOf(1, 0), arrayOf(-1, 0), arrayOf(0, 1), arrayOf(0, -1))
        if (visited[x][y] == '1') {
            visited[x][y] = 'X'
            shifts.forEach { shift -> 
                explore(visited, x + shift[0], y + shift[1]) 
            }
        } 
    }
    
    fun numIslands(grid: Array<CharArray>): Int {
        if (grid.size == 0) { return 0 }
        if (grid[0].size == 0) { return 0 }
        val visited = grid.map { it.toMutableList() }.toMutableList()
        
        var numIslands = 0
        for (rowIx in 0..visited.size-1) {
            for (colIx in 0..visited[0].size-1) {
                if (visited[rowIx][colIx] == '1') {
                   numIslands++
                   explore(visited, rowIx, colIx)  
                }
            }
        }
        return numIslands
    }

    // count and say
    // A follow-up question is to read from a file stream of numbers.
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

    // combination sum
    // Given a collection of soda bottles of different sizes, find all unique combinations of bottles that result in a given amount of soda.
    // This problem is given in the context of soda bottles or coins of different values.
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

    // 609. Find Duplicate File in System
    // Imagine you are given a real file system, how will you search files? DFS or BFS?
    // If the file content is very large (GB level), how will you modify your solution?
    // If you can only read the file by 1kb each time, how will you modify your solution?
    // What is the time complexity of your modified solution? What is the most time-consuming part and memory-consuming part of it? How to optimize?
    // How to make sure the duplicated files you find are not false positive?
    // SEE Solution Discussions: https://leetcode.com/problems/find-duplicate-file-in-system/solution/

    // Time complexity : O(n*x)O(n∗x). nn strings of average length xx is parsed.
    // Space complexity : O(n*x)O(n∗x). mapmap and resres size grows upto n*xn∗x.
    fun findDuplicate(paths: Array<String>): List<List<String>> {
        var contentMap = mutableMapOf<String, MutableList<String>>()
        for (path in paths) {
            val components = path.split(" ")
            for (fileIx in 1..components.size - 1) {
                val fileWithContent = components[fileIx]
                val fileWithContentSplit = fileWithContent.split("(")
                val content = fileWithContentSplit[1].replace(")", "")
                val pathsList = contentMap.getOrPut(content, { mutableListOf<String>() })
                pathsList.add(components[0] + "/" + fileWithContentSplit[0])
            }
        }
        return contentMap.values.toList().filter { it.size > 1 }
    }

    // https://github.com/insideofdrop/Dropbox-Interview-Prep/blob/main/code/hit_counter.py
    // Design a hit counter to record the number of hits on a webpage for the last 5 minutes.
    // Questions:
    // 1. Does this need to be threadsafe?
    // 2. Does the time window need to be resizeable?
    // """
    class HitCounter {
        val hits = IntArray(0, 300)
        val times = IntArray(0, 300)

        fun hit(timestamp: Int) {
            val idx = timestamp % 300
            if (times[idx] != timestamp) {
                times[idx] = timestamp
                hits[idx] = 1
            } else {
                hits[idx] += 1
            }
        }

        fun getHits(timestamp: Int) {
            var totalHits = 0
            for (ix in 0..times.size - 1) {
                val storedTimestamp = times[ix]
                if (timestamp - storedTimestamp < 300) {
                    totalHits += hits[idx]
                }
            }
            return totalHits
        }
    }

    // TODO: #Alternatively, use a deque.


    // https://github.com/insideofdrop/Dropbox-Interview-Prep/blob/main/code/webcrawler.py
    class Webcrawler {
        val visitedURLs = mutableSetOf<String>()
        val urlQueue = mutableListOf<String>()

        fun processURLs(url: String) {
            var tries = 5
            try {
                html = get_html_content(url)
            } catch(ex: ConnectionException) {
                return #talk about retries (with exponential backoff), what to do in this case
            }
            links = get_links_on_page(html)  
            for (link in links) {
                if (!visitedURLs.contains(link)) 
                {
                    visitedURLs.add(link)
                    urlQueue.add(link)
                }
            }          
        }

        fun run(url: String): List<String> {
            urlQueue.add(url)
            while (urlQueue.size > 0) {
                processURLs(urlQueue.removeLast())
            }
            return visitedURLs.toList()
        }
    }

    // TODO: Multithreaded webcrawler
    class Webcrawler {
        val orderedFiles = LinkedHashMap<Int, List<String>>()

        fun write(imageData: String, row: Int, col: Int) {

        }
    }

    class File {
        init(String path) {}
        fun exists(): Boolean {}
        fun read(): ByteArray {}
        fun write(bytes: ByteArray) {}
    }

    class Image {
        init(bytes: ByteArray) {}
        fun getBytes(): ByteArray {} // no more than 1MB in size
    }

    class Sector {
        lateinit val : Int
        lateinit val x: Int
        init(x: Int, y: Int) {
            x = x
            y = y
        }
        fun getX(): Int {}
        fun getY(): Int {}

        override fun hashCode(): Int {
            return Object.hash(x) * 32 + Object.hash(y)
        }
    }

    class SpacePanorama {

        val sectorMap = LinkedHashMap<Sector, Image>()

        init(int rows, int cols) {

        }

        /**
        * The Hubble will occasionally call this (via some radio wave communication)
        * to report new imagery for the sector at (y, x)
        * Images can be up to 1MB in size.
        */
        fun update(x: Int, y: Int, Image image) {
            sectorMap.remove("{$x}_{$y}")
            File(fileName).writeBytes(fileContentAsArray)
            sectorMap.put("{$x}_{$y}", image)
        }

        /**
        * NASA will occasionally call this to check the view of a particular sector.
        */
        fun fetch(x: Int, y: Int): Image? {
            return sectorMap.get("{$x}_{$y}")
        }

        /**
         * return the 2D index of the sector that has the stalest data.
        * the idea is that this may help the telescope decide where to aim next.
        */
        fun getStalestSector(): Sector {
            val firstSector = sectorMap.asSequence().first()
            val parts = firstSector.first.split("_")
            return Sector(parts[0].toInt(), parts[1].toInt())
        }
    }

    // Sharpness Value
    // https://github.com/userlj/alg2018/blob/master/src/dropbox/HighestMinimumSharpness.java

    // id allocator
    // binary heap - https://github.com/insideofdrop/Dropbox-Interview-Prep/blob/main/Binary%20Heap.png
    // https://github.com/insideofdrop/Dropbox-Interview-Prep/blob/main/code/allocate_id.py

    // Token Bucket
    // https://github.com/insideofdrop/Dropbox-Interview-Prep/blob/main/code/TokenBucket.java
}