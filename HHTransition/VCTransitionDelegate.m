//
//  VCTransitionDelegate.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "UIViewController+HHTransition.h"
#import "VCTransitionDelegate.h"
#import "AnimationFadeBegin.h"
#import "AnimationFadeEnd.h"
#import "AnimationWaveBegin.h"
#import "AnimationWaveEnd.h"
#import "AnimationErectBegin.h"
#import "AnimationErectEnd.h"
#import "AnimationTiltBegin.h"
#import "AnimationTildEnd.h"

@implementation VCTransitionDelegate

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (presented.animationStyle) {
        case AnimationStyleBackScale:
            objc = [AnimationFadeBegin new];
            break;
        case AnimationStyleCircle:
            objc = [AnimationWaveBegin animationOrigin:_touchPoint];
            break;
        case AnimationStyleErect:
            objc = [AnimationErectBegin animationIsInteraction:NO];
            break;
        case AnimationStyleTilted:
            objc = [AnimationTiltBegin new];
            break;
        default:
            break;
    }
    return objc;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (dismissed.animationStyle) {
        case AnimationStyleBackScale:
            objc = [AnimationFadeEnd new];
            break;
        case AnimationStyleCircle:
            objc = [AnimationWaveEnd animationOrigin:_touchPoint];
            break;
        case AnimationStyleErect:
            objc = [AnimationErectEnd new];
            break;
        case AnimationStyleTilted:
            objc = [AnimationTildEnd new];
            break;
        default:
            break;
    }
    return objc;
}

@end
