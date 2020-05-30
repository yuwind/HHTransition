//
//  HHInteractionDelegate.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHInteractionDelegate.h"
#import "UIViewController+HHTransitionProperty.h"
#import "HHInteractionDrawerTransition.h"
#import "HHInteractionMotionTransition.h"
#import "HHInteractionTiltedTransition.h"
#import "HHInteractionFlipTransition.h"
#import "HHInteractionTopBackTransition.h"

@interface HHInteractionDelegate ()

@property (nonatomic, assign) BOOL isPopInteraction;

@end

@implementation HHInteractionDelegate

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController {
    if (self.isPopInteraction) {
        return self;
    }
    return nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController animationControllerForOperation:(UINavigationControllerOperation)operation fromViewController:(UIViewController *)fromVC toViewController:(UIViewController *)toVC {
    
    if(operation == UINavigationControllerOperationPush) {
        if (!toVC.interactionDelegate) {
            return nil;
        }
        switch (toVC.pushStyle) {
            case HHPushStyleNone:
                return nil;
            case HHPushStyleSlipFromTop:
            case HHPushStyleSlipFromBottom:
            case HHPushStyleSlipFromLeft:
            case HHPushStyleSlipFromRight:
                return [HHInteractionFlipTransition flipTransitionWithStyle:toVC.pushStyle isBegining:YES];
            case HHPushStyleTilted:
                return [HHInteractionTiltedTransition transitionWithIsBegining:YES];
            case HHPushStyleDrawer:
                return [HHInteractionDrawerTransition transitionWithIsBegining:YES];
            case HHPushStyleMotion:
                return [HHInteractionMotionTransition transitionWithIsBegining:YES];
            case HHPushStyleTopBack:
                return [HHInteractionTopBackTransition transitionWithIsBegining:YES];
            default:
                return nil;
        }
    } else if (operation == UINavigationControllerOperationPop) {
        if (!fromVC.interactionDelegate) {
            return nil;
        }
        switch (fromVC.pushStyle) {
            case HHPushStyleNone:
                return nil;
            case HHPushStyleSlipFromTop:
            case HHPushStyleSlipFromBottom:
            case HHPushStyleSlipFromLeft:
            case HHPushStyleSlipFromRight:
                return [HHInteractionFlipTransition flipTransitionWithStyle:fromVC.pushStyle isBegining:NO];
            case HHPushStyleTilted:
                return [HHInteractionTiltedTransition transitionWithIsBegining:NO];
            case HHPushStyleDrawer:
                return [HHInteractionDrawerTransition transitionWithIsBegining:NO];
            case HHPushStyleMotion:
                return [HHInteractionMotionTransition transitionWithIsBegining:NO];
            case HHPushStyleTopBack:
                return [HHInteractionTopBackTransition transitionWithIsBegining:NO];
            default:
                return nil;
        }
    }
    return nil;
}

- (void)edgePanGestureAction:(UIScreenEdgePanGestureRecognizer *)gesture {
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    switch (gesture.state) {
        case UIGestureRecognizerStateBegan:
            self.isPopInteraction = YES;
            [self.navigation popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            self.isPopInteraction = NO;
            [self updateInteractiveTransition:rate];
            break;
        case UIGestureRecognizerStateEnded:
            self.isPopInteraction = NO;
            if (rate >= 0.4f) {
                [self finishInteractiveTransition];
                self.navigation.delegate = self.delegate;
            } else {
                if (velocity > 600){
                    [self finishInteractiveTransition];
                    self.navigation.delegate = self.delegate;
                } else {
                    [self cancelInteractiveTransition];
                }
            }
            break;
        default:
            self.isPopInteraction = NO;
            [self cancelInteractiveTransition];
            break;
    }
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if ([self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController {
    if ([self.delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController {
    if ([self.delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationUnknown;
}

- (void)dealloc {
    if (self.delegate) {
        self.navigation.delegate = self.delegate;
    }
}

@end
