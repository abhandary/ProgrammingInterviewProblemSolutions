//
//  ABCache.m
//  ABCache
//
//  Created by Akshay Bhandary on 4/21/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ABCache.h"
#import "ABCacheItem.h"

@interface ABCache ()

@property (nonatomic, strong) NSMutableArray*      items;
@property (nonatomic, strong) NSMutableDictionary* itemsLookup;
@property (nonatomic, strong) dispatch_queue_t     queue;
@end


@implementation ABCache

@synthesize countLimit=_countLimit;

#pragma mark - Creating a Cache


- (instancetype) init
{
    if (self = [super init])
    {
        NSString* queueName = [NSString stringWithFormat:@"om.ABQueue.%p", self];
        self.queue = dispatch_queue_create(queueName.UTF8String, DISPATCH_QUEUE_SERIAL);
        self.items = [NSMutableArray array];
        self.itemsLookup = [NSMutableDictionary dictionary];
    }
    return self;
}

+(instancetype) cache
{
    ABCache* cache = [[ABCache alloc] init];
    cache.evictionPolicyBlock = [self lastItemEvictionBlock];
    return cache;
}

+(instancetype) cacheWithEvictionPolicyBlock:(EvictionPolicyBlockType) evictionPolicyBlock
{
    ABCache* cache = [[ABCache alloc] init];
    cache.evictionPolicyBlock = evictionPolicyBlock;
    return cache;
}

+ (EvictionPolicyBlockType) lastItemEvictionBlock
{
    EvictionPolicyBlockType block = ^(NSMutableArray<ABCacheItem*>* itemsToEvict,
                                      ABCacheItem* item,
                                      NSUInteger idx,
                                      NSUInteger count,
                                      BOOL* stop)
    {
        if (idx == count - 1)
        {
            *stop = YES;
            [itemsToEvict addObject:item];
        }
    };
    return block;
}

#pragma mark - Managing Cache Size

- (NSUInteger) totalCost
{
    __block NSUInteger cost = 0;
    
    dispatch_sync(self.queue, ^{
        cost = [self internalTotalCost];
    });
    
    return cost;
    
}

-(NSUInteger) count {
    
    __block NSUInteger count = 0;
    
    dispatch_sync(self.queue, ^{
        count = self.items.count;
    });
    
    return count;
}

- (void) setCountLimit:(NSUInteger)countLimit
{
    dispatch_sync(self.queue, ^{
        _countLimit = countLimit;
        [self checkLimitsAndEvictIfNeeded];
    });
}

- (NSUInteger) countLimit
{
    __block NSUInteger count = 0;
    dispatch_sync(self.queue, ^{
        count = _countLimit;
    });
    return count;
}

#pragma mark - Getting a Cached Value

- (id) objectForKey:(id) key
{
    __block ABCacheItem* item = nil;
    dispatch_sync(self.queue,^{
        item = self.itemsLookup[key];
    });
    return item.object; // handles item is nil case gracefully
        
}

#pragma mark - Adding and Removing Cached Values

- (void)setObject:(id) obj
           forKey:(id) key
{
    [self setObject:obj forKey:key cost:0];
}

- (void)setObject:(id)        obj
           forKey:(id)        key
             cost:(NSUInteger)cost
{
    dispatch_async(self.queue,^{
        // remove the item if it's already in the cache
        [self internalRemoveObjectForKey:key];
        
        // add the item to the front of the cache
        [self internalPrependObject:obj forKey:key cost:cost];
        
        // check if the cost or count limits have been exceeded and evict to bring within limits
        [self checkLimitsAndEvictIfNeeded];
    });  
}

- (void)removeObjectForKey:(id) key
{
    dispatch_async(self.queue,^{
        [self internalRemoveObjectForKey:key];
    });
}

- (void) removeAllObjects {
    dispatch_async(self.queue,^{
        [self.itemsLookup removeAllObjects];
        [self.items removeAllObjects];
    });
}

#pragma mark - Add and Remove Internal Routines

//-- All internal routines are called from within a dispatch block and don't need
//-- further synchonization


- (void) internalRemoveObjectForKey:(id) key
{
    ABCacheItem* item = self.itemsLookup[key];
    if (item != nil) {
        [self.items removeObject:item];
        [self.itemsLookup removeObjectForKey:key];
    }
}

- (void) internalRemoveObjectsInArray:(NSArray<ABCacheItem*>*) cacheItems
{
    NSMutableArray* keys = [NSMutableArray array];
    [cacheItems enumerateObjectsUsingBlock:^(ABCacheItem* item, NSUInteger idx, BOOL* stop) {
        [keys addObject:item.cacheKey];
    }];
    [self.items removeObjectsInArray:cacheItems];
    [self.itemsLookup removeObjectsForKeys:keys];
}


- (void) internalPrependObject:(id)         obj
                        forKey:(id)         key
                          cost:(NSUInteger) cost
{
    ABCacheItem* item = [ABCacheItem cacheItemWithObject:obj cacheKey:key cost:cost];
    self.itemsLookup[key] = item;
    [self.items insertObject:item atIndex:0];
}


- (void) checkLimitsAndEvictIfNeeded
{
    while (([self internalCountLimit] > 0 && [self.items count] > [self internalCountLimit]) ||
           (self.totalCostLimit > 0 && [self internalTotalCost] > self.totalCostLimit))
    {
        NSUInteger initialCount = self.items.count;
        NSMutableArray* itemsToEvict = [NSMutableArray array];
        
        BOOL stop = NO;
        for (NSInteger ix = self.items.count - 1; stop == NO && ix >= 0; ix--)
        {
            self.evictionPolicyBlock(itemsToEvict, self.items[ix], ix, self.items.count, &stop);
        }
        [self internalRemoveObjectsInArray:itemsToEvict];
        
        // eviction policy didn't remove any elements, limits won't apply
        if (self.items.count == initialCount)
        {
            break;
        }
    }
}


- (NSUInteger) internalCountLimit
{
    return _countLimit;
}

- (NSUInteger) internalTotalCost
{
    __block NSUInteger cost = 0;
    [self.items enumerateObjectsUsingBlock:^(ABCacheItem* item, NSUInteger idx, BOOL* stop) {
        cost += item.cost;
    }];
    return cost;
}

@end

