//
//  UIViewController+HHTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCInteractionDelegate.h"
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HHPresent)

@property (nonatomic, assign, readonly) AnimationStyle animationStyle;
@property (nonatomic, strong, readonly) VCInteractionDelegate *interactionDelegate;

/**
 ViewController transition, Partial style available
 detail in "AnimationStyle.h"
 
 */
- (void)hh_presentVC:(UIViewController *)controller type:(AnimationStyle)style completion:(void (^__nullable)(void))completion;

/**
 Circular enlargement transition, Need to pass the param `touch point`
 
 */
- (void)hh_presentCircleVC:(UIViewController *)controller point:(CGPoint)point completion:(void (^__nullable)(void))completion;

/**
 End circular enlargement transition, Need to pass the param `touch point`
 
 */
- (void)hh_dismissWithPoint:(CGPoint)point completion:(void (^__nullable)(void))completion;

/**
 AnimationStyleScale transition must need to override
 
 */
- (UIView *_Nonnull)hh_transitionAnimationView;//need to override

@end


@interface UINavigationController (HHPush)

/**
 NavigationController transition, Partial style available
 detail in "AnimationStyle.h"
 
 */
- (void)hh_pushViewController:(UIViewController *)viewController style:(AnimationStyle)style;

@end

NS_ASSUME_NONNULL_END
