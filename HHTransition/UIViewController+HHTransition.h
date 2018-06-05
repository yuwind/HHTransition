//
//  UIViewController+HHTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIView+HHLayout.h"
#import "AnimationStyle.h"

@interface UIViewController (HHPresent)

@property (nonatomic, assign) AnimationStyle animationStyle;

/**
 背部缩隐式

 @param controller 控制器
 @param height 控制器高度
 @param completion 回调函数
 */
- (void)hh_presentBackScaleVC:(UIViewController * _Nonnull)controller height:(CGFloat)height completion:(void (^ __nullable)(void))completion;

/**
 圆形放大式
 
 @param controller 控制器
 @param point 触摸点
 @param completion 回调函数
 */
- (void)hh_presentCircleVC:(UIViewController * _Nonnull)controller point:(CGPoint)point completion:(void (^ __nullable)(void))completion;

/**
 旋转样式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)hh_presentTiltedVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion;

/**
 垂直折叠式
 
 @param controller 控制器
 @param completion 回调函数
 */
- (void)hh_presentErectVC:(UIViewController * _Nonnull)controller completion:(void (^ __nullable)(void))completion;

/**
 圆形放大式自定义结束触摸点

 @param point 触摸点
 @param completion 回调函数
 */
- (void)hh_dismissWithPoint:(CGPoint)point completion:(void (^ __nullable)(void))completion;

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
- (void)hh_pushViewController:(UIViewController * _Nonnull)viewController style:(AnimationStyle)style;

/**
 连续转场动画，需要实现方法`hh_transitionAnimationView`传递视图
 
 @param viewController 转场控制器
 */
- (void)hh_pushScaleViewController:(UIViewController * _Nonnull)viewController;

/**
 倾斜转场动画

 @param viewController 转场控制器
 */
- (void)hh_pushTiltViewController:(UIViewController * _Nonnull)viewController;

/**
 垂直转场动画
 
 @param viewController 转场控制器
 */
- (void)hh_pushErectViewController:(UIViewController * _Nonnull)viewController;

/**
 缩放转场动画
 
 @param viewController 转场控制器
 */
- (void)hh_pushBackViewController:(UIViewController * _Nonnull)viewController;


@end
