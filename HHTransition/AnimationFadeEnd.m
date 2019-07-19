//
//  AnimationFadeEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "AnimationFadeEnd.h"
#import "AnimationStyle.h"

@interface AnimationFadeEnd()

@property (nonatomic, assign) CGFloat height;

@end

@implementation AnimationFadeEnd

+ (instancetype)animationHeight:(CGFloat)height
{
    AnimationFadeEnd *fadeEnd = [[AnimationFadeEnd alloc] init];
    fadeEnd.height = height;
    return fadeEnd;
}
- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.4;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController * toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    
    CATransform3D rotate = CATransform3DIdentity;
    rotate.m34 = -1.0 / 1000.0;
    rotate = CATransform3DRotate(rotate, 4.0 * M_PI/180.0, 1, 0, 0);
    if(!KISiPhoneX)
    rotate = CATransform3DTranslate(rotate, 0, -5, 0);
    
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{

        toVC.view.layer.transform = rotate;
        toVC.view.alpha = 0.6;
    } completion:^(BOOL finished) {

        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toVC.view.alpha = 1;
            [toVC.view.layer setTransform:CATransform3DIdentity];
        } completion:^(BOOL finished) {
            toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toVC.view.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            [transitionContext completeTransition:YES];
        }];
    }];
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        CGRect frame = fromVC.view.frame;
        frame.origin.y = [UIScreen mainScreen].bounds.size.height;
        fromVC.view.frame = frame;
    } completion:nil];
}


@end
