//
//  UIView+HHAnimator.m
//  HHTransition
//
//  Created by huxuewei on 2024/4/29.
//

#import "UIView+HHAnimator.h"

@implementation UIView (HHAnimator)

+ (void)hh_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(UIViewAnimatingPosition finalPosition))completion {
    [self hh_animateWithDuration:duration delay:0 animations:animations completion:completion];
}

+ (void)hh_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^ __nullable)(UIViewAnimatingPosition finalPosition))completion {
    UIViewPropertyAnimator *animator = [[UIViewPropertyAnimator alloc] initWithDuration:duration controlPoint1:CGPointMake(0.84, 0) controlPoint2:CGPointMake(0.16, 1) animations:animations];
    [animator addCompletion:completion];
    [animator startAnimationAfterDelay:delay];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)((duration+delay) * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [animator duration];
    });
}

@end
