//
//  UIViewController+HHTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "UIViewController+HHTransition.h"
#import "VCTransitionDelegate.h"
#import <objc/runtime.h>


static char * const transitionDelegateKey = "transitionDelegateKey";

@interface UIViewController ()

@property (nonatomic, strong) VCTransitionDelegate *transitionDelegate;

@end


@implementation UIViewController (HHPresent)

+ (void)load
{
    Class class = [self class];
    
    SEL originalSelector = @selector(dismissViewControllerAnimated:completion:);
    SEL swizzledSelector = @selector(hh_dismissViewControllerAnimated:completion:);
    
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    
    BOOL didAddMethod =
    class_addMethod(class,
                    originalSelector,
                    method_getImplementation(swizzledMethod),
                    method_getTypeEncoding(swizzledMethod));
    
    if (didAddMethod) {
        class_replaceMethod(class,
                            swizzledSelector,
                            method_getImplementation(originalMethod),
                            method_getTypeEncoding(originalMethod));
    } else
    {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

- (void)setTransitionDelegate:(VCTransitionDelegate *)transitionDelegate
{
    objc_setAssociatedObject(self, transitionDelegateKey, transitionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
- (VCTransitionDelegate *)transitionDelegate
{
    return objc_getAssociatedObject(self, transitionDelegateKey);
}

- (void)hh_presentBackScaleVC:(UIViewController *)controller height:(CGFloat)height completion:(void (^)(void))completion
{
    [self hh_presentVC:controller type:TransitionStyleBackScale height:height point:CGPointZero completion:completion];
}
- (void)hh_presentCircleVC:(UIViewController *)controller point:(CGPoint)point completion:(void (^)(void))completion
{
    [self hh_presentVC:controller type:TransitionStyleCircle height:0 point:point completion:completion];
}
- (void)hh_presentErectVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion
{
    [self hh_presentVC:controller type:TransitionStyleErect height:0 point:CGPointZero completion:completion];
}
- (void)hh_presentVC:(UIViewController *)controller type:(TransitionStyle)style height:(CGFloat)height point:(CGPoint)point completion:(void (^)(void))completion
{
    self.transitionDelegate = [VCTransitionDelegate transitionStyle:style];
    self.transitionDelegate.height = height;
    self.transitionDelegate.touchPoint = point;
    controller.modalPresentationStyle = UIModalPresentationCustom;
    controller.transitioningDelegate = self.transitionDelegate;
    
    [self presentViewController:controller animated:YES completion:completion];
}
- (void)hh_dismissWithPoint:(CGPoint)point completion:(void (^)(void))completion
{
    VCTransitionDelegate *transitionDelegate = self.transitioningDelegate;
    transitionDelegate.touchPoint = point;
    
    [self dismissViewControllerAnimated:YES completion:completion];
}
- (void)hh_dismissViewControllerAnimated:(BOOL)animated completion:(void (^)(void))completion
{
    if (!animated) {
        [self.presentingViewController resetInitialInfo];
    }
    [self hh_dismissViewControllerAnimated:animated completion:completion];
}
- (void)resetInitialInfo
{
    if (CGPointEqualToPoint(self.view.layer.anchorPoint, CGPointMake(0.5, 0.5))) {
        return;
    }
    self.view.alpha = 1;
    [self.view.layer setTransform:CATransform3DIdentity];
    self.view.layer.anchorPoint = CGPointMake(0.5, 0.5);
    self.view.layer.frame = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
}
- (UIView *)hh_transitionAnimationView{
    return nil;
}
@end


#import "VCInteractionDelegate.h"

static char * const interactionDelegateKey = "interactionDelegateKey";

@interface UINavigationController ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) VCInteractionDelegate *interactionDelegate;

@end

@implementation UINavigationController (HHPush)

- (void)setInteractionDelegate:(VCInteractionDelegate *)interactionDelegate
{
    objc_setAssociatedObject(self, interactionDelegateKey, interactionDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (VCInteractionDelegate *)interactionDelegate
{
    return objc_getAssociatedObject(self, interactionDelegateKey);
}

- (void)hh_pushScaleViewController:(UIViewController *)viewController
{
     [self hh_pushViewController:viewController style:InteractionStyleScale];
}
- (void)hh_pushTiltViewController:(UIViewController *)viewController
{
    [self hh_pushViewController:viewController style:InteractionStyleTilted];
}
- (void)hh_pushErectViewController:(UIViewController *)viewController
{
    [self hh_pushViewController:viewController style:InteractionStyleErect];
}
- (void)hh_pushBackViewController:(UIViewController *)viewController
{
    [self hh_pushViewController:viewController style:InteractionStyleBack];
}
- (void)hh_pushViewController:(UIViewController *)viewController style:(InteractionStyle)style
{
    self.interactionDelegate = [VCInteractionDelegate interactionStyle:style];
    self.interactionDelegate.navigation = self;
    UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self.interactionDelegate action:NSSelectorFromString(@"edgePanAction:")];
    edgePan.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgePan];
    self.interactionDelegate.delegate = self.delegate?:nil;
    self.delegate = self.interactionDelegate;
    [self pushViewController:viewController animated:YES];
}

@end
