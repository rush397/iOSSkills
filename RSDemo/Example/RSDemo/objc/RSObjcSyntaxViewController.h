//
//  RSObjcSyntaxViewController.h
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSBlockSyntaxObject : NSObject

@property (nonatomic, strong) void(^strongBlock)(void);
@property (nonatomic, copy) void(^copyBlock)(void);

- (void)excuteStrongBlock;

- (void)excuteCopyBlock;

@end

@interface RSObjcSyntaxViewController : UIViewController

@end
