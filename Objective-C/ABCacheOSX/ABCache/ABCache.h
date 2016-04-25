//
//  ABCache.h
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

#ifndef ABCache_h
#define ABCache_h

#import <Foundation/Foundation.h>

#import "ABCacheItem.h"

/**  EvictionPolicyBlockType
 
 *  Can be used to create blocks that can then to passed as an eviction policy
 */

typedef void (^ EvictionPolicyBlockType)(NSMutableArray<ABCacheItem*>* itemsToEvict, ABCacheItem* item, NSUInteger idx, NSUInteger count, BOOL* stop);


/**  ABCache
 
  * The cache internally uses an array to maintain an order on the stored cache items
    and a hashtable to enable fast look ups.
  * The cache items in the array are ordered based on LRU times with most 
    recently used at the start and least recently used at the end.
  * The eviction policy defaults to an LRU eviction, however it is customizable.
  */

@interface ABCache<KeyType, ObjectType> : NSObject


///-------------------------
/// @name Creating a Cache
///-------------------------


/**
 Creates and returns a cache that uses the default eviction policy
 
 @return A cache object
 */
+(instancetype) cache;

/**
 Creates and returns a cache that uses the specified eviction policy.
 
 @param evictionPolicyBlock The block is invoked for each item in the cache, add the items that need to be evicted into the itemsToEvict array.
 Items are iterated in reverse order of index, starting from count - 1 and going down to 0. Use the stop parameter. Look at EvictionPolicyBlockType definition for more information on this block type.
 
 @return A cache object
 */
+(instancetype) cacheWithEvictionPolicyBlock:(EvictionPolicyBlockType) evictionPolicyBlock;



///--------------------------------
/// @name Modifying the Cache Name
///--------------------------------


/**
 The name of the Cache
 
 @discussion The empty string if no name is specified.
 */
@property (copy) NSString *name;



///-------------------------------
/// @name Getting a Cached Value
///-------------------------------

/**
 
 Returns the value associated with a given key.
 
 @param key An object identifying the value.
 
 @return The value associated with key, or nil if no value is associated with key.
 
 */
- (ObjectType) objectForKey:(KeyType) key;


///-----------------------------------------
/// @name Adding and Removing Cached Values
///-----------------------------------------

/**
 
 Sets the value of the specified key in the cache.
 
 @param obj The object to be stored in the cache.
 @param key The key with which to associate the value.
 
 */
- (void)setObject:(ObjectType) obj
           forKey:(KeyType)    key;

/**
 
 Sets the value of the specified key in the cache.
 
 @param obj The object to be stored in the cache.
 @param key The key with which to associate the value.
 @param cost The cost with which to associate the key-value pair.
 
 */
- (void)setObject:(ObjectType) obj
           forKey:(KeyType)    key
             cost:(NSUInteger) cost;

/**
 
 Removes the value of the specified key in the cache.
 
 @param key The key identifying the value to be removed.
 
 */
- (void)removeObjectForKey:(KeyType) key;


/**
 
 Empties the cache.
 
 */
- (void) removeAllObjects;


///---------------------------
/// @name Managing Cache Size
///---------------------------

/**
 
 The count of the number of items in the cache
 
 */
@property (readonly) NSUInteger count;

/**
 
 The cost of all the items in the cache
 
 */
@property (readonly) NSUInteger totalCost;

/**
 The eviction policy to use with the cache.
 
 @param itemsToEvict Items added to this array will be evicted once the block completes
 @param item The current cache item
 @param idx  The index of the current item in the ordered array that stores the cache items
 @param count The total count of the items in the cache
 @param stop  A reference to a Boolean value. The block can set the value to YES to stop further processing of the array. The stop argument is an out-only argument. You should only ever set this Boolean to YES within the block

 @discussion The default block removes the last item from the cache
 */
@property (nonatomic, copy) EvictionPolicyBlockType evictionPolicyBlock;

/**
 The maximum number of objects the cache should hold.
 
 @discussion The default value is 0, which means no limit.
 If the cache goes over the limit, objects in the cache are evicted using the
 eviction policy until the number of items are within the limit.
 
 If the eviction policy does not remove items from the cache then this property
 won't be able to limit the total count of the cache
 */
@property (nonatomic, assign) NSUInteger countLimit;

/**
 The maximum total cost that the cache can hold before it starts evicting objects.
 
 @discussion The default value is 0, which indicates no limit.
 
 When you add an object to the cache, you may pass in a specified cost for the object,
 such as the size in bytes of the object. If adding an object to the cache
 causes the cache’s total cost to go over the totalCostLimit then the cache will
 repeatedly use the eviction policy until its total cost goes below totalCostLimit.
 
 If the eviction policy does not remove items from the cache then this property
 won't be able to limit the cost of the cache
 */
@property (nonatomic, assign) NSUInteger totalCostLimit;

@end



#endif /* Cache_h */
