//
//  HHInteractionMotionTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHInteractionMotionTransition.h"
#import "HHTransitionUtility.h"

@implementation HHInteractionMotionTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController <HHInteractionMotionProtocol>*fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <HHInteractionMotionProtocol>*toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    UIView *containerView = [transitionContext containerView];
    toView.frame = containerView.bounds;
    [containerView addSubview:toVC.view];
    
    if (!fromVC || !toVC || ![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIView *sourceView = [fromVC hh_animationViewForMotionTransition];
    UIView *destinationView = [toVC hh_animationViewForMotionTransition];
    if (!sourceView || !destinationView) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIColor *containerViewColor = containerView.backgroundColor;
    containerView.backgroundColor = [UIColor whiteColor];
    
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];
    
    UIView *snapShot = [sourceView snapshotViewAfterScreenUpdates:NO];
    [containerView addSubview:snapShot];
    snapShot.hh_origin = sourcePoint;
    
    CGFloat heightScale = destinationView.hh_height / sourceView.hh_height;
    CGFloat widthScale = destinationView.hh_width / sourceView.hh_width;
    
    toView.hidden = YES;
    CGRect originFrame = fromView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        snapShot.transform =  CGAffineTransformMakeScale(widthScale,heightScale);
        snapShot.hh_origin = destinationPoint;
        fromView.alpha = 0;
        fromView.transform = snapShot.transform;
        fromView.hh_origin = CGPointMake((destinationPoint.x - sourcePoint.x) * widthScale, (destinationPoint.y - sourcePoint.y)  *heightScale);
    } completion:^(BOOL finished) {
        containerView.backgroundColor = containerViewColor;
        [snapShot removeFromSuperview];
        toView.hidden = NO;
        fromView.alpha = 1;
        fromView.transform = CGAffineTransformIdentity;
        fromView.frame = originFrame;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController <HHInteractionMotionProtocol>*fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController <HHInteractionMotionProtocol>*toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *toView = toVC.view;
    UIView *fromView = fromVC.view;
    UIView *containerView = [transitionContext containerView];
    toView.frame = containerView.bounds;
    [containerView addSubview:toView];
    
    if (!fromVC || !toVC || ![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    UIView *sourceView = [fromVC hh_animationViewForMotionTransition];
    UIView *destinationView = [toVC hh_animationViewForMotionTransition];
    if (!sourceView || !destinationView) {
        [transitionContext completeTransition:YES];
        return;
    }

    UIColor *containerViewColor = containerView.backgroundColor;
    containerView.backgroundColor = [UIColor whiteColor];
    
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];

    UIView *snapShot = [sourceView snapshotViewAfterScreenUpdates:NO];
    snapShot.hh_origin = sourcePoint;
    [containerView addSubview:snapShot];
    
    CGFloat heightScale = destinationView.hh_height / sourceView.hh_height;
    CGFloat widthScale = destinationView.hh_width / sourceView.hh_width;
    
    CGRect originFrame = toView.frame;
    CGFloat originHeightScale = sourceView.hh_height / destinationView.hh_height;
    CGFloat originWidthScale = sourceView.hh_width / destinationView.hh_width;
    
    toView.transform = CGAffineTransformMakeScale(originWidthScale,originHeightScale);
    toView.hh_origin = CGPointMake((sourcePoint.x - destinationPoint.x) * originWidthScale, (sourcePoint.y - destinationPoint.y) * originHeightScale);
    
    toView.alpha = 0;
    fromView.hidden = YES;
    destinationView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        snapShot.transform = CGAffineTransformMakeScale(widthScale, heightScale);
        snapShot.hh_origin = destinationPoint;
        toView.alpha = 1.0;
        toView.transform = CGAffineTransformIdentity;
        toView.frame = originFrame;
    } completion:^(BOOL finished) {
        containerView.backgroundColor = containerViewColor;
        fromView.hidden = NO;
        destinationView.hidden = NO;
        [snapShot removeFromSuperview];
        toView.transform = CGAffineTransformIdentity;
        toView.frame = originFrame;
        toView.alpha = 1;
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
