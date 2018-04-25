//
//  AnimationTiltBegin.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2018/4/19.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "AnimationTiltBegin.h"

@implementation AnimationTiltBegin

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    
    toView.layer.anchorPoint = CGPointMake(0.5, 1.5);
    toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 1.5);
    [transitionContext.containerView addSubview:toView];
    toView.transform = CGAffineTransformMakeRotation(M_PI_4);
    
    [UIView animateWithDuration:0.3 animations:^{
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        
        toView.layer.anchorPoint = CGPointMake(0.5, 0.5);
        toView.layer.position = CGPointMake(toView.bounds.size.width * 0.5, toView.bounds.size.height * 0.5);
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
