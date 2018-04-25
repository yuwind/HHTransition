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

@interface VCInteractionDelegate ()

@property (nonatomic, assign) InteractionStyle style;
@property (nonatomic, assign) BOOL isPop;
@property (nonatomic, assign) BOOL isInteraction;

@end

@implementation VCInteractionDelegate


+ (instancetype)interactionStyle:(InteractionStyle)style
{
    VCInteractionDelegate *interaction = [[VCInteractionDelegate alloc]init];
    interaction.style = style;
    return interaction;
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
        switch (_style) {
            case InteractionStyleScale:
                objc = [AnimationScaleBegin new];
                break;
            case InteractionStyleTilted:
                objc = [AnimationTiltBegin new];
                break;
            case InteractionStyleErect:
                objc = [AnimationErectBegin animationIsInteraction:YES];
                break;
            case InteractionStyleBack:
                objc = [AnimationBackBegin new];
                break;
            default:
                break;
        }
        return objc;
    }else if (operation == UINavigationControllerOperationPop)
    {
        _isPop = YES;
        switch (_style) {
            case InteractionStyleScale:
                objc = [AnimationScaleEnd new];;
                break;
            case InteractionStyleTilted:
                objc = [AnimationTildEnd new];;
                break;
            case InteractionStyleErect:
                objc = [AnimationErectEnd new];;
                break;
            case InteractionStyleBack:
                objc = [AnimationBackEnd new];
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
            _isInteraction = NO;
            if (rate >= 0.4f)
                [self finishInteractiveTransition];
            else
                if (velocity >1000)
                    [self finishInteractiveTransition];
                else
                    [self cancelInteractiveTransition];
            break;
        default:
            _isInteraction = NO;
            [self cancelInteractiveTransition];
            break;
    }
}
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationController:willShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController willShowViewController:viewController animated:animated];
    }
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationController:didShowViewController:animated:)]) {
        [self.delegate navigationController:navigationController didShowViewController:viewController animated:animated];
    }
}

- (UIInterfaceOrientationMask)navigationControllerSupportedInterfaceOrientations:(UINavigationController *)navigationController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationControllerSupportedInterfaceOrientations:)]) {
        return [self.delegate navigationControllerSupportedInterfaceOrientations:navigationController];
    }
    return UIInterfaceOrientationMaskPortrait;
}
- (UIInterfaceOrientation)navigationControllerPreferredInterfaceOrientationForPresentation:(UINavigationController *)navigationController
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(navigationControllerPreferredInterfaceOrientationForPresentation:)]) {
        return [self.delegate navigationControllerPreferredInterfaceOrientationForPresentation:navigationController];
    }
    return UIInterfaceOrientationUnknown;
}



@end
