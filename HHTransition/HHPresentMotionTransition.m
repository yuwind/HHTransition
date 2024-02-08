//
//  HHPresentMotionTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentMotionTransition.h"
#import "HHTransitionUtility.h"

@implementation HHPresentMotionTransition

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.5;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController <HHInteractionMotionProtocol>*fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <HHInteractionMotionProtocol>*toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([fromVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabbarVC = (UITabBarController *)fromVC;
        fromVC = tabbarVC.selectedViewController;
    }
    if ([fromVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)fromVC;
        fromVC = (id)navVC.topViewController;
    }
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    UIView *containerView = [transitionContext containerView];
    toView.frame = containerView.bounds;
    [containerView addSubview:toVC.view];
    
    if (!fromVC || !toVC || ![self responseToSel:@[fromVC,toVC]] || ![fromVC respondsToSelector:@selector(hh_animationMediumViewForMotionTransition)]) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIView *sourceView = [fromVC hh_animationViewForMotionTransition];
    UIView *destinationView = [toVC hh_animationViewForMotionTransition];
    UIView<HHViewMotionAnimation> *mediumView = [fromVC hh_animationMediumViewForMotionTransition];
    if (!sourceView || !destinationView || !mediumView) {
        [transitionContext completeTransition:YES];
        return;
    }
    mediumView.tag = 113215;
    [containerView addSubview:mediumView];
    if ([mediumView respondsToSelector:@selector(showPresentAnimation)]) {
        [mediumView showPresentAnimation];
    }
    
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];
    
    CGFloat heightScale = sourceView.hh_height / destinationView.hh_height;
    CGFloat widthScale = sourceView.hh_width / destinationView.hh_width;
    
    toView.alpha = 0;
    sourceView.hidden = true;
    mediumView.hh_size = destinationView.hh_size;
    mediumView.transform = CGAffineTransformMakeScale(widthScale, heightScale);
    mediumView.hh_origin = sourcePoint;
    toView.userInteractionEnabled = false;
    [UIView animateWithDuration:0.8 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        mediumView.transform = CGAffineTransformIdentity;
        mediumView.hh_origin = destinationPoint;
    } completion:^(BOOL finished) {
        toView.userInteractionEnabled = true;
        [toView addSubview:mediumView];
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
        fromView.transform = CGAffineTransformMakeScale(0.92, 0.9);
        toView.alpha = 1;
    } completion:^(BOOL finished) {
        sourceView.hidden = false;
        fromView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
    [containerView bringSubviewToFront:mediumView];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController <HHInteractionMotionProtocol>*fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <HHInteractionMotionProtocol>*toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if ([toVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabbarVC = (UITabBarController *)toVC;
        toVC = tabbarVC.selectedViewController;
    }
    if ([toVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)toVC;
        toVC = (id)navVC.topViewController;
    }
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;

    if (!fromVC || !toVC || ![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIView *sourceView = [fromVC hh_animationViewForMotionTransition];
    UIView *destinationView = [toVC hh_animationViewForMotionTransition];
    UIView<HHViewMotionAnimation> *mediumView = [fromView viewWithTag:113215];
    if (!sourceView || !destinationView || !mediumView) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIView *containerView = [transitionContext containerView];
    [containerView addSubview:mediumView];
    if ([mediumView respondsToSelector:@selector(showDismissAnimation)]) {
        [mediumView showDismissAnimation];
    }
    
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];
    
    CGFloat heightScale = destinationView.hh_height / sourceView.hh_height;
    CGFloat widthScale = destinationView.hh_width / sourceView.hh_width;
    
    CGAffineTransform origin = mediumView.transform;
    CGAffineTransform result = CGAffineTransformScale(origin, widthScale, heightScale);
    destinationView.alpha = 0;
    toView.userInteractionEnabled = false;
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.9 initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        mediumView.transform = result;
        mediumView.hh_origin = destinationPoint;
    } completion:^(BOOL finished) {
        toView.userInteractionEnabled = true;
        destinationView.alpha = 1;
        [mediumView removeFromSuperview];
    }];
    
    toView.transform = CGAffineTransformMakeScale(0.92, 0.9);
    [UIView animateWithDuration:0.5 animations:^{
        fromView.alpha = 0;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (BOOL)responseToSel:(NSArray <UIViewController <HHInteractionMotionProtocol>*>*)array {
    if (!array.count) {
        return NO;
    }
    for (UIViewController *vc in array) {
        if (![vc respondsToSelector:@selector(hh_animationViewForMotionTransition)]) {
            return NO;
        }
    }
    return YES;
}

@end
