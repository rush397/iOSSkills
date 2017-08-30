//
//  RSObjcSyntaxViewController.h
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

//https://opensource.apple.com/source/objc4/
//https://github.com/RetVal/objc-runtime

//clang -x objective-c -rewrite-objc -fobjc-arc -fobjc-runtime=macosx-10.11 -isysroot /Applications/Xcode.app/Contents/Developer/Platforms/iPhoneSimulator.platform/Developer/SDKs/iPhoneSimulator10.2.sdk RSObjcSyntaxViewController.m
@interface RSBlockSyntaxObject : NSObject

@property (nonatomic, strong) void(^strongBlock)(void);
@property (nonatomic, copy) void(^copyBlock)(void);

- (void)excuteStrongBlock;

- (void)excuteCopyBlock;

@end

@interface RSPropertySyntaxObject : NSObject<NSCopying>
{
    NSObject *_obj1;
    NSObject *__obj1;
}

@property (nonatomic, strong) NSObject *obj1;
@property (nonatomic, strong) NSObject *_obj1;

@property (nonatomic, assign) NSInteger intValue;

@property (nonatomic, strong) NSArray *strongArray;
@property (nonatomic, copy) NSArray *copyedArray;
@property (nonatomic, copy) NSMutableArray *copyedMutableArray;
@property (nonatomic, strong) NSString *strongText;
@property (nonatomic, copy) NSString *copyedText;
@property (nonatomic, copy) NSMutableString *copyedMutableText;

- (void)print;
- (void)testArrayCrash;

@end

@interface RSObjcSyntaxViewController : UIViewController

@property (nonatomic, strong) NSArray *items;
@property (nonatomic, weak) id delegate;
@property (nonatomic, assign) NSInteger intValue;
@property (nonatomic, strong) NSString *strongText;
@property (nonatomic, copy) NSString *copyedText;
@property (atomic, strong) NSArray *atomicItems;

@end
