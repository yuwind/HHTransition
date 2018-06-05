//
//  AnimationErectEnd.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2018/4/20.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import "AnimationErectEnd.h"
#import "UIView+HHLayout.h"

@implementation AnimationErectEnd

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

    snapShot.layer.anchorPoint = CGPointMake(0, 0.5);
    snapShot.layer.position = CGPointMake(0, snapShot.height * 0.5);
    
    CATransform3D rotateTransform = CATransform3DRotate(CATransform3DIdentity, -M_PI_2, 0, 1, 0);
    rotateTransform.m34 = -1.0 / 500.0;
    fromView.hidden = YES;
    [UIView animateWithDuration:0.3 animations:^{

        snapShot.layer.position = CGPointMake(snapShot.width, snapShot.height * 0.5);
        snapShot.layer.transform = rotateTransform;
    } completion:^(BOOL finished) {
        fromView.hidden = NO;
        [snapShot removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
