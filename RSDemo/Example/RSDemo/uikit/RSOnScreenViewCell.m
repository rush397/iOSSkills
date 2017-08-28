//
//  RSOnScreenViewCell.m
//  RSDemo
//
//  Created by mac on 17/8/25.
//  Copyright © 2017年 yaoqi. All rights reserved.
//

#import "RSOnScreenViewCell.h"

@implementation RSOnScreenViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        NSInteger count = 6;
        CGFloat width = [UIScreen mainScreen].bounds.size.width / (CGFloat)count;
        for (NSInteger idx = 0; idx < count; idx++) {
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.image = [self imageWithRoundedCornersAndSize:CGSizeMake(width, 44) cornerRadius:5.0];
            imageView.frame = CGRectMake(idx * width, 0, width, 44);
            [self.contentView addSubview:imageView];
            
            UILabel *label = [[UILabel alloc] init];
            label.text = [NSString stringWithFormat:@"%@", @(idx)];
            label.frame = CGRectMake(idx * width, 0, width, 44);
            [self.contentView addSubview:label];
        }
    }
    return self;
}

- (void)startTimer {
    if (!self.timer) {
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01 target:self selector:@selector(updateLabel) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    [self.timer fire];
}

- (void)stopTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

- (void)updateLabel {
    [self.contentView.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if ([obj isKindOfClass:[UILabel class]]) {
            UILabel *label = (UILabel *)obj;
            NSInteger num = [label.text integerValue];
            if (num == 9999) {
                num = 1;
            } else {
                num++;
            }
            label.text = [NSString stringWithFormat:@"%@", @(num)];
        }
    }];
}

- (UIImage *)imageWithRoundedCornersAndSize:(CGSize)size cornerRadius:(CGFloat)cornerRadius {
    CGRect rect = (CGRect){0.f, 0.f, size};
    //    NSLog(@"screen scale: %f", [UIScreen mainScreen].scale);
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextAddPath(context, [UIBezierPath bezierPathWithRoundedRect:rect cornerRadius:cornerRadius].CGPath);
    CGContextClip(context);
    CGContextSetFillColorWithColor(context, [UIColor redColor].CGColor);
    CGContextFillRect(context, rect);
    UIImage *output = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return output;
}

@end
