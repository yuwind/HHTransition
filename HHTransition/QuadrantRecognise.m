//
//  QuadrantRecognise.m
//  https://github.com/yuwind/HHTransition
//
//  Created by 豫风 on 2017/2/19.
//  Copyright © 2017年 豫风. All rights reserved.
//

#import "QuadrantRecognise.h"

typedef enum : NSUInteger {
    QuadrantStyleNone,
    QuadrantStyleFirst,
    QuadrantStyleSecond,
    QuadrantStyleThird,
    QuadrantStyleFourth,
} QuadrantStyle;


@implementation QuadrantRecognise

+ (CGFloat)recogniseWithPoint:(CGPoint)touchPoint
{
    QuadrantStyle style = QuadrantStyleNone;
    if (touchPoint.x>=[UIScreen mainScreen].bounds.size.width/2) {
        
        if (touchPoint.y>=[UIScreen mainScreen].bounds.size.height/2) {
            
            style = QuadrantStyleFourth;
        }else{
            style = QuadrantStyleFirst;
        }
    }else{
        if (touchPoint.y>=[UIScreen mainScreen].bounds.size.height/2) {
            
            style = QuadrantStyleThird;
        }else{
            style = QuadrantStyleSecond;
        }
    }
    CGFloat radius = 0;
    switch (style) {
        case QuadrantStyleFirst:
            radius =  sqrt(touchPoint.x * touchPoint.x  + ([UIScreen mainScreen].bounds.size.height-touchPoint.y) * ([UIScreen mainScreen].bounds.size.height-touchPoint.y));
            break;
            
        case QuadrantStyleSecond:
            radius =  sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x)  + ([UIScreen mainScreen].bounds.size.height-touchPoint.y) * ([UIScreen mainScreen].bounds.size.height-touchPoint.y));
            break;
            
        case QuadrantStyleThird:
            radius =  sqrt(([UIScreen mainScreen].bounds.size.width - touchPoint.x) * ([UIScreen mainScreen].bounds.size.width - touchPoint.x)  + touchPoint.y * touchPoint.y);
            break;
            
        case QuadrantStyleFourth:
            radius =  sqrt(touchPoint.x * touchPoint.x  + touchPoint.y * touchPoint.y);
            break;
            
        default:
            break;
    }
    return radius;
}

@end
