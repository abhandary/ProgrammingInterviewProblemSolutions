//
//  ABCacheItem.m
//  ABCache
//
//  Created by Akshay Bhandary on 4/21/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//
//
//  The MIT License
//  Copyright (c) 2016 Akshay Bhandary
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and
//  associated documentation files (the "Software"), to deal in the Software without restriction, including
//  without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the
//  following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT
//  LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
//  IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER
//  IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE

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


