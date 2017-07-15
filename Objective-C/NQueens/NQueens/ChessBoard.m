//
//  ChessBoard.m
//  NQueens
//
//  Created by Akshay Bhandary on 4/29/15.
//  Copyright (c) 2015 Axa Labs. All rights reserved.
//

#import "ChessBoard.h"

static const int kBoardSize = 4;


@interface ChessBoard ()

@property size_t boardSize;

@end


@implementation ChessBoard

- (void) setSize: (size_t) boardSize
{
    self.boardSize = boardSize;
}


- (id) initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.boardSize = kBoardSize;
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    int xStart = 10, yStart = 10;
    int gridSize = 800 / self.boardSize;
    
    UIBezierPath *topPath = [UIBezierPath bezierPath];
    // draw vertical lines
    for(int xId=0; xId<= self.boardSize; xId++) {
        int x = xStart + xId * gridSize / self.boardSize;
        [topPath moveToPoint:CGPointMake(x, yStart)];
        [topPath addLineToPoint:CGPointMake(x, yStart+gridSize)];
    }
    
    // draw horizontal lines
    for(int yId=0; yId<= 4; yId++) {
        int y = yStart + yId * gridSize / self.boardSize;
        [topPath moveToPoint:CGPointMake(xStart, y)];
        [topPath addLineToPoint:CGPointMake(xStart+gridSize, y)];
    }
    
    [[UIColor whiteColor] setStroke];
    
    [topPath stroke];
}

@end
