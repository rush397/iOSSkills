//
//  RSUnrecognizedSelectorObject.m
//  RSDemo
//
//  Created by mac on 17/8/31.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSUnrecognizedSelectorObject.h"

@implementation RSUnrecognizedSelectorObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self performSelector:@selector(unrecognizedMethod) withObject:nil];
    }
    return self;
}

+ (BOOL)resolveInstanceMethod:(SEL)sel {
    BOOL result = [super resolveInstanceMethod:sel];
    return result;
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id target = [super forwardingTargetForSelector:aSelector];
    return target;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    NSMethodSignature *signature = [super methodSignatureForSelector:aSelector];
    return signature;
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    return [super forwardInvocation:anInvocation];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    return [super doesNotRecognizeSelector:aSelector];
}

//- (void)unrecognizedMethod {
//    NSLog(@"unrecognizedMethod impl");
//}

@end
