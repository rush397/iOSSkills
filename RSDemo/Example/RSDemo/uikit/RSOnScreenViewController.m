//
//  RSOnScreenViewController.m
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSOnScreenViewController.h"
#import "RSOnScreenViewCell.h"

@interface RSOnScreenViewController ()

@end

@implementation RSOnScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self.tableView registerClass:[RSOnScreenViewCell class] forCellReuseIdentifier:NSStringFromClass([RSOnScreenViewCell class])];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [[self.tableView visibleCells] enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        RSOnScreenViewCell *theCell = (RSOnScreenViewCell *)obj;
        [theCell stopTimer];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([RSOnScreenViewCell class]) forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    RSOnScreenViewCell *theCell = (RSOnScreenViewCell *)cell;
    [theCell startTimer];
}

- (void)tableView:(UITableView *)tableView didEndDisplayingCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    RSOnScreenViewCell *theCell = (RSOnScreenViewCell *)cell;
    [theCell stopTimer];
}

@end
