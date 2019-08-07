//
//  VCTransitionDelegate.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//
#import <UIKit/UIKit.h>


@interface VCTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) CGPoint touchPoint;

@end
