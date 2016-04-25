//
//  ABCacheItem.h
//
//  Created by Akshay Bhandary on 4/21/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
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
//  OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

#ifndef ABCacheItem_h
#define ABCacheItem_h



/** ABCacheItem

    Wraps the object, cache key and cost of each cache item
 */

@interface ABCacheItem : NSObject



///----------------------------
/// @name Create a Cache Item
///----------------------------

/**
 
 Creates and returns a cacheItem as associates it with the passed in object and key
 
 @param obj Object that will be wrapped into this cache item.
 @param cacheKey A unique string identifying the passed in value.
 
 @return The cache item
 
 */
+(instancetype) cacheItemWithObject:(id) obj cacheKey:(NSString*) cacheKey;

/**
 
 Creates and returns a cacheItem as associates it with the passed in object, key and cost

 @param obj Object that will be wrapped into this cache item.
 @param cacheKey A unique string identifying the passed in value.
 @param cost cost associated with this cache item, this value can be zero.
 
 @return The cache item
 
 */
+(instancetype) cacheItemWithObject:(id) obj cacheKey:(NSString*) cacheKey cost:(NSUInteger) cost;


///----------------------------
/// @name Cache Item Properties
///----------------------------


/**
 A string that uniquely identifies the cache item.
 */
@property (readonly, strong) id cacheKey;

/**
 Returns the object that is associated with this cache item
 */
@property (readonly, strong) id object;

/**
 Returns the cost that is associated with this cache item
 */
@property (readonly) NSUInteger cost;



@end



#endif /* CacheItem_h */
