//
//  HHInteractionFlipTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHInteractionFlipTransition.h"

@interface HHInteractionFlipTransition ()

@property (nonatomic, assign) HHPushStyle style;

@end

static UIView *translucentView_ = nil;

@implementation HHInteractionFlipTransition

+ (instancetype)flipTransitionWithStyle:(HHPushStyle)style isBegining:(BOOL)isBegining {
    
    HHInteractionFlipTransition *flipTransition = [HHInteractionFlipTransition transitionWithIsBegining:isBegining];
    flipTransition.style = style;
    
    return flipTransition;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *containerView = [transitionContext containerView];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    
    toView.frame = containerView.bounds;
    self.translucentView.frame = containerView.bounds;
    [containerView addSubview:self.translucentView];
    [containerView addSubview:toView];
    
    [self setupBeginInfoWithToView:toView];
    self.translucentView.alpha = 0;
    CGFloat duration = [self transitionDuration:transitionContext];
    
    CGFloat damping = 1;
    if (self.style == HHPushStyleSlipFromTop) {
        damping = 0.65;
    }
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.translucentView.alpha = 1;
        [self setupSuspendInfoWithToView:toView];
    } completion:^(BOOL finished) {
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    [transitionContext.containerView addSubview:toView];
    [transitionContext.containerView addSubview:self.translucentView];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [transitionContext.containerView addSubview:fromView];
    
    CGFloat damping = 1;
    if (self.style == HHPushStyleSlipFromTop) {
        damping = 0.65;
    }
    self.translucentView.alpha = 1;
    CGFloat duration = [self transitionDuration:transitionContext];
    [UIView animateWithDuration:duration delay:0 usingSpringWithDamping:damping initialSpringVelocity:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.translucentView.alpha = 0;
        [self setupEndInfoWithFromView:fromView];
    } completion:^(BOOL finished) {
        if (!transitionContext.transitionWasCancelled) {
            [self.translucentView removeFromSuperview];
            translucentView_ = nil;
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)setupBeginInfoWithToView:(UIView *)toView {
    switch (self.style) {
        case HHPushStyleSlipFromTop:
            toView.hh_y = -toView.hh_height;
            break;
        case HHPushStyleSlipFromBottom:
            toView.hh_y = toView.hh_height;
            break;
        case HHPushStyleSlipFromLeft:
            toView.hh_x = -toView.hh_width;
            break;
        case HHPushStyleSlipFromRight:
            toView.hh_x = toView.hh_width;
            break;
        default:
            break;
    }
}

- (void)setupSuspendInfoWithToView:(UIView *)toView {
    switch (self.style) {
        case HHPushStyleSlipFromTop:
            toView.hh_y = 0;
            break;
        case HHPushStyleSlipFromBottom:
            toView.hh_y = 0;
            break;
        case HHPushStyleSlipFromLeft:
            toView.hh_x = 0;
            break;
        case HHPushStyleSlipFromRight:
            toView.hh_x = 0;
            break;
        default:
            break;
    }
}

- (void)setupEndInfoWithFromView:(UIView *)fromView {
    switch (self.style) {
        case HHPushStyleSlipFromTop:
            fromView.hh_y = fromView.hh_height;
            break;
        case HHPushStyleSlipFromBottom:
            fromView.hh_y = fromView.hh_height;
            break;
        case HHPushStyleSlipFromLeft:
            fromView.hh_x = fromView.hh_width;
            break;
        case HHPushStyleSlipFromRight:
            fromView.hh_x = -fromView.hh_width;
            break;
        default:
            break;
    }
}

- (UIView *)translucentView {
    if (!translucentView_) {
        translucentView_ = [[UIView alloc] init];
        translucentView_.backgroundColor = [UIColor colorWithWhite:0 alpha:0.8f];
    }
    return translucentView_;
}

@end
