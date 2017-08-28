//
//  RSThreadSafeDictionary.m
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSThreadSafeDictionary.h"

@implementation RSThreadSafeDictionary

- (id)init
{
    self = [super init];
    if (self) {
        _dict = [NSMutableDictionary dictionary];
        _concurrent_queue = dispatch_queue_create("com.thread_safe_queue.rs", DISPATCH_QUEUE_CONCURRENT);
    }
    return self;
}

- (void)objectForKey:(id)aKey block:(RSThreadSafeDictionaryBlock)block {
    id key = [aKey copy];
    __weak __typeof__(self) weakSelf = self;
    dispatch_async(self.concurrent_queue, ^{
        __strong __typeof__(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return ;
        }
        id object = [strongSelf.dict objectForKey:key];
        block(strongSelf, key, object);
    });
}

- (void)setObject:(id)anObject forKey:(id)aKey block:(RSThreadSafeDictionaryBlock)block {
    id key = [aKey copy];
    __weak __typeof__(self) weakSelf = self;
    dispatch_barrier_async(self.concurrent_queue, ^{
        __strong __typeof__(self) strongSelf = weakSelf;
        if (!strongSelf) {
            return ;
        }
        [strongSelf.dict setObject:anObject forKey:key];
        block(strongSelf, key, anObject);
    });
}

@end
