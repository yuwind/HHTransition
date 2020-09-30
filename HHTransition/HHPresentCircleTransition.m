//
//  HHPresentCircleTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/14.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentCircleTransition.h"
#import "HHTransitionUtility.h"

typedef NS_ENUM(NSUInteger, HHTransitionQuadrant) {
    HHTransitionFirstQuadrant,
    HHTransitionSecondQuadrant,
    HHTransitionThirdQuadrant,
    HHTransitionFourthQuadrant,
};

@interface HHPresentCircleTransition () <CAAnimationDelegate>

@property (nonatomic, weak) id <UIViewControllerContextTransitioning> transitionContext;
@property (nonatomic, strong) CAShapeLayer *shapeLayer;

@end

@implementation HHPresentCircleTransition

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isBegining) {
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.frame = [transitionContext containerView].bounds;
        [[transitionContext containerView] addSubview:toView];
    }
    
    UIViewController <HHPresentCircleProtocol>*fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    if ([fromVC isKindOfClass:UITabBarController.class]) {
        UITabBarController *tabBarVC = (UITabBarController *)fromVC;
        fromVC = (UIViewController <HHPresentCircleProtocol>*)tabBarVC.selectedViewController;
    }
    if ([fromVC isKindOfClass:UINavigationController.class]) {
        UINavigationController *navVC = (UINavigationController *)fromVC;
        fromVC = (UIViewController <HHPresentCircleProtocol>*)navVC.topViewController;
    }
    if (![fromVC respondsToSelector:@selector(hh_touchPointForCircleTransition)]) {
        [transitionContext completeTransition:YES];
        return;
    }
    
    self.transitionContext = transitionContext;
    CGPoint touchPoint = [fromVC hh_touchPointForCircleTransition];
    CGFloat radius = [self recogniseQuadrantWithPoint:touchPoint];
    
    UIBezierPath *initialPath = nil;
    UIBezierPath *finalPath = nil;
    
    self.shapeLayer = [CAShapeLayer layer];
    if (self.isBegining) {
        initialPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){touchPoint,CGSizeZero}];
        finalPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset((CGRect){touchPoint,CGSizeZero}, -radius, -radius)];
        self.shapeLayer.path = finalPath.CGPath;
        UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
        toView.layer.mask = self.shapeLayer;
    } else {
        initialPath = [UIBezierPath bezierPathWithOvalInRect:CGRectInset((CGRect){touchPoint,CGSizeZero}, -radius, -radius)];
        finalPath = [UIBezierPath bezierPathWithOvalInRect:(CGRect){touchPoint,CGSizeZero}];
        self.shapeLayer.path = finalPath.CGPath;
        fromVC.view.layer.mask = self.shapeLayer;
    }
    
    CABasicAnimation *basicAnim = [CABasicAnimation animationWithKeyPath:@"path"];
    basicAnim.fromValue = (__bridge id _Nullable)(initialPath.CGPath);
    basicAnim.toValue = (__bridge id _Nullable)(finalPath.CGPath);
    basicAnim.delegate = self;
    basicAnim.duration = [self transitionDuration:transitionContext];
    
    [self.shapeLayer addAnimation:basicAnim forKey:@"path"];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.transitionContext completeTransition:YES];
    [self.shapeLayer removeAllAnimations];
}

- (CGFloat)recogniseQuadrantWithPoint:(CGPoint)touchPoint {
    HHTransitionQuadrant quadrant;
    if (touchPoint.x >= [UIScreen mainScreen].bounds.size.width / 2) {
        if (touchPoint.y >= [UIScreen mainScreen].bounds.size.height / 2) {
            quadrant = HHTransitionFourthQuadrant;
        } else {
            quadrant = HHTransitionFirstQuadrant;
        }
    } else {
        if (touchPoint.y >= [UIScreen mainScreen].bounds.size.height / 2) {
            quadrant = HHTransitionThirdQuadrant;
        } else {
            quadrant = HHTransitionSecondQuadrant;
        }
    }
    
    switch (quadrant) {
        case HHTransitionFirstQuadrant:
            return sqrt(touchPoint.x * touchPoint.x  + ([UIScreen mainScreen].bounds.size.height - touchPoint.y) * ([UIScreen mainScreen].bounds.size.height - touchPoint.y));
            
        case HHTransitionSecondQuadrant:
            return sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x) + ([UIScreen mainScreen].bounds.size.height - touchPoint.y) * ([UIScreen mainScreen].bounds.size.height-touchPoint.y));
            
        case HHTransitionThirdQuadrant:
            return sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x)  + touchPoint.y * touchPoint.y);
            
        case HHTransitionFourthQuadrant:
            return sqrt(touchPoint.x * touchPoint.x  + touchPoint.y * touchPoint.y);
            
        default:
            return 0;
    }
}


@end
