//
//  RSIntrinsicLabel.m
//  RSDemo
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSIntrinsicLabel.h"

@implementation RSIntrinsicLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size = CGSizeMake(size.width + 20, size.height + 20);
    return size;
}

@end
