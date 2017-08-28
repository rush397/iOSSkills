//
//  RSUIKitViewController.m
//  RSDemo
//
//  Created by yaoqi on 08/24/2017.
//  Copyright (c) 2017 yaoqi. All rights reserved.
//

#import "RSUIKitViewController.h"
#import "RSFrameViewController.h"
#import "RSIntrinsicContentSizeViewController.h"
#import "RSLayoutPriorityViewController.h"
#import "RSOffScreenViewController.h"
#import "RSOnScreenViewController.h"

@interface RSUIKitViewController ()

@property (nonatomic, strong) NSArray *items;

@end
 
@implementation RSUIKitViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.items = @[
                   @{@"Frame" : [RSFrameViewController class]},
                   @{@"Intrinsic Content Size" : [RSIntrinsicContentSizeViewController class]},
                   @{@"Layout Priority" : [RSLayoutPriorityViewController class]},
                   @{@"Off Screen" : [RSOffScreenViewController class]},
                   @{@"On Screen" : [RSOnScreenViewController class]},
                   ];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *reuseIdentifier = @"UITableViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
    }
    NSDictionary *item = self.items[indexPath.row];
    cell.textLabel.text = item.allKeys.firstObject;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSDictionary *item = self.items[indexPath.row];
    Class class = item.allValues.firstObject;
    UIViewController *vc = [[class alloc] init];
    vc.title = item.allKeys.firstObject;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
