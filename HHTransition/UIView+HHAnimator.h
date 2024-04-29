//
//  UIView+HHAnimator.h
//  HHTransition
//
//  Created by huxuewei on 2024/4/29.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHAnimator)

+ (void)hh_animateWithDuration:(NSTimeInterval)duration animations:(void (^)(void))animations completion:(void (^ __nullable)(UIViewAnimatingPosition finalPosition))completion;
+ (void)hh_animateWithDuration:(NSTimeInterval)duration delay:(NSTimeInterval)delay animations:(void (^)(void))animations completion:(void (^ __nullable)(UIViewAnimatingPosition finalPosition))completion;

@end

NS_ASSUME_NONNULL_END
