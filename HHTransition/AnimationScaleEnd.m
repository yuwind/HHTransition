//
//  AnimationScaleEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "AnimationScaleEnd.h"
#import "UIViewController+HHTransition.h"
#import "UIView+HHLayout.h"

@implementation AnimationScaleEnd

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    if (![self responseToSel:@[fromVC,toVC]]) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIView *fromView = fromVC.view;
    UIView *toView = toVC.view;
    toView.frame = [transitionContext containerView].bounds;
    [[transitionContext containerView] addSubview:toView];
    UIView *sourceView = [fromVC hh_transitionAnimationView];
    UIView *destinationView = [toVC hh_transitionAnimationView];
    if (!sourceView || !destinationView) {
        [transitionContext completeTransition:YES];
        return;
    }
    UIColor *containerViewColor = [transitionContext containerView].backgroundColor;
    [transitionContext containerView].backgroundColor = [UIColor whiteColor];
    
    CGPoint sourcePoint = [sourceView convertPoint:CGPointZero toView:nil];
    CGPoint destinationPoint = [destinationView convertPoint:CGPointZero toView:nil];

    UIView *snapShot = [sourceView snapshotViewAfterScreenUpdates:NO];
    snapShot.origin = sourcePoint;
    [[transitionContext containerView] addSubview:snapShot];
    
    CGFloat heightScale = destinationView.height/sourceView.height;
    CGFloat widthScale = destinationView.width/sourceView.width;
    
    CGRect originFrame = toView.frame;
    CGFloat originHeightScale = sourceView.height/destinationView.height;
    CGFloat originWidthScale = sourceView.width/destinationView.width;
    
    toView.transform = CGAffineTransformMakeScale(originWidthScale,originHeightScale);
    toView.origin = CGPointMake((sourcePoint.x - destinationPoint.x)*originWidthScale, (sourcePoint.y - destinationPoint.y)*originHeightScale);
    
    toView.alpha = 0;
    fromView.hidden = YES;
    destinationView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{
        snapShot.transform = CGAffineTransformMakeScale(widthScale, heightScale);
        snapShot.origin = destinationPoint;
        toView.alpha = 1.0;
        toView.transform = CGAffineTransformIdentity;
        toView.frame = originFrame;
    } completion:^(BOOL finished) {
        [transitionContext containerView].backgroundColor = containerViewColor;
        fromView.hidden = NO;
        destinationView.hidden = NO;
        [snapShot removeFromSuperview];
        toView.transform = CGAffineTransformIdentity;
        toView.frame = originFrame;
        toView.alpha = 1;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (BOOL)responseToSel:(NSArray <UIViewController *>*)array
{
    if (!array.count) {
        return NO;
    }
    for (UIViewController *vc in array) {
        if (![vc respondsToSelector:@selector(hh_transitionAnimationView)]) {
            return NO;
        }
    }
    return YES;
}


@end
