//
//  RSObjCSyntaxTest.m
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "RSObjcSyntaxViewController.h"
#import <objc/runtime.h>

@interface RSObjCSyntaxTest : XCTestCase

@property (nonatomic, strong) RSBlockSyntaxObject *blockSyntaxObject;

@end


/**
 http://blog.devtang.com/2013/07/28/a-look-inside-blocks/
 http://ios.jobbole.com/85172/
 https://juejin.im/entry/588075132f301e00697f18e0
 https://onevcat.com/2011/11/objc-block/
 
 http://www.imlifengfeng.com/blog/?p=147
 
 clang -rewrite-objc -fobjc-arc -fobjc-runtime=macosx-10.11 RSObjCSyntaxTest.m
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

#pragma mark - block

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

#pragma mark - property

- (void)testPropertyAttributes {
    NSMutableString *text = [NSMutableString stringWithString:@"This is a mutable text"];
    NSMutableArray *array = [@[@"a1", @"a2", @"a3"] mutableCopy];
    NSString *immutableText = @"This is a immutable text";
    NSLog(@"immutable text init %@ : %@", [immutableText class], immutableText);
    NSLog(@"mutable text init %@ : %@", [text class], text);
    NSLog(@"mutable array init %@ : %@", [array class], array);
    NSMutableArray *immutableArray = [array copy];
    NSLog(@"immutable array init %@ : %@", [immutableArray class], immutableArray);
    
    RSPropertySyntaxObject *obj = [[RSPropertySyntaxObject alloc] init];
    obj.strongText = text;
    obj.copyedText = text;
    obj.copyedMutableText = text;
    obj.strongArray = array;
    obj.copyedArray = array;
    obj.copyedMutableArray = array;
    
    [obj print];
    
    NSLog(@"will change text and array......");
    
    text.string = @"This is a new text";
    [array insertObject:@"insert object" atIndex:0];
    
    [obj print];
}

- (void)testCrashWithSomeAttributes {
    RSPropertySyntaxObject *obj = [[RSPropertySyntaxObject alloc] init];
    NSMutableArray *array = [@[@"a1", @"a2", @"a3"] mutableCopy];
    obj.copyedMutableArray = array;
    [obj testArrayCrash];
}

#pragma mark - rumtime

/*
 iOS 底层解析weak的实现原理 - http://www.cocoachina.com/ios/20170328/18962.html
 */

- (void)testPropertyRuntime {
    unsigned int count;
    objc_property_t *properties = class_copyPropertyList([RSPropertySyntaxObject class], &count);
    
    for (int i = 0; i < count; i++) {
        objc_property_t property = properties[i];
//        objc_property_t property = class_getProperty([RSPropertySyntaxObject class], "strongText");
        const char *name = property_getName(property);
        const char *attributes = property_getAttributes(property);
        NSLog(@"name : %@", [NSString stringWithUTF8String:name]);
        NSLog(@"attributes : %@", [NSString stringWithUTF8String:attributes]);
    }
    
    Method *methodes = class_copyMethodList([RSPropertySyntaxObject class], &count);
    for (int i = 0; i < count; i++) {
        Method method = methodes[i];
        SEL methodName = method_getName(method);
        char returnType;
        method_getReturnType(method, &returnType, sizeof(char));
        
        NSLog(@"methodName : %@", NSStringFromSelector(methodName));
        NSLog(@"returnType : %c", returnType);
    }
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
