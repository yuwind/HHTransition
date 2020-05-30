//
//  UIViewController+HHTransitionProperty.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTransitionUtility.h"
#import "HHInteractionDelegate.h"
#import "HHTransitioningDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HHTransitionProperty)

@property (nonatomic, assign, readwrite) HHPresentStyle presentStyle;
@property (nonatomic, assign, readwrite) HHPushStyle pushStyle;
@property (nonatomic, strong, readwrite) HHTransitioningDelegate *transitionDelegate;
@property (nonatomic, strong, readwrite) HHInteractionDelegate *interactionDelegate;

@end

NS_ASSUME_NONNULL_END
