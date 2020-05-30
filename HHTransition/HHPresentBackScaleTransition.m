//
//  HHPresentBackScaleTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/5/30.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "HHPresentBackScaleTransition.h"

@implementation HHPresentBackScaleTransition

- (void)beginTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIView *toView = [transitionContext viewForKey:UITransitionContextToViewKey];
    toView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    [[transitionContext containerView] addSubview:toView];
    toView.layer.zPosition = MAXFLOAT;
    
    UIViewController * fromVC =
    [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    fromVC.view.layer.zPosition = -1;
    fromVC.view.layer.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height/2, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    fromVC.view.layer.anchorPoint = CGPointMake(0.5, 1);
    
    CATransform3D rotate = CATransform3DIdentity;
    rotate.m34 = -1.0 / 1000;
    rotate = CATransform3DRotate(rotate, (mISiPhoneX ? 4 : 3) * M_PI/180.0, 1, 0, 0);
    
    CATransform3D scale = CATransform3DIdentity;
    scale = CATransform3DScale(scale, mISiPhoneX ? 0.94 : 0.95, mISiPhoneX ? 0.96 : 0.97, 1);
    
    //toView animation
    [UIView animateWithDuration:0.35 animations:^{
        toView.hh_y = 0;
    }];
    
    //fromView animation
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        fromVC.view.layer.transform = rotate;
        fromVC.view.alpha = 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            fromVC.view.alpha = 0.5;
            fromVC.view.layer.transform = scale;
        } completion:^(BOOL finished){
             [transitionContext completeTransition:YES];
         }];
    }];
}

- (void)endTransitionWithTransitionContext:(id<UIViewControllerContextTransitioning>)transitionContext {
    UIViewController *toVC =
    [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView *fromView = [transitionContext viewForKey:UITransitionContextFromViewKey];
    
    //fromView animation
    [UIView animateWithDuration:0.35 animations:^{
        fromView.hh_y = fromView.hh_height;
    }];
    
    CATransform3D rotate = CATransform3DIdentity;
    rotate.m34 = -1.0 / 1000.0;
    rotate = CATransform3DRotate(rotate, 4.0 * M_PI/180.0, 1, 0, 0);
    if(!mISiPhoneX) {
        rotate = CATransform3DTranslate(rotate, 0, -5, 0);
    }
    //toView animation
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        toVC.view.layer.transform = rotate;
        toVC.view.alpha = 0.6;
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            toVC.view.alpha = 1;
            [toVC.view.layer setTransform:CATransform3DIdentity];
        } completion:^(BOOL finished) {
            toVC.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
            toVC.view.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
            [transitionContext completeTransition:YES];
        }];
    }];
}

@end
