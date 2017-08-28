//
//  RSObjCSyntaxTest.m
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSObjcSyntaxViewController.h"

@interface RSObjCSyntaxTest : XCTestCase

@property (nonatomic, strong) RSBlockSyntaxObject *blockSyntaxObject;

@end


/**
 http://blog.devtang.com/2013/07/28/a-look-inside-blocks/
 http://ios.jobbole.com/85172/
 https://juejin.im/entry/588075132f301e00697f18e0
 https://onevcat.com/2011/11/objc-block/
 
 http://www.imlifengfeng.com/blog/?p=147
 */
@implementation RSObjCSyntaxTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBlock {
    self.blockSyntaxObject = [[RSBlockSyntaxObject alloc] init];
    void(^strongBlock1)(void) = ^{
        NSLog(@"do nothing");
    };
    NSLog(@"strong 未捕获外部变量:");
    NSLog(@"block address %@", strongBlock1);
    self.blockSyntaxObject.strongBlock = strongBlock1;
    [self.blockSyntaxObject excuteStrongBlock];
    NSLog(@"--------------------");
    
    __block NSInteger value = 10;
    void(^strongBlock2)(void) = ^{
        value++;
        NSLog(@"value == %@", @(value));
    };
    NSLog(@"strong 捕获外部变量:");
    NSLog(@"block address %@", strongBlock2);
    self.blockSyntaxObject.strongBlock = strongBlock2;
    [self.blockSyntaxObject excuteStrongBlock];
    NSLog(@"--------------------");
    
    
    void(^copyBlock1)(void) = ^{
        NSLog(@"do nothing");
    };
    NSLog(@"copy 未捕获外部变量:");
    NSLog(@"block address %@", copyBlock1);
    self.blockSyntaxObject.copyBlock = copyBlock1;
    [self.blockSyntaxObject excuteCopyBlock];
    NSLog(@"--------------------");
    
    __block NSInteger value2 = 10;
    void(^copyBlock2)(void) = ^{
        value2++;
        NSLog(@"value == %@", @(value2));
    };
    NSLog(@"copy 捕获外部变量:");
    NSLog(@"block address %@", copyBlock2);
    self.blockSyntaxObject.copyBlock = copyBlock2;
    [self.blockSyntaxObject excuteCopyBlock];
    NSLog(@"--------------------");
    
    __weak RSObjCSyntaxTest *wself = self;
    NSLog(@"self 1 == %p", self);
    void(^copyBlock3)(void) = ^{
        NSLog(@"wself 2 == %p", wself);
    };
    NSLog(@"wself 3 == %p", wself);
    self.blockSyntaxObject.copyBlock = copyBlock3;
    [self.blockSyntaxObject excuteCopyBlock];
    NSLog(@"--------------------");
}

- (void)testBlockCapture {
    __block int a = 100;
    printf("1: %p\n", &a);
    void (^block2)(void) = ^{
        a = 80;
        printf("2: %p\n", &a);
        printf("%d\n", a);
    };
    block2();
    printf("3: %p\n", &a);
    printf("%d\n", a);
}

- (void)testBlockCapture2 {
    NSInteger a = 100;
    NSInteger (^block2)(void) = ^NSInteger{
        return a * 2;
    };
    a = 80;
    block2();
    // 200
    NSLog(@"%@", @(block2()));
}

- (void)testBlockCapture3 {
    __block NSInteger a = 100;
    NSInteger (^block2)(void) = ^NSInteger{
        return a * 2;
    };
    a = 80;
    block2();
    // 160
    NSLog(@"%@", @(block2()));
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
