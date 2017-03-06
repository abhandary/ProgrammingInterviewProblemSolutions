package com.company;

import java.util.*;

/**
 * Created by akshayb on 3/2/17.
 */
class PQO {
    int [] pair;
    int sum;
    PQO(int x, int y) {
        pair = new int[2];
        pair[0] = x;
        pair[1] = y;
        sum = x + y;
    }
}
public class Heaps {

    // 373. Find K Pairs with Smallest Sums
    // @todo: wrong, redo
    public List<int[]> kSmallestPairs(int[] nums1, int[] nums2, int k) {
        Comparator comparator = new Comparator<PQO>() {
            @Override
            public int compare(PQO o1, PQO o2) {
                return (o2.sum - o1.sum);
            }
        };
        PriorityQueue<PQO> pq = new PriorityQueue<>(k, comparator);
        for (int ix = 0; ix < nums1.length; ix++) {
            for (int jx = 0; jx < nums2.length; jx++) {
                if (pq.size() < k) {
                    pq.offer(new PQO(nums1[ix], nums2[jx]));
                } else {
                    PQO head = pq.peek();
                    if (nums1[ix] + nums2[ix] > head.sum) {
                        pq.poll();
                        pq.offer(new PQO(nums1[ix], nums2[jx]));
                    }
                }
            }
        }
        List<int[]> result = new ArrayList<>();
        for (PQO o : pq) {
            result.add(o.pair);
        }
        return result;
    }
}
