//
//  ViewController.m
//  NQueens
//
//  Created by Akshay Bhandary on 4/29/15.
//  Copyright (c) 2015 Axa Labs. All rights reserved.
//

#import "ViewController.h"
#import "ChessBoard.h"

static int* gQueens;

@interface ViewController ()

@property ChessBoard* boardView;

@end

@implementation ViewController

- (void)viewDidLoad {
    
    CGRect chessBoardFrame = CGRectMake(0, 60, self.view.frame.size.width, self.view.frame.size.height - 60);
    
    self.boardView = [[ChessBoard alloc] initWithFrame:chessBoardFrame];
    [self.view addSubview:self.boardView];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) solveForN:(size_t) N
{
    for (int col = 0; col < N; col++)
    {
        [self setQueenAtRow:0 andColumn:col boardSize:N];
    }
}

- (void) printQueensArrayForBoardSize:(size_t) N
{
    NSLog(@"######## PRINTING SOLUTION ########");
    
    for (int ix = 0; ix < N; ix++)
    {
        NSLog(@"###### Q[%d] = %d", ix, gQueens[ix]);
    }
}


- (void) setQueenAtRow: (int) row
             andColumn: (int) col
             boardSize: (size_t) N
{
    int ix = 0;
    
    // make sure none of the previously placed queens will attack at this
    // posistion
    for (ix = 0; ix < row; ix++)
    {
        // check vertical attack
        if (gQueens[ix] == col)
        {
            return;
        }
        
        // check diagonal attack
        if (abs(gQueens[ix] - col) == row - ix)
        {
            return;
        }
    }

    gQueens[row] = col;
    
    if (row == N - 1)
    {
        // found a solution
        [self printQueensArrayForBoardSize:N];
    }
    else
    {
        // now place the next row, try all columns
        for (int ix = 0; ix < N; ix++)
        {
            [self setQueenAtRow:row + 1 andColumn:ix boardSize:N];
        }
    }
}


-(IBAction) solveButtonPress:(id)sender
{
    NSString* num = self.boardSizeTextField.text;

    int size = [num intValue];
    
    gQueens = malloc(sizeof(int) * size);
    memset(gQueens, -1, size);
    
    [self.boardView setSize:size];
    [self.boardView setNeedsDisplay];
    [self solveForN:size];
    
}

@end
