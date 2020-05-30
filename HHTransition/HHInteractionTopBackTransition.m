//
//  HHInteractionTopBackTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHInteractionTopBackTransition.h"

static HHInteractionTopBackView *topBackView = nil;

@implementation HHInteractionTopBackTransition

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.25;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {

    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;

    toView.frame = containerView.bounds;
    topBackView = [[HHInteractionTopBackView alloc] init];
    topBackView.frame = containerView.bounds;
    [containerView addSubview:topBackView];
    [containerView addSubview:toView];

    [self setupTopCornersWithView:topBackView];
    fromView.hidden = YES;
    toView.hh_y = toView.hh_height;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        toView.hh_y = 0;
        topBackView.alpha = 0.7f;
        if (mISiPhoneX) {
            topBackView.transform = CGAffineTransformMakeScale(0.92, 0.9);
        }else{
            topBackView.transform = CGAffineTransformMakeScale(0.92, 0.94);
        }
    } completion:^(BOOL finished) {
        toView.hh_y = 0;
        fromView.hidden = NO;
        topBackView.alpha = 0.7f;
        [transitionContext completeTransition:YES];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    UIView *containerView = transitionContext.containerView;
    
    [containerView addSubview:toView];
    [containerView addSubview:topBackView];
    [containerView addSubview:fromView];
    toView.hidden = YES;
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
        topBackView.alpha =  1;
        fromView.hh_y = fromView.hh_height;
        topBackView.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        if (!transitionContext.transitionWasCancelled) {
            [topBackView removeFromSuperview];
            topBackView = nil;
            toView.hidden = NO;
        } else {
            topBackView.alpha = 0.7f;
        }
        [transitionContext completeTransition:!transitionContext.transitionWasCancelled];
    }];
}

- (void)setupTopCornersWithView:(UIView *)view {
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, view.hh_width, view.hh_height) byRoundingCorners:UIRectCornerTopLeft|UIRectCornerTopRight cornerRadii:CGSizeMake(15, 15)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = CGRectMake(0, 0, view.hh_width, view.hh_height);
    maskLayer.path = maskPath.CGPath;
    view.layer.mask = maskLayer;
}

@end

@implementation HHInteractionTopBackView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self configInitialInfo];
    }
    return self;
}

- (void)configInitialInfo {
    UIImage *image = [self captureCurrentPicture];
    self.image = image;
}

- (UIImage *)captureCurrentPicture {
    UIWindow *topWindow = [UIApplication sharedApplication].keyWindow;
    CGRect rect = [UIScreen mainScreen].bounds;
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    [topWindow drawViewHierarchyInRect:rect afterScreenUpdates:NO];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}

@end
