//
//  AnimationTopBackBegin.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2019/7/17.
//  Copyright © 2019 豫风. All rights reserved.
//

#import "AnimationTopBackBegin.h"
#import "UIView+HHLayout.h"
#import "AnimationTopBackImageView.h"
#import "AnimationStyle.h"

@implementation AnimationTopBackBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UINavigationController *navVC = fromVC.navigationController;
    
    UIView *firstView = navVC.view.subviews[0];
    if ([firstView isKindOfClass:AnimationTopBackImageView.class]) {
        [firstView removeFromSuperview];
    }
    AnimationTopBackImageView *imageView = [AnimationTopBackImageView new];
    imageView.frame = [UIScreen mainScreen].bounds;
    [navVC.view insertSubview:imageView atIndex:0];
    if (KISiPhoneX) {
        imageView.transform = CGAffineTransformMakeScale(0.92, 0.9);
    }else{
        imageView.transform = CGAffineTransformMakeScale(0.92, 0.94);
    }
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = [UIScreen mainScreen].bounds;
    [transitionContext.containerView addSubview:toView];

    toView.y = [UIScreen mainScreen].bounds.size.height;
    [UIView animateWithDuration:0.3 animations:^{
        toView.y = 0;
        if (KISiPhoneX) {
            fromView.transform = CGAffineTransformMakeScale(0.92, 0.9);
        }else{
            fromView.transform = CGAffineTransformMakeScale(0.92, 0.94);
        }
    } completion:^(BOOL finished) {
        toView.y = 0;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
