//
//  RSIntrinsicContentSizeViewController.m
//  RSDemo
//
//  Created by mac on 17/8/24.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSIntrinsicContentSizeViewController.h"

@interface RSIntrinsicContentSizeViewController ()

@property (weak, nonatomic) IBOutlet UILabel *topLabel;
@property (weak, nonatomic) IBOutlet UILabel *bottomLabel;

@end

@implementation RSIntrinsicContentSizeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    self.topLabel.text = @"@property(nonatomic, assign) UIRectEdge edgesForExtendedLayout;\n\
    Description\n\
    The extended edges to use for the layout.";
    self.bottomLabel.text = @"This property is applied only to view controllers that are embedded in a container such as UINavigationController. The window’s root view controller does not react to this property. The default value of this property is UIRectEdgeAll.";
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
