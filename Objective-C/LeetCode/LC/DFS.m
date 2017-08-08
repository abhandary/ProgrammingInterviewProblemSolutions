//
//  DFS.m
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TreeNode : NSObject

@property (nonatomic, assign) NSInteger val;
@property (nonatomic, strong) TreeNode* left;
@property (nonatomic, strong) TreeNode* right;

@end


@implementation TreeNode


#pragma mark - 199. Binary Tree Right Side View

- (NSArray*) rightSideView:(TreeNode*) root {
    
    NSMutableArray* queue = [NSMutableArray array];
    NSMutableArray* result = [NSMutableArray array];;
    
    [queue addObject:root];
    [result addObject:root];
    NSInteger numNodesInLevel = 1;
    while (queue.count > 0) {
        TreeNode* current = [queue objectAtIndex:0];
        numNodesInLevel--;
        [queue removeObjectAtIndex:0];
        if (current.left)  [queue addObject:current.left];
        if (current.right) [queue addObject:current.right];
        if (numNodesInLevel == 0) {
            [result addObject:[queue lastObject]];
            numNodesInLevel = queue.count;
        }
    }
    return result;
}

#pragma mark - 112. Path Sum

- (BOOL) hasPathSumHelper:(TreeNode*) root
                      sum:(NSInteger) sum
               partialSum:(NSInteger) partial {
    if (root == nil) {
        return NO;
    }
    partial += root.val;
    if (root.left == nil && root.right == nil && partial == sum) {
        return YES;
    }
    return [self hasPathSumHelper:root.left sum:sum partialSum:partial] ||
    [self hasPathSumHelper:root.right sum:sum partialSum:partial];
}

- (BOOL) hasPathSum:(TreeNode*) root
                sum:(NSInteger) sum {
    return [self hasPathSumHelper:root sum:sum partialSum:0];
}

#pragma mark - 104. Maximum Depth of Binary Tree
- (NSInteger) maxDepth:(TreeNode*) root {
    if (root == nil) {
        return 0;
    }
    
    return MAX([self maxDepth:root.left], [self maxDepth:root.right]) + 1;
}


@end
