//
//  AnimationTopBackEnd.m
//  HHTransitionDemo
//
//  Created by 豫风 on 2019/7/17.
//  Copyright © 2019 豫风. All rights reserved.
//

#import "AnimationTopBackEnd.h"
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"

@implementation AnimationTopBackEnd

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    fromView.frame = [UIScreen mainScreen].bounds;
    toView.frame = [UIScreen mainScreen].bounds;
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView bringSubviewToFront:fromView];
    
    if (KISiPhoneX) {
        toView.transform = CGAffineTransformMakeScale(0.92, 0.9);
    }else{
        toView.transform = CGAffineTransformMakeScale(0.92, 0.94);
    }
    [UIView animateWithDuration:0.3 animations:^{
        fromView.frame = [UIScreen mainScreen].bounds;
        fromView.y = [UIScreen mainScreen].bounds.size.height;
        toView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
        toView.transform = CGAffineTransformIdentity;
        fromView.frame = [UIScreen mainScreen].bounds;
        fromView.y = 0;
    }];
}


@end
