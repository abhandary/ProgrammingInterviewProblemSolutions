package com.company;


import java.util.*;


// 355. Design Twitter
// https://leetcode.com/problems/design-twitter/#/description
public class Twitter {

    class Tweet {
        int time;
        int id;

        Tweet(int time, int id) {
            this.time = time;
            this.id = id;
        }
    }

    Map<Integer, Set<Integer>> fans = new HashMap<>();
    Map<Integer, LinkedList<Tweet>> tweets = new HashMap<>();
    int cnt = 0;

    /** Initialize your data structure here. */
    public Twitter() {

    }

    /** Compose a new tweet. */
    public void postTweet(int userId, int tweetId) {
        if (!fans.containsKey(userId)) fans.put(userId, new HashSet<>());
        fans.get(userId).add(userId);
        if (!tweets.containsKey(userId)) tweets.put(userId, new LinkedList<>());
        tweets.get(userId).addFirst(new Tweet(cnt++, tweetId));
    }

    /** Retrieve the 10 most recent tweet ids in the user's news feed. Each item in the news feed must be posted by users who the user followed or by the user herself. Tweets must be ordered from most recent to least recent. */
    public List<Integer> getNewsFeed(int userId) {
        if (!fans.containsKey(userId)) return new LinkedList<>();
        PriorityQueue<Tweet> feed = new PriorityQueue<>((t1, t2) -> t2.time - t1.time);
        fans.get(userId).stream()
                .filter(f -> tweets.containsKey(f))
                .forEach(f -> tweets.get(f).forEach(feed::add));
        List<Integer> res = new LinkedList<>();
        while (feed.size() > 0 && res.size() < 10) res.add(feed.poll().id);
        return res;
    }

    /** Follower follows a followee. If the operation is invalid, it should be a no-op. */
    public void follow(int followerId, int followeeId) {
        if (!fans.containsKey(followerId)) fans.put(followerId, new HashSet<>());
        fans.get(followerId).add(followeeId);
    }

    /** Follower unfollows a followee. If the operation is invalid, it should be a no-op. */
    public void unfollow(int followerId, int followeeId) {
        if (fans.containsKey(followerId) && followeeId != followerId) fans.get(followerId).remove(followeeId);
    }
}


public interface NestedInteger {

    // @return true if this NestedInteger holds a single integer, rather than a nested list.
    public boolean isInteger();

    // @return the single integer that this NestedInteger holds, if it holds a single integer
    // Return null if this NestedInteger holds a nested list
    public Integer getInteger();

    // @return the nested list that this NestedInteger holds, if it holds a nested list
    // Return null if this NestedInteger holds a single integer
    public List<NestedInteger> getList();
 }

// 341. Flatten Nested List Iterator
// Time: hasNext: O(n), next - O(n)
// https://leetcode.com/problems/flatten-nested-list-iterator/#/description
public class NestedIterator implements Iterator<Integer> {

    Stack<NestedInteger> stack;

    public NestedIterator(List<NestedInteger> nestedList) {
        stack = new Stack<NestedInteger>();

        for (int ix = nestedList.size() - 1; ix >= 0; ix--) {
            stack.push(nestedList.get(ix));
        }
    }

    @Override
    public Integer next() {
        return stack.pop().getInteger();
    }

    @Override
    public boolean hasNext() {

        while (!stack.empty()) {
            NestedInteger ni = stack.peek();
            if (ni.isInteger()) {
                return true;
            } else {
                ni = stack.pop();
                List<NestedInteger> list = ni.getList();
                for (int ix = list.size() - 1; ix >= 0; ix--) {
                    stack.push(list.get(ix));
                }
            }
        }
        return false;
    }
}

// 284. Peeking Iterator
// https://discuss.leetcode.com/topic/24883/concise-java-solution
class PeekingIterator implements Iterator<Integer> {

    Integer next;
    Iterator<Integer> iterator;

