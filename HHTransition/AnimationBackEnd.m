//
//  AnimationBackEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2018/4/23.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "AnimationBackEnd.h"
#import "UIView+HHConstraint.h"

@implementation AnimationBackEnd

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView bringSubviewToFront:fromView];
    
    toView.transform = CGAffineTransformMakeScale(0.93, 0.93);
    
    CGRect origin = fromView.frame;
    [UIView animateWithDuration:0.3 animations:^{
        fromView.x = fromView.width;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        fromView.frame = origin;
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
