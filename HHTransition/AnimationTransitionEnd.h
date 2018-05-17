//
//  AnimationTransitionEnd.h
//  HHTransitionDemo
//
//  Created by 豫风 on 2018/5/17.
//  Copyright © 2018年 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCInteractionDelegate.h"

@interface AnimationTransitionEnd : NSObject<UIViewControllerAnimatedTransitioning>

+ (instancetype)animationStyle:(InteractionStyle)style;

@end
