//
//  RSFrameViewController.m
//  RSDemo
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSFrameViewController.h"

@interface RSFrameViewController ()

@end

@implementation RSFrameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *redView = [[UIView alloc] init];
    redView.frame = CGRectMake(0, 200, 200, 200);
    redView.backgroundColor = [UIColor redColor];
    [self.view addSubview:redView];
    
    UIView *yellowView = [[UIView alloc] init];
    yellowView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleWidth;
    yellowView.frame = CGRectInset(redView.bounds, 20, 20);
    yellowView.backgroundColor = [UIColor yellowColor];
    [redView addSubview:yellowView];
    
    [UIView animateWithDuration:0.5 animations:^{
        redView.frame = CGRectMake(0, 200, 300, 300);
    }];
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