    public PeekingIterator(Iterator<Integer> iterator) {
        this.iterator = iterator;
        next = iterator.hasNext() ? iterator.next() : null;
    }

    // Returns the next element in the iteration without advancing the iterator.
    public Integer peek() {
        return next;
    }

    // hasNext() and next() should behave the same as in the Iterator interface.
    // Override them if needed.
    @Override
    public Integer next() {
        int oldNext = next;
        next = iterator.hasNext() ? iterator.next() : null;
        return oldNext;
    }

    @Override
    public boolean hasNext() {
        return next != null;
    }
}

class TrieNode {
    public Character ch;
    public TrieNode[] children = new TrieNode[26];
    public boolean isFullWord;

    TrieNode(char c) {
        ch = c;
    }
    TrieNode() {
    }
}

// 211. Add and Search Word - Data structure design
// https://leetcode.com/problems/add-and-search-word-data-structure-design/#/solutions
public class WordDictionary {

    class TrieNode {
        public char ch;
        public TrieNode[] children = new TrieNode[26];
        boolean isWord;
        TrieNode(char ch) {
            this.ch = ch;
        }
    }

    TrieNode root;

    /** Initialize your data structure here. */
    public WordDictionary() {
        root = new TrieNode(' ');
    }

    /** Adds a word into the data structure. */
    public void addWord(String word) {
        TrieNode ws = root;
        for (int ix = 0; ix < word.length(); ix++) {
            char c = word.charAt(ix);
            if (ws.children[c - 'a'] == null) {
                ws.children[c - 'a'] = new TrieNode(c);
            }
            ws = ws.children[c - 'a'];
        }
        ws.isWord = true;
    }

    /** Returns if the word is in the data structure. A word could contain the dot character '.' to represent any one letter. */
    public boolean search(String word) {
        return match(word.toCharArray(), 0, root);
    }

    boolean match(char[] chars, int ix, TrieNode ws) {

        if (ix == chars.length) { return ws.isWord; }

        if (chars[ix] != '.') {
            if (ws.children[chars[ix] - 'a'] == null) { return false;}
            return match(chars, ix + 1, ws.children[chars[ix] - 'a']);
        } else {
            for (int jx = 0; jx < ws.children.length; jx++) {
                if (ws.children[jx] != null && match(chars, ix + 1, ws.children[jx])) {
                    return true;
                }
            }
        }
        return false;
    }
}

// 208. Implement Trie (Prefix Tree)
// https://leetcode.com/problems/implement-trie-prefix-tree/#/description
public class Trie {

    TrieNode root;

    /** Initialize your data structure here. */
    public Trie() {
        root = new TrieNode('0');
    }

    /** Inserts a word into the trie. */
    public void insert(String word) {
        TrieNode ws = root;
        for (int ix = 0; ix < word.length(); ix++) {
            char c = word.charAt(ix);
            if (ws.children[c - 'a'] == null) {
                ws.children[c - 'a'] = new TrieNode();
            }
            ws = ws.children[c - 'a'];
        }
        ws.isFullWord = true;
    }

    /** Returns if the word is in the trie. */
    public boolean search(String word) {

        TrieNode ws = root;
        for (int ix = 0; ix < word.length(); ix++) {
            char c = word.charAt(ix);
            if (ws.children[c - 'a'] == null) { return false; }
            ws = ws.children[c - 'a'];
        }
        return ws.isFullWord;
    }

    /** Returns if there is any word in the trie that starts with the given prefix. */
    public boolean startsWith(String prefix) {
        TrieNode ws = root;
        for (int ix = 0; ix < prefix.length(); ix++) {
            char c = prefix.charAt(ix);
            if (ws.children[c - 'a'] == null) { return false; }
            ws = ws.children[c - 'a'];
        }
        return true;
    }
}

/**
 * Created by akshayb on 3/15/17.
 */
public class Design {
}
