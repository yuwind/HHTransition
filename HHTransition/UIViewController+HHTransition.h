//
//  UIViewController+HHTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCInteractionDelegate.h"
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (HHPresent)

@property (nonatomic, assign) AnimationStyle animationStyle;
@property (nonatomic, strong, readonly) VCInteractionDelegate *interactionDelegate;

/**
 背部缩隐式

 @param controller 控制器
 @param height 控制器高度
 @param completion 回调函数
 */
- (void)hh_presentBackScaleVC:(UIViewController *)controller height:(CGFloat)height completion:(void (^ __nullable)(void))completion;

/**
 圆形放大式
 
 @param controller 控制器
 @param point 触摸点
 @param completion 回调函数
 */
- (void)hh_presentCircleVC:(UIViewController *)controller point:(CGPoint)point completion:(void (^__nullable)(void))completion;

/**
 旋转样式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)hh_presentTiltedVC:(UIViewController *)controller completion:(void (^__nullable)(void))completion;

/**
 垂直折叠式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)hh_presentErectVC:(UIViewController * _Nonnull)controller completion:(void (^__nullable)(void))completion;

/**
 圆形放大式自定义结束触摸点

 @param point 触摸点
 @param completion 回调函数
 */
- (void)hh_dismissWithPoint:(CGPoint)point completion:(void (^__nullable)(void))completion;

/**
 pushScale转场控制器重写
 
 @return 转场视图
 */
- (UIView *_Nonnull)hh_transitionAnimationView;//need to override

@end


@interface UINavigationController (HHPush)

/**
 CATransitin转场动画
 
 @param viewController 转场控制器
 @param style 转场类型
 */
- (void)hh_pushViewController:(UIViewController *)viewController style:(AnimationStyle)style;

@end

NS_ASSUME_NONNULL_END
