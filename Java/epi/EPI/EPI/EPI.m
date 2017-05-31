//
//  EPI.m
//  EPI
//
//  Created by Akshay Bhandary on 4/2/16.
//  Copyright © 2016 Axa Labs. All rights reserved.
//

#import <Foundation/Foundation.h>


@implementation NSMutableArray (Sorted)

- (void) insertSorted:(id)newObject {
    [self insertObject:newObject betweenLower:0 andUpper:self.count];
}

/**
 * Performs a binary search for the correct insert location
 */
- (void) insertObject:(id)newObject betweenLower:(NSInteger)lower andUpper:(NSInteger)upper {
    if (lower == upper) {
        [self insertObject:newObject atIndex:lower];
    } else {
        NSInteger middle = (upper - lower) / 2 + lower;
        
        NSComparisonResult result = [newObject compare:[self objectAtIndex:middle]];
        if (result == NSOrderedAscending) {
            [self insertObject:newObject betweenLower:lower andUpper:middle];
        } else if (result == NSOrderedSame) {
            [self insertObject:newObject atIndex:middle];
        } else {
            [self insertObject:newObject betweenLower:middle + 1 andUpper:upper];
        }
    }
}

// Useful for NSNumber, NSString, NSDate, NSDecimalNumber
// Implemented for  NSString implements a compare: method that meets the necessary requirements.
// Cocoa also includes appropriate compare: method implementations for the NSDate, NSDecimalNumber, and NSValue classes.

@end



@interface Vertex : NSObject

@property (nonatomic, assign) int value;

@property (nonatomic, strong) NSMutableArray<Vertex*>* vertices;

- (Vertex*) clone;

@end

@implementation Vertex

- (void) cloneHelper:(Vertex*) start
           vertexMap:(NSMutableDictionary*) vertexMap
{
    Vertex* clonedVertex = [Vertex new];
    clonedVertex.value = self.value;
    vertexMap[@((int)start)] = clonedVertex;
    clonedVertex.vertices = [NSMutableArray array];
    
    for (Vertex* vertex in self.vertices) {
        if (vertexMap[@((int)vertex)] == nil) {
            [self cloneHelper:vertex vertexMap:vertexMap];
        }
        [clonedVertex.vertices addObject:vertexMap[vertex]];
    }
}

- (Vertex*) clone {
    NSMutableDictionary<Vertex*, Vertex*>* vertexMap = [NSMutableDictionary dictionary];
    [self cloneHelper:self vertexMap:vertexMap];
    return vertexMap[self];
}

@end


@interface EPI : NSObject

- (void) partition:(NSMutableArray*) A;
- (NSArray*) plusOne:(NSArray*) input;

@end


@implementation EPI




- (void) partition:(NSMutableArray*) A
             pivot:(int) pivot {
    
    int small = 0;
    int equal = 0;
    int larger = [A count] - 1;
    
    while (equal < larger) {
        if (A[pivot] == A[equal]) {
            equal++;
        } else if (A[equal] < A[pivot]) {
      //      swap(A[small++], A[equal++]);
        } else {
       //     swap(A[larger--], A[equal]);
        }
    }
    
}

- (NSArray*) plusOne:(NSArray*) input {
    NSMutableArray* result = [input mutableCopy];
    
    if ([input count] == 0) {
        return result;
    }
    size_t inputLen = [input count];
    
    result[inputLen - 1] = @([result[inputLen - 1] intValue] + 1);
    
    for (size_t ix = inputLen - 1; ix > 0 && [result[ix] intValue] == 10; ix--) {
        result[ix] = @(0);
        result[ix - 1] = @([result[ix - 1] intValue] + 1);
    }
    
    if ([result[0] intValue] == 10) {
        result[0] = @(0);
        [result insertObject:@(1) atIndex:0];
    }
    
    return result;
}


- (void) deleteFromArray:(NSMutableArray*) input
                     key:(int) key {
    int wx = 0;
    for (int ix = 0; ix < [input count]; ix++) {
        if ([input[ix] intValue] != key) {
            input[wx++] = input[ix];
        }
    }

    [input removeObjectsInRange:NSMakeRange(wx, [input count] - wx)];
}


- (BOOL) canWin:(NSArray*) input {
    
    int furtherstReach = 0;
    
    for (int ix = 0; furtherstReach >= ix && furtherstReach < [input count] - 1; ix++) {
        furtherstReach = MAX(furtherstReach, [input[ix] intValue] + ix);
    }
    return furtherstReach >= [input count] - 1;
}

