//
//  HHPresentTopBackTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentTopBackTransition.h"
#import "UIViewController+HHTransitionProperty.h"
#import "UIView+HHAnimator.h"

@implementation HHPresentTopBackTransition

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;

    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if (![fromVC isKindOfClass:UITabBarController.class] && fromVC.tabBarController) {
        fromVC = fromVC.tabBarController;
    } else if (![fromVC isKindOfClass:UINavigationController.class] && fromVC.navigationController) {
        fromVC = fromVC.navigationController;
    }
    UIView *fromView = fromVC.view;
    UIView *snapshotView = [fromView snapshotViewAfterScreenUpdates:false];
    snapshotView.frame = containerView.bounds;
    snapshotView.tag = 1030201;
    [containerView addSubview:snapshotView];
    fromView.hidden = true;
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *translucentView = toVC.translucentView;
    translucentView.frame = containerView.bounds;
    [containerView addSubview:translucentView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    toView.frame = containerView.bounds;
    toView.hh_y = toView.hh_height;
    translucentView.alpha = 0;
    [UIView hh_animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.hh_y = 0;
        translucentView.alpha = 1;
        snapshotView.layer.cornerRadius = 20;
        snapshotView.layer.masksToBounds = true;
        if (mISiPhoneX) {
            snapshotView.transform = CGAffineTransformMakeScale(0.94, 0.9);
        } else {
            snapshotView.transform = CGAffineTransformMakeScale(0.94, 0.94);
        }
    } completion:^(UIViewAnimatingPosition finalPosition) {
        toView.hh_y = 0;
        snapshotView.layer.cornerRadius = 20;
        snapshotView.layer.masksToBounds = true;
        if (mISiPhoneX) {
            snapshotView.transform = CGAffineTransformMakeScale(0.94, 0.9);
        } else {
            snapshotView.transform = CGAffineTransformMakeScale(0.94, 0.94);
        }
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;
    UIView *snapshotView = [containerView viewWithTag:1030201];
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *translucentView = fromVC.translucentView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![toVC isKindOfClass:UITabBarController.class] && toVC.tabBarController) {
        toVC = toVC.tabBarController;
    } else if (![toVC isKindOfClass:UINavigationController.class] && toVC.navigationController) {
        toVC = toVC.navigationController;
    }
    UIView *toView = toVC.view;
        
    [UIView hh_animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.hh_y = fromView.hh_height;
        snapshotView.alpha = 1;
        snapshotView.layer.cornerRadius = 0;
        snapshotView.layer.masksToBounds = true;
        snapshotView.transform = CGAffineTransformIdentity;
        translucentView.alpha = 0;
    } completion:^(UIViewAnimatingPosition finalPosition) {
        snapshotView.alpha = 1;
        snapshotView.layer.cornerRadius = 0;
        snapshotView.layer.masksToBounds = true;
        snapshotView.transform = CGAffineTransformIdentity;
        [snapshotView removeFromSuperview];
        [translucentView removeFromSuperview];
        toView.hidden = false;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
