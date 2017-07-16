//
//  Strings.m
//  LC
//
//  Created by Akshay Bhandary on 7/9/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Strings : NSObject

- (NSString*) reverseVowels:(NSString*) s;

@end

@implementation Strings

#pragma mark - 345. Reverse Vowels of a String


- (BOOL) isVowel:(unichar) c {
    NSString* s = [NSString stringWithFormat:@"%c", c];
    return [@"aeiou" containsString:s] || [@"AEIOU" containsString:s];
}

- (NSString*) reverseVowels:(NSString*) s
{
    NSMutableString* result = [s mutableCopy];
    unichar* buffer = malloc(s.length * sizeof(unichar));
    [s getCharacters:buffer];
    
    int left = 0, right = s.length - 1;
    while (left < right) {
        while (![self isVowel:buffer[left]]) {
            left++;
        }
        while (![self isVowel:buffer[right]]) {
            right--;
        }
        if (left < right) {
            char temp = buffer[left];
            buffer[left] = buffer[right];
            buffer[right] = temp;
            left++, right--;
        }
    }
    return [NSString stringWithCharacters:buffer length:s.length];
}

#pragma mark - 38. Count and Say

- (NSString*) countAndSayHelper:(NSString*) s {
    
    int count = 1;
    NSMutableString* result = [NSMutableString string];
    
    char lastSeen = [s characterAtIndex:0];
    for (int ix = 1; ix < s.length; ix++) {

        if ([s characterAtIndex:ix] == lastSeen) {
            count++;
        } else {
            [result appendFormat:@"%d%c", count, lastSeen];
            count = 1;
        }
        lastSeen = [s characterAtIndex:ix];
    }
    
    [result appendFormat:@"%d%c", count, lastSeen];
    return result;
}

- (NSString*) countAndSay:(NSInteger) val {
    NSString* result = @"1";
    for (int ix = 1; ix < val; ix++) {
        result = [self countAndSayHelper:result];
    }
    return  result;
}

#pragma mark - 171. Excel Sheet Column Number
- (NSInteger) titleToColumnNumber:(NSString*) title {
    int col = 0;

    for (int ix = 0; ix < title.length; ix++) {
        col *= 26;
        col += [title characterAtIndex:ix] - 'A' + 1;
    }
    return col;
}

#pragma mark - 168. Excel Sheet Column Title
- (NSString*) convertToTitle:(int) number {
    
    NSMutableString* result = [NSMutableString string];
    while (number) {
        number--;
        [result appendFormat:@"%c", 'A' + (number % 26)];
        number /= 26;
    }
    
    // return the reversed string
    return result;
}

@end

#if 0
int main(int argc, const char * argv[])
{
    @autoreleasepool
    {
        // insert code here...
        NSLog(@"Hello, Strings!");
        Strings* strings = [Strings new];
        NSLog(@"####### reverse vowels = %@", [strings reverseVowels:@"hello"]);
        NSLog(@"####### count and say = %@", [strings countAndSay:5]);
        NSLog(@"####### title to column number = %d", [strings titleToColumnNumber:@"Z"]);
        NSLog(@"####### convert to title = %@", [strings convertToTitle:29]);
        }
    return 0;
}

#endif