//
//  HHBaseAnimatedTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHBaseAnimatedTransition.h"

@interface HHBaseAnimatedTransition ()

@property (nonatomic, assign) BOOL isBegining;

@end

@implementation HHBaseAnimatedTransition

+ (instancetype)transitionWithIsBegining:(BOOL)isBegining {
    HHBaseAnimatedTransition *transition = [self new];
    transition.isBegining = isBegining;
    return transition;
}

- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext {
    return 0.35;
}

- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext {
    if (self.isBegining) {
        [self beginTransitionWithTransitionContext:transitionContext];
    } else {
        [self endTransitionWithTransitionContext:transitionContext];
    }
}

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = [transitionContext containerView].bounds;
    [[transitionContext containerView] addSubview:toView];
    [transitionContext completeTransition:YES];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    [transitionContext completeTransition:YES];
}

@end
