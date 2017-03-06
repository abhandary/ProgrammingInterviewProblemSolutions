package com.company;

public class Main {




    public static void main(String[] args) {
	    // write your code here
        Hashtables ht = new Hashtables();
        ht.wordPattern("abba", "dog cat cat dog");

        Backtracking bt = new Backtracking();
        char[][] board = {{'a', 'a'}};
        bt.exist(board, "aa");

        Bits bits = new Bits();
        bits.toHex(-1);
    }
}
