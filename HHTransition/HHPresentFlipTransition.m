//
//  HHPresentFlipTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentFlipTransition.h"
#import <objc/runtime.h>

@interface UIViewController (translucentView)

@property (nonatomic, strong) UIView *translucentView_;

@end

@implementation UIViewController (translucentView)

- (UIView *)translucentView_ {
    UIView *translucentView_ = objc_getAssociatedObject(self, @selector(translucentView_));
    if (!translucentView_) {
        translucentView_ = [[UIView alloc] init];
        translucentView_.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
        self.translucentView_ = translucentView_;
    }
    return translucentView_;
}

- (void)setTranslucentView_:(UIView *)translucentView_ {
    objc_setAssociatedObject(self, @selector(translucentView_), translucentView_, OBJC_ASSOCIATION_RETAIN);
}

@end

@interface HHPresentFlipTransition ()

@property (nonatomic, assign) HHPresentStyle style;

@end

@implementation HHPresentFlipTransition

+ (instancetype)flipTransitionWithStyle:(HHPresentStyle)style isBegining:(BOOL)isBegining {
    
    HHPresentFlipTransition *flipTransition = [HHPresentFlipTransition transitionWithIsBegining:isBegining];
    flipTransition.style = style;
    
    return flipTransition;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *translucentView = toVC.translucentView_;
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = containerView.bounds;
    translucentView.frame = containerView.bounds;
    [containerView addSubview:translucentView];
    [containerView addSubview:toView];
    
    [self setupBeginInfoWithToView:toView];
    translucentView.alpha = 0;
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat damping = 1;
    if (self.style == HHPresentStyleSlipFromTop) {
        damping = 0.65;
    }
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        translucentView.alpha = 1;
        [self setupSuspendInfoWithToView:toView];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *translucentView = fromVC.translucentView_;
    
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat damping = 1;
    if (self.style == HHPresentStyleSlipFromTop) {
        damping = 0.65;
    }
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        translucentView.alpha = 0;
        [self setupEndInfoWithFromView:fromView];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:YES];
        [translucentView removeFromSuperview];
    }];
}

- (void)setupBeginInfoWithToView:(UIView *)toView {
    switch (self.style) {
        case HHPresentStyleSlipFromTop:
            toView.hh_y = -toView.hh_height;
            break;
        case HHPresentStyleSlipFromBottom:
            toView.hh_y = toView.hh_height;
            break;
        case HHPresentStyleSlipFromLeft:
            toView.hh_x = -toView.hh_width;
            break;
        case HHPresentStyleSlipFromRight:
            toView.hh_x = toView.hh_width;
            break;
        default:
            break;
    }
}

- (void)setupSuspendInfoWithToView:(UIView *)toView {
    switch (self.style) {
        case HHPresentStyleSlipFromTop:
            toView.hh_y = 0;
            break;
        case HHPresentStyleSlipFromBottom:
            toView.hh_y = 0;
            break;
        case HHPresentStyleSlipFromLeft:
            toView.hh_x = 0;
            break;
        case HHPresentStyleSlipFromRight:
            toView.hh_x = 0;
            break;
        default:
            break;
    }
}

- (void)setupEndInfoWithFromView:(UIView *)fromView {
    switch (self.style) {
        case HHPresentStyleSlipFromTop:
            fromView.hh_y = fromView.hh_height;
            break;
        case HHPresentStyleSlipFromBottom:
            fromView.hh_y = fromView.hh_height;
            break;
        case HHPresentStyleSlipFromLeft:
            fromView.hh_x = fromView.hh_width;
            break;
        case HHPresentStyleSlipFromRight:
            fromView.hh_x = -fromView.hh_width;
            break;
        default:
            break;
    }
}

@end
