//
//  HHBaseAnimatedTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HHTransitionUtility.h"
#import "UIView+HHTransition.h"

NS_ASSUME_NONNULL_BEGIN

@interface HHBaseAnimatedTransition : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign, readonly) BOOL isBegining;

+ (instancetype _Nonnull)transitionWithIsBegining:(BOOL)IsBegining;
- (NSTimeInterval)transitionDuration:(nullable id<UIViewControllerContextTransitioning>)transitionContext;
- (void)animateTransition:(nonnull id<UIViewControllerContextTransitioning>)transitionContext;
- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;
- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext;

@end

NS_ASSUME_NONNULL_END
