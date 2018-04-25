//
//  VCTransitionDelegate.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "VCTransitionDelegate.h"
#import "AnimationFadeBegin.h"
#import "AnimationFadeEnd.h"
#import "AnimationWaveBegin.h"
#import "AnimationWaveEnd.h"
#import "AnimationErectBegin.h"
#import "AnimationErectEnd.h"

@interface VCTransitionDelegate ()

@property (nonatomic, assign) TransitionStyle animationStyle;

@end


@implementation VCTransitionDelegate

+ (instancetype)transitionStyle:(TransitionStyle)style
{
    VCTransitionDelegate * transitionDele = [[VCTransitionDelegate alloc]init];
    transitionDele.animationStyle = style;
    return transitionDele;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (_animationStyle) {
        case TransitionStyleBackScale:
            objc = [AnimationFadeBegin animationHeight:_height];
            break;
        case TransitionStyleCircle:
            objc = [AnimationWaveBegin animationOrigin:_touchPoint];
            break;
        case TransitionStyleErect:
            objc = [AnimationErectBegin animationIsInteraction:NO];
            break;
        default:
            break;
    }
    return objc;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    switch (_animationStyle) {
        case TransitionStyleBackScale:
            objc = [AnimationFadeEnd animationHeight:_height];
            break;
        case TransitionStyleCircle:
            objc = [AnimationWaveEnd animationOrigin:_touchPoint];
            break;
        case TransitionStyleErect:
            objc = [AnimationErectEnd new];
            break;
        default:
            break;
    }
    return objc;
}

@end
