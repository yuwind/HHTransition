//
//  UIViewController+HHTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "HHTransitionUtility.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HHTransition)

/*
 UIViewController transition, some style need to conform corresponding protocol, see detail in `HHPresentStyle`
 */
- (void)hh_presentViewController:(UIViewController *)viewController presentStyle:(HHPresentStyle)presentStyle completion:(void (^__nullable)(void))completion;

@end

@interface UINavigationController (HHTransition)

/*
UINavigationController transition, some style need to conform corresponding protocol, see detail in `HHPushStyle`
*/
- (void)hh_pushViewController:(UIViewController *)viewController style:(HHPushStyle)style;

@end

NS_ASSUME_NONNULL_END
