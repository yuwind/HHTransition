//
//  UIViewController+HHTransitionProperty.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "UIViewController+HHTransitionProperty.h"
#import <objc/runtime.h>

static char * const kTransitionDelegateKey  = "kTransitionDelegateKey";
static char * const kTransitionPresentedKey = "kTransitionPresentedKey";
static char * const kTransitionPresentedAlphaKey = "kTransitionPresentedAlphaKey";
static char * const kInteractionDelegateKey = "kInteractionDelegateKey";
static char * const kTransitionPushStyleKey = "kTransitionPushStyleKey";

@implementation UIViewController (HHTransitionUtility)

- (void)setPresentStyle:(HHPresentStyle)presentStyle {
    objc_setAssociatedObject(self, kTransitionPresentedKey, @(presentStyle), OBJC_ASSOCIATION_ASSIGN);
}

- (HHPresentStyle)presentStyle {
    return [objc_getAssociatedObject(self, kTransitionPresentedKey) integerValue];
}

- (void)setTransitionDelegate:(HHTransitioningDelegate *)transitionDelegate {
    objc_setAssociatedObject(self, kTransitionDelegateKey, transitionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HHTransitioningDelegate *)transitionDelegate {
    return objc_getAssociatedObject(self, kTransitionDelegateKey);
}

- (void)setInteractionDelegate:(HHInteractionDelegate *)interactionDelegate {
    objc_setAssociatedObject(self, kInteractionDelegateKey, interactionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HHInteractionDelegate *)interactionDelegate {
    return objc_getAssociatedObject(self, kInteractionDelegateKey);
}

- (void)setPushStyle:(HHPushStyle)pushStyle {
    objc_setAssociatedObject(self, kTransitionPushStyleKey, @(pushStyle), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (HHPushStyle)pushStyle {
    return [objc_getAssociatedObject(self, kTransitionPushStyleKey) integerValue];
}

- (void)setTranslucentViewAlpha:(CGFloat)translucentViewAlpha {
    objc_setAssociatedObject(self, kTransitionPresentedAlphaKey, @(translucentViewAlpha), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (CGFloat)translucentViewAlpha {
    return [objc_getAssociatedObject(self, kTransitionPresentedAlphaKey) floatValue];
}

- (UIView *)translucentView {
    UIView *translucentView = objc_getAssociatedObject(self, @selector(translucentView));
    if (!translucentView) {
        CGFloat alpha = self.translucentViewAlpha > 0 ? self.translucentViewAlpha : 0.7;
        translucentView = [[UIView alloc] init];
        translucentView.backgroundColor = [UIColor colorWithWhite:0 alpha:alpha];
        self.translucentView = translucentView;
    }
    return translucentView;
}

- (void)setTranslucentView:(UIView *)translucentView {
    objc_setAssociatedObject(self, @selector(translucentView), translucentView, OBJC_ASSOCIATION_RETAIN);
}

@end
