//
//  AnimationTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2018/5/17.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimationStyle.h"

@interface AnimationTransitionBegin : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)animationStyle:(AnimationStyle)style;

@end
