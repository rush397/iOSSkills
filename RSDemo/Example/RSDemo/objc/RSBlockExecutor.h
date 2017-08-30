//
//  RSBlockExecutor.h
//  RSDemo
//
//  Created by mac on 17/8/30.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <Foundation/Foundation.h>

// 参考 https://github.com/ChenYilong/CYLDeallocBlockExecutor
@interface RSBlockExecutor : NSObject

- (instancetype)initWithBlock:(void(^)(void))block;

@end


@interface NSObject (RunAtDealloc)

- (void)rs_runAtDealloc:(void(^)(void))block;

@end
