//
//  VCInteractiveDelegate.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "AnimationStyle.h"

@interface VCInteractionDelegate : UIPercentDrivenInteractiveTransition<UINavigationControllerDelegate>

+ (instancetype)shareInstance;
@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, weak) id <UINavigationControllerDelegate> delegate;

@end
