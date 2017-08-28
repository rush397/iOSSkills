//
//  block_test3.c
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#include <stdio.h>

int main() {
    __block int a = 100;
    void (^block2)(void) = ^{
        printf("%d\n", a);
        a = 200;
    };
    block2();
    return 0;
}
