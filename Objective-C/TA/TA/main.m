//
//  main.m
//  TA
//
//  Created by Akshay Bhandary on 4/26/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MergeDictionary : NSObject

@end

@implementation MergeDictionary



- (NSDictionary*) mergeCountry1: (NSDictionary*) c1
                       country2:(NSDictionary*) c2 {
    NSMutableDictionary* result = [NSMutableDictionary dictionary];
    
    NSArray* allKeys1 = [c1 allKeys];
    NSArray* allKeys2 = [c2 allKeys];
    NSArray* allKeys = [NSMutableArray arrayWithArray:allKeys1];
    [allKeys appendArray:allKeys2]
    
    for (int ix = 0; ix < allKeys.count; ix++) {
        id key = allKeys[ix];
        id val1 = [c1 objectForKey: allKeys[ix];
                   id val2 = c2[allKeys[ix]];
                   if ([val1 isKindOFClass:[NSNumber class] && [val2 isKindOfClass:[NSNumber class]]) {
            result[key] = val1;
        }
                        else if ([val1 isKindOFClass:[NSDictionary class] && [val2 isKindOFClass:[NSDictionary class])
                                                                              NSDictionary* merged = [self mergeCountry1:val1 country2:val2];
                                                                              result[key] = merged;
                                                                              }
                                                                              else {
                                                                                  //
                                                                                  result[key] = val1;
                                                                              }
                                                                              }
                                                                              return result;
                                                                              }
                                                                              
                                                                              }
                                                                              
                                                                              
@end

#import <Foundation/Foundation.h>

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
    }
    return 0;
}
