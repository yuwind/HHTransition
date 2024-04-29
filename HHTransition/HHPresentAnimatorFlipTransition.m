//
//  HHPresentAnimatorFlipTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentAnimatorFlipTransition.h"
#import "UIViewController+HHTransitionProperty.h"
#import "UIView+HHAnimator.h"

@interface HHPresentAnimatorFlipTransition ()

@property (nonatomic, assign) HHPresentStyle style;

@end

@implementation HHPresentAnimatorFlipTransition

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

+ (instancetype)flipTransitionWithStyle:(HHPresentStyle)style isBegining:(BOOL)isBegining {
    
    HHPresentAnimatorFlipTransition *flipTransition = [HHPresentAnimatorFlipTransition transitionWithIsBegining:isBegining];
    flipTransition.style = style;
    
    return flipTransition;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *translucentView = toVC.translucentView;
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = containerView.bounds;
    translucentView.frame = containerView.bounds;
    [containerView addSubview:translucentView];
    [containerView addSubview:toView];
    
    toView.hh_y = toView.hh_height;
    translucentView.alpha = 0;
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView hh_animateWithDuration:duration animations:^{
        translucentView.alpha = 1;
        toView.hh_y = 0;
    } completion:^(UIViewAnimatingPosition finalPosition) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *translucentView = fromVC.translucentView;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    
    [UIView hh_animateWithDuration:duration animations:^{
        translucentView.alpha = 0;
        fromView.hh_y = fromView.hh_height;
    } completion:^(UIViewAnimatingPosition finalPosition) {
        [transitionContext completeTransition:YES];
        [translucentView removeFromSuperview];
    }];
}

@end
