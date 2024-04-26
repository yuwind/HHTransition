//
//  HHPresentTopBackTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentTopBackTransition.h"
#import "UIViewController+HHTransitionProperty.h"

@implementation HHPresentTopBackTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (![fromVC isKindOfClass:UITabBarController.class] && fromVC.tabBarController) {
        fromVC = fromVC.tabBarController;
    }
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *translucentView = toVC.translucentView;
    translucentView.frame = containerView.bounds;
    [containerView addSubview:translucentView];
    
    UIView *fromView = fromVC.view;
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    toView.frame = containerView.bounds;
    toView.hh_y = toView.hh_height;
    translucentView.alpha = 0;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.hh_y = 0;
        translucentView.alpha = 1;
        fromView.layer.cornerRadius = 20;
        fromView.layer.masksToBounds = true;
        if (mISiPhoneX) {
            fromView.transform = CGAffineTransformMakeScale(0.94, 0.9);
        }else{
            fromView.transform = CGAffineTransformMakeScale(0.94, 0.94);
        }
    } completion:^(BOOL finished) {
        toView.hh_y = 0;
        fromView.layer.cornerRadius = 20;
        fromView.layer.masksToBounds = true;
        if (mISiPhoneX) {
            fromView.transform = CGAffineTransformMakeScale(0.94, 0.9);
        }else{
            fromView.transform = CGAffineTransformMakeScale(0.94, 0.94);
        }
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *translucentView = fromVC.translucentView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![toVC isKindOfClass:UITabBarController.class] && toVC.tabBarController) {
        toVC = toVC.tabBarController;
    }
    UIView *toView = toVC.view;
        
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.hh_y = fromView.hh_height;
        toView.alpha = 1;
        toView.layer.cornerRadius = 20;
        toView.layer.masksToBounds = true;
        toView.transform = CGAffineTransformIdentity;
        translucentView.alpha = 0;
    } completion:^(BOOL finished) {
        toView.alpha = 1;
        toView.layer.cornerRadius = 20;
        toView.layer.masksToBounds = true;
        toView.transform = CGAffineTransformIdentity;
        [translucentView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
