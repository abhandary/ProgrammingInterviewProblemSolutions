//
//  ABCacheMacOSTests.m
//  ABCacheMacOSTests
//
//  Created by Akshay Bhandary on 4/22/16.
//  Copyright © 2016 Akshay Bhandary. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ABCache.h"

@interface ABCacheMacOSTests : XCTestCase

@property (nonatomic, strong) NSMutableArray* images;
@property (nonatomic, strong) NSMutableArray* imageNames;

@end

@implementation ABCacheMacOSTests

- (void) loadImages
{
    self.images      = [NSMutableArray array];
    self.imageNames  = [NSMutableArray array];
    
    for (int ix = 1; ix <= 10; ix++)
    {
        NSString* imgFile = [NSString stringWithFormat:@"%d.jpg", ix];
        NSString* path =  [[NSBundle mainBundle] pathForImageResource:imgFile];
        NSData* img = [NSData dataWithContentsOfFile:path];
        [self.images addObject:img];
        [self.imageNames addObject:imgFile];
    }
}

- (void)setUp {
    [super setUp];
    [self loadImages];
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void) runCommonTestsForCache:(ABCache*) cache
{
    // Insert
    for (int ix = 0; ix < self.images.count; ix++) {
        NSData* img = self.images[ix];
        NSLog(@"Inserting object <%@ => %p> of size %lu", self.imageNames[ix], img, (unsigned long)[img length]);
        [cache setObject:self.images[ix] forKey:self.imageNames[ix] cost:[img length]];
    }
    
    
    // Retrieve
    for (int ix = 0; ix < self.imageNames.count; ix++) {
        NSData* img = [cache objectForKey:self.imageNames[ix]];
        if (img)
        {
            NSLog(@"Retrieved object <%@ => %p> of size %lu", self.imageNames[ix], img, (unsigned long)[img length]);
        }
        else
        {
            NSAssert(cache.countLimit > 0 || cache.totalCostLimit > 0, @"Didn't find an image that was inserted earlier");
            
            // this is only legit if there are count or cost limts on the cache
            NSLog(@"Unable to find object for key %@", self.imageNames[ix]);
        }
    }
    
    
    // assert count is within count limit if applicable
    if (cache.countLimit > 0)
    {
        NSString* msg = [NSString stringWithFormat:@"cache count [%lu]  is not within count limit [%lu]", (unsigned long)cache.count, (unsigned long)cache.countLimit];
        NSAssert(cache.count <= cache.countLimit, msg);
    }
    
    // assert cost is within cost limit if applicable
    if (cache.totalCostLimit > 0)
    {
        NSString* msg = [NSString stringWithFormat:@"cache cost [%lu] is not within cost limit [%lu]", (unsigned long)cache.totalCost, (unsigned long)cache.totalCostLimit];
        NSAssert(cache.totalCost <= cache.totalCostLimit, msg);
    }
    if (cache.countLimit == 0 && cache.totalCostLimit == 0)
    {
        NSString* msg = [NSString stringWithFormat:@"cache count [%lu] is less than expected [%lu]", (unsigned long)cache.count, (unsigned long)self.imageNames.count];
        NSAssert([cache count] == self.imageNames.count, msg);
    }
    
    NSLog(@"Cache count prior to removal %lu", (unsigned long)[cache count]);
    
    // Remove some items
    for (int ix = 0; ix < self.imageNames.count; ix+=2) {
        [cache removeObjectForKey:self.imageNames[ix]];
    }
    NSLog(@"Cache count after removal of some objects %lu", (unsigned long)[cache count]);
    
    // Remove all items
    [cache removeAllObjects];
    NSLog(@"Cache count after removal of all objects %lu", (unsigned long)[cache count]);
    
    NSAssert(cache.count == 0, @"Cache count not zero after removal of all elements");
}


- (void)testWithNoLimits
{
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];
    
    [self runCommonTestsForCache:cache];
}


- (void)testWithCountLimit
{
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];
    
    cache.countLimit = 5;
    
    [self runCommonTestsForCache:cache];
}

- (void)testWithCostLimit
{
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];
    
    cache.totalCostLimit = 1000 * 1024; // 1000 kb
    
    [self runCommonTestsForCache:cache];
}


- (void)testWithCostAndCountLimit
{
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];
    
    cache.totalCostLimit = 1000 * 1024; // 1000 kb
    cache.countLimit = 5;
    
    [self runCommonTestsForCache:cache];
}

+ (EvictionPolicyBlockType) highCostItemEvictionBlock
{

    EvictionPolicyBlockType block = ^(NSMutableArray<ABCacheItem*>* itemsToEvict,
                                      ABCacheItem* item,
                                      NSUInteger idx,
                                      NSUInteger count,
                                      BOOL* stop)
    {
        if (itemsToEvict.count == 0)
        {
            [itemsToEvict addObject:item];
        }
        else
        {
            ABCacheItem* currentItem = [itemsToEvict firstObject];
            if (item.cost > currentItem.cost)
            {
                [itemsToEvict replaceObjectAtIndex:0 withObject:item];
            }
        }
    };
    return block;
}

- (void)testWithCustomEvictionPolicy
{
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];

    cache.countLimit = 5;
    cache.evictionPolicyBlock = [self.class highCostItemEvictionBlock];
    
    
    [self runCommonTestsForCache:cache];
}


- (void) testWithMovingItems
{
    
    NSLog(@"======= %s =======", __PRETTY_FUNCTION__);
    ABCache<NSString*, NSData*>* cache = [ABCache cache];
    
    // Insert 10 items
    for (int ix = 0; ix < self.images.count; ix++) {
        NSData* img = self.images[ix];
        NSLog(@"Inserting object <%@ => %p> of size %lu", self.imageNames[ix], img, (unsigned long)[img length]);
        [cache setObject:self.images[ix] forKey:self.imageNames[ix] cost:[img length]];
    }

    // Touch two items in the index range <4..9> and move them forward
    int idx1 = 7;
    int idx2 = 9;
    
    // touch the first two items to move them to the front
    [cache setObject:self.images[idx1] forKey:self.imageNames[idx1] cost:[self.images[idx1] length]];
    [cache setObject:self.images[idx2] forKey:self.imageNames[idx2] cost:[self.images[idx2] length]];
    
    // Set count limit
    cache.countLimit = 5;
    
    // Retrieve
    for (int ix = 0; ix < self.imageNames.count; ix++) {
        NSData* img = [cache objectForKey:self.imageNames[ix]];
        if (img)
        {
            NSLog(@"Retrieved object <%@ => %p> of size %lu", self.imageNames[ix], img, (unsigned long)[img length]);
        }
        else
        {
            NSAssert(cache.countLimit > 0 || cache.totalCostLimit > 0, @"Didn't find an image that was inserted earlier");
            
            // this is only legit if there are count or cost limts on the cache
            NSLog(@"Unable to find object for key %@", self.imageNames[ix]);
        }
    }
    
    // Make sure the two touched items are still there
    NSAssert([cache objectForKey:self.imageNames[idx1]] != nil, @"touched object was evicted");
    NSAssert([cache objectForKey:self.imageNames[idx2]] != nil, @"touched object was evicted");

    NSString* msg = [NSString stringWithFormat:@"cache count [%lu]  is not within count limit [%lu]", (unsigned long)cache.count, (unsigned long)cache.countLimit];
    NSAssert(cache.count <= cache.countLimit, msg);
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
