//
//  ABCacheItem.h
//
//  Created by Akshay Bhandary on 4/21/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

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
