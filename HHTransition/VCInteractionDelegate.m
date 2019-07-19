//
//  VCInteractiveDelegate.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "VCInteractionDelegate.h"
#import "AnimationScaleBegin.h"
#import "AnimationScaleEnd.h"
#import "AnimationTiltBegin.h"
#import "AnimationTildEnd.h"
#import "AnimationErectBegin.h"
#import "AnimationErectEnd.h"
#import "AnimationBackBegin.h"
#import "AnimationBackEnd.h"
#import "AnimationTransitionBegin.h"
#import "AnimationTransitionEnd.h"
#import "AnimationTopBackBegin.h"
#import "AnimationTopBackEnd.h"
#import "AnimationTopBackImageView.h"
#import "UIViewController+HHTransition.h"

@interface VCInteractionDelegate ()

@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, assign) BOOL isInteraction;

@end

@implementation VCInteractionDelegate

+ (instancetype)shareInstance
{
    static VCInteractionDelegate *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [VCInteractionDelegate new];
    });
    return _instance;
}

- (nullable id <UIViewControllerInteractiveTransitioning>)navigationController:(UINavigationController *)navigationController
                                   interactionControllerForAnimationController:(id <UIViewControllerAnimatedTransitioning>) animationController
{
    return _isInteraction ? _isPop ? self : nil : nil;
}

- (nullable id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                            animationControllerForOperation:(UINavigationControllerOperation)operation
                                                         fromViewController:(UIViewController *)fromVC
                                                           toViewController:(UIViewController *)toVC{
    
    id<UIViewControllerAnimatedTransitioning> objc = nil;
    if(operation == UINavigationControllerOperationPush)
    {
        _isPop = NO;
        switch (toVC.animationStyle) {
            case AnimationStyleScale:
                objc = [AnimationScaleBegin new];
                break;
            case AnimationStyleTilted:
                objc = [AnimationTiltBegin new];
                break;
            case AnimationStyleErect:
                objc = [AnimationErectBegin animationIsInteraction:YES];
                break;
            case AnimationStyleBack:
                objc = [AnimationBackBegin new];
                break;
            case AnimationStyleCube:
            case AnimationStyleSuckEffect:
            case AnimationStyleOglFlip:
            case AnimationStyleRippleEffect:
            case AnimationStylePageCurl:
            case AnimationStyleCameralIrisHollowOpen:
                objc = [AnimationTransitionBegin animationStyle:toVC.animationStyle];
                break;
            case AnimationStyleTopBack:
                objc = [AnimationTopBackBegin new];
                break;
            default:
                break;
        }
        return objc;
    }else if (operation == UINavigationControllerOperationPop)
    {
        _isPop = YES;
        switch (fromVC.animationStyle) {
            case AnimationStyleScale:
                objc = [AnimationScaleEnd new];;
                break;
            case AnimationStyleTilted:
                objc = [AnimationTildEnd new];;
                break;
            case AnimationStyleErect:
                objc = [AnimationErectEnd new];;
                break;
            case AnimationStyleBack:
                objc = [AnimationBackEnd new];
                break;
            case AnimationStyleCube:
            case AnimationStyleSuckEffect:
            case AnimationStyleOglFlip:
            case AnimationStyleRippleEffect:
            case AnimationStylePageCurl:
            case AnimationStyleCameralIrisHollowOpen:
                objc = [AnimationTransitionEnd animationStyle:fromVC.animationStyle];
                break;
            case AnimationStyleTopBack:
                objc = [AnimationTopBackEnd new];
                break;
            default:
                break;
        }
        return objc;
    }
    return nil;
}

- (void)edgePanAction:(UIScreenEdgePanGestureRecognizer *)gesture{
    CGFloat rate = [gesture translationInView:[[UIApplication sharedApplication] keyWindow]].x / [UIScreen mainScreen].bounds.size.width;
    CGFloat velocity = [gesture velocityInView:[[UIApplication sharedApplication] keyWindow]].x;
    switch (gesture.state)
    {
        case UIGestureRecognizerStateBegan:
            _isInteraction = YES;
            [self.navigation popViewControllerAnimated:YES];
            break;
        case UIGestureRecognizerStateChanged:
            _isInteraction = NO;
            [self updateInteractiveTransition:rate];
            break;
        case UIGestureRecognizerStateEnded:
            self.completionCurve = UIViewAnimationCurveEaseInOut;
            _isInteraction = NO;
            if (rate >= 0.3f){
                [self finishInteractiveTransition];
                UIView *firstView = self.navigation.view.subviews[0];
                if ([firstView isKindOfClass:AnimationTopBackImageView.class]) {
                    [firstView removeFromSuperview];
                }
                self.navigation.delegate = self.delegate;
            }else{
                if (velocity >700){
                    [self finishInteractiveTransition];
                    UIView *firstView = self.navigation.view.subviews[0];
                    if ([firstView isKindOfClass:AnimationTopBackImageView.class]) {
                        [firstView removeFromSuperview];
                    }
                    self.navigation.delegate = self.delegate;
                }else{
                    [self cancelInteractiveTransition];
                }
            }
            break;
        default:
            _isInteraction = NO;
            [self cancelInteractiveTransition];
            break;
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    if (self.delegate && self.delegate !=self && [self.delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationUnknown;
}



@end
