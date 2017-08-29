//
//  RSObjcSyntaxViewController.m
//  RSDemo
//
//  Created by yaoqi on 2017/8/27.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSObjcSyntaxViewController.h"

@implementation RSBlockSyntaxObject

- (void)excuteStrongBlock {
    if (self.strongBlock) {
        NSLog(@"excute strong block %@", self.strongBlock);
        self.strongBlock();
    }
}

- (void)excuteCopyBlock {
    if (self.copyBlock) {
        NSLog(@"excute copy block %@", self.copyBlock);
        self.copyBlock();
    }
}

@end

@implementation RSPropertySyntaxObject

- (instancetype)init
{
    self = [super init];
    if (self) {
        _copyedMutableArray = [@[@"haha"] mutableCopy];
        NSLog(@"[[RSPropertySyntaxObject alloc] init] - copyedMutableArray %@ : %@", [_copyedMutableArray class], _copyedMutableArray);
    }
    return self;
}

- (void)print {
    NSLog(@"strongArray %@ : %@", [self.strongArray class], self.strongArray);
    NSLog(@"copyedArray %@ : %@", [self.copyedArray class], self.copyedArray);
    NSLog(@"copyedMutableArray %@ : %@", [self.copyedMutableArray class], self.copyedMutableArray);
    NSLog(@"strongText %@ : %@", [self.strongText class], self.strongText);
    NSLog(@"copyedText %@ : %@", [self.copyedText class], self.copyedText);
    NSLog(@"copyedMutableText %@ : %@", [self.copyedMutableText class], self.copyedMutableText);
}


- (void)testArrayCrash {
    // copyedMutableArray 的属性是 copy，copy 就是复制一个不可变 NSArray 对象，对 NSArray 对象进行增删改操作，会直接 crash
    [self.copyedMutableArray insertObject:@"insert object" atIndex:0];
    NSLog(@"copyedMutableArray %@ : %@", [self.copyedMutableArray class], self.copyedMutableArray);
}

@end

@interface RSObjcSyntaxViewController ()

@end

@implementation RSObjcSyntaxViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
