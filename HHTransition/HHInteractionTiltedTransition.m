//
//  HHInteractionTiltedTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/19.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHInteractionTiltedTransition.h"

@implementation HHInteractionTiltedTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
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
        [self resetInitialInfoWithFromView:fromView toView:toView];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.layer.anchorPoint = CGPointMake(0, 1);
    toView.layer.position = CGPointMake(0, toView.bounds.size.height);
    toView.transform = CGAffineTransformMakeRotation(-M_PI_4 / 3);
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView insertSubview:toView belowSubview:fromView];
    [transitionContext.containerView addSubview:snapShot];
    [transitionContext.containerView insertSubview:snapShot belowSubview:fromView];
    
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
        [snapShot removeFromSuperview];
        [self resetInitialInfoWithFromView:fromView toView:toView];
        fromView.hidden = NO;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)resetInitialInfoWithFromView:(UIView *)fromView toView:(UIView *)toView {
    fromView.transform = CGAffineTransformIdentity;
    fromView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    fromView.layer.position = CGPointMake(fromView.bounds.size.width * 0.5, fromView.bounds.size.height * 0.5);
    toView.transform = CGAffineTransformIdentity;
    toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
}

@end