- (void) deleteDuplicates:(NSMutableArray*) input {
    
    int wx = 1;
    for (int ix = 0; ix < [input count]; ix++) {
        if (![input[wx - 1] isEqual:input[ix]]) {
            input[wx++] = input[ix];
        }
    }
    [input removeObjectsInRange:NSMakeRange(wx, [input count] - wx)];
}

- (void) computeMnemonics:(NSString*) input
                  inputIx:(int) ix
                  partial:(NSString*) partial
                  results:(NSMutableArray*) results {
    
    NSDictionary* lookup = @{@"0": @"0", @"1": @"1", @"2" : @"ABC"};
    
    if ([partial length] == [input length]) {
        [results addObject:partial];
        return;
    }
    NSString* current = [NSString stringWithFormat:@"%c", [partial characterAtIndex:ix]];
    
    NSString* mappedStr = lookup[current];
    for (int jx = 0; jx < [mappedStr length]; jx++) {
        NSString* next = [NSString stringWithFormat:@"%@%c", partial, [mappedStr characterAtIndex:jx]];
        [self computeMnemonics:input inputIx:ix + 1 partial:next results:results];
    }
}


- (NSString*) nextString:(NSString*) s {
    NSMutableString* result = [@"" mutableCopy];
    int count = 1;
    int ix = 1;
    for (ix = 1; ix < [s length]; ix++) {
        if ([s characterAtIndex:ix] == [s characterAtIndex:ix - 1]) {
            count++;
        } else {
            [result appendFormat:@"%d%c", count, [s characterAtIndex:ix - 1 ]];
            count = 1;
        }
    }
    [result appendFormat:@"%d%c", count, [s characterAtIndex:ix - 1 ]];
    return result;
}

- (NSString*) lookAndSay:(int) n {
    
    NSString* s = @"1";
    
    for (int ix = 1; ix < n; ix++) {
        s = [self nextString:s];
    }
    return s;
}

- (int) romanToDecimal:(NSString*) roman {
    NSDictionary* lookup = @{@"M": @1000,
                             @"D": @500,
                             @"C" : @100,
                             @"L":@50,
                             @"X":@10,
                             @"V":@5,
                             @"I":@1};
    
    NSString* current = [roman substringWithRange:NSMakeRange([roman length] - 1, 1)];
    int sum = [lookup[current] intValue];
    int lastSeen = sum;
    for (int ix = [roman length] - 2; ix >= 0; ix--) {
        NSString* current = [roman substringWithRange:NSMakeRange(ix, 1)];
        int val = [lookup[current] intValue];
        if (val < lastSeen) {
            sum -= val;
        } else {
            sum += val;
        }
        lastSeen = val;
    }
    
    return sum;
}

- (NSArray*) spiralOrder:(NSArray*) matrix {
    
    int matrixLen = [matrix count];
    NSMutableArray* result = [NSMutableArray array];
    for (int ix = 0; ix < ceil(matrixLen / 2); ix++) {
        for (int jx = ix; jx < matrixLen - ix - 1; jx++) {
            [result addObject:matrix[ix][jx]];
        }
        for (int jx = ix; jx < matrixLen - ix - 1; jx++) {
            [result addObject:matrix[jx][matrixLen - ix - 1]];
        }
        for (int jx = matrixLen - ix - 1; jx > ix; jx--) {
            [result addObject:matrix[matrixLen - ix - 1][jx]];
        }
        for (int jx = matrixLen - ix - 1; jx > ix; jx--) {
            [result addObject:matrix[jx][ix]];
        }
    }
    
    if (matrixLen %2) {
        [result addObject:matrix[matrixLen / 2][matrixLen / 2]];
    }
    
    return result;
}

