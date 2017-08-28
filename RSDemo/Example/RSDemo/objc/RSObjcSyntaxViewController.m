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
