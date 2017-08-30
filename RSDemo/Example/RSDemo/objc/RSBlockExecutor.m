//
//  RSBlockExecutor.m
//  RSDemo
//
//  Created by mac on 17/8/30.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSBlockExecutor.h"
#import <objc/runtime.h>

const void *RSRunAtDeallocKey = &RSRunAtDeallocKey;

@interface RSBlockExecutor()

@property (nonatomic, copy) void(^block)(void);

@end

@implementation RSBlockExecutor

- (instancetype)initWithBlock:(void(^)(void))block
{
    self = [super init];
    if (self) {
        _block = [block copy];
    }
    return self;
}

- (void)dealloc
{
    _block ? _block() : nil;
}

@end


@implementation NSObject (RunAtDealloc)

- (void)rs_runAtDealloc:(void(^)(void))block
{
    if (block) {
        RSBlockExecutor *executor = [[RSBlockExecutor alloc] initWithBlock:block];
        objc_setAssociatedObject(self, RSRunAtDeallocKey, executor, OBJC_ASSOCIATION_RETAIN);
    }
}

@end
