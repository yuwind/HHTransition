//
//  PushViewController.h
//  HHTransitionDemo
//
//  Created by 豫风 on 2020/4/19.
//  Copyright © 2020 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HHTransitionUtility.h"

NS_ASSUME_NONNULL_BEGIN

@interface PushViewController : UIViewController

@property (nonatomic, strong) UIImage *image;

+ (instancetype)instanceViewControllerWithStyle:(HHPushStyle)style;

@end

NS_ASSUME_NONNULL_END
