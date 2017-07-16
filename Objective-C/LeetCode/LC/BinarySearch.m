//
//  BinarySearch.m
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BinarySearch : NSObject



@end


@implementation BinarySearch

#pragma mark - 153. Find Minimum in Rotated Sorted Array

- (NSNumber*) findMin:(NSArray*) nums {
    
    NSInteger left = 0, right = nums.count - 1;
    NSInteger mid = -1;
    
    while (left < right) {
        mid = left + (right - left) / 2;
        if ([nums[mid] integerValue] <= [nums[right] integerValue]) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return nums[left];
}

#pragma mark - 74. Search a 2D Matrix

- (BOOL) searchMatrix:(NSArray<NSArray*>*) matrix
               target:(NSInteger) target {
    if (matrix.count == 0) {
        return NO;
    }
    NSInteger left = 0, right = matrix[0].count - 1;
    NSInteger top = 0, bottom = matrix.count - 1;
    
    while (left <= right && top <= bottom) {
        NSInteger cornerValue = [matrix[top][right] integerValue];
        if (cornerValue == target) {
            return YES;
        }
        if (cornerValue < target) {
            top++;
        } else {
            right--;
        }
    }
    
    return NO;
}

#pragma mark - 34. Search for a Range.

-(NSArray*) searchRange:(NSArray*) array
                 target:(NSInteger) target {
    
    NSInteger left = 0, right = array.count - 1;
    NSMutableArray* result = [@[@-1, @-1] mutableCopy];
    
    while (left < right) {
        NSInteger mid = left + (right - left) / 2;
        if ([array[mid] integerValue] < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    
    if ([array[left] integerValue] != target) {
        return result;
    }
    result[0] = @(left);
    
    while (left < right) {
        NSInteger mid = left + (right - left) / 2 + 1;
        if ([array[mid] integerValue] > target) {
            right = mid - 1;
        } else {
            left = mid;
        }
    }
    
    result[1] = @(right);
    return result;
}

#pragma mark - 33. Search in Rotated Sorted Array 

- (NSInteger) search:(NSArray*) nums
              target:(NSInteger) target {
    NSInteger left = 0, right = nums.count - 1;
    NSInteger mid = -1;
    while (left < right) {
        mid = left + (right - left)/2;
        if ([nums[mid] integerValue] == target) {
            return YES;
        }
        if ([nums[mid] integerValue] <= [nums[right] integerValue] && target > [nums[mid] integerValue]) {
            left = mid;
        } else {
            right = mid;
        }
    }
    return NO;
}



@end


int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        BinarySearch* bs = [BinarySearch new];
        NSLog(@"###### find min %@", [bs findMin:@[@6, @7, @0, @1, @2, @3, @4, @5]]);
        NSLog(@"###### find min %@", [bs findMin:@[@1, @2]]);
        NSLog(@"###### find min %@", [bs findMin:@[@2, @1]]);
        
        NSArray<NSArray*>* matrix = @[
                                     @[@1,   @3,  @5,  @7],
                                     @[@10, @11, @16, @20],
                                     @[@23, @30, @34, @50]
                                     ];
        NSLog(@"##### search matrix = %d", [bs searchMatrix:matrix target:17]);
        NSLog(@"##### binary search = %ld", (long)[bs search:@[@4, @5, @6, @7, @0, @1, @2] target:2]);
    }
    
    return 0;
}



