//
//  HashTable.m
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HashTable : NSObject

- (BOOL) wordPattern:(NSString*) pattern
                 str:(NSString*) str;

- (NSArray*) intersection: (NSArray*) nums1
                    nums2: (NSArray*) num2;

- (NSArray*) topKFrequent:(NSArray*) nums
                        k:(NSInteger) k;

@end


@implementation HashTable

- (BOOL) wordPattern:(NSString*) pattern
                 str:(NSString*) str {
    
    NSMutableDictionary* lookup = [@{} mutableCopy];
    NSMutableDictionary* rlookup = [NSMutableDictionary dictionary];
    
    NSArray* words = [str componentsSeparatedByString:@" "];
    
    for (int ix = 0; ix < [pattern length]; ix++) {
        char current = [pattern characterAtIndex:ix];
        if (lookup[@(current)] != nil && ![lookup[@(current)] isEqualToString:words[ix]]) {
            return NO;
        }
        if (rlookup[words[ix]] != nil && ![rlookup[words[ix]] isEqual:@(current)]) {
            return NO;
        }
        lookup[@(current)] = words[ix];
        rlookup[words[ix]] = @(current);
    }
    return YES;
}

- (NSArray*) intersection: (NSArray*) nums1
                    nums2: (NSArray*) nums2 {
    
    NSMutableSet * set = [NSMutableSet setWithArray:nums1];
    NSMutableSet * set2 = [NSMutableSet set];
    
    [nums2 enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([set containsObject:obj]) {
            [set2 addObject:obj];
        }
    }];
    return [set2 allObjects];
}

- (NSArray*) topKFrequent:(NSArray*) nums
                        k:(NSInteger) k {
    
    NSMutableDictionary* frequency = [NSMutableDictionary dictionary];
    
    for (NSNumber* num in nums) {
        frequency[num] = @([frequency[num] integerValue] + 1);
    }
    
    NSMutableArray* bucket = [NSMutableArray array];
    for (int ix = 0; ix < nums.count + 1; ix++) {
        [bucket addObject:@(-1)];
    }
    
    NSArray* keys = [frequency allKeys];
    for (NSNumber* key in keys) {
        NSNumber* freq = frequency[key];
        bucket[[freq integerValue]] = key;
    }
    
    NSMutableArray* mostFrequent = [NSMutableArray array];
    for (int ix = bucket.count - 1; ix >= 0 && mostFrequent.count < k; ix--) {
        if (![bucket[ix] isEqualTo:@(-1)]) {
            [mostFrequent addObject:bucket[ix]];
        }
    }
    return mostFrequent;
}

@end


#if 0
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        
        HashTable* ht = [HashTable new];
        NSLog(@"#### %d", [ht wordPattern:@"abba" str:@"dog cat cat dog"]);
        NSLog(@"#### %d", [ht wordPattern:@"abba" str:@"dog cat cat fish"]);
        NSLog(@"#### %d", [ht wordPattern:@"aaaa" str:@"dog cat cat dog"]);
        NSLog(@"#### %d", [ht wordPattern:@"abba" str:@"dog dog dog dog"]);
        
        NSLog(@"#### intersection = %@", [ht intersection:@[@1, @2, @2, @1] nums2:@[@2, @2]]);
        
        NSLog(@"##### top k frequent = %@", [ht topKFrequent:@[@1, @1, @1, @2, @2, @3] k:2]);
        
        NSLog(@"Hello, World!");
    }
    return 0;
}
#endif
