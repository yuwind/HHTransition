//
//  AnimationTildEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2018/4/19.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "AnimationTildEnd.h"

@implementation AnimationTildEnd


-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.3;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView * snapShot = [fromView snapshotViewAfterScreenUpdates:NO];
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView addSubview:snapShot];
    snapShot.frame = transitionContext.containerView.bounds;
    snapShot.layer.anchorPoint = CGPointMake(0.5, 1.5);
    snapShot.layer.position = CGPointMake(snapShot.bounds.size.width * 0.5, snapShot.bounds.size.height * 1.5);
    snapShot.transform = CGAffineTransformIdentity;
    
    [UIView animateWithDuration:0.3 animations:^{
        snapShot.transform = CGAffineTransformMakeRotation(M_PI_4);
    } completion:^(BOOL finished) {
        
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
