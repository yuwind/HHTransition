//
//  UIView+HHTransition.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2020/4/18.
//  Copyright © 2020 豫风. All rights reserved.
//

#import "UIView+HHTransition.h"

@implementation UIView (HHTransition)

- (void)setHh_x:(CGFloat)hh_x {
    CGRect tempFrame = self.frame;
    tempFrame.origin.x = hh_x;
    self.frame = tempFrame;
}

- (CGFloat)hh_x {
    return self.frame.origin.x;
}

- (void)setHh_y:(CGFloat)hh_y {
    CGRect tempFrame = self.frame;
    tempFrame.origin.y = hh_y;
    self.frame = tempFrame;
}

- (CGFloat)hh_y {
    return self.frame.origin.y;
}

- (void)setHh_width:(CGFloat)hh_width {
    CGRect tempFrame = self.frame;
    tempFrame.size.width = hh_width;
    self.frame = tempFrame;
}

- (CGFloat)hh_width {
    return self.frame.size.width;
}

- (void)setHh_height:(CGFloat)hh_height {
    CGRect tempFrame = self.frame;
    tempFrame.size.height = hh_height;
    self.frame = tempFrame;
}

- (CGFloat)hh_height {
    return self.frame.size.height;
}

- (void)setHh_origin:(CGPoint)hh_origin {
    CGRect frame = self.frame;
    frame.origin = hh_origin;
    self.frame = frame;
}

- (CGPoint)hh_origin {
    return self.frame.origin;
}

- (void)setHh_size:(CGSize)hh_size {
    CGRect frame = self.frame;
    frame.size = hh_size;
    self.frame = frame;
}

- (CGSize)hh_size {
    return self.frame.size;
}

@end
