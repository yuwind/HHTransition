//
//  AnimationImageView.m
//  当当
//
//  Created by 豫风 on 2019/7/17.
//  Copyright © 2019 DangDang. All rights reserved.
//

#import "AnimationTopBackImageView.h"

@implementation AnimationTopBackImageView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self configInitialInfo];
    }
    return self;
}

- (void)configInitialInfo
{
    UIImage *image = [self captureCurrentPicture];
    UIView *coverView = [UIView new];
    coverView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    coverView.frame = [UIScreen mainScreen].bounds;
    [self addSubview:coverView];
    self.image = image;
}

- (UIImage *)captureCurrentPicture
{
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [topWindow drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    UIImage * img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}

@end
