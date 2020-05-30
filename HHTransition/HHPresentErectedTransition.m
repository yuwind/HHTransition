//
//  HHPresentErectedTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentErectedTransition.h"

@implementation HHPresentErectedTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    toView.frame = transitionContext.containerView.bounds;
    toView.layer.anchorPoint = CGPointMake(0, 0.5);
    toView.layer.position = CGPointMake(toView.hh_width, toView.hh_height * 0.5);
    CATransform3D identity = CATransform3DIdentity;
    identity.m34 = -1.0 / 500.0;
    CATransform3D rotateTransform = CATransform3DRotate(identity, M_PI/3, 0, 1, 0);
    toView.layer.transform = rotateTransform;
    [UIView animateWithDuration:0.3 animations:^{
        toView.layer.transform = CATransform3DIdentity;
        toView.layer.position = CGPointMake(0, toView.hh_height * 0.5);
    } completion:^(BOOL finished) {
        toView.layer.transform = CATransform3DIdentity;
        toView.layer.position = CGPointMake(toView.hh_width * 0.5, toView.hh_height * 0.5);
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:snapShot];
    snapShot.frame = transitionContext.containerView.bounds;

    snapShot.layer.anchorPoint = CGPointMake(0, 0.5);
    snapShot.layer.position = CGPointMake(0, snapShot.hh_height * 0.5);
    
    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1, 0);
    rotateTransform.m34 = -1.0 / 500.0;
    fromView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        snapShot.layer.position = CGPointMake(snapShot.hh_width, snapShot.hh_height * 0.5);
        snapShot.layer.transform = rotateTransform;
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:YES];
    }];
}

@end
