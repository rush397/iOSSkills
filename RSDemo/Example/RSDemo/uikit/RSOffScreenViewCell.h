//
//  RSOffScreenViewCell.h
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSOffScreenViewCell : UITableViewCell

@property (nonatomic, strong) NSTimer *timer;
- (void)startTimer;
- (void)stopTimer;

@end
