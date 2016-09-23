

#!/usr/bin/python

class Solution:

# 399. Evaluate Division


# 395. Longest Substring with At Least K Repeating Characters
    def longestSubstring(self, s, k):
        if len(s) < k:
            return 0
        print set(s)

        c = min(set(s), key=s.count)
        if s.count(c) >= k:
            return len(s)
        return max(self.longestSubstring(t, k) for t in s.split(c))


# 388. Longest Absolute File Path
def lengthLongestPath(self, input):
    maxlen = 0
    pathlen = {0: 0}
    for line in input.splitlines():
        name = line.lstrip('\t')
        depth = len(line) - len(name)
        if '.' in name:
            maxlen = max(maxlen, pathlen[depth] + len(name))
        else:
            pathlen[depth + 1] = pathlen[depth] + len(name) + 1
    return maxlen



s = Solution()
print "Longest substring for aaabbbb", s.longestSubstring("aaabbbb", 4)
print "Longest substring for aaabb", s.longestSubstring("ababbc", 2)
# print s.longestSubstring
str = "Line1-abcdef \nLine2-abc \nLine4-abcd";
print str.split()
