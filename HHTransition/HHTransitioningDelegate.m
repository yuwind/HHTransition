//
//  HHTransitioningDelegate.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHTransitioningDelegate.h"
#import "UIViewController+HHTransitionProperty.h"
#import "HHPresentFlipTransition.h"
#import "HHPresentCircleTransition.h"
#import "HHPresentTiltedTransition.h"
#import "HHPresentErectedTransition.h"
#import "HHPresentBackScaleTransition.h"
#import "HHPresentSystemTransition.h"
#import "HHPresentTopBackTransition.h"
#import "HHPresentMotionTransition.h"

@implementation HHTransitioningDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source {
    switch (presented.presentStyle) {
        case HHPresentStyleNone:
            return nil;
        case HHPresentStyleSlipFromTop:
        case HHPresentStyleSlipFromBottom:
        case HHPresentStyleSlipFromLeft:
        case HHPresentStyleSlipFromRight:
            return [HHPresentFlipTransition flipTransitionWithStyle:presented.presentStyle isBegining:YES];
        case HHPresentStyleCircle:
            return [HHPresentCircleTransition transitionWithIsBegining:YES];
        case HHPresentStyleTilted:
            return [HHPresentTiltedTransition transitionWithIsBegining:YES];
        case HHPresentStyleErected:
            return [HHPresentErectedTransition transitionWithIsBegining:YES];
        case HHPresentStyleBackScale:
            return [HHPresentBackScaleTransition transitionWithIsBegining:YES];
        case HHPresentStyleCube:
        case HHPresentStyleFade:
        case HHPresentStyleMoveIn:
        case HHPresentStylePageCurl:
            return [HHPresentSystemTransition systemTransitionWithStyle:presented.presentStyle isBegining:YES];
        case HHPresentStyleTopBack:
            return [HHPresentTopBackTransition transitionWithIsBegining:YES];
        case HHPresentStyleMotion:
            return [HHPresentMotionTransition transitionWithIsBegining:YES];
        default:
            return nil;
    }
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed {
    switch (dismissed.presentStyle) {
        case HHPresentStyleNone:
            return nil;
        case HHPresentStyleSlipFromTop:
        case HHPresentStyleSlipFromBottom:
        case HHPresentStyleSlipFromLeft:
        case HHPresentStyleSlipFromRight:
            return [HHPresentFlipTransition flipTransitionWithStyle:dismissed.presentStyle isBegining:NO];
        case HHPresentStyleCircle:
            return [HHPresentCircleTransition transitionWithIsBegining:NO];
        case HHPresentStyleTilted:
            return [HHPresentTiltedTransition transitionWithIsBegining:NO];
        case HHPresentStyleErected:
            return [HHPresentErectedTransition transitionWithIsBegining:NO];
        case HHPresentStyleBackScale:
            return [HHPresentBackScaleTransition transitionWithIsBegining:NO];
        case HHPresentStyleCube:
        case HHPresentStyleFade:
        case HHPresentStyleMoveIn:
        case HHPresentStylePageCurl:
            return [HHPresentSystemTransition systemTransitionWithStyle:dismissed.presentStyle isBegining:NO];
        case HHPresentStyleTopBack:
            return [HHPresentTopBackTransition transitionWithIsBegining:NO];
        case HHPresentStyleMotion:
            return nil;[HHPresentMotionTransition transitionWithIsBegining:NO];
        default:
            return nil;
    }
}

@end
