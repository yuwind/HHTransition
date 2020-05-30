//
//  HHPresentTitledTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/14.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentTiltedTransition.h"

@implementation HHPresentTiltedTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabBarVC = (UITabBarController *)fromVC;
        fromVC = tabBarVC.selectedViewController;
    }
    if ([fromVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)fromVC;
        fromVC = navVC.topViewController;
    }

    UIView *fromView = fromVC.view;
    fromView.layer.anchorPoint = CGPointMake(0, 1);
    fromView.layer.position = CGPointMake(0, fromView.bounds.size.height);
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 1.5);
    [transitionContext.containerView addSubview:toView];
    
    toView.transform = CGAffineTransformMakeRotation(M_PI / 3);
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        fromView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 3);
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabBarVC = (UITabBarController *)toVC;
        toVC = tabBarVC.selectedViewController;
    }
    if ([toVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)toVC;
        toVC = navVC.topViewController;
    }
    UIView *toView = toVC.view;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:snapShot];
    
    snapShot.frame = transitionContext.containerView.bounds;
    snapShot.layer.anchorPoint = CGPointMake(0.5, 1.5);
    snapShot.layer.position = CGPointMake(snapShot.bounds.size.width * 0.5, snapShot.bounds.size.height * 1.5);
    snapShot.transform = CGAffineTransformIdentity;
    fromView.hidden = YES;
    
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration animations:^{
        toView.transform = CGAffineTransformIdentity;
        snapShot.transform = CGAffineTransformMakeRotation(M_PI / 3);
    } completion:^(BOOL finished) {
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        fromView.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
