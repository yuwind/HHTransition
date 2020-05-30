//
//  HHTransitionUtility.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#ifndef HHTransitionUtility_h
#define HHTransitionUtility_h

#import <UIKit/UIKit.h>

#define mISiPhoneX \
({BOOL isPhoneX = NO;\
if (@available(iOS 11.0, *)) {\
isPhoneX = [[UIApplication sharedApplication] delegate].window.safeAreaInsets.bottom > 0.0;\
}\
(isPhoneX);})

typedef NS_ENUM(NSUInteger, HHPresentStyle) {
    HHPresentStyleNone = 0,
    HHPresentStyleSlipFromTop,
    HHPresentStyleSlipFromBottom,
    HHPresentStyleSlipFromLeft,
    HHPresentStyleSlipFromRight,
    HHPresentStyleCircle, //viewController must conforms HHPresentCircleProtocol
    HHPresentStyleTilted,
    HHPresentStyleErected,
    HHPresentStyleBackScale,
};

typedef NS_ENUM(NSUInteger, HHPushStyle) {
    HHPushStyleNone = 0,
    HHPushStyleSlipFromTop,
    HHPushStyleSlipFromBottom,
    HHPushStyleSlipFromLeft,
    HHPushStyleSlipFromRight,
    HHPushStyleTilted,
    HHPushStyleDrawer,
    HHPushStyleMotion,//viewController must conforms HHInteractionMotionProtocol
    HHPushStyleTopBack,
};

#pragma mark - just for HHPresentStyleCircle
@protocol HHPresentCircleProtocol <NSObject>

@required;
- (CGPoint)hh_touchPointForCircleTransition;

@end

#pragma mark - just for HHPushStyleMotion
@protocol HHInteractionMotionProtocol <NSObject>

@required;
- (UIView *_Nonnull)hh_animationViewForMotionTransition;

@end

#endif /* HHTransitionUtility_h */
