//
//  UIView+HHTransition.h
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (HHTransition)

@property (nonatomic, assign) CGFloat hh_x;
@property (nonatomic, assign) CGFloat hh_y;
@property (nonatomic, assign) CGFloat hh_width;
@property (nonatomic, assign) CGFloat hh_height;
@property (nonatomic, assign) CGPoint hh_origin;
@property (nonatomic, assign) CGSize  hh_size;

@end

NS_ASSUME_NONNULL_END