- (void) common
{
    // NSArray
    NSArray<NSNumber*>* fArray = @[@11, @2, @333];
    [fArray count];                   // size
    [fArray containsObject:@1];       // check if object is present
    [fArray firstObject];             // first object
    [fArray lastObject];              // last object
    id x = fArray[0];                 // ith object
    [fArray arrayByAddingObject:@2];  // return copy + new element
    [fArray arrayByAddingObjectsFromArray:[NSArray array]];   // return copy + another array
    [[fArray reverseObjectEnumerator] allObjects];            // reverse
    NSString* joinedStr = [fArray componentsJoinedByString:@":"];  // form string by joining components, intersperse with separator
    // sort ascending
    NSArray *sortedArray;
    sortedArray = [fArray sortedArrayUsingComparator: ^(NSNumber* num1, NSNumber* num2) {
        return [num1 compare:num2];
    }];
    
    // sort descending
    sortedArray = [fArray sortedArrayUsingComparator: ^(NSNumber* num1, NSNumber* num2) {
        
        NSComparisonResult result = [num1 compare:num2];
        if (result == NSOrderedAscending) {
            return NSOrderedDescending;
        }
        if (result == NSOrderedDescending) {
            return NSOrderedAscending;
        }
        return NSOrderedSame;
    }];
    
    NSLog(@"x = %@", x);
    NSLog(@"sorted = %@", sortedArray);
    
    // NSMutableArray
    NSMutableArray<NSNumber*>* input = [@[@10, @11, @12] mutableCopy];
    [input addObject:@1];                              // add object  - push()
    [input addObjectsFromArray:fArray];                // append
    [input removeLastObject];                          // remove last - pop()
    [input removeAllObjects];                          // clear
    [input removeObjectsInRange:NSMakeRange(0, 0)];    // remove objects in range
    [input insertObject:@2 atIndex:0];                 // insert object at index
    // [input insertObjects:@[@1, @2] atIndexes:[NSIndexSet indexSetWithIndex:2]];           // insert object at indexes
    [input enumerateObjectsUsingBlock:^(NSNumber* value, NSUInteger idx, BOOL* stop) {    // enumerate
        
    }];
    
    // NSString
    NSString* s = @"";
    [s substringFromIndex:2];                          // substring from index
    [s substringToIndex:3];                            // substring to index
    [s substringWithRange:NSMakeRange(0, 3)];          // substring with range
    [s containsString:@""];                            // contains string check
    NSRange range = [s rangeOfString:@"sub string"];   // get range of string
    if (range.location == NSNotFound) {
        NSLog(@"Not found");
    }
    [s hasSuffix:@","];                                // has suffix
    [s hasPrefix:@"prefix"];                           // has prefix
    [s isEqualToString:@"Another String"];             // is equal to string check
    NSArray* chunks = [s componentsSeparatedByString:@" "]; // tokenize
    
    // NSMutableString
    NSMutableString* str = [@"This is immutable" mutableCopy];
    [str appendFormat:@"%@####", @1];                                  // append format
    [str appendString:@""];                                            // append string
    [str deleteCharactersInRange:NSMakeRange(0, 3)];                   // delete characters in range
    [str insertString:@"Test" atIndex:2];                              // insert string at index
    [str replaceCharactersInRange:NSMakeRange(2, 10) withString:@""];  // replace characters in range with string
    [str replaceOccurrencesOfString:@"in" withString:@"out" options:0 range:NSMakeRange(0, 3)];  // replace occurence of string with string
    [str setString:@"new string"];                                     // set string
    NSComparisonResult result = [str compare:@"Another String"];       // compare strings
    NSLog(@" result %ld", (long)result);
    
    // NSDictionary
    NSDictionary<NSString*, NSNumber*>* dict = @{@"Test": @1, @2 : @3};
    id find = dict[@"Find me"];
    NSArray* keys = [dict allKeys];
    for (NSString* key in keys) {                                      // enumerate
        NSNumber* value = dict[key];
        NSLog(@"value = %@", value);
    }
    [dict enumerateKeysAndObjectsUsingBlock:^(NSString* key, NSNumber* value, BOOL* stop) {
        
    }];
    NSLog(@"%@", find);
    
    // NSMutableDictionary
    NSMutableDictionary<NSString*, NSNumber*>* dict2 = [dict mutableCopy];
    dict2[@"value"] = @30;
    
    // NSMutableSet
    NSMutableSet<NSNumber*>* mSet = [NSMutableSet set];
    
    [mSet addObject:@1];          // add object
    [mSet removeObject:@3];       // remove object
    [mSet removeAllObjects];      // remove all objects
    [mSet containsObject:@4];     // contains object check
    
}

@end



int main() {

    EPI* epi = [EPI new];
    
    NSMutableArray* input = [@[@1, @2, @3, @3, @3, @4, @5, @6, @6, @7] mutableCopy];
    
    NSMutableArray* test = [NSMutableArray arrayWithCapacity:10];

    NSArray* matrix = @[@[@1, @ 2, @3], @[@4, @ 5, @6], @[@7, @ 8, @9]];
    
//  NSArray* result = [epi plusOne:input];
//  [epi deleteFromArray:input key:11];
//  [epi deleteDuplicates:input];

    // NSString* result = [epi lookAndSay:4];
    int sum = [epi romanToDecimal:@"MMMMDDLIV"];
    NSLog(@"##### %d", sum);
    

    
    return 0;
}
