//
//  ABCacheItem.m
//  ABCache
//
//  Created by Akshay Bhandary on 4/21/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>



#import "ABCacheItem.h"


@interface ABCacheItem ()

@property (readwrite, strong)  NSString*  cacheKey;
@property (readwrite, strong)  id         object;
@property (readwrite)          NSUInteger cost;

@end

@implementation ABCacheItem

#pragma - Factory Methods

+(instancetype) cacheItemWithObject:(id) obj cacheKey:(NSString*) cacheKey
{
    ABCacheItem* cacheItem = [[ABCacheItem alloc] init];
    cacheItem.object = obj;
    cacheItem.cacheKey = cacheKey;
    return cacheItem;
}

+(instancetype) cacheItemWithObject:(id) obj cacheKey:(NSString*) cacheKey cost:(NSUInteger) cost
{
    ABCacheItem* cacheItem = [ABCacheItem cacheItemWithObject:obj cacheKey:cacheKey];
    cacheItem.cost = cost;
    return cacheItem;
}



@end


