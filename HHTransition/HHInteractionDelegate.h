//
//  HHInteractionDelegate.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface HHInteractionDelegate : UIPercentDrivenInteractiveTransition <UINavigationControllerDelegate>

@property (nonatomic, weak) UINavigationController *navigation;
@property (nonatomic, weak) id <UINavigationControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
