//
//  HHPresentAlertZoomTransition.m
//  HHTransition
//
//  Created by huxuewei on 2024/4/26.
//

#import "HHPresentAlertZoomTransition.h"
#import "UIViewController+HHTransitionProperty.h"
#import "UIView+HHAnimator.h"

@implementation HHPresentAlertZoomTransition

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.6;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *containerView = transitionContext.containerView;

    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    
    UIView *translucentView = toVC.translucentView;
    translucentView.frame = containerView.bounds;
    [containerView addSubview:translucentView];
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [containerView addSubview:toView];
    
    toView.frame = containerView.bounds;
    toView.transform = CGAffineTransformMakeScale(0.1, 0.1);
    toView.alpha = 0;
    translucentView.alpha = 0;
    [UIView hh_animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.transform = CGAffineTransformIdentity;
        translucentView.alpha = 1;
        toView.alpha = 1;
    } completion:^(UIViewAnimatingPosition finalPosition) {
        toView.transform = CGAffineTransformIdentity;
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *translucentView = fromVC.translucentView;
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
        
    [UIView hh_animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        translucentView.alpha = 0;
        fromView.alpha = 0;
    } completion:^(UIViewAnimatingPosition finalPosition) {
        fromView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        [translucentView removeFromSuperview];
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

@end
