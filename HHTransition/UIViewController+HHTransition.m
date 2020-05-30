//
//  UIViewController+HHTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/13.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "UIViewController+HHTransition.h"
#import "UIViewController+HHTransitionProperty.h"

@implementation UIViewController (HHTransition)

- (void)hh_presentViewController:(UIViewController *)viewController presentStyle:(HHPresentStyle)presentStyle completion:(void (^__nullable)(void))completion {
    
    HHTransitioningDelegate *transitionDelegate = [HHTransitioningDelegate new];
    viewController.presentStyle = presentStyle;
    viewController.transitionDelegate = transitionDelegate;
    viewController.modalPresentationStyle = UIModalPresentationCustom;
    viewController.transitioningDelegate = transitionDelegate;
    
    [self presentViewController:viewController animated:YES completion:completion];
}

@end

@implementation UINavigationController (HHTransition)

- (void)hh_pushViewController:(UIViewController *)viewController style:(HHPushStyle)style {
    HHInteractionDelegate *interaction = [HHInteractionDelegate new];
    SEL panGestureAction = NSSelectorFromString(@"edgePanGestureAction:");
    if (![interaction respondsToSelector:panGestureAction]) {
        [self pushViewController:viewController animated:YES];
        return;
    }
    
    interaction.navigation = self;
    interaction.delegate = self.delegate;
    viewController.interactionDelegate = interaction;
    viewController.pushStyle = style;
    
    UIScreenEdgePanGestureRecognizer *edgePanGesture = [[UIScreenEdgePanGestureRecognizer alloc] initWithTarget:interaction action:panGestureAction];
    edgePanGesture.edges = UIRectEdgeLeft;
    [viewController.view addGestureRecognizer:edgePanGesture];
    self.delegate = interaction;
    [self pushViewController:viewController animated:YES];
}

@end
