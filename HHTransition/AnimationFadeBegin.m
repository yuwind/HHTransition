//
//  AnimationFadeBegin.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "AnimationFadeBegin.h"

@interface AnimationFadeBegin()

@property (nonatomic, assign) CGFloat height;

@end

@implementation AnimationFadeBegin

+ (instancetype)animationHeight:(CGFloat)height
{
    AnimationFadeBegin *fadeBegin = [[AnimationFadeBegin alloc] init];
    fadeBegin.height = height;
    return fadeBegin;
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    toVC.view.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, self.height?:[UIScreen mainScreen].bounds.size.height);
    [[transitionContext containerView] addSubview:toVC.view];
    toVC.view.layer.zPosition = MAXFLOAT;
    
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.layer.zPosition = -1;
    fromVC.view.layer.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    CATransform3D rotate = CATransform3DIdentity;
    rotate.m34 = -1.0 / 1000;
    rotate = CATransform3DRotate(rotate, ([UIScreen mainScreen].bounds.size.height == 812.0f?5:3) * M_PI/180.0, 1, 0, 0);
    
    CATransform3D scale = CATransform3DIdentity;
    scale = CATransform3DScale(scale, [UIScreen mainScreen].bounds.size.height == 812.0f?0.94:0.95, [UIScreen mainScreen].bounds.size.height == 812.0f?0.96:0.97, 1);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        fromVC.view.layer.transform = rotate;
        fromVC.view.alpha = 0.6;
    } completion:^(BOOL finished) {
        
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVC.view.alpha = 0.5;
            fromVC.view.layer.transform = scale;
        } completion:^(BOOL finished){
             [transitionContext completeTransition:YES];
         }];
    }];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        CGRect frame = toVC.view.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height - self.height?:[UIScreen mainScreen].bounds.size.height;
        toVC.view.frame = frame;
    } completion:nil];
}



@end
