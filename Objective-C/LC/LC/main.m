//
//  main.m
//  LC
//
//  Created by Akshay Bhandary on 6/14/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Solution : NSObject

#pragma mark - 345. Reverse Vowels of a String

- (NSString*) reverseVowels:(NSString*) s;

@end

@implementation Solution


- (NSArray*) intersection:(NSArray<NSNumber*>*) nums1
                    nums2:(NSArray<NSNumber*>*) nums2
{
    NSSet* set1 = [NSSet setWithArray:nums1];
    NSSet* set2 = [NSSet setWithArray:nums2];
 
    NSMutableArray* result = [@[] mutableCopy];
    for (NSNumber* n in set1)
    {
        if ([set2 containsObject:n])
        {
            [result addObject:n];
        }
    }
    return result;
}

#pragma mark - 345. Reverse Vowels of a String
- (BOOL) isVowel:(char) c
{
    NSString* str = [NSString stringWithFormat:@"%c", c];
    return [@"aeiouAEIOU" containsString:str];
}

- (NSString*) reverseVowels:(NSString*) s
{
    unsigned long left = 0, right = s.length - 1;
    unichar* chars = malloc((s.length + 1) * sizeof(unichar));
    [s getCharacters:chars];
    
    while (left < right)
    {
        if (![self isVowel:[s characterAtIndex:left]]) {
            left++; continue;
        }
        if (![self isVowel:[s characterAtIndex:right]]) {
            right--; continue;
        }
        char temp = chars[left];
        chars[left] = chars[right];
        chars[right] = temp;
        left++, right--;
    }
    return [NSString stringWithCharacters:chars length:s.length];
}

- (NSString*) reverseString:(NSString*) s {
    unsigned long left = 0, right = s.length - 1;
    unichar* result = malloc((s.length + 1) * sizeof(unichar));
    
    while (left < right) {
        
    }
    return [NSString stringWithCharacters:result length:s.length];
}

@end


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        Solution* s = [Solution new];
        NSLog(@"###### %@", [s reverseVowels:@"hello"]);
    }
    return 0;
}
