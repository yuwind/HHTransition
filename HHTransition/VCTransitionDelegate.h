//
//  VCTransitionDelegate.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//
#import <UIKit/UIKit.h>

typedef enum : NSUInteger{
    TransitionStyleCircle,
    TransitionStyleBackScale,
    TransitionStyleErect,
} TransitionStyle;



@interface VCTransitionDelegate : NSObject<UIViewControllerTransitioningDelegate>

@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGPoint touchPoint;
+ (instancetype)transitionStyle:(TransitionStyle)style;

@end
