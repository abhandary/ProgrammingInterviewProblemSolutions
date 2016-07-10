//
//  Array.m
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Array : NSObject

- (BOOL) containsNearbyDuplicate:(NSArray*) nums
                               k:(NSInteger) k;
- (void) moveZeroes:(NSMutableArray*) array;
- (void) rotate:(NSArray*) nums
              k:(NSInteger) k;

@end


@implementation Array


#pragma mark - 283. Move Zeroes
- (void) moveZeroes:(NSMutableArray*) array {
    int w_ix = 0;
    
    for (int r_ix = 0; r_ix < array.count; r_ix++) {
        if (![array[r_ix] isEqualTo:@(0)]) {
            array[w_ix++] = array[r_ix];
        }
    }
    
    while (w_ix < array.count) {
        array[w_ix++] = @(0);
    }
}


#pragma mark - 219. Contains Duplicate II

- (BOOL) containsNearbyDuplicate:(NSArray*) nums
                               k:(NSInteger) k
{
    
    NSMutableDictionary* lookup = [NSMutableDictionary dictionary];
    for (int ix = 0; ix < nums.count; ix++) {
        NSInteger lastSeen = [lookup[nums[ix]] integerValue];
        if (lookup[nums[ix]] && ix - lastSeen <= k) {
            return YES;
        }
        lookup[nums[ix]] = @(ix);
    }
    return NO;
}


#pragma mark - 189. Rotate Array

- (void) reverse:(NSMutableArray*) array
           start:(NSInteger) start
             end:(NSInteger) end
{
    while (start < end) {
        id temp = array[start];
        array[start] = array[end];
        array[end] = temp;
        start++, end--;
    }
}

- (void) rotate:(NSMutableArray*) nums
              k:(NSInteger) k
{
    k = k % nums.count;
    
    [self reverse:nums start:0 end:nums.count - 1];
    [self reverse:nums start:0 end:k - 1];
    [self reverse:nums start:k end:nums.count - 1];
}


#pragma mark - 54. Spiral Matrix
- (NSArray*) spiralOrder:(NSArray<NSArray*>*) matrix {
    
    NSMutableArray* result = [NSMutableArray array];
    if (matrix.count == 0) {
        return result;
    }
    
    int top = 0, bottom = matrix.count - 1;
    int left = 0, right = matrix[0].count - 1;
    
    while (top <= bottom && left <= right) {
        for (int col = left; col <= right; col++) {
            [result addObject:matrix[top][col]];
        }
        top++;
        for (int row = top; row <= bottom; row++) {
            [result addObject:matrix[row][right]];
        }
        right--;
        if (top <= bottom) {
            for (int col = right; col >= left; col--) {
                [result addObject:matrix[bottom][col]];
            }
            bottom--;
        }
        if (left <= right) {
            for (int row = bottom; row >= top; row--) {
                [result addObject:matrix[row][left]];
            }
            left++;
        }
    }

    return result;
}

@end


#if 0
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        
        Array* A = [Array new];
        
        
        NSMutableArray* marray = [@[@0, @1, @0, @3, @2] mutableCopy];
        [A moveZeroes:marray];
        NSLog(@"###### Move Zeroes = %@", marray);
        
        NSMutableArray* rarray = [@[@1, @2, @3, @4, @5, @6, @7] mutableCopy];
        [A rotate:rarray k:3];
        NSLog(@"##### rotated array = %@", rarray);
        
        NSArray* matrix = @[
                           @[ @1, @2, @3 ],
                           @[ @4, @5, @6 ],
                           @[ @7, @8, @9 ]
                           ];
        NSLog(@"#### spiral = %@", [A spiralOrder:matrix]);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
#endif

