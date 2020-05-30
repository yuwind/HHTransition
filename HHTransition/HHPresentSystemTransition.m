//
//  HHPresentSystemTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentSystemTransition.h"

#define mSystemTransitionKey @"mSystemTransitionKey"

@interface HHPresentSystemTransition ()<CAAnimationDelegate>

@property (nonatomic, assign) HHPresentStyle style;
@property (nonatomic, strong) id<UIViewControllerContextTransitioning>transitionContext;

@end

@implementation HHPresentSystemTransition

+ (instancetype)systemTransitionWithStyle:(HHPresentStyle)style isBegining:(BOOL)isBegining {
    HHPresentSystemTransition *transition = [self transitionWithIsBegining:isBegining];
    transition.style = style;
    return transition;
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = transitionContext.containerView.bounds;
    [transitionContext.containerView addSubview:toView];
    
    self.transitionContext = transitionContext;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    switch (self.style) {
        case HHPresentStyleCube: {
            animation.type = @"cube";
            animation.subtype = kCATransitionFromRight;
        }
            break;
        case HHPresentStyleFade: {
            animation.type = kCATransitionFade;
        }
            break;
        case HHPresentStyleMoveIn: {
            animation.type = kCATransitionMoveIn;
        }
            break;
        case HHPresentStylePageCurl: {
            animation.type = @"pageCurl";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        default:
            break;
    }
    [self.appWindow.layer addAnimation:animation forKey:mSystemTransitionKey];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    [fromView removeFromSuperview];
    
    self.transitionContext = transitionContext;
    CATransition *animation = [CATransition animation];
    animation.delegate = self;
    animation.duration = [self transitionDuration:transitionContext];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    switch (self.style) {
        case HHPresentStyleCube:{
            animation.type = @"cube";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        case HHPresentStyleFade: {
            animation.type = kCATransitionFade;
        }
            break;
        case HHPresentStyleMoveIn: {
            animation.type = kCATransitionMoveIn;
        }
            break;
        case HHPresentStylePageCurl: {
            animation.type = @"pageUnCurl";
            animation.subtype = kCATransitionFromLeft;
        }
            break;
        default:
            break;
    }
    [self.appWindow.layer addAnimation:animation forKey:mSystemTransitionKey];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:YES];
    [self.appWindow.layer removeAnimationForKey:mSystemTransitionKey];
    self.transitionContext = nil;
}

- (UIWindow *)appWindow {
    id<UIApplicationDelegate> delegate = UIApplication.sharedApplication.delegate;
    if ([delegate respondsToSelector:@selector(window)]) {
        return delegate.window;
    }
    return [UIApplication.sharedApplication keyWindow];
}

@end
